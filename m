From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v6 04/10] Documentation: dt: device tree bindings for
 LPDDR3 memories
Date: Mon, 29 Apr 2019 14:04:56 +0200
Message-ID: <86715dda-c1b0-5354-17d2-419f8137cb91@partner.samsung.com>
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87@eucas1p1.samsung.com>
        <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
        <20190425195156.GA31128@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425195156.GA31128@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 4/25/19 9:51 PM, Rob Herring wrote:
> On Fri, Apr 19, 2019 at 04:19:22PM +0200, Lukasz Luba wrote:
>> The device tree bindings for LPDDR3 SDRAM memories.
>>
>> For specifying the AC timing parameters of the memory device
>> the 'lpddr3' binding uses binding 'lpddr2-timings'.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../devicetree/bindings/lpddr3/lpddr3-timings.txt  | 57 +++++++++++++
>>   .../devicetree/bindings/lpddr3/lpddr3.txt          | 93 ++++++++++++++++++++++
> 
> Please rename the lpddr2 directory to 'ddr' and add these to it.
OK, I will rename it in the nex patch set.
> 
> Maybe whatever properties are common should be put in a common doc.
There are maybe a few common properties, but I would not dare to merge
lpddr2 and lpddr3 before consulting it with TI engineers who made
LPDDR2 support.
Could we work on a common file after the patch set got merged?
> 
>>   2 files changed, 150 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
>>   create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3.txt
>>
>> diff --git a/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt b/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
>> new file mode 100644
>> index 0000000..ebf3e00
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
>> @@ -0,0 +1,57 @@
>> +* AC timing parameters of LPDDR3 memories for a given speed-bin.
>> +* The structures are based on LPDDR2 and extended where needed.
>> +
>> +Required properties:
>> +- compatible : Should be "jedec,lpddr3-timings"
>> +- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
>> +- max-freq : maximum DDR clock frequency for the speed-bin. Type is <u32>
>> +
>> +Optional properties:
>> +
>> +The following properties represent AC timing parameters from the memory
>> +data-sheet of the device for a given speed-bin. All these properties are
>> +of type <u32> and the default unit is ps (pico seconds).
>> +- tRFC
>> +- tRRD
>> +- tRPab
>> +- tRPpb
>> +- tRCD
>> +- tRC
>> +- tRAS
>> +- tWTR
>> +- tWR
>> +- tRTP
>> +- tW2W-C2C
>> +- tR2R-C2C
>> +- tFAW
>> +- tXSR
>> +- tXP
>> +- tCKE
>> +- tCKESR
>> +- tMRD
>> +
>> +Example:
>> +
>> +timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
> 
> Since the lpddr2 version was written, we've gotten stricter about
> allowing unit-address without reg property. Perhaps 'reg' should be the
> max-freq instead.
OK, so I will rename 'max-freq' to 'reg' and add a comment with:
'/* workaround: it shows max-freq */
Does it make sense?
> 
>> +	compatible	= "jedec,lpddr3-timings";
>> +	min-freq	= <100000000>;
>> +	max-freq	= <800000000>;
>> +	tRFC		= <65000>;
>> +	tRRD		= <6000>;
>> +	tRPab		= <12000>;
>> +	tRPpb		= <12000>;
>> +	tRCD		= <10000>;
>> +	tRC		= <33750>;
>> +	tRAS		= <23000>;
>> +	tWTR		= <3750>;
>> +	tWR		= <7500>;
>> +	tRTP		= <3750>;
>> +	tW2W-C2C	= <0>;
>> +	tR2R-C2C	= <0>;
>> +	tFAW		= <25000>;
>> +	tXSR		= <70000>;
>> +	tXP		= <3750>;
>> +	tCKE		= <3750>;
>> +	tCKESR		= <3750>;
>> +	tMRD		= <7000>;
>> +};
>> diff --git a/Documentation/devicetree/bindings/lpddr3/lpddr3.txt b/Documentation/devicetree/bindings/lpddr3/lpddr3.txt
>> new file mode 100644
>> index 0000000..fc7875c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/lpddr3/lpddr3.txt
>> @@ -0,0 +1,93 @@
>> +* LPDDR3 SDRAM memories compliant to JEDEC JESD209-2
> 
> That's an LPDDR2 spec.
Right, should be JESD209-3C.

Thank you for the review.

Regards,
Lukasz
> 
>> +
>> +Required properties:
>> +- compatible : Should be  - "jedec,lpddr3"
>> +- density  : <u32> representing density in Mb (Mega bits)
>> +- io-width : <u32> representing bus width. Possible values are 8, 16, 32, 64
>> +
>> +Optional properties:
>> +
>> +The following optional properties represent the minimum value of some AC
>> +timing parameters of the DDR device in terms of number of clock cycles.
>> +These values shall be obtained from the device data-sheet.
>> +- tRFC-min-tck
>> +- tRRD-min-tck
>> +- tRPab-min-tck
>> +- tRPpb-min-tck
>> +- tRCD-min-tck
>> +- tRC-min-tck
>> +- tRAS-min-tck
>> +- tWTR-min-tck
>> +- tWR-min-tck
>> +- tRTP-min-tck
>> +- tW2W-C2C-min-tck
>> +- tR2R-C2C-min-tck
>> +- tWL-min-tck
>> +- tDQSCK-min-tck
>> +- tRL-min-tck
>> +- tFAW-min-tck
>> +- tXSR-min-tck
>> +- tXP-min-tck
>> +- tCKE-min-tck
>> +- tCKESR-min-tck
>> +- tMRD-min-tck
>> +
>> +Child nodes:
>> +- The lpddr3 node may have one or more child nodes of type "lpddr3-timings".
>> +  "lpddr3-timings" provides AC timing parameters of the device for
>> +  a given speed-bin. Please see Documentation/devicetree/
>> +  bindings/lpddr3/lpddr3-timings.txt for more information on "lpddr3-timings"
>> +
>> +Example:
>> +
>> +samsung_K3QF2F20DB: lpddr3 {
>> +	compatible	= "Samsung,K3QF2F20DB","jedec,lpddr3";
>> +	density		= <16384>;
>> +	io-width	= <32>;
>> +
>> +	tRFC-min-tck		= <17>;
>> +	tRRD-min-tck		= <2>;
>> +	tRPab-min-tck		= <2>;
>> +	tRPpb-min-tck		= <2>;
>> +	tRCD-min-tck		= <3>;
>> +	tRC-min-tck		= <6>;
>> +	tRAS-min-tck		= <5>;
>> +	tWTR-min-tck		= <2>;
>> +	tWR-min-tck		= <7>;
>> +	tRTP-min-tck		= <2>;
>> +	tW2W-C2C-min-tck	= <0>;
>> +	tR2R-C2C-min-tck	= <0>;
>> +	tWL-min-tck		= <8>;
>> +	tDQSCK-min-tck		= <5>;
>> +	tRL-min-tck		= <14>;
>> +	tFAW-min-tck		= <5>;
>> +	tXSR-min-tck		= <12>;
>> +	tXP-min-tck		= <2>;
>> +	tCKE-min-tck		= <2>;
>> +	tCKESR-min-tck		= <2>;
>> +	tMRD-min-tck		= <5>;
>> +
>> +	timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
>> +		compatible	= "jedec,lpddr3-timings";
>> +		min-freq	= <100000000>;
>> +		max-freq	= <800000000>;
>> +		tRFC		= <65000>;
>> +		tRRD		= <6000>;
>> +		tRPab		= <12000>;
>> +		tRPpb		= <12000>;
>> +		tRCD		= <10000>;
>> +		tRC		= <33750>;
>> +		tRAS		= <23000>;
>> +		tWTR		= <3750>;
>> +		tWR		= <7500>;
>> +		tRTP		= <3750>;
>> +		tW2W-C2C	= <0>;
>> +		tR2R-C2C	= <0>;
>> +		tFAW		= <25000>;
>> +		tXSR		= <70000>;
>> +		tXP		= <3750>;
>> +		tCKE		= <3750>;
>> +		tCKESR		= <3750>;
>> +		tMRD		= <7000>;
>> +	};
>> +}
>> -- 
>> 2.7.4
>>
> 
> 
