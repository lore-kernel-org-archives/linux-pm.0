From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/6] cpufreq: sort the drivers in ARM part
Date: Mon, 4 Dec 2017 14:48:50 +0530
Message-ID: <20171204091850.iamq5uslv3hv6bez@vireshk-mac-ubuntu>
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
 <20171201112508.14121-4-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40373 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753282AbdLDJSz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Dec 2017 04:18:55 -0500
Received: by mail-pg0-f68.google.com with SMTP id k15so7770699pgr.7
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2017 01:18:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171201112508.14121-4-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Hua Jing <jinghua@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Evan Wang <xswang@marvell.com>

On 01-12-17, 12:25, Gregory CLEMENT wrote:
> Keep the driver files alphabetically sorted.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/cpufreq/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 812f9e0d01a3..d762e76887e7 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -53,22 +53,24 @@ obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)	+= arm_big_little.o
>  obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
>  
>  obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
> +obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o

Shouldn't we add them in ascending order of the whole config name and not just
CPPC_CPUFREQ ?

-- 
viresh
