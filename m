From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v3 01/10] dt: power: bq24257-charger: Cover additional
 devices
Date: Tue, 15 Sep 2015 08:57:59 -0500
Message-ID: <20150915135751.GA27134@borg>
References: <1442003202-1430-1-git-send-email-dannenberg@ti.com>
 <1442003202-1430-2-git-send-email-dannenberg@ti.com>
 <55F66514.1080909@samsung.com>
 <20150914135430.GA21442@borg>
 <55F7CF44.3010102@samsung.com>
 <20150915090537.GB3166@lpalcu-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51598 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbbION6b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Sep 2015 09:58:31 -0400
Content-Disposition: inline
In-Reply-To: <20150915090537.GB3166@lpalcu-desk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Sep 15, 2015 at 12:05:37PM +0300, Laurentiu Palcu wrote:
> On Tue, Sep 15, 2015 at 04:56:52PM +0900, Krzysztof Kozlowski wrote:
[...]
> > In this case - the 2XTMR_EN - I assume that for certain batteries or
> > boards you want to extend the time of charging in case of special
> > conditions?
> 
> FWIW, I don't see any real benefit in manually changing the 2X timer at
> all. The default setting is decent enough. The chip will automatically
> switch to 2X timer in certain conditions: for example, when the
> temperature threshold is exceeded and the charge current is
> automatically lowered. This makes sense since it'll take the battery
> more time to charge at a lower current.

Laurentiu,
your comment just made me go double-check the applicable datasheets and
realize that the timer 2x extension feature is by default enabled (not
disabled as I originally thought) which is great. With that, we do have
good coverage for the "special" charging conditions and don't
need to expose access to this feature at this time. Will remove it.

> It would probably make more sense to add a DT property to change the
> 'Safety Timer Time Limit' device property (which can be 0.75hrs, 6hrs,
> 9hrs or totally disabled) than the 2XTMR.
> 
> I omitted both when I originally added support for this chip since the
> 6hrs default safety timer seemed more than enough to charge a nowadays
> battery, even at 500mA (provided by a standard USB port). But, future
> batteries might (and probably will) have higher capacities and will take
> longer to charge.

Agreed, 6hrs should cover most use cases. And it'll be easy enough to
add on this property when needed.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc

