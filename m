From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Wed, 22 Jan 2014 16:23:14 +0000
Message-ID: <20140122162313.GE24288@e102568-lin.cambridge.arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
 <20140121133148.GB28801@e102568-lin.cambridge.arm.com>
 <CAP245DXdFS5FEkrDvSw07aDDuZDqFPZXF=CoBLPrBB4JuYE8cQ@mail.gmail.com>
 <20140121152358.GD28801@e102568-lin.cambridge.arm.com>
 <20140122115214.GG17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:35481 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbaAVQXU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2014 11:23:20 -0500
In-Reply-To: <20140122115214.GG17314@sirena.org.uk>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Antti Miettinen <ananaza@iki.fi>, Tomasz Figa <t.figa@samsung.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Dave P Martin <Dave.Martin@arm.com>, Lists LAKML <linux-arm-kernel@lists.infradead.org>, Charles

Hi Mark,

On Wed, Jan 22, 2014 at 11:52:14AM +0000, Mark Brown wrote:
> On Tue, Jan 21, 2014 at 03:23:59PM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Jan 21, 2014 at 02:35:11PM +0000, Amit Kucheria wrote:
> 
> > > DT-newbie here. What would happen if a vendor does not characterise
> > > the latency at each OPP? IOW, the table only contains latency values
> > > for a subset of the OPPs.
> 
> > The bindings are explicit, so the kernel will barf. Adding a LUT to map
> > latencies to OPPs make me cringe, so I would not change the current
> > bindings.
> 
> Actually looking at the OPP binding I do wonder if it might not be
> better to have a v2/rich binding for them which is extensible - the fact
> that it's not possible to add additional information seems like an
> issue, this can't be the only thing anyone might want to add and lining
> up multiple tables is never fun.

On one hand OPP bindings need improvement and that's on the cards. I am not
really following what you mean by "extensible", I only want to make sure
that the C-state bindings do not become too complex.

Do you mean extending OPP bindings to add eg C-state information there
(or whatever piece of information that is OPP dependent) ?
It seems a bit of a stretch but I can think about that.

I think that C-state properties are better defined in the C-state bindings
that was the idea but I am open to suggestions.

Thank you !
Lorenzo

