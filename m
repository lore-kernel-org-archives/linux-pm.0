From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v12 3/9] usb: separate out sysdev pointer from usb_bus
Date: Fri, 10 Feb 2017 10:42:36 +0800
Message-ID: <20170210024231.GC1334@b29397-desktop>
References: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
 <1486372421-29073-4-git-send-email-peter.chen@nxp.com>
 <CAFp+6iGJxWqyingm0oszWCfyw1fkhCMFKHwe5uhRGpcYWX-XOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAFp+6iGJxWqyingm0oszWCfyw1fkhCMFKHwe5uhRGpcYWX-XOA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Chen <peter.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Ming Lei <tom.leiming@gmail.com>, Stephen Boyd <stephen.boyd@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Leo Li <pku.leo@gmail.com>, Sinjan Kumar <sinjank@codeaurora.org>, Sriram Dash <sriram.dash@nxp.com>, Fabio Estevam <festevam@gmail.com>, Joshua Clayton <stillcompiling@gmail.com>, Felipe Balbi <felipe.balbi@linux.intel.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Dann Frazier <dann.frazier@canonical.com>, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, krzk@kernel.org, David Fisher <david.fisher1@synopsys.com>, mka@chromium.org, Alan Stern <stern@rowland.harvard.edu>, Catalin Marinas <catalin.marinas@arm.com>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 09, 2017 at 11:50:32AM +0530, Vivek Gautam wrote:
> Hi,
> 
> On Mon, Feb 6, 2017 at 2:43 PM, Peter Chen <peter.chen@nxp.com> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > For xhci-hcd platform device, all the DMA parameters are not
> > configured properly, notably dma ops for dwc3 devices.
> >
> > The idea here is that you pass in the parent of_node along with
> > the child device pointer, so it would behave exactly like the
> > parent already does. The difference is that it also handles all
> > the other attributes besides the mask.
> >
> > sysdev will represent the physical device, as seen from firmware
> > or bus.Splitting the usb_bus->controller field into the
> > Linux-internal device (used for the sysfs hierarchy, for printks
> > and for power management) and a new pointer (used for DMA,
> > DT enumeration and phy lookup) probably covers all that we really
> > need.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> > Tested-by: Baolin Wang <baolin.wang@linaro.org>
> > Tested-by: Brian Norris <briannorris@chromium.org>
> > Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> > Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> > Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > Cc: Sinjan Kumar <sinjank@codeaurora.org>
> > Cc: David Fisher <david.fisher1@synopsys.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: "Thang Q. Nguyen" <tqnguyen@apm.com>
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Ming Lei <tom.leiming@gmail.com>
> > Cc: Jon Masters <jcm@redhat.com>
> > Cc: Dann Frazier <dann.frazier@canonical.com>
> > Cc: Peter Chen <peter.chen@nxp.com>
> > Cc: Leo Li <pku.leo@gmail.com>
> > ---
> >  drivers/usb/core/buffer.c | 12 ++++++------
> >  drivers/usb/core/hcd.c    | 48 ++++++++++++++++++++++++++++-------------------
> >  drivers/usb/core/usb.c    | 18 +++++++++---------
> >  include/linux/usb.h       |  1 +
> >  include/linux/usb/hcd.h   |  3 +++
> >  5 files changed, 48 insertions(+), 34 deletions(-)
> 
> [snip]
> 
> > @@ -2511,8 +2512,8 @@ static void init_giveback_urb_bh(struct giveback_urb_bh *bh)
> >   * Return: On success, a pointer to the created and initialized HCD structure.
> >   * On failure (e.g. if memory is unavailable), %NULL.
> >   */
> 
> sorry for the noise, but a minor nit here.
> The comments section above explains usb_create_shared_hcd() method
> and so should be moved down to its place.

Will update it at v13

> 
> > -struct usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
> > -               struct device *dev, const char *bus_name,
> > +struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
> > +               struct device *sysdev, struct device *dev, const char *bus_name,
> >                 struct usb_hcd *primary_hcd)
> >  {
> >         struct usb_hcd *hcd;
> > @@ -2553,8 +2554,9 @@ struct usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
> >
> >         usb_bus_init(&hcd->self);
> >         hcd->self.controller = dev;
> > +       hcd->self.sysdev = sysdev;
> >         hcd->self.bus_name = bus_name;
> > -       hcd->self.uses_dma = (dev->dma_mask != NULL);
> > +       hcd->self.uses_dma = (sysdev->dma_mask != NULL);
> >
> >         init_timer(&hcd->rh_timer);
> >         hcd->rh_timer.function = rh_timer_func;
> > @@ -2569,6 +2571,14 @@ struct usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
> >                         "USB Host Controller";
> >         return hcd;
> >  }
> > +EXPORT_SYMBOL_GPL(__usb_create_hcd);
> > +
> > +struct usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
> > +               struct device *dev, const char *bus_name,
> > +               struct usb_hcd *primary_hcd)
> > +{
> > +       return __usb_create_hcd(driver, dev, dev, bus_name, primary_hcd);
> > +}
> >  EXPORT_SYMBOL_GPL(usb_create_shared_hcd);
> 
> 
> Regards
> Vivek
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 

Best Regards,
Peter Chen
