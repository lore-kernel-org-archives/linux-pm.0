From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix the driver can not be unloaded issue
Date: Fri, 26 Apr 2013 10:11:01 +0530
Message-ID: <CAKohpon2PHFj4WuGd1wwBLnSC8Fc_VOvWmVoc04278gPKZWsrg@mail.gmail.com>
References: <1366792092-10407-1-git-send-email-Yuantian.Tang@freescale.com>
	<CAKohpomcSP4HegdQfJYDe6UHa6CTuV-G9UCb8QFDxfDvcTzsYw@mail.gmail.com>
	<D07C73A334FF604B95B3CBD2A545D07B0B165120@039-SN2MPN1-011.039d.mgd.msft.net>
	<CAKohpokWAKQDsf-6LrjDnjyKFuuZTsCYCOuiEqsv0wO0i5Ny-A@mail.gmail.com>
	<D07C73A334FF604B95B3CBD2A545D07B0B165358@039-SN2MPN1-011.039d.mgd.msft.net>
	<CAKohponjJ-30omoXJM94TE2Zs=8zT1Vkgcptd6KcvdY_ztqRsw@mail.gmail.com>
	<D07C73A334FF604B95B3CBD2A545D07B0B1656F0@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:46368 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab3DZElC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Apr 2013 00:41:02 -0400
Received: by mail-ob0-f176.google.com with SMTP id wd20so3139720obb.7
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2013 21:41:01 -0700 (PDT)
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B0B1656F0@039-SN2MPN1-011.039d.mgd.msft.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tang Yuantian-B29983 <B29983@freescale.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On 26 April 2013 07:09, Tang Yuantian-B29983 <B29983@freescale.com> wrote:
> Exactly.
> Currently, we don't consider the offline cpus when setting policy->cpus.
> Probably other platforms do the same thing.

But this is a requirement of cpufreq framework and drivers must adapt to it.
Let me know which drivers don't meet this requirement and i will get them
fixed.
