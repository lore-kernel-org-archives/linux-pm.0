From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v8 6/8] drivers: cpuidle: CPU idle ARM64 driver
Date: Sun, 14 Sep 2014 18:59:20 +0200
Message-ID: <5415C968.90303@gmail.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com> <1409585324-3678-7-git-send-email-lorenzo.pieralisi@arm.com> <20140903173740.GJ1824@e102568-lin.cambridge.arm.com> <20140904160320.GB22354@arm.com> <20140904172909.GA14822@e102568-lin.cambridge.arm.com> <20140905092120.GG13515@arm.com> <20140905153457.GA26306@e102568-lin.cambridge.arm.com> <54115D16.30206@linaro.org> <20140911085727.GA25773@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33768 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbaINQ7Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Sep 2014 12:59:25 -0400
In-Reply-To: <20140911085727.GA25773@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Steph

[dropping my old @samsung.com address]

On 11.09.2014 10:57, Lorenzo Pieralisi wrote:
> On Thu, Sep 11, 2014 at 09:28:06AM +0100, Daniel Lezcano wrote:
>> On 09/05/2014 05:34 PM, Lorenzo Pieralisi wrote:
>>> On Fri, Sep 05, 2014 at 10:21:20AM +0100, Will Deacon wrote:
>>>> On Thu, Sep 04, 2014 at 06:29:10PM +0100, Lorenzo Pieralisi wrote:
>>>>> On Thu, Sep 04, 2014 at 05:03:20PM +0100, Catalin Marinas wrote:
>>>>>> On Wed, Sep 03, 2014 at 06:37:40PM +0100, Lorenzo Pieralisi wrote:
>>>>>>> This patch should be ready to go too, is it ok if I split the series
>>>>>>> in arm64 arch specific patches (will ask Catalin to pull) and CPUidle ones
>>>>>>> (inclusive of DT bindings and !!this patch!!) and send two separate pull
>>>>>>> requests ?
>>>>>>
>>>>>> If Daniel/Rafael don't have any objection, I can take the whole series
>>>>>> through the arm64 tree (it seems that patches have been already acked by
>>>>>> Daniel).
>>>>>
>>>>> Thanks a lot Catalin. Since this one is a brand new CPUidle driver and it
>>>>> follows a different pattern from arm legacy drivers I would like to get
>>>>> Daniel's ack on this patch too before pushing it. For the records I have
>>>>> just added two pr_err to signal driver probing error, ultraminor changes
>>>>> that do not justify a repost.
>>>>>
>>>>> If Samsung guys do not manifest themselves I would drop patch 8 from
>>>>> the series till it gets tested and its patch dependency queued too.
>>>>
>>>> The last patch also has a dependency, as you mentioned to Daniel. I think
>>>> we can certainly merge the arm64 parts, and if Daniel doesn't object, then
>>>> we can take the driver stuff too but leaving the exynos bits out (i.e. drop
>>>> the last patch).
>>>>
>>>> Anyway, if you could repost with the acks you've collected and rearrange it
>>>> so the arm64 patches are first in the series, that would be great.
>>>
>>> I can repost it with the acks and rearrange the patches, but for the
>>> pull request I have to know what code can be merged, since there are
>>> some arm64 patches (PSCI and CPUidle arm64 back-end) that are strictly
>>> tied to the arm64 CPUidle driver, so I *have* to know if the arm64
>>> CPUidle driver (this patch) can get merged and that requires an ack.
>>>
>>> If I do not hear from Samsung guys I will drop patch 8.
>>
>> Well I would prefer to have this patch merged (Cc'ing Tomasz).
> 
> Ok, but:
> 
> a) I only compile tested it
> b) There is a dts patch dependency for patch 8 to apply cleanly and it
>    hasn't been acked (I can't really do it since I can't test it)
> 
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/274179.html
> 
> So, what should we do ? Tomasz ?

Sorry for late reply. I don't work for Samsung anymore so I don't focus
that much on areas other than I still maintain.

As for b) I believe all my patches have been already merged and now
we're just waiting for Kukjin to apply Bart's patch (although it's been
sitting on the ML since July, so probably needs rebasing).

About the patch 8 alone, somebody would have to test it. Maybe Bart or
Krzysztof could find some time to look at this? Other than that, I'm not
quite sure about entry latency you specified. It would look like
entering the state takes longer time than leaving, which I believe is
not the case. However I can't find any place in the code which would use
entry latency, so it might not be that important for now.

Best regards,
