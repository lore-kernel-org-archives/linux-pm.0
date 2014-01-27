From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH RFC v2 1/2] Documentation: arm: add cache DT bindings
Date: Mon, 27 Jan 2014 18:11:38 +0000
Message-ID: <20140127181138.GB2178@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:50957 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753845AbaA0SMm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2014 13:12:42 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Grant Likely <grant.likely@linaro.org>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On Mon, Jan 27, 2014 at 12:58:39PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 21, 2014 at 11:49:01AM +0000, Dave Martin wrote:
> > I do have a worry that because the kernel won't normally use this
> > information, by default it will get pasted between .dts files, won't get
> > tested and will be wrong rather often.  It also violates the DT principle
> > that probeable information should not be present in the DT -- ePAPR
> > obviously envisages systems where cache geometry information is not
> > probeable, but that's not the case for architected caches on ARM, except
> > in rare cases where the CLIDR is wrong.
> 
> That statement is wrong.  There are caches on ARM CPUs where there is no
> CLIDR register.  I suggest reading the earlier DDI0100 revisions.

You're right; I should have qualified that statement with the proviso
that there _is_ a CLIDR (or some other reliably way to discover the
cache geometry directly from the hardware).  In particular, this applies
to all v7-[AR] CPUs, but not to <=v5.  Not sure about v6 -- it may be
a mixture.

My worry was about duplication of information; so if there is no discovery
mechanism then there is no duplication and no problem -- on those older
CPUs, the corresponding information could be placed in the DT, or where
it doesn't cause a problem it can remain hard-coded into the kernel, as
at present.  If we _allow_ inclusion of that information in the DT for
pre-v7, that still raises questions about what information gets used if
there is hard-coded geometry in the kernel too.

I can't see a sufficient reason to advocate churn for pre-v7 platforms,
but other people's views may differ.

Cheers
---Dave
