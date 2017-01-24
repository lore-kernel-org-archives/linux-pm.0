From: kernel@martin.sperl.org
Subject: Re: [PATCH V9] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Tue, 24 Jan 2017 10:37:19 +0100
Message-ID: <20F6A8E3-F181-4B42-AC29-E681749FAD2A@martin.sperl.org>
References: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org> <20170120041400.GA24617@localhost.localdomain> <20170120042323.GA6651@localhost.localdomain> <D349C10C-C929-40A4-86BF-7F6E834DB613@martin.sperl.org> <20170124092645.GA3651@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:51730
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbdAXJhR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2017 04:37:17 -0500
In-Reply-To: <20170124092645.GA3651@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org


> On 24.01.2017, at 10:26, Eduardo Valentin <edubezval@gmail.com> wrote:
> 
> Hello Martin,
> 
> On Fri, Jan 20, 2017 at 09:43:02AM +0100, kernel@martin.sperl.org wrote:
>> 
>>> On 20.01.2017, at 05:23, Eduardo Valentin <edubezval@gmail.com> wrote:
>>> 
>>> On Thu, Jan 19, 2017 at 08:14:02PM -0800, Eduardo Valentin wrote:
>>>> Hello Martin,
>>>> 
>>>> On Sat, Jan 07, 2017 at 04:55:45PM +0000, kernel@martin.sperl.org wrote:
>>>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>>> 
>>>>> Add basic thermal driver for bcm2835 SOC.
>>>>> 
>>>>> This driver currently relies on the firmware setting up the
>>>>> tsense HW block and does not set it up itself.
>>>>> 
>>>>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>>>>> Acked-by: Eric Anholt <eric@anholt.net>
>>>>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>>> 
>>>> 
>>>> <cut>
>>> 
>>> 
>>> Also, I am getting this warn from sparse:
>>> drivers/thermal/bcm2835_thermal.c:110:16: warning: cast truncates bits
>>> from constant value (3ffffffffff00 becomes ffffff00)
>>> drivers/thermal/bcm2835_thermal.c:134:16: warning: cast truncates bits
>>> from constant value (3ffffffffff becomes ffffffff)
>>> 
>>> Have you seen this?
>> 
>> No, I have not checked sparse.
>> 
>> These values are defined via GENMASK on line 47 and 57 respectively
>> and should actually compute to the following values:
>>  for line 110 (line 47 has the define):
>>    GENMASK(BCM2835_TS_TSENSCTL_THOLD_BITS +     \
>>            BCM2835_TS_TSENSCTL_THOLD_SHIFT - 1, \
>>            BCM2835_TS_TSENSCTL_THOLD_SHIFT)
>>    = GENMASK(10 + 8 - 1, 8) 
>>    = GENMASK(17, 8)
>>    = (((~0UL) << (8)) & (~0UL >> (32 - 1 - (10 + 8 - 1))))
>>    = 0x3ff00
>>  for line 134 (line 57 has the define):
>>    GENMASK(BCM2835_TS_TSENSCTL_THOLD_BITS +     \
>>            BCM2835_TS_TSENSCTL_THOLD_SHIFT - 1, \
>>            BCM2835_TS_TSENSCTL_THOLD_SHIFT)
>>    = GENMASK(10 + 0 - 1, 0)
>>    = GENMASK(9, 0)
>>    = (((~0UL) << (0)) & (~0UL >> (32 - 1 - (10 + 0 - 1))))
>>    = 0x003ff
>> 
>> Note that the preprocessor expansions have been verified by
>> looking at the preprocessed driver source
>> (drivers/thermal/bcm2835_thermal.i)
> 
> OK then.
> 
>> 
>> I wonder why sparse is computing these GENMASK values as:
>> 0x3ffffffffff00 and 0x3ffffffffff
> 
> In the case you can confirm that the values are correct, I believe this
> could be a false positive report on sparse, in this case.

The correct values are the ones in my email: 0x3ff00 and 0x003ff

The ones reported by sparse (0x3ffffffffff00 and 0x3ffffffffff) are 
not calculated correctly - to me it looks as if it is possibly some
sort of 64 bit issue of sparse in conjunction with the generic macro
GENMASK.


