From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] Documentation: dt: add bindings for ti-cpufreq
Date: Wed, 7 Sep 2016 10:42:15 +0530
Message-ID: <20160907051215.GN27345@vireshk-i7>
References: <20160901025328.376-1-d-gerlach@ti.com>
 <20160901025328.376-2-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32809 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbcIGFMT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2016 01:12:19 -0400
Received: by mail-pa0-f41.google.com with SMTP id cm16so2427289pac.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Sep 2016 22:12:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160901025328.376-2-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>

On 31-08-16, 21:53, Dave Gerlach wrote:
> +In 'operating-points-v2' table:
> +- compatible: Should be
> +	- 'operating-points-v2-ti-am3352-cpu' for am335x SoCs
> +	- 'operating-points-v2-ti-am4372-cpu' for am43xx SoCs
> +	- 'operating-points-v2-ti-dra7-cpu' for dra7xx/am57xx SoCs

Why do you need SoC specific compatible here? Are you defining new
fields in OPP tables for your SoC ? How are the tables for your case
going to differ from the ones using "operating-points-v2" compatible
string?

-- 
viresh
