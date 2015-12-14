From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Intel-gfx] [PATCH v2] PM / Runtime: Introduce pm_runtime_get_noidle
Date: Mon, 14 Dec 2015 03:04:20 +0100
Message-ID: <3626982.Y3cVYgn8p5@vostro.rjw.lan>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com> <1449949245.2815.20.camel@intel.com> <20151212194956.GA2407@nuc-i3427.alporthouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55512 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751567AbbLNBeP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Dec 2015 20:34:15 -0500
In-Reply-To: <20151212194956.GA2407@nuc-i3427.alporthouse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Imre Deak <imre.deak@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, linux-pm@vger.kernel.org

On Saturday, December 12, 2015 07:49:56 PM Chris Wilson wrote:
> On Sat, Dec 12, 2015 at 09:40:45PM +0200, Imre Deak wrote:
> > On Sat, 2015-12-12 at 02:51 +0100, Rafael J. Wysocki wrote:
> > > +bool pm_runtime_get_if_in_use(struct device *dev)
> > > +{
> > > +	unsigned long flags;
> > > +	bool retval;
> > > +
> > > +	spin_lock_irqsave(&dev->power.lock, flags);
> > > +	retval = dev->power.runtime_status == RPM_ACTIVE ?
> > > +		!!atomic_inc_not_zero(&dev->power.usage_count) :
> > > false;
> > > +	spin_unlock_irqrestore(&dev->power.lock, flags);
> > > +	return retval;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_use);
> > > +
> > 
> > To me this looks ok:
> > Acked-by: Imre Deak <imre.deak@intel.com>
> 
> Pendant says
> retval = (dev->power.runtime_status == RPM_ACTIVE &&
> 	  atomic_inc_not_zero(&dev->power.usage_count);

Well, this wouldn't build AFAICS.

retval = dev->power.runtime_status == RPM_ACTIVE &&
	atomic_inc_not_zero(&dev->power.usage_count);

Thanks,
Rafael

