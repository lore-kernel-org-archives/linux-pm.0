From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing capacity values for bq27421
Date: Wed, 30 Aug 2017 11:30:57 +0200
Message-ID: <7428DD60-FE09-41C4-9DBC-FFDCB9D0B591@goldelico.com>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com> <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>
Cc: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-pm@vger.kernel.org

Hi Liam and Sebastian,

> Am 29.08.2017 um 22:20 schrieb Liam Breck <liam@networkimprov.net>:
> 
> Hi Nikolaus, thanks for the patch...
> 
> On Tue, Aug 29, 2017 at 1:10 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>> Tested on Pyra prototype with bq27421.
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/power/supply/bq27xxx_battery.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index b6c3120ca5ad..e3c878ef7c7e 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -688,7 +688,7 @@ static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
>> #define bq27545_dm_regs 0
>> #endif
>> 
>> -#if 0 /* not yet tested */
>> +#if 1 /* tested on Pyra */
>> static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
> 
> I think we can drop the #if and #else...#endif so it's just the
> dm_regs table, as with bq27425.

I have fixed that and did take the chance to update my OpenPandora
kernel so that I also could test and make the bq27500 working.

The biggest hurdle was to find out that I have to change the
compatible string to "ti,bq27500-1" to get non-NULL dm_regs...

[   12.765930] bq27xxx_battery_i2c_probe name=bq27500-1-0
[   12.771392] bq27xxx_battery_i2c_probe call setup
[   12.874816] bq27xxx_battery_setup
[   12.904266] bq27xxx_battery_setup: dm_regs=bf0520e0
[   12.933380] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name attribute, please fix
[   13.234893] bq27xxx_battery_settings
[   13.238891] bq27xxx-battery 2-0055: invalid battery:energy-full-design-microwatt-hours 14800000
[   13.312469] bq27xxx_battery_set_config
[   13.407745] bq27xxx_battery_unseal
[   13.455993] bq27xxx_battery_update_dm_block
[   13.460418] bq27xxx-battery 2-0055: update terminate-voltage to 3200
[   13.694885] bq27xxx_battery_seal

Does this look ok for

	bat: battery {
		compatible = "simple-battery", "openpandora-battery";
		voltage-min-design-microvolt = <3200000>;
		energy-full-design-microwatt-hours = <14800000>;
		charge-full-design-microamp-hours = <4000000>;
	};

?

I will send a patch for enabling both fuel gauges and the omap3-pandora-common.dtsi asap.

BR and thanks,
Nikolaus
