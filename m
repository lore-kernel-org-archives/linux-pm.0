From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [RFC] TI BQ242xx Battery Charger Development/Consolidation Plans
Date: Wed, 12 Aug 2015 11:10:47 -0500
Message-ID: <55CB7007.3020403@ti.com>
References: <1438706177-8115-1-git-send-email-dannenberg@ti.com>	<55C23441.2030305@ti.com> <CAD03FC+DqSdg_LZ-SNaCNLsh9eZS9hSeJL5Q+8aWU+bGVcVPDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60950 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbbHLQLT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Aug 2015 12:11:19 -0400
In-Reply-To: <CAD03FC+DqSdg_LZ-SNaCNLsh9eZS9hSeJL5Q+8aWU+bGVcVPDQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <lpalcu@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Hi Palcu,

On 08/07/2015 03:58 AM, Laurentiu Palcu wrote:
> Hi Andreas,
> 
> On 5 Aug 2015 19:11, "Andreas Dannenberg" <dannenberg@ti.com> wrote:
>>
>> Not too long I ago started working on a new driver called bq242xx_charger.c
>> that will add support for TI's BQ24250, BQ24251, BQ24261M, and BQ24262 Li-Ion
>> battery charger/power-path management ICs and that work is about 50% done. I
>> chose a working name of bq242xx_charger.c in the hopes that in addition to
>> providing immediate support for said devices that this driver can later be used
>> as a platform to add other devices of the BQ242xx sub-family in an effort to
>> re-use/consolidate and help keep drivers/power organized.
>>
>> Long story short I also realized that we just got a new bq24257_charger.c
>> driver (for the BQ24257) already in the Linux 4.2 tree which creates somewhat
>> of a conflict with the bq242xx_charger.c work in progress.
>>
>> I would like to solicit ideas/comments regarding the following plan of attack:
>>
>> - Continue bq242xx_charger.c development as scoped in the first paragraph
>> - Work on getting it accepted into upstream
>> - As future work, absorb the already existing bq24257_charger.c driver into the
>>   bq242xx_charger.c driver, and deprecate its usage
> 
> Using wildcards in the driver name looks like a good idea until a new
> part that fits the naming scheme appears but it's a totally different
> product...

Thanks for your comments. It's really good and timely to have this discussion.

Generally I would agree but since this driver would encompass several devices from
the start on, all from a rather narrowly defined sub-family IMHO it would make
sense to give it a wildcard name rather than a single part number which won't
apply from the get-go to most what the driver would support. But this all might
be a moot point...

> Assuming those chips have a similar register layout as
> BQ24257, why don't you start with the existing bq24257_charger driver
> and build on that? Then, in Kconfig, make it clear what parts are
> supported by the driver. This practice is quite common in Linux
> kernel.

The BQ24257 is more or less a subset of the BQ24250/BQ24251 devices I'm working
on (once of the main difference is that the latter support dynamic power path
management which is a pretty useful feature) so generally speaking yes they
could sit in the same driver. The register maps look exactly the same so it
definitely makes sense to consolidate here.

I'll do some more digging in BQ24257_charger.c to see how feature-complete it
is and what it would mean adding support for "my" BQ24250/bq24251 devices.

One concern I have with bq24257_charger.c is the extensive use of regmap fields.
While certainly elegant I'm worried about the overhead/memory it consumes vs.
simple #defines. For example the charger code creates 27 instances of struct
regmap_field at runtime which consumes ~650 bytes of memory, and another 27
instances of struct reg_field allocated at load time consuming 540 byte, bringing
the total to almost 1.2KB (along the lines, bq25890_charger.c has 72 register
fields and consumes almost 3x that amount of memory for the same reasons).
Maybe it's because I'm from an MCU background but this sounds like a lot of
memory to me to hold 6 bytes worth of actual data (the device registers)...

>> There might be a potential risk for user confusion for a transitional time if
>> somebody was just looking at the filenames to select their driver due to part
>> number overlap. However I argue folks are more likely to go the Kconfig route
>> to select their driver so this may not be a problem after all.
> 
> This one is tricky. If the BQ24257 chip became part of a commercial
> product, then the customers will have to change the .config after
> doing a kernel upgrade. Customers are not keen on doing that for a
> commercially released product.

Understood. Migrating stuff is never fun. If I can find a good way to split/merge
my work into yours (and Ram's) hopefully it won't come to that.

Thanks and Regards,

-- 
Andreas Dannenberg
Texas Instruments Inc.

> 
> Sebastian, what do you think?
> 
> laurentiu
> 


