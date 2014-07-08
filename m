From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 0/2] cpuidle fixes and cleanup
Date: Tue, 08 Jul 2014 15:56:48 +0200
Message-ID: <53BBF8A0.1050005@samsung.com>
References: <1404225158-8453-1-git-send-email-k.chander@samsung.com>
 <20140701145244.GX32514@n2100.arm.linux.org.uk>
 <CADWw7OgCgg8aE4W6LwmU3axDdmt-5uH=a+0fSSErfqDci3nNUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:15835 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbaGHN5W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jul 2014 09:57:22 -0400
In-reply-to: <CADWw7OgCgg8aE4W6LwmU3axDdmt-5uH=a+0fSSErfqDci3nNUA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chander Kashyap <k.chander@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 02.07.2014 05:11, Chander Kashyap wrote:
> On Tue, Jul 1, 2014 at 8:22 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Tue, Jul 01, 2014 at 08:02:36PM +0530, Chander Kashyap wrote:
>>> This patch series fixes the cpuidle for different states. Also removes arm
>>> diagnostic and power register save/restore code as it is made generic.
>>>
>>> Based on:
>>> ARM: save/restore diagnostic register on Cortex-A9 suspend/resume
>>>  http://www.spinics.net/lists/arm-kernel/msg340506.html

[Ccing people who participated in discussion in that thread]

>>
>> As there is an outstanding issue with this patch, we can't proceed with
>> this set of changes until we know what's going on there.
> 
> Sure, I will wait for the conclusion.

So I believe the conclusion was that this can't be handled in generic
way, because on systems running in non-secure mode writing to those
registers faults.

However I believe this could be moved into generic helpers.

Best regards,
Tomasz
