From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PM / runtime: Asynchronous "idle" in pm_runtime_allow()
Date: Wed, 29 Jun 2016 17:00:44 +0200
Message-ID: <20160629150044.GA1900@wunner.de>
References: <2236951.5ps16Zk8OD@vostro.rjw.lan>
 <Pine.LNX.4.44L0.1606291002030.1917-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1606291002030.1917-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 29, 2016 at 10:02:42AM -0400, Alan Stern wrote:
> On Wed, 29 Jun 2016, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Arjan reports that it takes a relatively long time to enable runtime
> > PM for multiple devices at system startup, because all writes to the
> > "control" attribute in sysfs are handled synchronously and if the
> > device is suspended as a result of the write, it will block until
> > that operation is complete.
> > 
> > That may be avoided by passing the RPM_ASYNC flag to rpm_idle()
> > in pm_runtime_allow() which will make it execute the device's
> > "idle" callback asynchronously, so writes to "control" changing
> > it from "on" to "auto" will return without waiting.

Looks like pm_runtime_allow() can now be added to the section "It is
safe to execute the following helper functions from interrupt context"
in Documentation/power/runtime_pm.txt.

Best regards,

Lukas

> > 
> > Reported-by: Arjan van de Ven <arjan@linux.intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/runtime.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -1256,7 +1256,7 @@ void pm_runtime_allow(struct device *dev
> >  
> >  	dev->power.runtime_auto = true;
> >  	if (atomic_dec_and_test(&dev->power.usage_count))
> > -		rpm_idle(dev, RPM_AUTO);
> > +		rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
> >  
> >   out:
> >  	spin_unlock_irq(&dev->power.lock);
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
