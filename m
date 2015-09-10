From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v2 13/13] dt: power: bq2425x-charger: Cover additional
 devices
Date: Thu, 10 Sep 2015 16:05:44 -0500
Message-ID: <20150910210544.GB16113@borg>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-14-git-send-email-dannenberg@ti.com>
 <55EF7CDA.9030505@samsung.com>
 <20150909024841.GB32255@beast>
 <55EFBC61.1050405@samsung.com>
 <20150909201534.GB9887@beast>
 <55F0CB8D.9000507@samsung.com>
 <20150910150032.GP21512@lpalcu-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40054 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbbIJVGP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 17:06:15 -0400
Content-Disposition: inline
In-Reply-To: <20150910150032.GP21512@lpalcu-desk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Sep 10, 2015 at 06:00:32PM +0300, Laurentiu Palcu wrote:
> On Thu, Sep 10, 2015 at 09:15:09AM +0900, Krzysztof Kozlowski wrote:
> > On 10.09.2015 05:15, Andreas Dannenberg wrote:

[...]

> > >> ti,current-limit (bq2425x) - maximum current to be drawn in *uA*
> > > 
> > > Ok. Again here my preference would be mA. Like already on the bq2415x.
> > > If we can change the bq2425x driver to mA (see separate thread) we'd be
> > > closer to a more unified set of properties. Otherwise we would have
> > > properties with the same name but different units (is this even
> > > possible?).
> > 
> > mA would be nice... but bq2425x driver must support existing device
> > which means it must support existing bindings. Unfortunately the
> > existing binding for bq24257 is in uA.
> 
> Oh boy... apparently this unit discrepancy mess for TI chargers was my
> doing. :/
> 
> I replied on the other thread already on my bindings choice... As I said
> there, all we can do now is agree on the binding names to be consistent.
> I'm afraid the units (as Krzysztof pointed) are pretty much settled...
> :|

Hi Laurentiu,

Yes let's keep the binding names consistent. And as for the units -
given the new state of the world (recent driver additions, inability to
change units on existing drivers) the way this aspects looks to me now
we should probably go wih uA/uV for all new bqXXX chargers. It's not a
big deal, looks like micro units are widely used in other parts of the
Kernel already (see IIO framework).

As indicated in the other thread I'll be happy to step in as the TI/bqXXX
DT bindings maintainer moving forward.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc
