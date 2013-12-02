From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC 1/2] Documentation: arm: add cache DT bindings
Date: Mon, 2 Dec 2013 18:34:12 +0000
Message-ID: <20131202183412.GA13791@e102568-lin.cambridge.arm.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1386001205-11978-2-git-send-email-lorenzo.pieralisi@arm.com>
 <D010BD06-683A-4500-AF13-64699ECEF808@codeaurora.org>
 <20131202175055.GA13125@e102568-lin.cambridge.arm.com>
 <CB2ECFBB-A959-4A44-B301-0188EA5599A3@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39728 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab3LBSeU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2013 13:34:20 -0500
In-Reply-To: <CB2ECFBB-A959-4A44-B301-0188EA5599A3@codeaurora.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Mon, Dec 02, 2013 at 05:59:56PM +0000, Kumar Gala wrote:
> 
> On Dec 2, 2013, at 11:50 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> > On Mon, Dec 02, 2013 at 05:28:41PM +0000, Kumar Gala wrote:
> >> 
> >> On Dec 2, 2013, at 10:20 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> >> 
> >>> On ARM systems the cache topology cannot be probed at runtime, in
> >>> particular, it is impossible to probe which CPUs share a given cache
> >>> level. Power management software requires this knowledge to implement
> >>> optimized power down sequences, hence this patch adds a document that
> >>> defines the DT cache bindings for ARM systems. The bindings are compliant
> >>> with ePAPR (PowerPC bindings), and rely on the cache bindings already
> >>> standardized in the ePAPR v1.1 document; ARM required updates are underlined
> >>> in the binding document.
> >>> 
> >>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>> ---
> >>> Documentation/devicetree/bindings/arm/cache.txt | 25 +++++++++++++++++++++++++
> >>> 1 file changed, 25 insertions(+)
> >>> create mode 100644 Documentation/devicetree/bindings/arm/cache.txt
> >>> 
> >>> diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentation/devicetree/bindings/arm/cache.txt
> >>> new file mode 100644
> >>> index 0000000..009cddb
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/arm/cache.txt
> >>> @@ -0,0 +1,25 @@
> >>> +==========================================
> >>> +ARM processors cache binding description
> >>> +==========================================
> >>> +
> >>> +Device tree bindings for ARM processor caches adhere to the cache bindings
> >>> +described in [3], in section 3.8 for multi-level and shared caches.
> >>> +
> >>> +On ARM, internal caches cannot be described in the cpu node but require
> >>> +specific nodes marked with compatible string set to "cache" (see [3],
> >>> +section 3.8).
> >> 
> >> can you explain why
> > 
> > ARM v7 and v8 processors have a concept of cache levels which is valid
> > even for internal caches. So either we add a cache-level property to
> > internal caches or we do not use them for ARM.
> 
> There isn't anything precluding a cachel-level property for internal caches.
> 
> > On top of that the definition of internal caches in the ePAPR is not
> > well defined (for ARM) (what if you have multiple levels of internal
> > caches ? - do we describe just L1 in the cpu node ?).
> 
> ePAPR has examples of multiple level's of internal cache in the cpu node.

Where ? 3.7.3 (ePAPR v1.1) Internal (L1) Cache properties ? I do not think so.

It does by using the definitions in 3.8 "Multi level and shared caches".

So, since the cache bindings in 3.8 allow to describe a cache hierarchy
on ARM, that's what I used. Declaring L1 in the CPU node buys us nothing, so
I do not think there is a point in using it on ARM. That's why instead
of changing the bindings for internal (L1) caches to require cache-level
we should just ignore them IMHO.

ePAPR v1.1 contains a bug (example page 47 - line 47) since a cpu node cannot
contain a cache-level property, that's not a property of internal caches and
it has to be declared in a node with:

compatible = "cache";

unless my understanding of ePAPR is wrong.

All I am saying is that multi-level cache bindings can be used to
describe all cache hierarchies for ARM, we do not need internal (L1)
cache bindings at all, it is just legacy stuff.

Lorenzo

