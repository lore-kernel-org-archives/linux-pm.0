From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH] devfreq: simple_ondemand: Update devfreq stats when
 governor started
Date: Tue, 18 Jul 2017 10:35:49 +0000
Message-ID: <20170718103549epcms1p87cf1d138e35426be0f95afa61fcebc85@epcms1p8>
References: <1500372171-7194-1-git-send-email-jeffy.chen@rock-chips.com>
        <CGME20170718100259epcas3p2886849647d4a6fe257a4e12854a10f7c@epcms1p8>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45991 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdGRKfw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 06:35:52 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20170718103550epoutp03beeca787b3f039b646c3593b1aa21624~SZldMIwXT1424214242epoutp03t
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2017 10:35:50 +0000 (GMT)
In-Reply-To: <1500372171-7194-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "briannorris@chromium.org" <briannorris@chromium.org>, "javi.merino@kernel.org" <javi.merino@kernel.org>, "dianders@chromium.org" <dianders@chromium.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> If governor suspends soon after started, it may not have the chance to
> update devfreq stats, which leaves devfreq stats' current frequence be
> zero.
> 
> So when the thermal core tries to throttle the power, it would failed
> to get the correct static power of current frequence and print these
> warnings:
> [    2.024735] core: dev_pm_opp_get_voltage: Invalid parameters
> [    2.024743] mali ff9a0000.gpu: Failed to get voltage for frequency 0:
> -34
> ...
> [    2.026320] core: dev_pm_opp_get_voltage: Invalid parameters
> [    2.026327] mali ff9a0000.gpu: Failed to get voltage for frequency 0:
> -34
> 
> Update devfreq stats when governor started to avoid that.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

How are you calling suspend/resume routins in the mali drivers?

It appears that your mali device driver's suspend/resume routines are
accessing "struct devfreq_dev_status" directly. Is this correct?


Plus, for MALI (if that assumption is correct), this issue might occur
with other governors.

If so, would it be better to put the first initializing call of
devfreq_update_stats() at devfreq_add_device()?


Cheers,
MyungJoo

ps. Where can I look at the mali-devfreq device driver? (I couldn't find it)
