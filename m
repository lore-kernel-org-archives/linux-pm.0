From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 0/5] bq27xxx_battery data memory update
Date: Tue, 29 Aug 2017 10:31:57 -0500
Message-ID: <0bf4ba2f-18f9-1204-8241-8acb6ac6f490@ti.com>
References: <20170824033617.20840-1-liam@networkimprov.net>
 <20170829105413.6wbejdaxxxd6hk7b@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:62673 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdH2PcK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 11:32:10 -0400
In-Reply-To: <20170829105413.6wbejdaxxxd6hk7b@earth>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Liam Breck <liam@networkimprov.net>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>

On 08/29/2017 05:54 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Aug 23, 2017 at 08:36:12PM -0700, Liam Breck wrote:
>> Overview:
>> * Reorganizes chip data definitions
>> * Enables features landed in these patches:
>>   dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
>>   power: supply: bq27xxx: Add chip data memory read/write support
>>   power: supply: bq27xxx: Add power_supply_battery_info support
>> * Supports the following chips (only BQ27425 is active)
>>   BQ27500, 545, 425, 421, 441, 621
>>
>> Changes in v3:
>> * BQ27425 tested; workaround minor chip bug
>> * Dropped driver_version
>> * Fixed dbg_dupes logic for .props & .dm_regs
>> * Dropped two props array dupes
>>
>> Changes in v2:
>> * Added di->opts flags for remaining chip features
>> * Commented out untested bq27xxx_dm_regs parameters
>> * Changed dbg_dupes to run only once
>>
>> Notes on v1:
>> * Not fully tested (hence RFC tag)
> 
> Thanks, full series queued.
> 
> -- Sebastian
> 

Hold up, I'm just now seeing this series, looks like Liam left me out of
the CC despite being a reviewer in the MAINTAINERS file.. (possibly due
to me actually reviewing these patches and making him fix shit). I've
actively NACK'd some of these changes previously, making this all the
sneakier -_-

Anyway, I've not got the time to fight these changes anymore, but at
very least could you drop 4/5, it's static analysis code made into a
runtime check built into a kernel driver, if not at least add my
nacked-by. :)

>> Liam Breck (5):
>>   power: supply: bq27xxx: Create single chip data table
>>   power: supply: bq27xxx: Add chip IDs for previously shadowed chips
>>   power: supply: bq27xxx: Enable data memory update for certain chips
>>   power: supply: bq27xxx: Flag identical chip data when in debug mode
>>   power: supply: bq27xxx: Remove duplicate chip data arrays
>>
>>  drivers/power/supply/bq27xxx_battery.c     | 514 ++++++++++++++---------------
>>  drivers/power/supply/bq27xxx_battery_i2c.c |  16 +-
>>  include/linux/power/bq27xxx_battery.h      |  10 +-
>>  3 files changed, 265 insertions(+), 275 deletions(-)
>>
>> -- 
>> 2.13.2
>>
