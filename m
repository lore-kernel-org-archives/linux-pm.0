From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Wed, 22 Jan 2014 16:33:22 +0000
Message-ID: <20140122163322.GF24288@e102568-lin.cambridge.arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
 <20140121133148.GB28801@e102568-lin.cambridge.arm.com>
 <20140122114232.GB20247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52404 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbaAVQd0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2014 11:33:26 -0500
In-Reply-To: <20140122114232.GB20247@sirena.org.uk>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Antti Miettinen <ananaza@iki.fi>, Amit Kucheria <amit.kucheria@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Dave P Martin <Dave.Martin@arm.com>, LAK <linux-arm-kernel@lists.infradead.org>, Charl

On Wed, Jan 22, 2014 at 11:42:32AM +0000, Mark Brown wrote:
> On Tue, Jan 21, 2014 at 01:31:48PM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Jan 21, 2014 at 11:16:46AM +0000, Vincent Guittot wrote:
> 
> > > > +       - psci-power-state
> > > > +               Usage: Required if entry-method property value is set to
> > > > +                      "psci".
> > > > +               Value type: <u32>
> > > > +               Definition: power_state parameter to pass to the PSCI
> > > > +                           suspend call to enter the C-state.
> 
> > > Why psci has got a dedicated field and not vendor methods ? can't you
> > > make that more generic ?
> 
> > If anyone provides me with an example usage why not, for now I know I
> > need that parameter for PSCI, I can call it differently, define it for PSCI
> > and leave it as optional for other methods.
> 
> Would it not be sensible to define a PSCI binding that extends this and
> other bindings - ISTR some other properties getting scattered into
> bindings for it?

You mean adding the properties in the PSCI bindings instead of defining
them here ? Let me think about this, I really reckon these are C-state
specific properties that belong in here (but actually I have to add
a statement related to PSCI - ie bindings require a PSCI node to be
present and valid), I will look into this.

Thank you,
Lorenzo

