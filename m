From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v4 2/7] power: bq27x00_battery: Renaming for consistency
Date: Tue, 15 Sep 2015 11:53:24 -0500
Message-ID: <55F84D04.9020501@ti.com>
References: <1442265973-32261-1-git-send-email-afd@ti.com>
 <1442265973-32261-3-git-send-email-afd@ti.com>
 <20150915083224.GA3166@lpalcu-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150915083224.GA3166@lpalcu-desk>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/15/2015 03:32 AM, Laurentiu Palcu wrote:
> On Mon, Sep 14, 2015 at 04:26:08PM -0500, Andrew F. Davis wrote:
>> Rename functions that are used by multiple devices. New devices
>> have been added and the function names and driver name are no longer
>> general enough for the functionality they provide.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>   MAINTAINERS                                        |   4 +-
>>   arch/arm/configs/omap2plus_defconfig               |   2 +-
>>   arch/unicore32/Kconfig                             |   2 +-
>>   drivers/power/Kconfig                              |  22 +-
>>   drivers/power/Makefile                             |   2 +-
>>   .../power/{bq27x00_battery.c => bq27xxx_battery.c} | 333 +++++++++++----------
>
> 1000 chips! That's how many potential chips is this driver supposed to
> support, after the rename, with little or no modifications.Is it even
> possible to guarantee that all future chips, starting with 'bq27' in
> their naming scheme, are register compatible?
>  

After this series we support three times as many chips, and almost none
of them follow the 27x00 naming (only the bq27000 and bq27200 ever did).

Also almost *none* of the new chips added are register compatible, that's
why this series moves register mapping to a table, but they all perform the
same task (fuel gauging) in almost the same way so it works well.

> Call me conservative, but when I see driver names/renames containing
> wildcards, I get chills down my spine. I can probably get over single
> digit wildcards but 3 digit wildcards is a little too much. :)
>

Perhaps just bq27x :)

> I can't help but wonder what will one have to do if one single newly
> released bq27xxx chip is completely different... :/
>

If someday they make a part that is so different it doesn't fit in this
driver then it can be the oddball with its own named driver file.

Regards,
Andrew

> laurentiu
>
>
