From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv3 2/8] devfreq: exynos: Add documentation for generic
 exynos memory bus frequency driver
Date: Wed, 21 Jan 2015 15:12:57 +0900
Message-ID: <54BF4369.1060900@samsung.com>
References: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
 <1420681257-3078-3-git-send-email-cw00.choi@samsung.com>
 <CAL_Jsq+5sdsm_-VW-ta+qV-NBao-XTHvsYWcbMdZmbP0Nw43Cw@mail.gmail.com>
 <CAKohpomqosqxeDANC=NLBVmOUHyUoqd7Zhph7r6f7+ufYN48EQ@mail.gmail.com>
 <54BE108F.8090506@samsung.com>
 <CAKohpokSuVhH3hHFF+mLtJXvjt=bmJy1oZRBOttCNXORBS1Y0A@mail.gmail.com>
 <54BE3E10.2080906@samsung.com>
 <CAKohpontEntV48XqNcJq+euT9SdEjkgn5Pa=sSUpgM8mfKKCUA@mail.gmail.com>
 <54BF2929.3090107@samsung.com>
 <CAKohpomrAtqedODuzaAe3qO_YppeOU+LYR45eEs0+KcHJKHcQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:23245 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbbAUGNA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jan 2015 01:13:00 -0500
In-reply-to: <CAKohpomrAtqedODuzaAe3qO_YppeOU+LYR45eEs0+KcHJKHcQA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mark Rutland <mark.rutland@arm.com>, a.kesavan@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>, =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, InKi Dae <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

On 01/21/2015 01:37 PM, Viresh Kumar wrote:
> On 21 January 2015 at 09:50, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> If the clock will be stayed on highest voltage, will reduce
>> the considerable benefit of power-consumption.
> 
> But this is exactly what you must be doing right now as well..
> I think I didn't make it clear enough with an example. Let me
> try..
> 
> This is how I feel it should look like:
> 
>        memory_bus_int: memory_bus@1 {
>                // Regulator is shared for all below
>                blocks {
>                        peri_block: memory_bus_block1 {
>                                 operating-points = <
>                                         100000 850000
>                                         50000  850000>;
>                        };
> 
>                        display_block: memory_bus_block2 {
>                                 operating-points = <
>                                         200000 950000
>                                         160000 950000
>                                         100000 925000
>                                         80000  850000
>                                         50000  850000>;
>                        };
> 
>                        isp_block: memory_bus_block3 {
>                                 operating-points = <
>                                         200000 950000
>                                         100000 925000
>                                         80000  850000
>                                         50000  850000>;
>                        };
> 
>                        gps_block: memory_bus_block4 {
>                                 operating-points = <
>                                         300000 950000
>                                         200000 950000
>                                         133000 925000
>                                         100000 850000
>                                         50000  850000>;
>                        };
> 
> 
> Now suppose these are the requirements from all the blocks
> at any point of time:
> - block1: 100000 850000
> - block2: 100000 925000
> - block3: 80000  850000
> - block4: 133000 925000
> 
> Now, all of them can control freq separately and we don't need to
> worry for that. But regulator is shared between them. We can check
> what's the highest voltage requested at this point of time and can
> switch to that.
> 
> i.e. 925000 in this case. And that's not the highest possible one.
> And you will reach to similar conclusion with your current code as
> well I believe.
> 

OK, I understand.
I'll try to update exynos memory bus according to your comment.

Thanks
Chanwoo








