From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v5 01/11] dt: power: bq24257-charger: Cover additional
 devices
Date: Tue, 22 Sep 2015 16:58:24 -0500
Message-ID: <20150922215823.GA30297@beast>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-2-git-send-email-dannenberg@ti.com>
 <20150922162448.GE4235@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58042 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934864AbbIVWE1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 18:04:27 -0400
Content-Disposition: inline
In-Reply-To: <20150922162448.GE4235@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Sep 22, 2015 at 06:24:48PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Sep 18, 2015 at 04:39:49PM -0500, Andreas Dannenberg wrote:
> > Extend the bq24257 charger's device tree documentation to cover the
> > bq24250 and bq24251 devices as well feature additions.
> 
> The binding looks fine to except for:
> 
> > +- stat-gpios: GPIO used for the devices STAT_IN pin. Alternatively the pin can
> > +    also be defined through the standard interrupt definition properties (see
> > +    optional properties section below). Only use one method.
> 
> Why do you expose two ways for this?

Hi Sebastian. The original driver exposed this - it just didn't
document it in the DT binding doc. I'm not sure why this was introduced
in the first place (Laurentiu?). I know we can't change the API but
since it was never documented maybe we can remove it?

Regards,

--
Andreas Dannenberg
Texas Instruments Inc


> 
> -- Sebastian


