From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v3 2/4] devicetree: bindings: let thermal-sensor point to
 other thermal zones
Date: Mon, 21 Mar 2016 11:55:11 +0000
Message-ID: <20160321115511.GA6590@e104805>
References: <1448464186-26289-1-git-send-email-javi.merino@arm.com>
 <1448464186-26289-3-git-send-email-javi.merino@arm.com>
 <20160104141709.GB19256@pengutronix.de>
 <20160303032152.GD3379@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34875 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754251AbcCULzQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Mar 2016 07:55:16 -0400
Content-Disposition: inline
In-Reply-To: <20160303032152.GD3379@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zang@intel.com, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

On Wed, Mar 02, 2016 at 07:21:53PM -0800, Eduardo Valentin wrote:
> On Mon, Jan 04, 2016 at 03:17:09PM +0100, Sascha Hauer wrote:
> > On Wed, Nov 25, 2015 at 03:09:44PM +0000, Javi Merino wrote:
> > > The thermal-sensor property of the thermal zone node accepts phandles to
> > > thermal sensors.  However, thermal zones can be created as an
> > > +
> > > +		thermal-sensors = <&cpu_thermal &gpu_thermal &lcd_thermal>
> > 
> > This seems inconsistent. Why can a thermal zone only have multiple
> > thermal sensors when they are thermal zones themselves? Either we assume
> > that one thermal zone has a single sensor or we assume that it can have
> > multiple sensors, but this should not depend on the zone being a sub zone
> > or not.
> > 
> > I think the thermal-sensors property should always point to one or
> > multiple sensors. I see no point in "This property either points to
> > exactly one sensor or multiple other thermal zones (from which we only
> > use the temperature)"
> 
> 
> Agreed here. In fact, if we are going to allow thermal zones to be
> treated as sensors, it means there should be no limits on what you put
> of there, as long as all items have #thermal-sensor-cells. So, mixing
> one (or more) regular sensors, with other thermal zones shall be
> allowed, if we agree in this semantics.

Eduardo, thanks for the review.  There doesn't seem to be much
interest in this and I currently have no time to work on it so I am
dropping this series for the time being.  I'm happy for this to be
picked up by somebody else (or who knows, maybe I will be able to work
on it again in the future).

Javi
