From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v2 10/13] power: bq24257: Add various device-specific
 sysfs properties
Date: Thu, 10 Sep 2015 13:53:33 -0500
Message-ID: <20150910185333.GA7716@borg>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-11-git-send-email-dannenberg@ti.com>
 <20150910141331.GL21512@lpalcu-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35160 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbbIJSyD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 14:54:03 -0400
Content-Disposition: inline
In-Reply-To: <20150910141331.GL21512@lpalcu-desk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Sep 10, 2015 at 05:13:32PM +0300, Laurentiu Palcu wrote:
> On Tue, Sep 08, 2015 at 07:12:34PM -0500, Andreas Dannenberg wrote:
> > This patch adds support to enable/disable some device specific features
> > through device properties at boot time or sysfs properties at runtime
> > depending on whether they should be accessible during runtime or not.
> > The use of those features is be optional however they might be helpful
> > in certain scenarios:
> > 
> > * High-impedance mode enable/disable (through sysfs r/w)
> > * Sysoff enable/disable (through sysfs r/w)
> > * 2X Timer enable/disable (through "ti,safety-timer-2x-enable" dev
> >   property)
> > 
> > If not explicitly modified those settings are left at their device-
> > specific power-on defaults. Refer to the respectice device datasheets
> > for more information:
> > 
> > http://www.ti.com/product/bq24250
> > http://www.ti.com/product/bq24251
> > http://www.ti.com/product/bq24257
> > 
> > Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> 
> I'm OK with adding these properties, but I'll wait for your explanation
> on the mutex patch since I really don't think you need it, except for
> protecting chip state data.

Yes as per the other thread we don't need additional mutex protection
after all.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc


> 
> laurentiu
