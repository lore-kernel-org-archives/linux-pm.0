From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC 1/2] Documentation: arm: add cache DT bindings
Date: Mon, 2 Dec 2013 17:50:59 +0000
Message-ID: <20131202175055.GA13125@e102568-lin.cambridge.arm.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1386001205-11978-2-git-send-email-lorenzo.pieralisi@arm.com>
 <D010BD06-683A-4500-AF13-64699ECEF808@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52400 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab3LBRvH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2013 12:51:07 -0500
In-Reply-To: <D010BD06-683A-4500-AF13-64699ECEF808@codeaurora.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Mon, Dec 02, 2013 at 05:28:41PM +0000, Kumar Gala wrote:
> 
> On Dec 2, 2013, at 10:20 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
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
> > Documentation/devicetree/bindings/arm/cache.txt | 25 +++++++++++++++++++++++++
> > 1 file changed, 25 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/arm/cache.txt
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
> > +
> > +On ARM, internal caches cannot be described in the cpu node but require
> > +specific nodes marked with compatible string set to "cache" (see [3],
> > +section 3.8).
> 
> can you explain why

ARM v7 and v8 processors have a concept of cache levels which is valid
even for internal caches. So either we add a cache-level property to
internal caches or we do not use them for ARM.

On top of that the definition of internal caches in the ePAPR is not
well defined (for ARM) (what if you have multiple levels of internal
caches ? - do we describe just L1 in the cpu node ?).

Overall I think that is better to describe every cache object with a node
and a compatible string, and shared caches are just cache nodes pointed at
by multiple nodes (and private caches are just pointed at by one phandle
in the respective cpu node).

No strong position on that though, provided every cache "object" on ARM has a
cache-level attached to it.

Lorenzo

> > +
> > +Furthermore the cache bindings in [3] require the following property update:
> > +
> > +- [Table 3.9] cache-level: This property of cache nodes must match the cache
> > +			   level encoded in the processors CLIDR (v7) and
> > +			   CLIDR_EL1 (v8) registers, as described in [1][2].
> > +
> > +All other properties and rules apply.
> > +
> > +[1] ARMv7-AR Reference Manual
> > +    http://infocenter.arm.com/help/index.jsp
> > +[2] ARMv8-A Reference Manual
> > +    http://infocenter.arm.com/help/index.jsp
> > +[3] ePAPR standard
> > +    https://www.power.org/documentation/epapr-version-1-1/
> > -- 
> > 1.8.4
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
> 

