From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v2 08/13] power: bq24257: Add charge type setting support
Date: Thu, 10 Sep 2015 13:50:27 -0500
Message-ID: <20150910185025.GC16768@borg>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-9-git-send-email-dannenberg@ti.com>
 <20150910135622.GJ21512@lpalcu-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44075 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbbIJSvA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 14:51:00 -0400
Content-Disposition: inline
In-Reply-To: <20150910135622.GJ21512@lpalcu-desk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Sep 10, 2015 at 04:56:22PM +0300, Laurentiu Palcu wrote:
> On Tue, Sep 08, 2015 at 07:12:32PM -0500, Andreas Dannenberg wrote:
> > The bq2425x devices support charging with a configurable charge current
> > i_chg or a specific fixed low-current in what's called Low Charge mode.
> > This patch exposes access to the Low Charge mode through a POWER_
> > SUPPLY_PROP_CHARGE_TYPE sysfs property value of POWER_SUPPLY_CHARGE_
> > TYPE_TRICKLE. It also allows to completely disable charging if desired
> > by setting the property to POWER_SUPPLY_CHARGE_TYPE_NONE. Normal
> > charging with the configured i_chg current is activated through
> > POWER_SUPPLY_CHARGE_TYPE_FAST (default).
> > 
> > Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> 
> I have some questions here. Are there any cases in the wild, when
> userspace selects the charging type (apart from testing purposes)? And
> if yes, how is userspace supposed to detect/decide when to switch from
> trickle to fast?
> 
> I have the strange feeling that we're adding properties that will never
> be used... Other people's opinions are welcomed too.

Hi Laurentiu. I just talked to our product people to see as to how the
underlying LOW_CHG feature would be used and they essentially said its a
legacy feature used by only one customer in the past and that it doesn't
need to get exposed in our driver. I had initially implemented it in
analogy with the bq24190_charger.c driver that exposes a somewhat
similar feature but if nobody needs it from a TI point of view I'm ok
dropping it. Unless somebody screams they want it :)

Regards,

--
Andreas Dannenberg
Texas Instruments Inc


> 
> laurentiu
