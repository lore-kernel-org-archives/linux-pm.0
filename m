From: Chris Lapa <chris@lapa.com.au>
Subject: Re: BQ27xxx registers
Date: Thu, 22 Dec 2016 10:37:56 +1100
Message-ID: <a03bfb52-4eb2-406a-211d-7ae7347908cf@lapa.com.au>
References: <6da60215-4b73-8924-d5ca-48f99c70e7fb@lapa.com.au>
 <201612201234.19759@pali> <a354018a-a2e5-f70e-85b1-477a8d349a04@lapa.com.au>
 <201612211346.17265@pali>
Reply-To: chris@lapa.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33004 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758224AbcLUXiC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2016 18:38:02 -0500
Received: by mail-pg0-f65.google.com with SMTP id g1so16106347pgn.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2016 15:38:01 -0800 (PST)
In-Reply-To: <201612211346.17265@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: afd@ti.com, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 21/12/16 11:46 pm, Pali Rohár wrote:
> On Wednesday 21 December 2016 03:49:10 Chris Lapa wrote:
>> On 20/12/16 10:34 pm, Pali Rohár wrote:
>>> On Tuesday 20 December 2016 07:00:41 Chris Lapa wrote:
>>>> I can generate a patch to fix this issue, however the bigger
>>>> problem exists as to which revision fuel gauge the
>>>> bq27xxx_battery.c driver is intended to support for each family.
>>>
>>> Hi! I think driver should support all revisions. There can be (and
>>> probably really is) hardware which uses old revision and such
>>> hardware should be still supported...
>>
>> I agree. However due to the register address changes across the
>> spectrum of revisions, each revision will have to be specified
>> individually. For example, we will need to implement a BQ27510G1,
>> BQ27510G2, BQ27510G3, BQ27520G1, BQ27520G2, BQ27520G3, BQ27520G4
>> definitions and prospective device tree additions ti,bq27510g1,
>> ti,bq27510g2 etc.
>>
>> The other option is to aim for bottom of the barrel support for all
>> the devices under the BQ27500 definition but my feeling is it would
>> get messier fast and be less maintainable.
>>
>> My preference is to go with the first option if you agree?
>
> Yes. If those chips have different register addresses, then those chips
> are different. Name, generation or suffix does not matter here.
>
> Similarly there could be chips with different name, but same addresses,
> so can use one driver/configuration without any change.
>
> So I'm for different name in device tree (or platform data or what is
> being used) to distinguish between different revisions.
>

I've been working my way through the revision migration datasheets and 
noticed this could be simplified with the FW_VERSION parameter. It is 
always located at the same address and is distinctly different between 
each chip revision. Unfortunately the migration datasheets vs individual 
revision datasheets firmware version information directly contradict 
each other. Which makes me wary of committing to using it.

Given that I don't have every single variant of this device to test 
with, its probably still safest to have the user manually specify each 
device. I should have some patches ready soon.

Thanks,
Chris

