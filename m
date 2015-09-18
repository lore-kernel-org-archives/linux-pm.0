From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v4 09/10] power: bq24257: Add various device-specific
 sysfs properties
Date: Fri, 18 Sep 2015 14:08:09 -0500
Message-ID: <20150918190809.GH27772@beast>
References: <1442339914-25843-1-git-send-email-dannenberg@ti.com>
 <1442339914-25843-10-git-send-email-dannenberg@ti.com>
 <55F923DE.5010809@samsung.com>
 <20150916195449.GF27772@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51836 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbbIRTJX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Sep 2015 15:09:23 -0400
Content-Disposition: inline
In-Reply-To: <20150916195449.GF27772@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Sep 16, 2015 at 02:54:53PM -0500, Andreas Dannenberg wrote:
> On Wed, Sep 16, 2015 at 05:10:06PM +0900, Krzysztof Kozlowski wrote:
> > On 16.09.2015 02:58, Andreas Dannenberg wrote:
> > >  static DEVICE_ATTR(ovp_voltage, S_IRUGO, bq24257_show_ovp_voltage, NULL);
> > >  static DEVICE_ATTR(in_dpm_voltage, S_IRUGO, bq24257_show_in_dpm_voltage, NULL);
> > 
> > This applies to previous patches actually: DEVICE_ATTR_RO?
> 
> Ok. Will simplify.

Actually I looked into this more and realized that the use of the
pre-configured DEVICE_ATTR_* definitions imposes certain function names,
which would mean renaming the functions including dropping the bq24257_
prefix those function names have, making the code inconsistent and
decreasing the unique-ness of those function names in the global Kernel
namespace. So I rather leave the more general DEVICE_ATTR() definitions
in place.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc
