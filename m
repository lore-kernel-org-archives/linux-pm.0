From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Ask for help on governor
Date: Tue, 12 Dec 2017 13:00:58 +0530
Message-ID: <20171212073058.GM25177@vireshk-i7>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:39325 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbdLLHbB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 02:31:01 -0500
Received: by mail-pf0-f175.google.com with SMTP id l24so13601680pfj.6
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2017 23:31:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Tang <andy.tang@nxp.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12-12-17, 02:46, Andy Tang wrote:
> Hi,
> 
> I run into a question that conservative governor can't work while ondemand governor works well.
> When cpu load gets higher, if ondemand governor is used, cpu frequency can get higher and higher.
> But if I use conservative governor, cpu frequency stays on lowest frequency no matter what cpu load is.
> 
> This issue was found on kernel 4.14.0, on kernel 4.9 kernel. It acts well.

You mean to say that the problem exists on 4.14 but not on 4.9?

Strange, as we haven't seen any such reports from anyone else.

> I think it may related to cpufreq framework, not driver itself. Could you guys give me some clues on how to debug it?
> I don't expect a direct answer; any suggestions are welcome.

Please provide output of below:

grep . /sys/devices/system/cpu/cpufreq/policy*/*

And then you may need to bisect the problem as well by going to kernel version
in between 4.9 and 4.14.

-- 
viresh
