From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Sun, 13 Nov 2016 17:58:46 +0100
Message-ID: <20161113165846.GA9598@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan>
 <20161026111902.GA6447@wunner.de>
 <20161027152551.GA15718@kroah.com>
 <20161107212250.GH1764@wotan.suse.de>
 <20161108064541.GA13024@kroah.com>
 <20161108192103.GN1764@wotan.suse.de>
 <20161108194335.GA22680@kroah.com>
 <20161108205824.GA13978@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161108205824.GA13978@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrzej Hajda <a.hajda@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 08, 2016 at 09:58:24PM +0100, Luis R. Rodriguez wrote:
> On Tue, Nov 08, 2016 at 08:43:35PM +0100, Greg Kroah-Hartman wrote:
> > Yes, you can iterate a
> > lot of times, but that's fine, we have time at boot to do that (and
> > really, it is fast.)
> 
> Deferred probe is left for late_initcall() [1] -- this *assumes* that the
> driver/subsystem can be loaded so late, and as per Andrzej this solution
> isunacceptable/undesirable. So it would be unfair and incorrect to categorize
> all drivers in the same boat, in fact given this lone fact it may be
> worth revisiting the idea I mentioned about a capability aspect to support
> a late deferred probe later. We tend to assume its fine, however it does
> not seem to be the case.
> 
> [1] drivers/base/dd.c:late_initcall(deferred_probe_initcall);

Note that driver_deferred_probe_trigger() is called not only from this
late_initcall but also from driver_bound().  In other words, whenever
a driver binds successfully, deferred devices will reprobe, and devices
which had to defer will not necessarily have to wait until late_initcall
until they're reprobed.  The late_initcall is just a way to tell devices
"this is last call".

Thanks,

Lukas
