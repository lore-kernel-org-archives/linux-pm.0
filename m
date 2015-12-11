From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Intel-gfx] [PATCH v2] PM / Runtime: Introduce pm_runtime_get_noidle
Date: Sat, 12 Dec 2015 00:41:06 +0100
Message-ID: <11905299.HflTrQjrxk@vostro.rjw.lan>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com> <1449848828.11262.68.camel@intel.com> <2275921.by5gDRlTiV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45898 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752971AbbLKXLD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2015 18:11:03 -0500
In-Reply-To: <2275921.by5gDRlTiV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: imre.deak@intel.com
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, linux-pm@vger.kernel.org

On Saturday, December 12, 2015 12:21:43 AM Rafael J. Wysocki wrote:
> On Friday, December 11, 2015 05:47:08 PM Imre Deak wrote:
> > On pe, 2015-12-11 at 16:40 +0100, Rafael J. Wysocki wrote:
> > > On Friday, December 11, 2015 02:54:45 PM Imre Deak wrote:
> > > > On to, 2015-12-10 at 23:14 +0100, Rafael J. Wysocki wrote:
> > > > > On Thursday, December 10, 2015 11:20:40 PM Imre Deak wrote:
> > > > > > On Thu, 2015-12-10 at 22:42 +0100, Rafael J. Wysocki wrote:
> > > > > > > On Thursday, December 10, 2015 10:36:37 PM Rafael J. Wysocki

[cut]

> 
> Yes, my suggested function can be written like this:
> 
> bool pm_runtime_get_if_active(struct device *dev)
> {
>         unsigned log flags;
>         bool ret = false;
> 
>         spin_lock_irqsave(&dev->power.lock, flags);
> 
>         if (dev->power.runtime_status == RPM_ACTIVE) {
>                 if (atomic_inc_return(&dev->power.usage_count) > 1)
>                 	ret = true;
> 		else
> 			atomic_dec(&dev->power.usage_count);
>         }
> 
>         spin_unlock_irqrestore(&dev->power.lock, flags);
> 	return ret;
> }
> 
> but this is obviously racy with respect to anyone concurrently changing the
> usage counter.

Somethng like this would be slightly more efficient:

bool pm_runtime_get_if_in_use(struct device *dev)
{
        unsigned log flags;
        bool ret = false;

        spin_lock_irqsave(&dev->power.lock, flags);

        if (dev->power.runtime_status == RPM_ACTIVE)
                ret = !!atomic_inc_not_zero(&dev->power.usage_count);

        spin_unlock_irqrestore(&dev->power.lock, flags);
        return ret;
}

Thanks,
Rafael

