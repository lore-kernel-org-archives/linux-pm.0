From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [PATCH 12/21] usb: chipidea: msm: Keep device runtime enabled
Date: Thu, 30 Jun 2016 13:30:54 -0700
Message-ID: <146731865461.12823.6532384101517870130@sboyd-linaro>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-13-stephen.boyd@linaro.org>
 <20160629064600.GG25236@shlinux2>
 <146724741028.16253.4741331543289283958@sboyd-linaro>
 <20160630013901.GC19928@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160630013901.GC19928@shlinux2>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <narmstrong@baylibre.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Peter Chen <peter.chen@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <andy.gross@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quoting Peter Chen (2016-06-29 18:39:01)
> On Wed, Jun 29, 2016 at 05:43:30PM -0700, Stephen Boyd wrote:
> > Quoting Peter Chen (2016-06-28 23:46:00)
> > > On Sun, Jun 26, 2016 at 12:28:29AM -0700, Stephen Boyd wrote:
> > > > Sometimes the usb wrapper device is part of a power domain that
> > > > needs to stay on as long as the device is active. Let's get and
> > > > put the device in driver probe/remove so that we keep the power
> > > > domain powered as long as the device is attached. We can fine
> > > > tune this later to handle wakeup interrupts, etc. for finer grain
> > > > power management later, but this is necessary to make sure we can
> > > > keep accessing the device right now.
> > > 
> > > Since some of the controllers work abnormal if we enables runtime
> > > pm unconditionally, so I use one system flag CI_HDRC_SUPPORTS_RUNTIME_PM
> > > for it. I can't understand why you can't access device without enable
> > > parent's runtime pm, the controller will not enter runtime suspend
> > > without that flag.
> > 
> > Correct, the child device of ci_hdrc_msm will be able to do runtime PM
> > and keep the parent enabled if the CI_HDRC_SUPPORTS_RUNTIME_PM flag is
> > set. But even if that flag isn't set, the ci_hdrc_msm driver is calling
> > pm_runtime_enable() on the same device that it would be called on if the
> > CI_HDRC_SUPPORTS_RUNTIME_PM flag was set. That allows runtime PM
> > transition of child devices such as the usb ports (usb1-port1 for
> > example) to propagate up all the way to the ci_hdrc_msm device and
> > disable any attached power domains.
> 
> Sorry, I can't get you.
> 
> If the chipidea core's runtime is disabled, the port under the
> controller will not be in runtime suspended, only the bus will
> be in suspended due to USB core enables runtime PM by default.

Hmm sorry, I was confused too.

>From what I can tell, if I don't call pm_runtime_set_active() on the
glue device, it will runtime suspend once I call pm_runtime_enable() on
it (which we do in ci_hdrc_mms_probe()). When we runtime suspend the
glue device, we turn off the power domain associated with it too. The
runtime pm enabled state of the core device doesn't seem to matter
either way here. So perhaps I should be calling pm_runtime_set_active()
before pm_runtime_enable() there instead of doing the get/put? It isn't
clear to me when we should be calling pm_runtime_get() vs.
pm_runtime_set_active() though.

> 
> > 
> > Why don't we call runtime PM functions on the ci->dev for all cases of
> > ci->supports_runtime_pm? It seems like the glue drivers should be
> > managing their own device power states and the ci->dev should be managed
> > by core.c code.
> > 
> 
> This is current design. Chipidea core manages portsc.phcd and PHY's PM
> (through PHY's API), and glue layer manages its own clocks on the system
> bus for register visit (and data transfer if necessary).
> 

Sorry, I mean this code in core.c

	pm_runtime_set_active(&pdev->dev);
	pm_runtime_enable(&pdev->dev);
       	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
       	pm_runtime_mark_last_busy(ci->dev);
       	pm_runtime_use_autosuspend(&pdev->dev);

which confused me. I thought pdev->dev was the glue device, but it's the
same as ci->dev, the core device. I get it now, but I'd like to change
all the calls there to use ci->dev to be clearer.
