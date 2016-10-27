From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Thu, 27 Oct 2016 17:25:51 +0200
Message-ID: <20161027152551.GA15718@kroah.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan>
 <20161026111902.GA6447@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161026111902.GA6447@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 26, 2016 at 01:19:02PM +0200, Lukas Wunner wrote:
> Hi Rafael,
> 
> sorry for not responding to v5 of your series earlier, just sending
> this out now in the hope that it reaches you before your travels.
> 
> On Mon, Oct 10, 2016 at 02:51:04PM +0200, Rafael J. Wysocki wrote:
> > - Modify device_links_check_suppliers(), device_links_driver_bound(),
> >   device_links_no_driver(), device_links_driver_cleanup(), device_links_busy(),
> >   and device_links_unbind_consumers() to walk link lists under device_links_lock
> >   (to make the new "driver presence tracking" mechanism work reliably).
> 
> This change might increase boot time if drivers return -EPROBE_DEFER.

"might"?  Please verify this before guessing....

And don't make this more complex than needed before actually determining
a real issue.

thanks,

greg k-h
