From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 2/4] devicetree: bindings: let thermal-sensor point to
 other thermal zones
Date: Wed, 2 Mar 2016 19:21:53 -0800
Message-ID: <20160303032152.GD3379@localhost.localdomain>
References: <1448464186-26289-1-git-send-email-javi.merino@arm.com>
 <1448464186-26289-3-git-send-email-javi.merino@arm.com>
 <20160104141709.GB19256@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32900 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbcCCDV5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 22:21:57 -0500
Content-Disposition: inline
In-Reply-To: <20160104141709.GB19256@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Javi Merino <javi.merino@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zang@intel.com, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

On Mon, Jan 04, 2016 at 03:17:09PM +0100, Sascha Hauer wrote:
> On Wed, Nov 25, 2015 at 03:09:44PM +0000, Javi Merino wrote:
> > The thermal-sensor property of the thermal zone node accepts phandles to
> > thermal sensors.  However, thermal zones can be created as an
> > +
> > +		thermal-sensors = <&cpu_thermal &gpu_thermal &lcd_thermal>
> 
> This seems inconsistent. Why can a thermal zone only have multiple
> thermal sensors when they are thermal zones themselves? Either we assume
> that one thermal zone has a single sensor or we assume that it can have
> multiple sensors, but this should not depend on the zone being a sub zone
> or not.
> 
> I think the thermal-sensors property should always point to one or
> multiple sensors. I see no point in "This property either points to
> exactly one sensor or multiple other thermal zones (from which we only
> use the temperature)"


Agreed here. In fact, if we are going to allow thermal zones to be
treated as sensors, it means there should be no limits on what you put
of there, as long as all items have #thermal-sensor-cells. So, mixing
one (or more) regular sensors, with other thermal zones shall be
allowed, if we agree in this semantics.

> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
