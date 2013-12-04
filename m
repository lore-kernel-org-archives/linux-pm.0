From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC 1/2] Documentation: arm: add cache DT bindings
Date: Wed, 4 Dec 2013 15:00:09 +0000
Message-ID: <20131204150009.GA23691@e102568-lin.cambridge.arm.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1386001205-11978-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20131204132955.GB2323@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:57308 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932257Ab3LDPAT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2013 10:00:19 -0500
In-Reply-To: <20131204132955.GB2323@e103592.cambridge.arm.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Amit Kucheria <amit.kucheria@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>

On Wed, Dec 04, 2013 at 01:29:55PM +0000, Dave Martin wrote:
> On Mon, Dec 02, 2013 at 04:20:04PM +0000, Lorenzo Pieralisi wrote:
> > On ARM systems the cache topology cannot be probed at runtime, in
> > particular, it is impossible to probe which CPUs share a given cache
> > level. Power management software requires this knowledge to implement
> > optimized power down sequences, hence this patch adds a document that
> > defines the DT cache bindings for ARM systems. The bindings are compliant
> > with ePAPR (PowerPC bindings), and rely on the cache bindings already
> > standardized in the ePAPR v1.1 document; ARM required updates are underlined
> > in the binding document.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/cache.txt | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/cache.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentation/devicetree/bindings/arm/cache.txt
> > new file mode 100644
> > index 0000000..009cddb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/cache.txt
> > @@ -0,0 +1,25 @@
> > +==========================================
> > +ARM processors cache binding description
> > +==========================================
> > +
> > +Device tree bindings for ARM processor caches adhere to the cache bindings
> > +described in [3], in section 3.8 for multi-level and shared caches.
> 
> For architected levels of cache, most of the cache properties can be
> probed through the system register interface.
> 
> Should we be explicit about prohibiting properties in the DT describing
> cache characteristics that can be probed?

I think so, yes.

> > +On ARM, internal caches cannot be described in the cpu node but require
> > +specific nodes marked with compatible string set to "cache" (see [3],
> > +section 3.8).
> > +
> > +Furthermore the cache bindings in [3] require the following property update:
> > +
> > +- [Table 3.9] cache-level: This property of cache nodes must match the cache
> > +			   level encoded in the processors CLIDR (v7) and
> > +			   CLIDR_EL1 (v8) registers, as described in [1][2].
> 
> I still don't understand why a given cache definitely has the same level
> number assigned to it with respect to each CPU.  Is that an architectural
> requirement?
> 
> All those LoC, LoU, LoUIS properties etc. are probeable per-CPU not
> globally...  I don't see why they couldn't be different.

That's a good point, that definitely requires investigation.

Thanks,
Lorenzo

