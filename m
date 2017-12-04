From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] cpufreq: ARM: sort the Kconfig menu
Date: Mon, 4 Dec 2017 14:11:24 +0530
Message-ID: <20171204084124.mchpmw3kta5tddgh@vireshk-mac-ubuntu>
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
 <20171201112508.14121-3-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34931 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbdLDIl3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Dec 2017 03:41:29 -0500
Received: by mail-pg0-f67.google.com with SMTP id q20so7719054pgv.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2017 00:41:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171201112508.14121-3-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Hua Jing <jinghua@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Evan Wang <xswang@marvell.com>

On 01-12-17, 12:25, Gregory CLEMENT wrote:
> +config ARM_VEXPRESS_SPC_CPUFREQ
> +        tristate "Versatile Express SPC based CPUfreq driver"
> +	depends on ARM_BIG_LITTLE_CPUFREQ && ARCH_VEXPRESS_SPC
> +        help
> +          This add the CPUfreq driver support for Versatile Express
> +	  big.LITTLE platforms using SPC for power management.
> +
> +config ARM_SCPI_CPUFREQ

The order of above two must be reversed ?

-- 
viresh
