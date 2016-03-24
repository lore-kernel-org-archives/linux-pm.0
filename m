From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 14/17] cpufreq: ipq4019: add cpufreq driver
Date: Thu, 24 Mar 2016 12:14:10 +0530
Message-ID: <20160324064410.GH22062@vireshk-i7>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
 <1458770712-10880-15-git-send-email-mmcclint@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33885 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbcCXGod (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 02:44:33 -0400
Received: by mail-pf0-f171.google.com with SMTP id x3so50008308pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2016 23:44:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1458770712-10880-15-git-send-email-mmcclint@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matthew McClintock <mmcclint@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, qca-upstream.external@qca.qualcomm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, open list <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>

On 23-03-16, 17:05, Matthew McClintock wrote:
> Add cpufreq driver for ipq4019 SoC. This driver simply instantiates
> cpufreq-dt.
> 
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  9 +++++++++
>  drivers/cpufreq/Makefile          |  1 +
>  drivers/cpufreq/ipq4019-cpufreq.c | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+)
>  create mode 100644 drivers/cpufreq/ipq4019-cpufreq.c

I have just sent a patchset and cc'd you:
"[PATCH 0/3] cpufreq: dt: Create platform device from generic code"

and so this patch may get replaced now.


-- 
viresh
