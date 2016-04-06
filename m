From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v7] thermal: add temperature sensor support for tango SoC
Date: Wed, 6 Apr 2016 08:51:57 -0700
Message-ID: <20160406155155.GB326@localhost.localdomain>
References: <20160308214846.GA10950@localhost.localdomain>
 <56F84427.1000507@free.fr>
 <56F91A47.9060901@free.fr>
 <20160329020050.GA15721@localhost.localdomain>
 <56FACE0B.9060606@free.fr>
 <20160330000503.GA2625@localhost.localdomain>
 <56FBEE4F.3060106@free.fr>
 <56FD8582.80002@free.fr>
 <20160401015240.GB19409@localhost.localdomain>
 <570254D8.3090406@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35730 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbcDFPwB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 11:52:01 -0400
Received: by mail-pa0-f44.google.com with SMTP id td3so35656885pab.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 08:52:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <570254D8.3090406@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, arm-soc <arm@kernel.org>

On Mon, Apr 04, 2016 at 01:49:44PM +0200, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> 
> The Tango thermal driver provides support for the primitive temperature
> sensor embedded in Tango chips since the SMP8758.
> 
> This sensor only generates a 1-bit signal to indicate whether the die
> temperature exceeds a programmable threshold.

<cut>

> +	priv->zone = thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &ops);

I would still prefer you use the devm_ version.

BR,

Eduardo
