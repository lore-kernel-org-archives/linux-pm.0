From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH v2 0/8] PM / devfreq: Use OPP interface to handle
 the frequency
Date: Wed, 27 Sep 2017 08:09:22 +0000
Message-ID: <20170927080922epcms1p3c8f87f8f55d753f57afe053d5750ebfc@epcms1p3>
References: <59CAFEA7.10007@samsung.com>
        <1505954032-3327-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170921003355epcas1p1d1bbb04ff7a7c46946f62a91883bd6a6@epcms1p3>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60194 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751987AbdI0IJY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2017 04:09:24 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20170927080922epoutp0457ed940b1c2a9379893e2744910659d9~oKY1xBsDX2080720807epoutp04j
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2017 08:09:22 +0000 (GMT)
In-Reply-To: <59CAFEA7.10007@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "chanwoo@kernel.org" <chanwoo@kernel.org>, Inki Dae <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> Hi Myungjoo,
> 
> Could you please review this patchset?


I ignored your v2 patchset because of the follow-up message:

| Re: [PATCH v2 8/8] PM / devfreq: exynos-bus: Register cooling device
|
| Dear all,
|
| Please ignore this patch. It has some problem.
| I'll fix and resend this patch on v2.

I thought you'd send another series with [PATCH v3 x/8]...

(I've just noticed that [PATCH v2.1] was sent yesterday.
 Is the patchsetv2 ready with the replacement of 8th commit?)

Cheers,
MyungJoo

ps. you know I'm going to be away for a long vacation
 starting this week.
 I can't gurantee that I'll see all of the set before the vacation.

> 
> On 2017년 09월 21일 09:33, Chanwoo Choi wrote:

> > These patches makes the devfreq to use the OPP interface and clean-up codes.

> > - patch 1~5 are related to the OPP interfaces. 

> > - patch 6 removes the unneeded code.

> > - patch 7 clean-up for the governor name.

> > - patch 8 registers the cooling device for exynos-bus.

> > 

> > [Detaild Descripion]

> > The commit a76caf55e5b3 ("thermal: Add devfreq cooling") provides

> > the devfreq cooling device by using the OPP interface such as

> > dev_pm_opp_disable() and dev_pm_opp_enable(). It means that

> > the OPP interface is able to change the available status of the frequency.

> > 

> > Firstly, the existing devfreq doesn't use the OPP interface when showing

> > the minimum and maximum frequency through the following sysfs nodes:

> > It shows the wrong frequency value because min_freq/max_freq don't

> > consider the frequency status by handling OPP interface

> > (opp_dev_pm_opp_{disable|add}()). So, these patches fix this issue.

> > - /sys/class/devfreq/devfreqX/min_freq

> > - /sys/class/devfreq/devfreqX/max_freq

> > 

> > Second, the 'available_frequencies' should show the all supported frequencis

> > even if the specific frequency is not available. It doesn't matter whether

> > frequneyc is available or not. Because the role of 'available_frequencies'

> > shows the all frequencies. Also, these patches fix this issue.

> > - /sys/class/devfreq/devfreqX/available_frequencies

> > 

> > Third, update_devfreq() get the available next frequency by using

> > the devfreq_recommended_opp() in order to consider the disabled OPP.
