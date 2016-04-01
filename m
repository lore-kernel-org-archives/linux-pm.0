From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v6] thermal: add temperature sensor support for tango SoC
Date: Thu, 31 Mar 2016 18:52:41 -0700
Message-ID: <20160401015240.GB19409@localhost.localdomain>
References: <56D5C7FE.7010807@free.fr>
 <56D9AF4F.1010304@free.fr>
 <20160308214846.GA10950@localhost.localdomain>
 <56F84427.1000507@free.fr>
 <56F91A47.9060901@free.fr>
 <20160329020050.GA15721@localhost.localdomain>
 <56FACE0B.9060606@free.fr>
 <20160330000503.GA2625@localhost.localdomain>
 <56FBEE4F.3060106@free.fr>
 <56FD8582.80002@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33805 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbcDABwr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 21:52:47 -0400
Received: by mail-pf0-f178.google.com with SMTP id x3so82491996pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2016 18:52:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56FD8582.80002@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Rob Herring <robh@kernel.org>

On Thu, Mar 31, 2016 at 10:16:02PM +0200, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> 
> The Tango thermal driver provides support for the primitive temperature
> sensor embedded in Tango chips since the SMP8758.
> 
> This sensor only generates a 1-bit signal to indicate whether the die
> temperature exceeds a programmable threshold.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  Documentation/devicetree/bindings/thermal/tango-thermal.txt |  17 ++++
>  drivers/thermal/Kconfig                                     |   9 ++
>  drivers/thermal/Makefile                                    |   1 +
>  drivers/thermal/tango_thermal.c                             | 125 +++++++++++++++++++++++++++
>  4 files changed, 152 insertions(+)

Based on previous versions discussion, I don't see issues with this
specific patch, despite the fact that it lacks a pointer to its doc (but looks
like there is none available).

The only request I do for now, as mentioned on v5, is to include in your
series the required dt changes to add thermal zones, describing the
needed typical trips for this chip.

BR,

Eduardo Valentin
