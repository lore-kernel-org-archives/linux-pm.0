From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [Intel-gfx] [PATCH v2] PM / Runtime: Introduce
 pm_runtime_get_noidle
Date: Sat, 12 Dec 2015 19:49:56 +0000
Message-ID: <20151212194956.GA2407@nuc-i3427.alporthouse.com>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com>
 <2275921.by5gDRlTiV@vostro.rjw.lan>
 <11905299.HflTrQjrxk@vostro.rjw.lan>
 <1824809.48ZhrgqXQF@vostro.rjw.lan>
 <1449949245.2815.20.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.fireflyinternet.com ([87.106.93.118]:63162 "EHLO
	fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750940AbbLLTuM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Dec 2015 14:50:12 -0500
Content-Disposition: inline
In-Reply-To: <1449949245.2815.20.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Imre Deak <imre.deak@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, linux-pm@vger.kernel.org

On Sat, Dec 12, 2015 at 09:40:45PM +0200, Imre Deak wrote:
> On Sat, 2015-12-12 at 02:51 +0100, Rafael J. Wysocki wrote:
> > +bool pm_runtime_get_if_in_use(struct device *dev)
> > +{
> > +	unsigned long flags;
> > +	bool retval;
> > +
> > +	spin_lock_irqsave(&dev->power.lock, flags);
> > +	retval = dev->power.runtime_status == RPM_ACTIVE ?
> > +		!!atomic_inc_not_zero(&dev->power.usage_count) :
> > false;
> > +	spin_unlock_irqrestore(&dev->power.lock, flags);
> > +	return retval;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_use);
> > +
> 
> To me this looks ok:
> Acked-by: Imre Deak <imre.deak@intel.com>

Pendant says
retval = (dev->power.runtime_status == RPM_ACTIVE &&
	  atomic_inc_not_zero(&dev->power.usage_count);
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
