From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/5] Functional dependencies between devices
Date: Thu, 27 Oct 2016 17:32:52 +0200
Message-ID: <20161027153252.GA26705@kroah.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030284AbcJ0Pdr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Oct 2016 11:33:47 -0400
Content-Disposition: inline
In-Reply-To: <13957403.ZrB4mMbICz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Mon, Oct 10, 2016 at 02:36:31PM +0200, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> > On Thursday, September 08, 2016 11:25:44 PM Rafael J. Wysocki wrote:
> > 
> 
> [cut]
> 
> > 
> > Time for another update. :-)
> > 
> > Fewer changes this time, mostly to address issues found by Lukas and Marek.
> > 
> > The most significant one is to make device_link_add() cope with the case
> > when
> > the consumer device has not been registered yet when it is called.  The
> > supplier device still is required to be registered and the function will
> > return NULL if that is not the case.
> > 
> > Another significant change is in patch [4/5] that now makes the core apply
> > pm_runtime_get_sync()/pm_runtime_put() to supplier devices around the
> > probing of a consumer one (in analogy with the parent).
> 
> One more update after some conversations during LinuxCon Europe.
> 
> The main point was to make it possible for device_link_add() to figure out the
> initial state of the link instead of expecting the caller to provide it which
> might not be reliable enough in general.
> 
> In this version device_link_add() takes three arguments, the supplier and
> consumer pointers and flags and it sets the correct initial state of the link
> automatically (unless invoked with the "stateless" flag, of course).  The cost
> is one additional field in struct device (I moved all of the links-related
> fields in struct device to a separate sub-structure while at it) to track
> the "driver presence status" of the device (to be used by device_link_add()).
> 
> In addition to that, the links list walks in the core.c and dd.c code are
> under the device links mutex now, so the iternal link spinlock is not needed
> any more and I have renamed symbols to distinguish between flags, link states
> and device "driver presence statuses".
> 
> More information is there in the changelogs.

First off, thanks so much for doing this work, it's been needed for a
long time.  It all looks good, and I've added it to my testing tree to
give the 0-day bot some fun with it for a day or so.

thanks,

greg k-h
