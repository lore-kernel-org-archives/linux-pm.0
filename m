From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v5 0/7] PM / devfreq: Use OPP interface to handle the frequency
Date: Mon, 6 Nov 2017 10:11:13 -0800
Message-ID: <CAOCOHw5+TtrCrnDUVj1QjBYb5tivsgTFL_8MgDGocAp0uWoEUw@mail.gmail.com>
References: <CGME20171023013213epcas1p165faa416f69659b60ec4c3f18ea251d8@epcas1p1.samsung.com>
 <1508722332-10628-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:46465 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753534AbdKFSLP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2017 13:11:15 -0500
Received: by mail-pg0-f43.google.com with SMTP id k7so8841170pga.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Nov 2017 10:11:14 -0800 (PST)
In-Reply-To: <1508722332-10628-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vinayak Holikatti <vinholikatti@gmail.com>, Vivek Gautam <vivek.gautam@codeaurora.org>

On Sun, Oct 22, 2017 at 6:32 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> These patches makes the devfreq to use the OPP interface and clean-up codes.
>

Hi Chanwoo,

This patch series breaks UFS support on modern Qualcomm platforms
(e.g. MSM8996).

Prior to this series the call to devm_devfreq_add_device() would
return ok even though the ufshcd device does not come with a opp
table. Afaict the code then relies on the devfreq code to target 0 and
MAX_INT (see ufshcd_devfreq_target()), to switch between a "high" and
"low" frequency.

I'm quite skeptical of the ufshcd code, so can you please confirm if
this usage of the devfreq interface is valid or not?

PS. If I do register some frequencies (and hack up
ufshcd_devfreq_target() accordingly) this works again, but the "high"
and "low" currently affects two clocks with different frequencies, so
I'm not sure how to properly describe the two clocks frequencies.
Should I just map "high"/"low" of the primary clock to "high"/"low"
frequencies of the secondary clock?

Regards,
Bjorn
