From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/7] cpufreq: Merge cpufreq_offline_prepare/finish
 routines
Date: Thu, 11 Feb 2016 17:16:33 +0530
Message-ID: <20160211114633.GB28558@vireshk>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
 <e773903ed5010cb3a9e445e2cf3a96db3942ff28.1454988792.git.viresh.kumar@linaro.org>
 <CAJZ5v0hbZMmgN2q-eR6dXK=rgLSDK_WEbD-mFB12Agb1RMm8-w@mail.gmail.com>
 <CAJZ5v0iWxdP9qYZow2yJ2CF8GD-HTO5W1w6e8baJunXEQpMjQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34156 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbcBKLqg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 06:46:36 -0500
Received: by mail-pf0-f182.google.com with SMTP id x65so28404328pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Feb 2016 03:46:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iWxdP9qYZow2yJ2CF8GD-HTO5W1w6e8baJunXEQpMjQA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 11-02-16, 02:15, Rafael J. Wysocki wrote:
> And one question tangentially related to this patch: Would it be
> possible to avoid calling __cpufreq_governor(_EXIT) for CPU offline?
> 
> The fact that we still carry out the whole governor teardown at that
> point is slightly disturbing, as in theory it should be possible to
> keep the governor attributes in place across offline/online.

Will think about that after the current code is stable a bit. It should be
possible, but need to see if it is worth it.

-- 
viresh
