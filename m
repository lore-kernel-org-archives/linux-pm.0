From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] Documentation: dt: add bindings for ti-cpufreq
Date: Thu, 8 Sep 2016 09:05:57 +0530
Message-ID: <20160908033557.GQ27345@vireshk-i7>
References: <20160901025328.376-1-d-gerlach@ti.com>
 <20160901025328.376-2-d-gerlach@ti.com>
 <20160907051215.GN27345@vireshk-i7>
 <57D025E8.6030202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36414 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753267AbcIHDgC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2016 23:36:02 -0400
Received: by mail-pa0-f49.google.com with SMTP id id6so12639337pad.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Sep 2016 20:36:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57D025E8.6030202@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>

On 07-09-16, 09:36, Dave Gerlach wrote:
> On 09/07/2016 12:12 AM, Viresh Kumar wrote:
> >On 31-08-16, 21:53, Dave Gerlach wrote:
> >>+In 'operating-points-v2' table:
> >>+- compatible: Should be
> >>+	- 'operating-points-v2-ti-am3352-cpu' for am335x SoCs
> >>+	- 'operating-points-v2-ti-am4372-cpu' for am43xx SoCs
> >>+	- 'operating-points-v2-ti-dra7-cpu' for dra7xx/am57xx SoCs
> >
> >Why do you need SoC specific compatible here? Are you defining new
> >fields in OPP tables for your SoC ? How are the tables for your case
> >going to differ from the ones using "operating-points-v2" compatible
> >string?
> >
> 
> I thought you had suggested that I do this in your comments from v1, but I
> guess that was dependent on whether or not I put the properties I have
> inserted into the cpu node into the operating-points table instead.

Yes.

> I still
> have gotten no comments from any DT maintainers so I left it as is. I am
> still not sure if that is acceptable.

@Rob: Can you please share your views on the new properties being
added to the CPU node ?

-- 
viresh
