From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: acpi-cpufreq: make Intel/AMD MSR access, io
 port access static
Date: Tue, 22 Mar 2016 20:13:53 +0530
Message-ID: <20160322144353.GN5272@vireshk-i7>
References: <1458657270-2440-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34016 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbcCVOn6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2016 10:43:58 -0400
Received: by mail-pf0-f176.google.com with SMTP id x3so314370532pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2016 07:43:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1458657270-2440-1-git-send-email-jszhang@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 22-03-16, 22:34, Jisheng Zhang wrote:
> These frequency register read/write operations' implementations for the
> given processor (Intel/AMD MSR access or I/O port access) are only used
> internally in acpi-cpufreq, so make them static.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
