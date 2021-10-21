///////////////////////////////
//
// ©2021 @aramakme
//
// This code is released with an ARAMAKME License v0.1.  The ARAMAKME license v0.1 provides the following rights:
//    Usage: You may use this library provided that you follow the following restrictions:
//         - you do not remove or modify the license payment code
//         - you do not modify the receiving license_canister configuration except to indicate a selected distribution license
//         - you pay the license_check_cycles fee via code operation at least once every license_rate_reset nanoseconds
//         - you pay the license_check_cycles fee via code operation at least once every license_overrun_grace_periods
//    Commercial Use: You may use this library commercially provided you follow all stipulations under Usage
//    Modifications: You may modify this code as long as any modified libraries are also released under the
//         ARAMAKME v0.1 license and maintain sending a license_follow_rights_pecent to the stipulated license_canister configuration
//         and as long as no future modifier demands more than the license_follow_rights_percent remaining rights.
//    Merging: You may merge this library with another library provided you follow the following restrictions:
//         - you do not remove or modify the license payment code for existing functions
//         - you do not modify the receiving license_canister configuration
//         - you pay the license_check_cycles fee via code operation at least once every license_rate_reset nanoseconds for existing functions
//         - you pay the license_check_cycles fee via code operation at least once every min_license_rate, or rate dictated by the existing code execution for existing functions
//         - any new functions follow the license stipulations under "Modifications"
//    Publishing and distribution:  You may publish and distribute this library as text and source code as long as this license is included in the text.  Any binary
//         publication must include this license in the documentation. Any user leveraging the published library must also adhere to this
//         license.
//    Selling Copies:  You may sell copies of this library as long as this license is disclosed to any buyer and provided that the buyer
//         agrees, subject to the penalty of law, to adhere to this license. The seller must provide a schedule to the buyer of expected ongoing
//         costs expected in the operation of the code.
//    Sublicensing: This software may be sub-licensed as part of a larger license provided this license is disclosed to any licensee and provided that the licensee
//         agrees, subject to the penalty of law, to adhere to this license. The licensor must provide a schedule to the buyer of expected ongoing
//         costs expected in the operation of the code.
//    Canister Upgrades:  Canister upgrades will reset the library to the min_license_rate. After the first initialization, up to 10 initializations will be refunded every 30 days.
//    Usage tracking: You grant the canisters in license_canister the right to track calls and data about calls to the
//          update_license function. This data may be used to track usage and provide refunds based on that usage.
//    License Updates: The licensor reserves the right to change the configuration of the parameters of this license if the cost structure or topography of
//          of the Internet Computer changes.
//    Redistribution: 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the
//          disclaimer at the end of the license.  2. Redistributions in binary form must reproduce the above copyright notice,
//          this list of conditions and the following disclaimer in the documentation and/or other materials provided with the
//          distribution.
//    Payment for Use: The use of this software requires the periodic payment of license fees to a licensors and an optional distribution licensor.
//          Licensors have the responsibility of ensuring the continued operation of, improvement of, and promotion of the software.  Any transfer of a Licensor's distribution license
//          requires that the transfer of all responsibilities and obligations to the new owner.  Distribution licensors are expected to propose and support
//          improvements to the library. Original licensors are expected to update and improve the library as is necessary for technical operation and commercial usefulness of
//          the library.
//    Completeness:  This library is considered complete.  Any payments for distribution licenses should be considered to be for the restricted operation of this current library
//          and there should be no expectation of remuneration beyond what is required for the fulfillment of the distribution laid out in the ARAMAKME DISTRIBUTION LICENSE v0.1 license.
//          Future improvements to the library and operation rights are not guaranteed.
//    Collusion: The licensee agrees to not collude with other license holders to bypass the code or payment requirements of this license.
//
// This library is released withe ARAMAKME license v0.1 with the following parameters:
// license_check_cycles: 714_285_714_286
// license_rate_reset: 2_628_000_000_000_000
// min_license_rate: 100
// canister_min_cycles: 4_000_000_000_000
// license_discount_per_check_percent: 25
// license_follow_rights_percent: 20
// license_overrun_grace_periods: 100
// license_canister:
//      (hnvk4-laaaa-aaaai-aasmq-cai, null) : 100

// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
// BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
// SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
// OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// OFAC Compliance: Licensee agrees that they are currently in compliance with and shall at all times during the term of this Agreement (including any extension thereof) remain in
// compliance with the regulations of OFAC (including those named on OFAC’s Specially Designated Nationals and Blocked Persons List) and any statute, executive order (including the
// September 24, 2001, Executive Order Blocking Property and Prohibiting Transactions with Persons Who Commit, Threaten to Commit, or Support Terrorism), or other governmental action
// relating thereto. Further licensee will apply this same OFAC compliance clause to any distribution partner or user of this software. Violation of this clause will result in a license
// restriction and revocation.
///////////////////////////////

import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Result "mo:base/Result";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Int "mo:base/Int";
import Blob "mo:base/Blob";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Buffer "mo:base/Buffer";
import Candy "../candylib";
import ExperimentalCycles "mo:base/ExperimentalCycles";
import Debug "mo:base/Debug";
import AID "mo:aid/AccountId";
import hex "../candylib/hex";
import Time "mo:base/Time";
import Float "mo:base/Float";
import Token "./nft/token";
import Types "./nft/token";
import Static "./nft/static";
import Prim "mo:⛔";
import MapHelper "./nft/mapHelper";
import Http "./nft/http";
import Event "./nft/event";
import NFTTypes "./nft/types";
import LicenseManager "../candylib/licenseManager";
import List "mo:base/List";
import ExtCore "mo:ext/Core";
import ExtNonFungible "mo:ext/NonFungible";

shared(msg) actor class() = this {

    stable var owner : Principal = msg.caller;
    stable var createdAt : Int = Time.now();
    stable var aramakmeNFTLMCanister : Text = "hnvk4-laaaa-aaaai-aasmq-cai";
    stable var candyLMCanister : Text = "hdxhu-qqaaa-aaaai-aasnq-cai";

    let aramakmeNFTLM = LicenseManager.LicenseManager({
            min_license_rate = 100; //base number of calls
            license_discount_per_check_percent = 10; //10% discount each check
            license_rate_reset = 2_628_000_000_000_000; //30 days
            license_overrun_grace_periods = 10000; // you can go 100x over without error
            license_check_cycles = 714_285_714_286; //about a buck
            license_canister = [{canister  = aramakmeNFTLMCanister; percent = 100; distribution_license = null}]; //if you have a distribution license you want your customers to put the principal that owns your nft here
            //the funder license charges
            //  - 1% of cycles redeemed
            //  - $1 per 100 lines of code added
            //  - $1 per ICP raised up to $5 per funding transaction
            //  - about 50 cents per NFT handed out
            //  - about 50 cents per NFT transfer
        });

    ////////////
    //Ledger Types
    ////////////

    type Memo = Nat64;

    type ICPTs = {
        e8s : Nat64;
    };

    type AccountIdentifier = Text;

    type Transfer = {
        #Burn: {
            from: AccountIdentifier;
            amount: ICPTs;
        };
        #Mint: {
            to: AccountIdentifier;
            amount: ICPTs;
        };
        #Send: {
            from: AccountIdentifier;
            to: AccountIdentifier;
            amount: ICPTs;
        };
    };

    type TimeStamp = {
        timestamp_nanos: Nat64;
    };

    type Transaction = {
        transfer: Transfer;
        memo: Memo;
        created_at_time: TimeStamp;
    };

    type TipOfChain = {
        certification: ?Blob;
        tip_index: Nat64;
    };

    type Block = {
        parent_hash: ?{inner: Blob;};
        timestamp: TimeStamp;
        transaction: Transaction;
    };

    type LedgerActor = actor {
        block : (Nat64) -> async {#Ok: {#Ok: Block; #Err: Principal}; #Err: Text };
        tip_of_chain : () ->  async { #Ok: TipOfChain; #Err: Text };
    };

    type CycleWalletActor = actor {
        wallet_receive() : async ();
    };

    ////////////
    //Candy Types
    ////////////
    let candy : Candy.Candy = Candy.Candy({
            min_license_rate = 100_000; //base number of calls
            license_discount_per_check_percent = 10; //10% discount each check
            license_rate_reset = 2_628_000_000_000_000; //30 days
            license_overrun_grace_periods = 100; // you can go 100x over without error
            license_check_cycles = 714_285_714_286; //about a buck
            license_canister = [{canister  = candyLMCanister; percent = 100; distribution_license=null}];
            distribution_license = null; //if you have a distribution license you want your customers to put the principal that owns your nft here
            //the candy license charges $1 upon startup, at least once a month, and per 100,000 or more calls
        });

    type CandyValue = Candy.CandyValue;
    type CandyValueUnstable = Candy.CandyValueUnstable;
    type Workspace = Candy.Workspace;
    type DataZone = Candy.DataZone;
    type DataChunk = Candy.DataChunk;
    type AddressedChunkArray = Candy.AddressedChunkArray;
    type AddressedChunkBuffer = Candy.AddressedChunkBuffer;
    type CandyProperty = Candy.Property;
    type CandyPropertyUnstable = Candy.PropertyUnstable;

    ////////////
    //Canister Types
    ////////////
    type CodeLine = {
        sourceImage: Nat;
        line: Text;
        lineNumber: Nat;
        isNFT: Bool;
        nftID: ?Text;
        image: [Blob];
        order: Nat
    };

    stable var balancesEntries : [(Principal, Nat)] = [];  //upgrade storage for current credit balance
    stable var redemptionEntries : [(Nat64, Bool)] = []; //upgrade storage for used redemptions
    //stable var ledgerProxy : Text = "q4eej-kyaaa-aaaaa-aaaha-cai";
    stable var ledgerProxy : Text = "hewba-5iaaa-aaaai-aasna-cai"; //the proxy to retrieve candid typed transactions from
    stable var targetAccount = "ee3f4f56cf684b87a50f7f574c74765fe79b729adcf4867a8f0ae0ae45126571"; //account that ICP should be sent to to get credits
    stable var baseFee = 100_000_000; //should be 1 ICP
    stable var minCycles = 10_000_000_000_000; // the minimum cycles the canister needs before it can distribute rewards.
    stable var currentFee = baseFee;  // the current cost of one nft
    stable var feeIncreasePercent = 25; // the percentage to increase the current fee by each time an nft is purchased
    stable var discountPercentPerHour : Float = 0.2; //the discount to apply to the current fee each hour
    stable var codeLinesStable : [(Nat,CodeLine)] = []; // upgrade storage for the code lines collection
    stable var availableNFTsStable : [CodeLine] = []; // upgrade storage for the availible NFTs
    stable var currentCode : Text = ""; // currently revealed code
    stable var lastTimeAwarded : Int = createdAt; // keeps track of when the last nft was sold.  used for the discount
    stable var redemptionBucket : Nat = 0;  // keeps track of how many cycles have been sent for license payment that can be distributed to nft holders/owner
    stable var ownerBucket : Nat = 0; // keeps tracke of how many cycles the owner has been send during license checks
    stable var shareBankStable : [(Principal, Nat)] = []; //keeps track of the number of cycles a particular principal can collect
    stable var kycEntriesStable : [(Principal, Text)] = []; //upgrade storage for keeping track of the kyc info
    stable var initializedPrincipalsStable : [(Principal, (Int,Nat))] = [];
    stable var kycServer = "notset";
    stable var kycRequired : Bool = false;
    stable var logHistory : List.List<[CandyValue]> = List.nil<[CandyValue]>();

    let e8sInICP : Nat = 100_000_000; // 1 ICP

    //produces a unique has for all Nt64s up to the nat 32 size.  If we go past the
    //nat 32 max number of blocks this will break
    func Nat64Hash(n : Nat64) : Nat32{
        Nat32.fromNat(Nat64.toNat(Nat64.rem(n, 4_294_967_295)));
    };

    // holds the current balance of ICP sent to the target if there was change or not enough was sent to buy an NFT
    private var balances : HashMap.HashMap<Principal, Nat> = HashMap.fromIter<Principal, Nat>(balancesEntries.vals(), balancesEntries.size(), Principal.equal, Principal.hash);

    // holds the data about the different codelines in the library
    private var codeLines : HashMap.HashMap<Nat, CodeLine>  = HashMap.fromIter<Nat, CodeLine>(codeLinesStable.vals(), 2400, Nat.equal, Hash.hash);


    // holds the currently available NFTs. when they are gone, they are gone
    private var availableNFTs : Buffer.Buffer<CodeLine> = candy.toBuffer<CodeLine>(availableNFTsStable);

    // keeps track of the redemptions of ICP transactions so they can't be double spent
    private var redemptions : HashMap.HashMap<Nat64, Bool> = HashMap.fromIter<Nat64, Bool>(redemptionEntries.vals(), redemptionEntries.size(), Nat64.equal, Nat64Hash);

    //keeps track of the cycles that can be claimed by different principals
    private var shareBank : HashMap.HashMap<Principal, Nat> = HashMap.fromIter<Principal, Nat>(shareBankStable.vals(), shareBankStable.size(), Principal.equal, Principal.hash);

    //keeps track of the kyc of principals
    private var kycEntries : HashMap.HashMap<Principal, Text> = HashMap.fromIter<Principal, Text>(kycEntriesStable.vals(), kycEntriesStable.size(), Principal.equal, Principal.hash);

    //keeps track of who has intialized in the last 30 days
    private var initializedPrincipals : HashMap.HashMap<Principal, (Int,Nat)> = HashMap.fromIter<Principal, (Int,Nat)>(initializedPrincipalsStable.vals(), initializedPrincipalsStable.size(), Principal.equal, Principal.hash);

    //keeps track of the logs
    private var log : Buffer.Buffer<CandyValue> = Buffer.Buffer<CandyValue>(100);

    //handles logs and archiving logs
    private func appendLog(item : CandyValue) : (){

        if(log.size() > 999){
            logHistory := List.append<[CandyValue]>(logHistory, List.make<[CandyValue]>(log.toArray()));
            log := Buffer.Buffer<CandyValue>(1000);

        };
        log.add(item);
    };

    appendLog(#Class(
        [
            {name = "event"; value=#Text("class_init"); immutable= true;},
            {name = "time"; value=#Int(Time.now()); immutable= true;},
        ]
    ));

    // used to confirm transactions on the ledger
    var ledger : LedgerActor = actor(ledgerProxy);

    private func license_ready() : Bool {
        return aramakmeNFTLM.license_ready() or candy.__licenseManager.license_ready();
    };

    private func checkLicenses() : async (){
        if(aramakmeNFTLM.license_ready()){let ignoreFuture = aramakmeNFTLM.update_license()};
        if(candy.__licenseManager.license_ready()){let ignoreFuture = candy.__licenseManager.update_license()};
    };

    // returns the number of nft credits a particular principal has on file
    public query(msg) func creditBalanceOf(p : Text) : async ?Nat {
        assert(msg.caller == Principal.fromText(p) or msg.caller == owner);
        return balances.get(Principal.fromText(p));
    };

    // returns the number of cycles a particular principal has on file and can collect
    public query(msg) func cyclesBalanceOf(p : Text) : async ?Nat {
        assert(msg.caller == Principal.fromText(p) or msg.caller == owner);
        return shareBank.get(Principal.fromText(p));
    };



    // changes the owner of the canister
    // can only be called by the owner
    public shared(msg) func changeOwner(newPrincipal: Text) : async(){
        assert(owner == msg.caller);
        if(license_ready()){let ignoreFuture = checkLicenses();};
        appendLog(#Class(
            [
                {name = "event"; value=#Text("change_owner"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "old"; value=#Principal(owner); immutable= true;},
                {name = "new"; value=#Principal(Principal.fromText(newPrincipal)); immutable= true;},
            ]
        ));
        owner := Principal.fromText(newPrincipal);
        contractOwners := [owner];
        return;
    };

    // returns the owner of the canister
    public query(msg) func getOwner() : async Principal{
        return owner;
    };

    // updates the canister to use for checking transactions
    // can only be called by the owner
    public shared(msg) func updateLedgerProxy(newProxy : Text) : async () {
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};
        appendLog(#Class(
            [
                {name = "event"; value=#Text("update_ledger_proxy"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "old"; value=#Text(ledgerProxy); immutable= true;},
                {name = "new"; value=#Text(newProxy); immutable= true;},
            ]
        ));
        ledgerProxy := newProxy;
        ledger := actor(ledgerProxy);
    };

    // updates the canister to use for th candy license
    // can only be called by the owner
    public shared(msg) func updateCandyLMCanister(newCanister : Text) : async (){
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};
        appendLog(#Class(
            [
                {name = "event"; value=#Text("update_candylmcanister"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "old"; value=#Text(candyLMCanister); immutable= true;},
                {name = "new"; value=#Text(newCanister); immutable= true;},
            ]
        ));
        candyLMCanister := newCanister;
        //note: a an upgrade is required before this will take effect
    };

    // updates the canister to use for the aramakme license
    // can only be called by the owner
    public shared(msg) func updateAramakmeLMCanister(newCanister : Text) : async (){
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};
        appendLog(#Class(
            [
                {name = "event"; value=#Text("update_aramakmelmcanister"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "old"; value=#Text(aramakmeNFTLMCanister); immutable= true;},
                {name = "new"; value=#Text(newCanister); immutable= true;},
            ]
        ));
        aramakmeNFTLMCanister := newCanister;
        //note: a an upgrade is required before this will take effect
    };

    // updates the account buyers should send ICP to
    // can only be called by the owner
    public shared(msg) func updateTargetAccount(newAccount : Text) : async (){
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};
        appendLog(#Class(
            [
                {name = "event"; value=#Text("update_target_account"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "old"; value=#Text(targetAccount); immutable= true;},
                {name = "new"; value=#Text(newAccount); immutable= true;},
            ]
        ));
        targetAccount := newAccount;
    };

    // updates the account buyers should send ICP to
    // can only be called by the owner
    public query(msg) func getTargetAccount() : async Text{
        targetAccount;
    };

    // updates the current fee to a particular value
    // can only be called by the owner
    public shared(msg) func updateCurrentFee(newFee : Nat) : async (){
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};

        if(newFee >= baseFee){
            appendLog(#Class(
                [
                    {name = "event"; value=#Text("update_current_fee"); immutable= true;},
                    {name = "time"; value=#Int(Time.now()); immutable= true;},
                    {name = "old"; value=#Nat(currentFee); immutable= true;},
                    {name = "new"; value=#Nat(newFee); immutable= true;},
                ]
            ));
            currentFee := newFee;
        };
    };

    // force code update
    public shared(msg) func forceCodeUpdate() : async (){
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};

        buildCode();
    };

    // updates the current fee to a particular value
    // can only be called by the owner
    public shared(msg) func updateBaseFee(newFee : Nat) : async (){
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};


        appendLog(#Class(
            [
                {name = "event"; value=#Text("update_base_fee"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "old"; value=#Nat(baseFee); immutable= true;},
                {name = "new"; value=#Nat(newFee); immutable= true;},
            ]
        ));
        baseFee := newFee;

    };

    // updates the current setting for kyc requirements
    public shared(msg) func updateKYCRequired(setting : Bool) : async (){
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};
        appendLog(#Class(
            [
                {name = "event"; value=#Text("update_kyc_required"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "old"; value=#Bool(kycRequired); immutable= true;},
                {name = "new"; value=#Bool(setting); immutable= true;},
            ]
        ));
        kycRequired := setting;
    };

    // updates the kyc server
    public shared(msg) func updateKYCServer(setting : Text) : async(){
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};
        appendLog(#Class(
            [
                {name = "event"; value=#Text("update_kyc_server"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "old"; value=#Text(kycServer); immutable= true;},
                {name = "new"; value=#Text(setting); immutable= true;},
            ]
        ));
        kycServer := setting;
    };

    // update the last time awarded
    // can only be called by the owner
    public shared(msg) func updateLastTimeAwarded() : async (){
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};
        appendLog(#Class(
            [
                {name = "event"; value=#Text("update_kyc_server"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "old"; value=#Int(lastTimeAwarded); immutable= true;},
                {name = "new"; value=#Int(Time.now()); immutable= true;},
            ]
        ));
        lastTimeAwarded := Time.now();
    };

    // update the last min cycles
    // can only be called by the owner
    public shared(msg) func updateMinCycles(newVal : Nat) : async (){
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};
        appendLog(#Class(
            [
                {name = "event"; value=#Text("update_min_cycles"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "old"; value=#Nat(minCycles); immutable= true;},
                {name = "new"; value=#Nat(newVal); immutable= true;},
            ]
        ));
        minCycles := newVal;
    };

    // adds a code line to the codelines collection
    // can only be called by the owner
    public shared(msg) func addCodeLine(codeLine: CodeLine) : async Bool{
        assert(owner == msg.caller or msg.caller == Principal.fromText("3t3os-ikzuu-lqo4s-67wjg-oo3ms-hu3rh-s4yhb-gpoqg-fbfdv-cituf-sae"));
        //if(license_ready()){let ignoreFuture = checkLicenses();};
        //aramakmeNFTLM.check_license();
         var tracker = 0 : Nat;
         let thisLine = codeLines.get(codeLine.lineNumber);
         switch(thisLine){
             case(null){
                 Debug.print("adding line " # debug_show(codeLine.lineNumber) # "  " # debug_show(codeLine.image.size()) #  " " #  debug_show(codeLine.image[0].size()));
                 codeLines.put(codeLine.lineNumber, codeLine);
             };
             case(?thisLine){
                 let newLine = {
                    line = codeLine.line;
                    lineNumber = codeLine.lineNumber;
                    isNFT = codeLine.isNFT;
                    nftID = null;
                    image = Array.append<Blob>(thisLine.image, [codeLine.image[0]]);
                    order = codeLine.order;
                    sourceImage = codeLine.sourceImage;
                };

                codeLines.put(codeLine.lineNumber,newLine);

             }
         };
        /*
        appendLog(#Class(
            [
                {name = "event"; value=#Text("code_line_added"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "lineNumber"; value=#Nat(codeLine.lineNumber); immutable= true;},
                {name = "order"; value=#Nat(codeLine.order); immutable= true;},
                {name = "line"; value=#Text(codeLine.line); immutable= true;},
                {name = "isNFT"; value=#Bool(codeLine.isNFT); immutable= true;},
            ]
        ));
        */

        return true;
    };

    // gets a summary of the codelines
    // can only be called by the owner
    public query(msg) func getCodeLines() : async [CodeLine]{
        assert(owner == msg.caller);
        let items :Buffer.Buffer<CodeLine> = Buffer.Buffer<CodeLine>(codeLines.size());

        for(thisItem in codeLines.entries()){
            items.add({
                    line = thisItem.1.line;
                    lineNumber = thisItem.1.lineNumber;
                    isNFT = thisItem.1.isNFT;
                    nftID = thisItem.1.nftID;
                    image = [];
                    order = thisItem.1.order;
                    sourceImage = thisItem.1.sourceImage;
            });

        };
        return items.toArray();
        /*
        Array.tabulate<CodeLine>(codeLines.size(), func(x){
            let thisCodeLine = Option.unwrap(codeLines.get(x+1));
            return {
                    line = thisCodeLine.line;
                    lineNumber = thisCodeLine.lineNumber;
                    isNFT = thisCodeLine.isNFT;
                    nftID = thisCodeLine.nftID;
                    image = if(thisCodeLine.image.size() > 0){[thisCodeLine.image[0],thisCodeLine.image[1],thisCodeLine.image[2],thisCodeLine.image[3],thisCodeLine.image[4],thisCodeLine.image[5],thisCodeLine.image[6],thisCodeLine.image[7]]} else {[]};
                    order = thisCodeLine.order;
                    sourceImage = thisCodeLine.sourceImage;
            }
        });
        */

    };

    // clears out all the code lines, redeptions, NFTs.  basically lets you start over
    // can only be called by the owner
    public shared(msg) func clearCodeLines() : async Bool{
        assert(owner == msg.caller);
        if(license_ready()){let ignoreFuture = checkLicenses();};

        appendLog(#Class(
                    [
                        {name = "event"; value=#Text("clear_code_lines"); immutable= true;},
                        {name = "time"; value=#Int(Time.now()); immutable= true;},

                    ]
                ));

        codeLines := HashMap.HashMap<Nat, CodeLine>(2400, Nat.equal, Hash.hash);
        availableNFTs := Buffer.Buffer<CodeLine>(1500);
        redemptions := HashMap.fromIter<Nat64, Bool>(redemptionEntries.vals(), redemptionEntries.size(), Nat64.equal, Nat64Hash);
        nfts := Token.NFTs(
            0,
            0,
            [],
        );
        INITALIZED := false;
        return true;
    };

    // clears out all the code lines, redeptions, NFTs.  basically lets you start over
    // can only be called by the owner
    public shared(msg) func clearNFTs() : async Bool{
        assert(owner == msg.caller);
        if(license_ready()){let ignoreFuture = checkLicenses();};



        availableNFTs := Buffer.Buffer<CodeLine>(1500);
        redemptions := HashMap.fromIter<Nat64, Bool>(redemptionEntries.vals(), redemptionEntries.size(), Nat64.equal, Nat64Hash);
        nfts := Token.NFTs(
            0,
            0,
            [],
        );
        INITALIZED := false;
        return true;
    };

    // clears out all the code lines, redeptions, NFTs.  basically lets you start over
    // can only be called by the owner
    public query(msg) func getNFTs() : async [(Text, (?Principal, [Principal]), Token.Token)]{
        assert(owner == msg.caller);
        let results = Buffer.Buffer<(Text, (?Principal, [Principal]), Token.Token)>(200);
        for(thisItem in nfts.entries()){
            results.add(thisItem.0, thisItem.1, {
                payload =[];
                contentType = thisItem.2.contentType;
                properties = thisItem.2.properties;
                isPrivate = thisItem.2.isPrivate;
                createdAt  = thisItem.2.createdAt;
            })
        };


        return results.toArray();
    };

    // clears out all the code lines, redeptions, NFTs.  basically lets you start over
    // can only be called by the owner
    public shared(msg) func clear102() : async Bool{
        assert(owner == msg.caller);
        if(license_ready()){let ignoreFuture = checkLicenses();};

        let item = codeLines.remove(102);
        return true;
    };

    // called by the candy library to send cycles to this canister
    public func adminGiveCycles(principal: Text, amount : Nat) : async Bool{
        assert(owner == msg.caller);

        appendLog(#Class(
            [
                {name = "event"; value=#Text("admin_cycle_award"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "amount"; value=#Nat(amount); immutable= true;},
                {name = "principal"; value=#Text(principal); immutable= true;},

            ]
        ));
        let share = switch(shareBank.get(Principal.fromText(principal))){
            case(null){0};
            case(?v){v};
        };

        shareBank.put(Principal.fromText(principal), share + amount);


        return true;
    };


    // called by the candy library to send cycles to this canister
    public shared(msg) func __updateLicense(amount : Nat, distribution_license: ?Text) :async Bool{
        assert(ExperimentalCycles.available() > 50_000_000);
        //Dont check license here because it may cause a cycle overrun if a string of checks occur
        //if(license_ready()){let ignoreFuture = checkLicenses();};

        //make sure this principal hasn't initialized in last 30 days
        if(amount == 0){
            switch(initializedPrincipals.get(msg.caller)){
                case(null){};
                case(?val){
                    if(Time.now() < val.0 + aramakmeNFTLM.config.license_rate_reset){
                        //gets 10 free initializations a month
                        if(val.1 < 10){
                            appendLog(#Class(
                                [
                                    {name = "event"; value=#Text("free_init"); immutable= true;},
                                    {name = "time"; value=#Int(Time.now()); immutable= true;},
                                    {name = "principal"; value=#Principal(msg.caller); immutable= true;},
                                    {name = "occurance"; value=#Nat(val.1+1); immutable= true;},

                                ]
                            ));
                            initializedPrincipals.put(msg.caller, (val.0, val.1 + 1));
                            //they have inited within the last 30 days. refund
                            return true;
                        };
                    };
                };
            };
        };

        initializedPrincipals.put(msg.caller, (Time.now(),0));

        var shortage = 0;
        let balance = ExperimentalCycles.balance();

        if(balance < minCycles){
            shortage :=  minCycles - ExperimentalCycles.balance();
        };

        var licenseCycles = ExperimentalCycles.accept(ExperimentalCycles.available());

        if(licenseCycles >= aramakmeNFTLM.get_license_info().license_check_cycles){
            aramakmeNFTLM.check_license_n((licenseCycles/aramakmeNFTLM.get_license_info().license_check_cycles)); //send 1% to aramakme
        } else {
            aramakmeNFTLM.check_license(); //send 1% to aramakme
        };

        if(shortage > 0 and shortage > licenseCycles){
            //do nothing. These all need to be reserved
            return true;
        } else if(shortage > 0){
            licenseCycles := licenseCycles - shortage;
        };

        var share = licenseCycles / 5;
        var shareText = "";
        switch(distribution_license){
            case(null){
                share := 0;
            };
            case(?distribution_license){
                //make sure this is a valid distribution license
                let nftOwner = nfts.ownerOf(distribution_license);
                switch(nftOwner){
                    case(#ok(nftOwner)){
                        shareText := Principal.toText(nftOwner);
                        let currentBalance = switch(shareBank.get(nftOwner)){
                            case(null){0};
                            case(?val){val};
                        };
                        shareBank.put(nftOwner, share + currentBalance);
                    };
                    case(#err(err)) {
                        share :=0;
                    };
                };
            };
        };

        appendLog(#Class(
            [
                {name = "event"; value=#Text("license_update"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "principal"; value=#Principal(msg.caller); immutable= true;},
                {name = "amount"; value=#Nat(amount); immutable= true;},
                {name = "owner_cycles"; value=#Nat(licenseCycles); immutable= true;},
                {name = "share_cycles"; value=#Nat(share); immutable= true;},
                {name = "share_principal"; value=#Text(shareText); immutable= true;},
            ]
        ));

        ownerBucket += (licenseCycles - share);

        return true;
    };



    //lets the owner withdraw the amount in ownerBucket
    public shared(msg) func wallet_withdraw(cycle_wallet: Text, amount : Nat) : async Bool {
        assert(owner == msg.caller and ownerBucket > amount);
        if(license_ready()){let ignoreFuture = checkLicenses();};

        let remoteWallet : CycleWalletActor = actor(cycle_wallet);
        ExperimentalCycles.add(amount);
        let resultAmount = remoteWallet.wallet_receive();

        appendLog(#Class(
            [
                {name = "event"; value=#Text("wallet_withdraw"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "principal"; value=#Principal(msg.caller); immutable= true;},
                {name = "amount"; value=#Nat(amount); immutable= true;},
                {name = "cycle_wallet"; value=#Text(cycle_wallet); immutable= true;},
            ]
        ));
        return true;
    };


    // allows a principal to claim their cycles and send them to the corrosponding cylcles wallet.
    // provide null for amount to move the entire balance
    public shared(msg) func collect_share(cycle_wallet: Text, amount : ?Nat) : async Result.Result<Nat, Text> {

        let textCaller = Principal.toText(msg.caller);
        if(license_ready()){let ignoreFuture = checkLicenses();};

        if(kycRequired == true){
            switch(kycEntries.get(msg.caller)){
                case(null) {
                    appendLog(#Class(
                            [
                                {name = "event"; value=#Text("collect_fail_kyc"); immutable= true;},
                                {name = "time"; value=#Int(Time.now()); immutable= true;},
                                {name = "principal"; value=#Principal(msg.caller); immutable= true;},
                                {name = "amount"; value=switch(amount){case(null){#Option(null)}; case(?v)(#Option(?#Nat(v)));}; immutable= true;},
                                {name = "cycle_wallet"; value=#Text(cycle_wallet); immutable= true;},
                            ]
                        ));
                    return #err("KYC required for " # textCaller)};
                case(?val) {
                    if(val.size() == 0){
                        appendLog(#Class(
                            [
                                {name = "event"; value=#Text("collect_fail_kyc"); immutable= true;},
                                {name = "time"; value=#Int(Time.now()); immutable= true;},
                                {name = "principal"; value=#Principal(msg.caller); immutable= true;},
                                {name = "amount"; value=switch(amount){case(null){#Option(null)}; case(?v)(#Option(?#Nat(v)));}; immutable= true;},
                                {name = "cycle_wallet"; value=#Text(cycle_wallet); immutable= true;},
                            ]
                        ));
                        return #err("KYC required for " # textCaller);
                    };
                };
            };
        };


        //validate that the nft is not restricted and exists
        let entries = nfts.tokensOf(msg.caller);
        for(thisItem in entries.vals()){

            let thisNFT = switch(nfts.getToken(thisItem)){
                case(#ok(val)){val};
                case(#err(err)){return #err("cannot find nft")};
            };

            switch(candy.getProperties(thisNFT.properties, [{name="restricted"; next=[]}])){
                case(#ok(val)){

                    if(val.size() > 0){

                        if(candy.valueToBool(val[0].value) == true){
                            appendLog(#Class(
                                [
                                    {name = "event"; value=#Text("collect_fail_restriction"); immutable= true;},
                                    {name = "time"; value=#Int(Time.now()); immutable= true;},
                                    {name = "principal"; value=#Principal(msg.caller); immutable= true;},
                                    {name = "amount"; value=switch(amount){case(null){#Option(null)}; case(?v)(#Option(?#Nat(v)));}; immutable= true;},
                                    {name = "cycle_wallet"; value=#Text(cycle_wallet); immutable= true;},
                                ]
                            ));
                            return #err("principal " # Principal.toText(msg.caller) # " is restricted on license " # thisItem)}
                    };
                };
                case(#err(err)){
                    //doesnt exist
                };
            };

        };

        var totalShare = 0;

        let redeembank = shareBank.get(msg.caller);
        let redeemBalance = switch redeembank {
            case(null){0};
            case(?val){val};
        };

        var authAmount = switch(amount){
            case(null){redeemBalance};
            case(?val){val};
        };

        //make sure we have more than the minimum cycles in the canister of no one can claim

        if((minCycles + authAmount < ExperimentalCycles.balance()) == false){
            appendLog(#Class(
                [
                    {name = "event"; value=#Text("collect_fail_min_cycles"); immutable= true;},
                    {name = "time"; value=#Int(Time.now()); immutable= true;},
                    {name = "principal"; value=#Principal(msg.caller); immutable= true;},
                    {name = "amount"; value=switch(amount){case(null){#Option(null)}; case(?v)(#Option(?#Nat(v)));}; immutable= true;},
                    {name = "balance"; value=#Nat(ExperimentalCycles.balance()); immutable= true;},
                    {name = "cycle_wallet"; value=#Text(cycle_wallet); immutable= true;},
                ]
            ));
            return #err("canister is below the min cycle level");
        };

        if(redeemBalance >= authAmount){
            if(redeemBalance > 714_285_714_286){ //must be more than a buck
                let remoteWallet : CycleWalletActor = actor(cycle_wallet);
                //this need to go before sending to avoid rentry. https://forum.dfinity.org/t/throwing-during-a-cycle-transfer/7482
                shareBank.put(msg.caller, redeemBalance - authAmount ); //reset their bank to 0
                ExperimentalCycles.add(authAmount);

                appendLog(#Class(
                    [
                        {name = "event"; value=#Text("collect_share"); immutable= true;},
                        {name = "time"; value=#Int(Time.now()); immutable= true;},
                        {name = "principal"; value=#Principal(msg.caller); immutable= true;},
                        {name = "amount"; value=switch(amount){case(null){#Option(null)}; case(?v)(#Option(?#Nat(v)));}; immutable= true;},
                        {name = "cycle_wallet"; value=#Text(cycle_wallet); immutable= true;},
                    ]
                ));
                let resultAmount = await remoteWallet.wallet_receive();

                return #ok(redeemBalance);
            } else {
                appendLog(#Class(
                    [
                        {name = "event"; value=#Text("collect_fail_low_collect"); immutable= true;},
                        {name = "time"; value=#Int(Time.now()); immutable= true;},
                        {name = "principal"; value=#Principal(msg.caller); immutable= true;},
                        {name = "amount"; value=switch(amount){case(null){#Option(null)}; case(?v)(#Option(?#Nat(v)));}; immutable= true;},
                        {name = "cycle_wallet"; value=#Text(cycle_wallet); immutable= true;},
                    ]
                ));
                return #err("not enough cycles to transfer. 714_285_714_286 required");
            };
        } else {
            appendLog(#Class(
                [
                    {name = "event"; value=#Text("collect_fail_invalid"); immutable= true;},
                    {name = "time"; value=#Int(Time.now()); immutable= true;},
                    {name = "principal"; value=#Principal(msg.caller); immutable= true;},
                    {name = "amount"; value=switch(amount){case(null){#Option(null)}; case(?v)(#Option(?#Nat(v)));}; immutable= true;},
                    {name = "share"; value=#Nat(redeemBalance); immutable= true;},
                    {name = "cycle_wallet"; value=#Text(cycle_wallet); immutable= true;},
                ]
            ));
            return #err("amount requested is greater than available");
        };



    };

    // allows the owner to restrict an nft if the owner violates the license.
    public shared(msg) func restrict(id: Text, value: Bool) : async Result.Result<Bool, Text> {
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};

        let thisNFT = switch(nfts.getToken(id)){
            case(#ok(val)){val};
            case(_){ return #err("cannot find nft");}
        };

        switch(candy.getProperties(thisNFT.properties, [{name="restricted"; next=[]}])){
            case(#ok(val)){
                if(val.size() > 0){


                    let newProps = Array.tabulate<CandyProperty>(thisNFT.properties.size(), func(x){
                            if(thisNFT.properties[x].name == "restricted"){
                                return {
                                    name = thisNFT.properties[x].name;
                                    value = #Bool(value);
                                    immutable = thisNFT.properties[x].immutable;
                                };
                            } else {
                                return {
                                    name = thisNFT.properties[x].name;
                                    value = thisNFT.properties[x].value;
                                    immutable = thisNFT.properties[x].immutable;
                                };
                            };
                    });

                    let update = nfts.updateProperties(id, newProps);
                };
            };
            case(#err(err)){
                let newValue = let newValue = {
                            name = "restricted";
                            value = #Bool(value);
                            immutable = true;
                        };

                    let newProps = Array.append<CandyProperty>(thisNFT.properties, Array.make<CandyProperty>(newValue));

                    let update = nfts.updateProperties(id, newProps);
            };
        };

         appendLog(#Class(
                [
                    {name = "event"; value=#Text("restriction_updated"); immutable= true;},
                    {name = "time"; value=#Int(Time.now()); immutable= true;},
                    {name = "principal"; value=#Text(id); immutable= true;},
                    {name = "owner"; value=#Principal(owner); immutable= true;},
                    {name = "value"; value=#Bool(value); immutable= true;},
                ]
            ));

        return #ok(true);

    };

    // allows a principal to submit kyc info if required
    public shared(msg) func submit_kyc(kycInfo: Text, principal: Text) : async Result.Result<Bool, Text> {
        assert(msg.caller == owner or Principal.toText(msg.caller) == kycServer);

        if(license_ready()){let ignoreFuture = checkLicenses();};
        appendLog(#Class(
                [
                    {name = "event"; value=#Text("kyc_added"); immutable= true;},
                    {name = "time"; value=#Int(Time.now()); immutable= true;},
                    {name = "caller"; value=#Principal(msg.caller); immutable= true;},
                    {name = "principal"; value=#Principal(owner); immutable= true;},
                ]
            ));
        kycEntries.put(Principal.fromText(principal), kycInfo);
        return #ok(true);
    };


    // builds the code and stores it in the current code variable
    private func buildCode(){
        var code : Text = "";
        var tracker = 1;
        while(tracker < codeLines.size()+1){
            let thisItem = Option.unwrap(codeLines.get(tracker));
            if(thisItem.isNFT == true){
                if(thisItem.image.size() > 0){
                    code := code # "*********  This line has not been unlocked  **********" # "\n";
                } else{

                    code := code # thisItem.line # "\n";
                };
            } else {
                code := code # thisItem.line # "\n";
            };
            tracker += 1;
        };
        currentCode := code;
        return;
    };

    //returns the current state of the revealed library
    public query func getCode() : async Text{
        currentCode;
    };

    //
    //public func getDestinationAccountID() : async Text{
    //    hex.encode(AID.fromPrincipal(Principal.fromActor(this), null));
    //};

    public query(msg) func getDefaultAccountID() : async Text{
        hex.encode(AID.fromPrincipal(msg.caller, null));
    };

    // calculates the current fee for an nft that includes the time discount
    private func calcCurrentFee() : Nat {
        //calculate the new fee based on time elapsed
        var aFee = currentFee;
        if(lastTimeAwarded > 0){
            let discountRatio = Float.pow(discountPercentPerHour, ((Float.fromInt(Time.now() - lastTimeAwarded))/(3_600_000_000_000:Float * 48:Float) ));
            aFee := candy.valueToNat(#Float(Float.fromInt(currentFee) * discountRatio));
            if(aFee < baseFee){
                aFee := baseFee;
            };
        };
        return aFee;
    };



    public shared(msg) func getCurrentLog() : async [CandyValue]{
        assert(msg.caller == owner);
        appendLog(#Class(
                [
                    {name = "event"; value=#Text("log_retrieve"); immutable= true;},
                    {name = "time"; value=#Int(Time.now()); immutable= true;},
                    {name = "caller"; value=#Principal(msg.caller); immutable= true;}
                ]
            ));
        log.toArray();
    };

    public shared(msg) func getLogHistory(page : Nat) : async ([CandyValue], Nat){
        assert(msg.caller == owner);
        let result = switch(List.get<[CandyValue]>(logHistory, page)){
            case(null){([#Empty], List.size<[CandyValue]>(logHistory))};
            case(?v){(v, List.size<[CandyValue]>(logHistory))};
        };

        appendLog(#Class(
            [
                {name = "event"; value=#Text("log_retrieve_history"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "page"; value=#Nat(page); immutable= true;}
            ]
        ));
        return result;
    };

    // redeems an ICP transaction and then claims NFTs
    // provide null for block if current credit balance is greater than price
    public shared(msg) func redeemAndClaim(block: ?Nat64, agree: Bool) : async Result.Result<(Nat, [Text]), Text> {
        assert(agree == true);
        if(license_ready()){let ignoreFuture = checkLicenses();};
        var newBalance : Nat = 0;
        let currentBalance = balances.get(msg.caller);


        switch(currentBalance){
            case(?currentBalance){
                newBalance := currentBalance;
            };
            case(_){};
        };

        switch(block){
            case(?block){
                let t : {#Ok: {#Ok: Block; #Err: Principal}; #Err: Text } = await ledger.block(block);
                switch(t){
                    case(#Err(errText)){
                        appendLog(#Class(
                            [
                                {name = "event"; value=#Text("redeem_bad_block"); immutable= true;},
                                {name = "time"; value=#Int(Time.now()); immutable= true;},
                                {name = "block"; value=#Nat64(block); immutable= true;},
                                {name = "caller"; value=#Principal(msg.caller); immutable= true;}
                            ]
                        ));
                        return #err("cant find block " # errText);
                    };
                    case(#Ok(blockResult)){
                        switch(blockResult){
                            case(#Err(errText)){
                                appendLog(#Class(
                                    [
                                        {name = "event"; value=#Text("redeem_bad_block_result"); immutable= true;},
                                        {name = "time"; value=#Int(Time.now()); immutable= true;},
                                        {name = "block"; value=#Nat64(block); immutable= true;},
                                        {name = "caller"; value=#Principal(msg.caller); immutable= true;}
                                    ]
                                ));
                                return #err("cant find block result " # Principal.toText(errText));
                            };
                            case(#Ok(actualblock)){
                                switch(actualblock.transaction.transfer){
                                    case(#Send(details)){
                                        //check that this block hasnt been redeemed
                                        let foundRedemptions = redemptions.get(block);
                                        switch(foundRedemptions){
                                            case(null){
                                                if(details.to == targetAccount){
                                                    //check that this is from the calling principal's root account DO NOT USE A LINKED ACCOUNT or any nonce but 0
                                                    let expectedID = hex.encode(AID.fromPrincipal(msg.caller, null));
                                                    if(expectedID == details.from){
                                                        //a valid redemption

                                                        newBalance := newBalance + Nat64.toNat(details.amount.e8s);

                                                        if((details.amount.e8s < details.amount.e8s * 5)){
                                                            aramakmeNFTLM.check_license_n((Nat64.toNat(details.amount.e8s) * 100)/e8sInICP); //send up to $5 to aramakme
                                                        } else {
                                                            aramakmeNFTLM.check_license_n(500); //send a max of $5 to aramakme
                                                        };

                                                        redemptions.put(block, true);
                                                        appendLog(#Class(
                                                            [
                                                                {name = "event"; value=#Text("redeem_block"); immutable= true;},
                                                                {name = "time"; value=#Int(Time.now()); immutable= true;},
                                                                {name = "block"; value=#Nat64(block); immutable= true;},
                                                                {name = "caller"; value=#Principal(msg.caller); immutable= true;},
                                                                {name = "amount"; value=#Nat(Nat64.toNat(details.amount.e8s)); immutable= true;},
                                                                {name = "new_balance"; value=#Nat(newBalance); immutable= true;},
                                                            ]
                                                        ));
                                                    } else {
                                                        return #err("Was not sent from root account of this principal.  Expected Account " # expectedID);
                                                    };
                                                } else {
                                                    return #err("ICP was not sent to target account " # targetAccount);
                                                };

                                            };
                                            case(?foundRedemptions){
                                                if(foundRedemptions == true){
                                                    appendLog(#Class(
                                                            [
                                                                {name = "event"; value=#Text("redeem_failed_dup"); immutable= true;},
                                                                {name = "time"; value=#Int(Time.now()); immutable= true;},
                                                                {name = "block"; value=#Nat64(block); immutable= true;},
                                                                {name = "caller"; value=#Principal(msg.caller); immutable= true;}

                                                            ]
                                                        ));
                                                    return #err("already redeemed");
                                                } else {
                                                    //shouldnt be here. never write false
                                                    appendLog(#Class(
                                                            [
                                                                {name = "event"; value=#Text("redeem_failed_funky"); immutable= true;},
                                                                {name = "time"; value=#Int(Time.now()); immutable= true;},
                                                                {name = "block"; value=#Nat64(block); immutable= true;},
                                                                {name = "caller"; value=#Principal(msg.caller); immutable= true;}

                                                            ]
                                                        ));
                                                    return #err("something funky");
                                                };

                                            };
                                        }

                                    };
                                    case(_){
                                        appendLog(#Class(
                                            [
                                                {name = "event"; value=#Text("redeem_failed_transaction_type"); immutable= true;},
                                                {name = "time"; value=#Int(Time.now()); immutable= true;},
                                                {name = "block"; value=#Nat64(block); immutable= true;},
                                                {name = "caller"; value=#Principal(msg.caller); immutable= true;}

                                            ]
                                        ));
                                        return #err("not a valid transaction type")
                                    }
                                }
                            };
                        };
                    };

                };
            };
            case(null){

            };
        };

        let awardedNFTs = Buffer.Buffer<Text>(1);

        //calculate the new fee based on time elapsed
        var aFee = calcCurrentFee();

        if(newBalance >= aFee and availableNFTs.size() > 0){
            let nftIndex = candy.valueToNat(#Nat32(Hash.hash(Int.abs(Time.now()) % 4_294_967_295))) % availableNFTs.size();
            let thisNFT = availableNFTs.get(nftIndex);

            //nfts.writeStagedSync(#Chunks(candy.toBuffer<Blob>(availableNFTs.get(nftIndex).image)));
            Debug.print("about to egg" # debug_show(nftIndex) # " " # debug_show(availableNFTs.get(nftIndex).image[0].size())) ;
            let egg = {
                payload = #Payload(availableNFTs.get(nftIndex).image[0]);
                //payload = #StagedData;
                contentType = "image/png";
                owner = ?msg.caller;
                properties = [
                    {
                        name = "line";
                        value = #Text(thisNFT.line);
                        immutable = true;
                    },
                    {
                        name = "lineNumber";
                        value = #Text(Nat.toText(thisNFT.lineNumber));
                        immutable = true;
                    },
                    {
                        name = "baseImage";
                        value = #Nat(thisNFT.sourceImage);
                        immutable = true;
                    },
                    {
                        name = "dateMinted";
                        value = #Int(Time.now());
                        immutable = true;
                    },
                    {
                        name = "originalPrice";
                        value = #Nat(aFee);
                        immutable = true;
                    },
                    {
                        name = "originalCreator";
                        value = #Principal(Principal.fromText("3t3os-ikzuu-lqo4s-67wjg-oo3ms-hu3rh-s4yhb-gpoqg-fbfdv-cituf-sae"));
                        immutable = true;
                    },
                    {
                        name = "license";
                        value = #Text("Image Content License: ARAMAKME hereby grants the cryptograpically secure bearer of this non-fungible image a royalty-free, nonexclusive, worldwide, license to display, reproduce, distribute, and otherwise use and exploit all Content in this digital object.  All legal transfers, subject to the jurisdictions of the parties, are authorized provide 1% of the sales price is remitted to ARAMAKME at the target address.  The bearer takes on all responsibility to maintain the cycles requred to store the image.");
                        immutable = true;
                    },
                    {
                        name = "ownerList";
                        value = #Array(#frozen([
                            #Class([{
                                name = "principal";
                                value = #Principal(Principal.fromText("3t3os-ikzuu-lqo4s-67wjg-oo3ms-hu3rh-s4yhb-gpoqg-fbfdv-cituf-sae"));
                                immutable = true;
                                },
                                {
                                name = "ownedAt";
                                value = #Int(createdAt);
                                immutable = true;
                                },
                                ]),
                            #Class([{
                                name = "principal";
                                value = #Principal(msg.caller);
                                immutable = true;
                                },
                                {
                                name = "ownedAt";
                                value = #Int(Time.now());
                                immutable = true;
                                },
                                ])
                        ]));
                        immutable = false;
                    },
                    {
                        name = "originalOwner";
                        value = #Principal(msg.caller);
                        immutable = true;
                    }];
                    isPrivate = false;
                    desiredID = ?Nat.toText(thisNFT.lineNumber);

            };
            Debug.print("done with eg");

            let (id, nftowner) = await nfts.mint(Principal.fromActor(this), egg);
            Debug.print("done with mint");
            awardedNFTs.add(id);

            appendLog(#Class(
                [
                    {name = "event"; value=#Text("nft_award"); immutable= true;},
                    {name = "time"; value=#Int(Time.now()); immutable= true;},
                    {name = "id"; value=#Text(id); immutable= true;},
                    {name = "principal"; value=#Principal(msg.caller); immutable= true;},
                    {name = "fee"; value=#Nat(aFee); immutable= true;}

                ]
            ));

            //update balances
            newBalance := newBalance - aFee;
            currentFee := (aFee * (100 + feeIncreasePercent))/100;
            if(currentFee > 20_000 * e8sInICP){
                currentFee := 20_000 * e8sInICP;
            };

            aFee := currentFee;

            //remove the selected nft
            availableNFTs := candy.toBuffer<CodeLine>(Array.filter<CodeLine>(availableNFTs.toArray(), func(x){ x.lineNumber != thisNFT.lineNumber}));
            lastTimeAwarded := Time.now();
            aramakmeNFTLM.check_license_n(50); //send 50 cents an NFT

            let oldCodeLine = Option.unwrap(codeLines.get(thisNFT.lineNumber));
            let updatedCodeLine = {
                    line = oldCodeLine.line;
                    lineNumber = oldCodeLine.lineNumber;
                    isNFT = oldCodeLine.isNFT;
                    nftID = ?id;
                    image = []; //empty because we moved it to the NFT
                    order = oldCodeLine.order;
                    sourceImage = oldCodeLine.sourceImage;
            };

            codeLines.put(thisNFT.lineNumber, updatedCodeLine);
            balances.put(msg.caller, newBalance);
            Debug.print("done with award");
        };

        balances.put(msg.caller, newBalance);
        Debug.print("balance done");
        appendLog(#Class(
            [
                {name = "event"; value=#Text("balance_updated"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "principal"; value=#Principal(msg.caller); immutable= true;},
                {name = "new_balance"; value=#Nat(newBalance); immutable= true;}
            ]
        ));
        Debug.print("building code");
        buildCode();
        Debug.print("done code");

        appendLog(#Class(
            [
                {name = "event"; value=#Text("redeem_and_claim_complete"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "last_time_awarded"; value=#Int(lastTimeAwarded); immutable= true;},
                {name = "current_fee"; value=#Nat(currentFee); immutable= true;}


            ]
        ));
        Debug.print("at end func");
        return #ok((newBalance, awardedNFTs.toArray()));
    };

    public shared(msg) func adminClaim(line : Nat, principal : Text) : async Bool{
        assert(msg.caller == owner);
        if(license_ready()){let ignoreFuture = checkLicenses();};
        var nftIndex = 0;
        aramakmeNFTLM.check_license_n(50); //send a max of 50 cents per nft
        var thisNFT : ?CodeLine = null;
        label find for(thisItem in availableNFTs.vals()){
            if(thisItem.lineNumber == line){
                thisNFT := ?thisItem;
                break find;
            };
            nftIndex += nftIndex;
        };

        if(nftIndex >= availableNFTs.size()){
            appendLog(#Class(
                [
                    {name = "event"; value=#Text("admin_claim_fail_bounds"); immutable= true;},
                    {name = "time"; value=#Int(Time.now()); immutable= true;},
                    {name = "line"; value=#Nat(line); immutable= true;},
                    {name = "caller"; value=#Principal(msg.caller); immutable= true;},
                    {name = "principal"; value=#Text(principal); immutable= true;},

                ]
            ));
            return false;
        };

        //let thisNFT = availableNFTs.get(nftIndex);
        switch(thisNFT){
            case(null){};
            case(?thisNFT){

                //nfts.writeStagedSync(#Chunks(candy.toBuffer<Blob>(thisNFT.image)));

                let egg = {
                    //payload = #StagedData;
                    payload = #Payload(thisNFT.image[0]);
                    contentType = "image/png";
                    owner = ?msg.caller;
                    properties = [
                        {
                            name = "line";
                            value = #Text(thisNFT.line);
                            immutable = true;
                        },
                        {
                            name = "lineNumber";
                            value = #Text(Nat.toText(thisNFT.lineNumber));
                            immutable = true;
                        },
                        {
                            name = "baseImage";
                            value = #Nat(thisNFT.sourceImage);
                            immutable = true;
                        },
                        {
                            name = "dateMinted";
                            value = #Int(Time.now());
                            immutable = true;
                        },
                        {
                            name = "originalPrice";
                            value = #Nat(0);
                            immutable = true;
                        },
                        {
                            name = "originalCreator";
                            value = #Principal(Principal.fromText("3t3os-ikzuu-lqo4s-67wjg-oo3ms-hu3rh-s4yhb-gpoqg-fbfdv-cituf-sae"));
                            immutable = true;
                        },
                        {
                            name = "ownerList";
                            value = #Array(#frozen([
                                #Class([{
                                    name = "principal";
                                    value = #Principal(Principal.fromText("3t3os-ikzuu-lqo4s-67wjg-oo3ms-hu3rh-s4yhb-gpoqg-fbfdv-cituf-sae"));
                                    immutable = true;
                                    },
                                    {
                                    name = "ownedAt";
                                    value = #Int(createdAt);
                                    immutable = true;
                                    },
                                    ]),
                                #Class([{
                                    name = "principal";
                                    value = #Principal(Principal.fromText(principal));
                                    immutable = true;
                                    },
                                    {
                                    name = "ownedAt";
                                    value = #Int(Time.now());
                                    immutable = true;
                                    },
                                    ])
                            ]));
                            immutable = false;
                        },
                        {
                            name = "originalOwner";
                            value = #Principal(Principal.fromText(principal));
                            immutable = true;
                        }];
                        isPrivate = false;
                        desiredID = ?Nat.toText(thisNFT.lineNumber);

                };

                let (id, nftowner) = await nfts.mint(Principal.fromActor(this), egg);

                appendLog(#Class(
                    [
                        {name = "event"; value=#Text("nft_award_admin"); immutable= true;},
                        {name = "time"; value=#Int(Time.now()); immutable= true;},
                        {name = "line"; value=#Nat(line); immutable= true;},
                        {name = "caller"; value=#Principal(msg.caller); immutable= true;},
                        {name = "principal"; value=#Text(principal); immutable= true;},

                    ]
                ));



                //remove the selected nft
                availableNFTs := candy.toBuffer<CodeLine>(Array.filter<CodeLine>(availableNFTs.toArray(), func(x){ x.lineNumber != thisNFT.lineNumber}));

                let oldCodeLine = Option.unwrap(codeLines.get(thisNFT.lineNumber));
                let updatedCodeLine = {
                        line = oldCodeLine.line;
                        lineNumber = oldCodeLine.lineNumber;
                        isNFT = oldCodeLine.isNFT;
                        nftID = ?id;
                        image = []; //empty because we moved it to the NFT
                        order = oldCodeLine.order;
                        sourceImage = oldCodeLine.sourceImage;
                };

                codeLines.put(thisNFT.lineNumber, updatedCodeLine);

            buildCode();
            };
        };


        return true;

    };




    private func lr() : Bool{
        return candy.__licenseManager.license_ready();
    };

    private func ul() : async (){
        appendLog(#Class(
            [
                {name = "event"; value=#Text("call_update_license"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
            ]
        ));
        let result = candy.__licenseManager.update_license();
        return;
    };

    //////////////////////////
    //  The following set of functions expose the functionality of the Candy library to the actor canister so you can test that they work
    /////////////////////////

    public query func valueToNat(val : CandyValue) : async Nat {
        return candy.valueToNat(val)
    };

    public query func valueToNat8(val : CandyValue) : async Nat8 {
        return candy.valueToNat8(val)
    };

    public query func valueToNat16(val : CandyValue) : async Nat16 {
        return candy.valueToNat16(val)
    };

    public query func valueToNat32(val : CandyValue) : async Nat32 {
        return candy.valueToNat32(val)
    };

    public query func valueToNat64(val : CandyValue) : async Nat64 {
        return candy.valueToNat64(val);
    };

    public query func valueToInt(val : CandyValue) : async Int {
        return candy.valueToInt(val);
    };

    public query func valueToInt8(val : CandyValue) : async Int8 {
        return candy.valueToInt8(val);
    };

    public query func valueToInt16(val : CandyValue) : async Int16 {
        return candy.valueToInt16(val);
    };

    public query func valueToInt32(val : CandyValue) : async Int32 {
        return candy.valueToInt32(val);
    };

    public query func valueToInt64(val : CandyValue) : async Int64 {
        return candy.valueToInt64(val);
    };

    public query func valueToFloat(val : CandyValue) : async Float {
        return candy.valueToFloat(val);
    };

    public query func valueToText(val : CandyValue) : async Text {
        return candy.valueToText(val);
    };

    public query func valueToBool(val : CandyValue) : async Bool {
        return candy.valueToBool(val);
    };

    public query func valueToBlob(val : CandyValue) : async Blob {
        return candy.valueToBlob(val);
    };

    public query func valueUnstableToNat(val : CandyValue) : async Nat {
        return candy.valueUnstableToNat(candy.destabalizeValue(val));
    };

    public query func valueUnstableToNat8(val : CandyValue) : async Nat8 {
        return candy.valueUnstableToNat8(candy.destabalizeValue(val))
    };

    public query func valueUnstableToNat16(val : CandyValue) : async Nat16 {
        return candy.valueUnstableToNat16(candy.destabalizeValue(val))
    };

    public query func valueUnstableToNat32(val : CandyValue) : async Nat32 {
        return candy.valueUnstableToNat32(candy.destabalizeValue(val))
    };

    public query func valueUnstableToNat64(val : CandyValue) : async Nat64 {
        return candy.valueUnstableToNat64(candy.destabalizeValue(val));
    };

    public query func valueUnstableToInt(val : CandyValue) : async Int {
        return candy.valueUnstableToInt(candy.destabalizeValue(val));
    };

    public query func valueUnstableToInt8(val : CandyValue) : async Int8 {
        return candy.valueUnstableToInt8(candy.destabalizeValue(val));
    };

    public query func valueUnstableToInt16(val : CandyValue) : async Int16 {
        return candy.valueUnstableToInt16(candy.destabalizeValue(val));
    };

    public query func valueUnstableToInt32(val : CandyValue) : async Int32 {
        return candy.valueUnstableToInt32(candy.destabalizeValue(val));
    };

    public query func valueUnstableToInt64(val : CandyValue) : async Int64 {
        return candy.valueUnstableToInt64(candy.destabalizeValue(val));
    };

    public query func valueUnstableToFloat(val : CandyValue) : async Float {
        return candy.valueUnstableToFloat(candy.destabalizeValue(val));
    };

    public query func valueUnstableToText(val : CandyValue) : async Text {
        return candy.valueUnstableToText(candy.destabalizeValue(val));
    };

    public query func valueUnstableToBool(val : CandyValue) : async Bool {
        return candy.valueUnstableToBool(candy.destabalizeValue(val));
    };

    public query func valueUnstableToBlob(val : CandyValue) : async Blob {
        return candy.valueUnstableToBlob(candy.destabalizeValue(val));
    };

    public query func valueToBytes(val : CandyValue) : async [Nat8] {
        return candy.valueToBytes(val);
    };

    public query func valueUnstableToBytes(val : CandyValue) : async [Nat8] {
        return candy.valueToBytes(val);
    };

    public query func valueUnstableToBytesBuffer(val : CandyValue) : async [Nat8] {
        return candy.valueUnstableToBytesBuffer(candy.destabalizeValue(val)).toArray();
    };

    public query func valueUnstableToFloatsBuffer(val : CandyValue) : async [Float] {
        return candy.valueUnstableToFloatsBuffer(candy.destabalizeValue(val)).toArray();
    };

    public query func cloneValueUnstable(val : CandyValue) : async CandyValue {
        return candy.stabalizeValue(candy.cloneValueUnstable(candy.destabalizeValue(val)));
    };

    public query func unwrapOptionValue(val : CandyValue) : async CandyValue {
        return candy.unwrapOptionValue(val);
    };

    public query func unwrapOptionValueUnstable(val : CandyValue) : async CandyValue {
        return candy.stabalizeValue(candy.unwrapOptionValueUnstable(candy.destabalizeValue(val)));
    };

    public query func stabalizeProperty(val : CandyProperty) : async CandyProperty {
        return candy.stabalizeProperty(candy.destabalizeProperty(val));
    };

    public query func destabalizeProperty(val : CandyProperty) : async CandyProperty {
        return candy.stabalizeProperty(candy.destabalizeProperty(val));
    };

    public query func stabalizeValue(val : CandyValue) : async CandyValue {
        return candy.stabalizeValue(candy.destabalizeValue(val));
    };

    public query func destabalizeValue(val : CandyValue) : async CandyValue {
        return candy.stabalizeValue(candy.destabalizeValue(val));
    };

    public query func nat64ToBytes(val : Nat64) : async [Nat8] {
        return candy.nat64ToBytes(val);
    };

    public query func nat32ToBytes(val : Nat32) : async [Nat8] {
        return candy.nat32ToBytes(val);
    };

    public query func nat16ToBytes(val : Nat16) : async [Nat8] {
        return candy.nat16ToBytes(val);
    };

    public query func bytesToNat16(val : [Nat8]) : async Nat16 {
        return candy.bytesToNat16(val);
    };

    public query func bytesToNat32(val : [Nat8]) : async Nat32 {
        return candy.bytesToNat32(val);
    };

    public query func bytesToNat64(val : [Nat8]) : async Nat64 {
        return candy.bytesToNat64(val);
    };

    public query func natToBytes(val : Nat) : async [Nat8] {
        return candy.natToBytes(val);
    };

    public query func bytesToNat(val : [Nat8]) : async Nat {
        return candy.bytesToNat(val);
    };

    public query func textToByteBuffer(val : Text) : async [Nat8] {
        return candy.textToByteBuffer(val).toArray();
    };

    public query func textToBytes(val : Text) : async [Nat8] {
        return candy.textToBytes(val);
    };

    public query func bytesToText(val : [Nat8]) : async Text {
        return candy.bytesToText(val);
    };

    public query func principalToBytes(val : Principal) : async [Nat8] {
        return candy.principalToBytes(val);
    };

    public query func bytesToPrincipal(val : [Nat8]) : async Principal {
        return candy.bytesToPrincipal(val);
    };

    public query func boolToBytes(val : Bool) : async [Nat8] {
        return candy.boolToBytes(val);
    };

    public query func bytesToBool(val : [Nat8]) : async Bool {
        return candy.bytesToBool(val);
    };



    public query func bytesToInt(val : [Nat8]) : async Int {
        return candy.bytesToInt(val);
    };

    public query func intToBytes(val : Int) : async [Nat8] {
        return candy.intToBytes(val);
    };


    public query func countAddressedChunksInWorkspace(val : AddressedChunkArray) : async Nat {
        let ws = candy.emptyWorkspace();
        candy.fileAddressedChunks(ws, val);
        return candy.countAddressedChunksInWorkspace(ws);
    };

    public query func emptyWorkspace() : async AddressedChunkArray {
        return candy.workspaceToAddressedChunkArray(candy.emptyWorkspace());
    };

    public query func initWorkspace(val : Nat) : async AddressedChunkArray {
        return candy.workspaceToAddressedChunkArray(candy.initWorkspace(val));
    };

    public query func getValueSize(val : CandyValue) : async Nat {
        return candy.getValueSize(val);
    };

    public query func getValueUnstableSize(val : CandyValue) : async Nat {
        return candy.getValueUnstableSize(candy.destabalizeValue(val));
    };

    public query func stabalizeValueArray(val : [CandyValue]) : async [CandyValue] {
        let unstableBuffer = Buffer.Buffer<CandyValueUnstable>(val.size());
        for(thisItem in val.vals()){
            unstableBuffer.add(candy.destabalizeValue(thisItem));
        };
        return candy.stabalizeValueArray(unstableBuffer.toArray());
    };

    public query func destabalizeValueArray(val : [CandyValue]) : async [CandyValue] {
        return candy.stabalizeValueArray(candy.destabalizeValueArray(val));
    };


    public query func stabalizeValueBuffer(val : AddressedChunkArray) : async [CandyValue] {
        //data array must put data into data zone 0
        let ws = candy.emptyWorkspace();
        candy.fileAddressedChunks(ws, val);
        return candy.stabalizeValueBuffer(ws.get(0));
    };


    public query func workspaceToAddressedChunkArray(val : AddressedChunkArray) : async AddressedChunkArray {
        let ws = candy.emptyWorkspace();
        candy.fileAddressedChunks(ws, val);
        return candy.workspaceToAddressedChunkArray(ws);
    };

    public query func workspaceDeepClone(val : AddressedChunkArray) : async AddressedChunkArray {
        let ws = candy.emptyWorkspace();
        candy.fileAddressedChunks(ws, val);
        return candy.workspaceToAddressedChunkArray(candy.workspaceDeepClone(ws));
    };

    public query func fromAddressedChunks(val : AddressedChunkArray) : async AddressedChunkArray {
        return candy.workspaceToAddressedChunkArray(candy.fromAddressedChunks(val));
    };

    public query func fileAddressedChunks(ws: AddressedChunkArray, val : AddressedChunkArray) : async AddressedChunkArray{
        let ws1 = candy.emptyWorkspace();
        candy.fileAddressedChunks(ws1, ws);
        candy.fileAddressedChunks(ws1,val);
        return candy.workspaceToAddressedChunkArray(ws1);
    };

    public query func getDataZoneSize(val : AddressedChunkArray) : async Nat{
        let ws = candy.emptyWorkspace();
        candy.fileAddressedChunks(ws, val);
        return candy.getDataZoneSize(ws.get(0));
    };

    public query func getWorkspaceChunkSize(val : AddressedChunkArray, _maxChunkSize : Nat) : async Nat{
        let ws = candy.emptyWorkspace();
        candy.fileAddressedChunks(ws, val);
        return candy.getDataZoneSize(ws.get(0));
    };

    public query func getWorkspaceChunk(val : AddressedChunkArray, _chunkID : Nat, _maxChunkSize: Nat) : async ({#eof; #chunk} , AddressedChunkArray){
        let ws = candy.emptyWorkspace();
        candy.fileAddressedChunks(ws, val);
        let result = candy.getWorkspaceChunk(ws, _chunkID, _maxChunkSize);
        return ( result.0, result.1.toArray());
    };

    public query func getAddressedChunkArraySize(val : AddressedChunkArray) : async Nat{
        return candy.getAddressedChunkArraySize(val);
    };

    public query func getDataChunkFromAddressedChunkArray(item : AddressedChunkArray, dataZone: Nat, dataChunk: Nat) : async CandyValue{
        return candy.getDataChunkFromAddressedChunkArray(item, dataZone, dataChunk);
    };

    public query func getClassProperty(val: CandyValue, name : Text) : async CandyProperty{
        return candy.getClassProperty(val, name);
    };

    public query func byteBufferDataZoneToBuffer(dz: AddressedChunkArray) : async [[Nat8]]{
        let ws = candy.emptyWorkspace();
        candy.fileAddressedChunks(ws, dz);
        let result =  candy.byteBufferDataZoneToBuffer(ws.get(0));
        let accumulator = Buffer.Buffer<[Nat8]>(result.size());
        for(thisItem in result.vals()){
            accumulator.add(thisItem.toArray());
        };
        return accumulator.toArray();
    };

    public query func byteBufferChunksToValueUnstableBufferDataZone(buffer : [[Nat8]]) : async AddressedChunkArray{
        let accumulator = Buffer.Buffer<Buffer.Buffer<Nat8>>(buffer.size());
        for(thisItem in buffer.vals()){
            accumulator.add(candy.toBuffer<Nat8>(thisItem));
        };
        let result = candy.byteBufferChunksToValueUnstableBufferDataZone(accumulator);
        let ws = candy.emptyWorkspace();
        ws.add(result);
        return candy.workspaceToAddressedChunkArray(ws);
    };

    public query func initDataZone(val : CandyValue) : async AddressedChunkArray{
        let result = candy.initDataZone(candy.destabalizeValue(val));
        let ws = candy.emptyWorkspace();
        ws.add(result);
        return candy.workspaceToAddressedChunkArray(ws);
    };

    public query func flattenAddressedChunkArray(data : AddressedChunkArray) : async [Nat8]{
        return candy.flattenAddressedChunkArray(data);
    };

    // Returns the owner of the NFT with given identifier.
    public query(msg) func owns() : async Result.Result<[Text], NFTTypes.Error> {
        #ok(nfts.tokensOf(msg.caller));
    };


    ////////////
    // from https://github.com/jorgenbuilder/ext-nft-example
    // ht @jorgenbuilder
    // the only changes are to allow for suggesting an nft ID so that they don't have to be sequential
    // and to the contract info function so I can get more data out and logging
    //
    // The code below and up to the departure labs code is not licensed by he ARAMAKME v0.1 license. please see the license at the above url for licensing info
    ////////////

    ////////////
    // Types //
    //////////

    type EXTAccountIdentifier = ExtCore.AccountIdentifier;
    type SubAccount = ExtCore.SubAccount;
    type User = ExtCore.User;
    type Balance = ExtCore.Balance;
    type TokenIdentifier = ExtCore.TokenIdentifier;
    type TokenIndex  = ExtCore.TokenIndex;
    type Extension = ExtCore.Extension;
    type CommonError = ExtCore.CommonError;
    type BalanceRequest = ExtCore.BalanceRequest;
    type BalanceResponse = ExtCore.BalanceResponse;
    type TransferRequest = ExtCore.TransferRequest;
    type TransferResponse = ExtCore.TransferResponse;
    type MintRequest  = ExtNonFungible.MintRequest;

    ////////////
    // State //
    //////////

    let EXTENSIONS : [Extension] = ["@ext/common", "@ext/nonfungible"];


    public shared query func extensions () : async [Extension] {
        EXTENSIONS;
    };

    public shared query func balance (request : BalanceRequest) : async BalanceResponse {
        switch(request.user){
            case(#address(address)){ return #err(#Other("account ids not supported. use principal"))};
            case(#principal(requestedPrincipal)){
                switch(nfts.getToken(request.token)){
                    case(#err(err)){
                        return #err(#InvalidToken(request.token));
                    };
                    case(#ok(token)){
                        switch(nfts.ownerOf(request.token)){
                            case(#err(err)){
                                return #err(#InvalidToken(request.token));
                            };
                            case(#ok(principal)){
                                if(Principal.equal(principal, requestedPrincipal)){
                                    #ok(1);
                                } else {
                                    #ok(0);
                                };
                            }
                        }
                    };
                };
            };
        };
    };

    //we do not support ext transfer function. Use departure lab transfer(to:Principal, id: Text)

    public shared query func bearer (token : TokenIdentifier) : async Result.Result<EXTAccountIdentifier, CommonError> {

        switch(nfts.ownerOf(token)){
            case(#err(err)){
                return #err(#InvalidToken(token));
            };
            case(#ok(principal)){
                return #ok(Principal.toText(principal));
            }
        }

    };

    public shared({ caller }) func mintNFT (request : MintRequest) : async () {
        //does nothing
    };


    ////////////
    // from https://github.com/DepartureLabsIC/non-fungible-token
    // ht @SuddnlyHazel, @di-wu
    // the only changes are to allow for suggesting an nft ID so that they don't have to be sequential
    // and to the contract info function so I can get more data out
    //
    // The code below is not licensed byt he ARAMAKME v0.1 license. please see the license at the above url for licensing info
    ////////////

    var MAX_RESULT_SIZE_BYTES     = 1_000_000; // 1MB Default
    var HTTP_STREAMING_SIZE_BYTES = 1_900_000;

    stable var CONTRACT_METADATA : ContractMetadata = {
        name   = "none";
        symbol = "none";
    };
    stable var INITALIZED : Bool = false;

    stable var TOPUP_AMOUNT             = 2_000_000;
    stable var BROKER_CALL_LIMIT        = 25;
    stable var BROKER_FAILED_CALL_LIMIT = 25;

    stable var id          = 0;
    stable var payloadSize = 0;
    stable var nftEntries : [(
        Text, // Token Identifier.
        (
            ?Principal, // Owner of the token.
            [Principal] // Authorized principals.
        ),
        Token.Token, // NFT data.
    )] = [];

    var nfts = Token.NFTs(
        id,
        payloadSize,
        nftEntries,
    );


    stable var staticAssetsEntries : [(
        Text,        // Asset Identifier (path).
        Static.Asset // Asset data.
    )] = [];
    let staticAssets = Static.Assets(staticAssetsEntries);

    stable var contractOwners : [Principal] = [owner];

    stable var messageBrokerCallback : ?Event.Callback = null;
    stable var messageBrokerCallsSinceLastTopup : Nat = 0;
    stable var messageBrokerFailedCalls : Nat = 0;

    public type UpdateEventCallback = {
        #Set : Event.Callback;
        #Remove;


    };

    // Specifies the list of properties that are queried.
    public type QueryRequest = {
        id   : Text;
        mode : Candy.QueryMode;
    };

    // Removes or updates the event callback.
    public shared ({caller}) func updateEventCallback(update : UpdateEventCallback) : async () {
        assert(_isOwner(caller));

        appendLog(#Class(
            [
                {name = "event"; value=#Text("update_event_callback"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "caller"; value=#Principal(msg.caller); immutable= true;},

            ]
        ));
        switch (update) {
            case (#Remove) {
                messageBrokerCallback := null;
            };
            case (#Set(cb)) {
                messageBrokerCallback := ?cb;
            };
        };
    };

    // Returns the event callback status.
    public shared ({caller}) func getEventCallbackStatus() : async Event.CallbackStatus {
        assert(_isOwner(caller));
        return {
            callback            = messageBrokerCallback;
            callsSinceLastTopup = messageBrokerCallsSinceLastTopup;
            failedCalls         = messageBrokerFailedCalls;
            noTopupCallLimit    = BROKER_CALL_LIMIT;
            failedCallsLimit    = BROKER_FAILED_CALL_LIMIT;
        };
    };

    // Initializes the contract with the given (additional) owners and metadata. Can only be called once.
    // @pre: isOwner
    public shared({caller}) func initNFTs(
        metadata : ContractMetadata
    ) : async () {
        assert(not INITALIZED and caller == owner);
        //contractOwners    := Array.append(contractOwners, owners);
        CONTRACT_METADATA := metadata;
        INITALIZED        := true;

        appendLog(#Class(
            [
                {name = "event"; value=#Text("init_nfts"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},

                {name = "caller"; value=#Principal(msg.caller); immutable= true;},

            ]
        ));

        for(thisItem in codeLines.entries()){
            if(thisItem.1.isNFT){
                availableNFTs.add(thisItem.1);
            }
        };
    };

    // Updates the access rights of one of the contact owners.
    public shared({caller}) func updateContractOwners(
        user          : Principal,
        isAuthorized : Bool,
    ) : async Result.Result<(), NFTTypes.Error> {
        if (not _isOwner(caller)) { return #err(#Unauthorized); };

        appendLog(#Class(
            [
                {name = "event"; value=#Text("update_contract_owners"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "is_authorized"; value=#Bool(isAuthorized); immutable= true;},
                {name = "caller"; value=#Principal(msg.caller); immutable= true;},
                {name = "user"; value=#Principal(user); immutable= true;},

            ]
        ));

        switch(isAuthorized) {
            case (true) {
                contractOwners := Array.append(
                    contractOwners,
                    [user],
                );
            };
            case (false) {
                contractOwners := Array.filter<Principal>(
                    contractOwners,
                    func(v) { v != user; },
                );
            };
        };
        ignore _emitEvent({
            createdAt     = Time.now();
            event         = #ContractEvent(
                #ContractAuthorize({
                    user         = user;
                    isAuthorized = isAuthorized;
                }),
            );
            topupAmount   = TOPUP_AMOUNT;
            topupCallback = wallet_receive;
        });
        #ok();
    };

    public type ContractMetadata = {
        name   : Text;
        symbol : Text;
    };

    // Returns the meta data of the contract.
    public query func getMetadata() : async ContractMetadata {
        CONTRACT_METADATA;
    };

    // Returns the total amount of minted NFTs.
    public query func getTotalMinted() : async Nat {
        nfts.getTotalMinted();
    };

    public shared({caller}) func wallet_receive() : async () {
         appendLog(#Class(
            [
                {name = "event"; value=#Text("wallet_receive"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "available"; value=#Nat(ExperimentalCycles.available()); immutable= true;},
                {name = "caller"; value=#Principal(caller); immutable= true;},

            ]
        ));
        ignore ExperimentalCycles.accept(ExperimentalCycles.available());
    };

    // Mints a new egg.
    // @pre: isOwner
    public shared ({caller}) func mint(egg : Token.Egg) : async Text {
        assert(_isOwner(caller));
        let (id, owner) = await nfts.mint(Principal.fromActor(this), egg);
        appendLog(#Class(
            [
                {name = "event"; value=#Text("raw_mint"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "caller"; value=#Principal(caller); immutable= true;},
            ]
        ));
        ignore _emitEvent({
            createdAt     = Time.now();
            event         = #ContractEvent(
                #Mint({
                    id    = id;
                    owner = owner;
                }),
            );
            topupAmount   = TOPUP_AMOUNT;
            topupCallback = wallet_receive;
        });
        id;
    };

    public type ContractInfo = {
        heap_size : Nat;
        memory_size : Nat;
        max_live_size : Nat;
        nft_payload_size : Nat;
        total_minted : Nat;
        cycles : Nat;
        authorized_users : [Principal];
        availableNFTs : Nat;
        currentFee : Nat;
        lastTimeAwarded : Int;
    };

    // Returns the contract info.
    // @pre: isOwner
    public query ({caller}) func getContractInfo() : async ContractInfo {
        assert(_isOwner(caller));
        return {
            heap_size        = Prim.rts_heap_size();
            memory_size      = Prim.rts_memory_size();
            max_live_size    = Prim.rts_max_live_size();
            nft_payload_size = payloadSize;
            total_minted     = nfts.getTotalMinted();
            cycles           = ExperimentalCycles.balance();
            authorized_users = contractOwners;
            availableNFTs = availableNFTs.size();
            currentFee = calcCurrentFee();
            lastTimeAwarded = lastTimeAwarded
        };
    };

    // Returns the tokens of the given principal.
    public query func balanceOf(p : Principal) : async [Text] {
        nfts.tokensOf(p);
    };

    // Returns the tokens of the given principal.
    public query func getFeeInfo() : async (Nat, Nat, Nat) {
        (calcCurrentFee(), nfts.getTotalMinted(), availableNFTs.size());
    };

    // Returns the owner of the NFT with given identifier.
    public query func ownerOf(id : Text) : async Result.Result<Principal, NFTTypes.Error> {
        nfts.ownerOf(id);
    };


    // Transfers one of your own NFTs to another principal.
    public shared({caller}) func transfer(to : Principal, id : Text) : async Result.Result<(), NFTTypes.Error> {
        let owner = switch (_canChange(caller, id)) {
            case (#err(e)) { return #err(e); };
            case (#ok(v))  { v; };
        };
        //make sure principal isnt restricted


        let thisNFT = switch(nfts.getToken(id)){
            case(#ok(val)){val};
            case(#err(err)){
                appendLog(#Class(
                    [
                        {name = "event"; value=#Text("nft_transfer_fail_not_found"); immutable= true;},
                        {name = "time"; value=#Int(Time.now()); immutable= true;},
                        {name = "to"; value=#Principal(to); immutable= true;},
                        {name = "id"; value=#Text(id); immutable= true;},
                        {name = "caller"; value=#Principal(caller); immutable= true;},
                    ]
                ));
                return #err(#NotFound)};
        };
        switch(candy.getProperties(thisNFT.properties, [{name="restricted"; next=[]}])){
            case(#ok(val)){
                if(val.size() > 0){
                    if(candy.valueToBool(val[0].value) == true){
                        appendLog(#Class(
                            [
                                {name = "event"; value=#Text("nft_transfer_fail_restricted"); immutable= true;},
                                {name = "time"; value=#Int(Time.now()); immutable= true;},
                                {name = "to"; value=#Principal(to); immutable= true;},
                                {name = "id"; value=#Text(id); immutable= true;},
                                {name = "caller"; value=#Principal(caller); immutable= true;},
                            ]
                        ));

                        return #err(#Restricted)}
                };
            };
            case(#err(err)){};
        };

        switch(candy.getProperties(thisNFT.properties, [{name="ownerList"; next=[]}])){
            case(#ok(val)){
                if(val.size() > 0){
                    let newArray = #Array(#frozen(Array.append<CandyValue>(candy.valueToValueArray(val[0].value), Array.make<CandyValue>(
                        #Class([{
                            name = "principal";
                            value = #Principal(to);
                            immutable = true;
                        },
                        {
                            name = "ownedAt";
                            value = #Int(Time.now());
                            immutable = true;
                        },
                        ])))));

                    let newProps = Array.tabulate<CandyProperty>(thisNFT.properties.size(), func(x){
                        if(thisNFT.properties[x].name == "ownerList"){
                            return {
                                name = thisNFT.properties[x].name;
                                value = newArray;
                                immutable = thisNFT.properties[x].immutable;
                            }
                        } else {
                            return {
                                name = thisNFT.properties[x].name;
                                value = thisNFT.properties[x].value;
                                immutable = thisNFT.properties[x].immutable;
                            }

                        };
                    });

                    let update = nfts.updateProperties(id, newProps);
                };
            };
            case(#err(err)){};
        };



        let res = await nfts.transfer(to, id);
        aramakmeNFTLM.check_license_n(50); //50 cents for a transfer

        appendLog(#Class(
            [
                {name = "event"; value=#Text("nft_transfer"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "to"; value=#Principal(to); immutable= true;},
                {name = "id"; value=#Text(id); immutable= true;},
                {name = "caller"; value=#Principal(caller); immutable= true;},
            ]
        ));

        ignore _emitEvent({
            createdAt     = Time.now();
            event         = #TokenEvent(
                #Transfer({
                    from = owner;
                    to   = to;
                    id   = id;
                }));
            topupAmount   = TOPUP_AMOUNT;
            topupCallback = wallet_receive;
        });
        res;
    };

    // Allows the caller to authorize another principal to act on its behalf.
    public shared ({caller}) func authorize(req : Token.AuthorizeRequest) : async Result.Result<(), NFTTypes.Error> {
        switch (_canChange(caller, req.id)) {
            case (#err(e)) { return #err(e); };
            case (#ok(v))  { };
        };
        if (not nfts.authorize(req)) {
            return #err(#AuthorizedPrincipalLimitReached(Token.AUTHORIZED_LIMIT))
        };
        appendLog(#Class(
            [
                {name = "event"; value=#Text("nft_authorized_request"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},
                {name = "to"; value=#Principal(req.p); immutable= true;},
                {name = "id"; value=#Text(req.id); immutable= true;},
                {name = "is_authorized"; value=#Bool(req.isAuthorized); immutable= true;},
                {name = "caller"; value=#Principal(caller); immutable= true;},
            ]
        ));
        ignore _emitEvent({
            createdAt     = Time.now();
            event         = #TokenEvent(
                #Authorize({
                    id           = req.id;
                    user         = req.p;
                    isAuthorized = req.isAuthorized;
                }));
            topupAmount   = TOPUP_AMOUNT;
            topupCallback = wallet_receive;
        });
        #ok();
    };

    private func _canChange(caller : Principal, id : Text) : Result.Result<Principal, NFTTypes.Error> {
        let owner = switch (nfts.ownerOf(id)) {
            case (#err(e)) {
                if (not _isOwner(caller)) return #err(e);
                Principal.fromActor(this);
            };
            case (#ok(v))  {
                // The owner not is the caller.
                if (not _isOwner(caller) and v != caller) {
                    // Check whether the caller is authorized.
                    if (not nfts.isAuthorized(caller, id)) return #err(#Unauthorized);
                };
                v;
            };
        };
        #ok(owner);
    };

    // Returns whether the given principal is authorized to change to NFT with the given identifier.
    public query func isAuthorized(id : Text, p : Principal) : async Bool {
        nfts.isAuthorized(p, id);
    };

    // Returns which principals are authorized to change the NFT with the given identifier.
    public query func getAuthorized(id : Text) : async [Principal] {
        nfts.getAuthorized(id);
    };

    // Gets the token with the given identifier.
    public shared ({caller}) func tokenByIndex(id : Text) : async Result.Result<Token.PublicToken, NFTTypes.Error> {
        switch(nfts.getToken(id)) {
            case (#err(e)) { return #err(e); };
            case (#ok(v))  {
                if (v.isPrivate) {
                    if (not nfts.isAuthorized(caller, id) and not _isOwner(caller)) {
                        return #err(#Unauthorized);
                    };
                };
                var payloadResult : Token.PayloadResult = #Complete(v.payload[0]);
                if (v.payload.size() > 1) {
                    payloadResult := #Chunk({
                        data       = v.payload[0];
                        totalPages = v.payload.size();
                        nextPage   = ?1;
                    });
                };
                let owner = switch (nfts.ownerOf(id)) {
                    case (#err(_)) { Principal.fromActor(this); };
                    case (#ok(v))  { v;                         };
                };
                return #ok({
                    contentType = v.contentType;
                    createdAt = v.createdAt;
                    id = id;
                    owner = owner;
                    payload = payloadResult;
                    properties = v.properties;
                });
            }
        }
    };

    // Gets the token chuck with the given identifier and page number.
    public shared({caller}) func tokenChunkByIndex(id : Text, page : Nat) : async Result.Result<Token.Chunk, NFTTypes.Error> {
        switch (nfts.getToken(id)) {
            case (#err(e)) { return #err(e); };
            case (#ok(v)) {
                if (v.isPrivate) {
                    if (not nfts.isAuthorized(caller, id) and not _isOwner(caller)) {
                        return #err(#Unauthorized);
                    };
                };
                let totalPages = v.payload.size();
                if (page > totalPages) {
                    return #err(#InvalidRequest);
                };
                var nextPage : ?Nat = null;
                if (totalPages > page + 1) {
                    nextPage := ?(page + 1);
                };
                #ok({
                    data       = v.payload[page];
                    nextPage   = nextPage;
                    totalPages = totalPages;
                });
            };
        };
    };

    type Metadata = {
        id          : Text;
        contentType : Text;
        owner       : Principal;
        createdAt   : Int;
        properties  : [Property];
    };

    type Value = {
            #Int       : Int;
            #Nat       : Nat;
            #Float     : Float;
            #Text      : Text;
            #Bool      : Bool;
            #Class     : [Property];
            #Principal : Principal;
            #Empty;
        };
    type Property = {
        name : Text;
        immutable : Bool;
        value : Value;
    };

    private func toDepartureValue(_src : Candy.CandyValue) : Value {
        let anItem = switch(_src){
            case(#Int(v)){#Int(v)};
            case(#Nat(v)){#Nat(v)};
            case(#Float(v)){#Float(v)};
            case(#Text(v)){#Text(v)};
            case(#Bool(v)){#Bool(v)};
            case(#Class(v)){#Class(toDepartureProperties(v))};
            case(#Principal(v)){#Principal(v)};
            case(#Empty){#Empty};
            case(#Array(v)){
                let thisArray = switch(v){case(#frozen(v)){v};case(#thawed(v)){v};};
                let convert = Buffer.Buffer<Property>(thisArray.size());
                var tracker = 0;
                for(thisItem in thisArray.vals()){
                    convert.add({name = Nat.toText(tracker); immutable = false; value= toDepartureValue(thisItem)});
                    tracker += 1;
                };
                #Class(convert.toArray());
            };
            case(_){
                //only support the above
                Debug.print(debug_show(_src));
                assert(false);
                #Empty;
            }
        };
        return anItem;
    };

    private func toDepartureProperties(_src : Candy.Properties) : [Property] {
            let results : Buffer.Buffer<Property> = Buffer.Buffer<Property>(_src.size());
            for(thisItem in _src.vals()){
                let anItem = switch(thisItem.value){
                    case(#Int(v)){{name=thisItem.name; immutable=thisItem.immutable; value =#Int(v)};};
                    case(#Nat(v)){{name=thisItem.name; immutable=thisItem.immutable; value =#Nat(v)};};
                    case(#Float(v)){{name=thisItem.name; immutable=thisItem.immutable; value =#Float(v)};};
                    case(#Text(v)){{name=thisItem.name; immutable=thisItem.immutable; value =#Text(v)};};
                    case(#Bool(v)){{name=thisItem.name; immutable=thisItem.immutable; value =#Bool(v)};};
                    case(#Class(v)){{name=thisItem.name; immutable=thisItem.immutable; value =#Class(toDepartureProperties(v))};};
                    case(#Principal(v)){{name=thisItem.name; immutable=thisItem.immutable; value =#Principal(v)};};
                    case(#Empty){{name=thisItem.name; immutable=thisItem.immutable; value =#Empty};};
                    case(#Array(v)){

                        {name=thisItem.name; immutable=thisItem.immutable; value = toDepartureValue(#Array(v))};
                    };
                    case(_){
                        //only support the above
                        Debug.print(debug_show(thisItem));
                        assert(false);
                        {name=thisItem.name; immutable=thisItem.immutable; value =#Empty};
                    }
                };
                results.add(anItem);
            };

            return results.toArray();
        };



    // Returns the token metadata of an NFT based on the given identifier.
    public shared ({caller}) func tokenMetadataByIndex(id : Text) : async Result.Result<Metadata, NFTTypes.Error> {
        Debug.print("in func");
        switch (nfts.getToken(id)) {
            case (#err(e)) { return #err(e); };
            case (#ok(v)) {
                Debug.print("in ok" );
                if (v.isPrivate) {
                    if (not nfts.isAuthorized(caller, id) and not _isOwner(caller)) {
                        return #err(#Unauthorized);
                    };
                };
                Debug.print("returning");
                #ok({
                    contentType = v.contentType;
                    createdAt   = v.createdAt;
                    id          = id;
                    owner       = switch (nfts.ownerOf(id)) {
                        case (#err(_)) { owner; };
                        case (#ok(v))  { v;   };
                    };
                    properties  = toDepartureProperties(v.properties);
                });
            };
        };
    };

    // Returns the attributes of an NFT based on the given query.
    public query ({caller}) func queryProperties(
        q : QueryRequest,
    ) : async Result.Result<Candy.Properties, NFTTypes.Error> {
        switch(nfts.getToken(q.id)) {
            case (#err(e)) { #err(e); };
            case (#ok(v))  {
                if (v.isPrivate) {
                    if (not nfts.isAuthorized(caller, q.id) and not _isOwner(caller)) {
                        return #err(#Unauthorized);
                    };
                };
                switch (q.mode) {
                    case (#All)      { #ok(v.properties); };
                    case (#Some(qs)) { candy.getProperties(v.properties, qs); };
                };
            };
        };
    };

    // Updates the attributes of an NFT and returns the resulting (updated) attributes.
    public shared ({caller}) func updateProperties(
        u : Candy.UpdateRequest,
    ) : async Result.Result<Candy.Properties, NFTTypes.Error> {
        switch(nfts.getToken(u.id)) {
            case (#err(e)) { #err(e); };
            case (#ok(v))  {
                if (v.isPrivate) {
                    if (not nfts.isAuthorized(caller, u.id) and not _isOwner(caller)) {
                        return #err(#Unauthorized);
                    };
                };
                switch (candy.updateProperties(v.properties, u.update)) {
                    case (#err(e)) { #err(e); };
                    case (#ok(ps)) {

                        switch (nfts.updateProperties(u.id, ps)) {
                            case (#err(e)) { #err(e); };
                            case (#ok())   { #ok(ps); };
                        };
                    };
                };
            };
        };
    };

    private func _isOwner(p : Principal) : Bool {
        switch(Array.find<Principal>(contractOwners, func(v) {return v == p})) {
            case (null) { false; };
            case (? v)  { true;  };
        };
    };

    private func _emitEvent(event : Event.Message) : async () {
        let emit = func(broker : Event.Callback, msg : Event.Message) : async () {
            try {
                await broker(msg);
                messageBrokerCallsSinceLastTopup := messageBrokerCallsSinceLastTopup + 1;
                messageBrokerFailedCalls := 0;
            } catch(_) {
                messageBrokerFailedCalls := messageBrokerFailedCalls + 1;
                if (messageBrokerFailedCalls > BROKER_FAILED_CALL_LIMIT) {
                    messageBrokerCallback := null;
                };
            };
        };

        switch(messageBrokerCallback) {
            case (null)    { return; };
            case (?broker) {
                if (messageBrokerCallsSinceLastTopup > BROKER_CALL_LIMIT) return;
                ignore emit(broker, event);
            };
        };
    };

    // HTTP interface

    public query func http_request(request : Http.Request) : async Http.Response {

        let path = Iter.toArray(Text.tokens(request.url, #text("/")));

        if (path.size() != 0 and path[0] == "nft") {

            let ops = Iter.toArray(Text.tokens(path[1], #text("?")));

            if(ops.size() > 1){

                let params = Iter.toArray(Text.tokens(ops[1], #text("&")));

                if(params[0] == "modeText"){

                    return nfts.getHTML(ops[0], candy);
                };
            };

            return nfts.get(path[1], nftStreamingCallback);
        };
        return staticAssets.get(request.url, staticStreamingCallback);
    };

    public query func http_request_streaming_callback(
        tk : Http.StreamingCallbackToken
    ) : async Http.StreamingCallbackResponse {
        if (Text.startsWith(tk.key, #text("nft/"))) {
            switch (nfts.getToken(tk.key)) {
                case (#err(_)) { };
                case (#ok(v))  {
                    return Http.streamContent(
                        tk.key,
                        tk.index,
                        v.payload,
                    );
                };
            };
        } else {
            switch (staticAssets.getToken(tk.key)) {
                case (#err(_)) { };
                case (#ok(v))  {
                    return Http.streamContent(
                        tk.key,
                        tk.index,
                        v.payload,
                    );
                };
            };
        };
        return {
            body  = Blob.fromArray([]);
            token = null;
        };
    };

    // A streaming callback based on static assets.
    // Returns {[], null} if the asset can not be found.
    public query func staticStreamingCallback(tk : Http.StreamingCallbackToken) : async Http.StreamingCallbackResponse {
        switch(staticAssets.getToken(tk.key)) {
            case (#err(_)) { };
            case (#ok(v))  {
                return Http.streamContent(
                    tk.key,
                    tk.index,
                    v.payload,
                );
            };
        };
        {
            body = Blob.fromArray([]);
            token = null;
        };
    };

    // A streaming callback based on NFTs. Returns {[], null} if the token can not be found.
    // Expects a key of the following pattern: "nft/{key}".
    public query func nftStreamingCallback(tk : Http.StreamingCallbackToken) : async Http.StreamingCallbackResponse {
        let path = Iter.toArray(Text.tokens(tk.key, #text("/")));
         if (path.size() == 2 and path[0] == "nft") {
            switch (nfts.getToken(path[1])) {
                case (#err(e)) {};
                case (#ok(v))  {
                    if (not v.isPrivate) {
                        return Http.streamContent(
                            "nft/" # tk.key,
                            tk.index,
                            v.payload,
                        );
                    };
                };
            };
        };
        {
            body  = Blob.fromArray([]);
            token = null;
        };
    };

    // upgrade code
    system func preupgrade() {
        appendLog(#Class(
            [
                {name = "event"; value=#Text("pre_upgrade"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},

            ]
        ));
        //upgradeBitMapStore := Iter.toArray(bitMapStore.entries());
        balancesEntries := Iter.toArray(balances.entries());
        redemptionEntries := Iter.toArray(redemptions.entries());
        availableNFTsStable := availableNFTs.toArray();
        codeLinesStable := Iter.toArray(codeLines.entries());
        shareBankStable := Iter.toArray(shareBank.entries());
        kycEntriesStable    := Iter.toArray(kycEntries.entries());
        initializedPrincipalsStable    := Iter.toArray(initializedPrincipals.entries());
        logHistory := List.append<[CandyValue]>(logHistory, List.make<[CandyValue]>(log.toArray()));


        /////////
        //departure labs nft
        /////////

        id                  := nfts.currentID();
        payloadSize         := nfts.payloadSize();
        nftEntries          := Iter.toArray(nfts.entries());
        staticAssetsEntries := Iter.toArray(staticAssets.entries());

    };

    // upgrade code
    system func postupgrade() {

        appendLog(#Class(
            [
                {name = "event"; value=#Text("post_upgrade"); immutable= true;},
                {name = "time"; value=#Int(Time.now()); immutable= true;},

            ]
        ));

        balancesEntries := [];
        redemptionEntries := [];
        availableNFTsStable := [];
        codeLinesStable := [];
        shareBankStable := [];
        kycEntriesStable := [];
        initializedPrincipalsStable := [];

        //////////
        //depature labs nft
        //////////

        id                  := 0;
        payloadSize         := 0;
        nftEntries          := [];
        staticAssetsEntries := [];


    };
};
