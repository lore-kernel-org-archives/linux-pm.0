From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v2 02/10] driver core: Functional dependencies tracking
	support
Date: Wed, 07 Sep 2016 01:57:11 +0200
Message-ID: <1546158.G8Vnv1pldV@vostro.rjw.lan>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
	<2841548.NIYVpJFBcH@vostro.rjw.lan>
	<20160728152831.GA1929@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160728152831.GA1929-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, July 28, 2016 05:28:31 PM Lukas Wunner wrote:
> On Thu, Jul 28, 2016 at 02:30:31AM +0200, Rafael J. Wysocki wrote:
> > On Monday, July 25, 2016 12:48:32 AM Lukas Wunner wrote:
> > > On Thu, Jul 21, 2016 at 02:25:15AM +0200, Rafael J. Wysocki wrote:
> > > > On Thursday, July 21, 2016 01:25:53 AM Lukas Wunner wrote:
> > > > > I guess I could amend portdrv to return -EPROBE_DEFER on Macs if
> > > > > no driver is bound to the NHI. Doesn't feel pretty to me though.
> > > > > 
> > > > > Ultimately this seems to be the same issue as with calling
> > > > > dev_pm_domain_set() for a bound device. Perhaps device_link_add()
> > > > > can likewise be allowed if a runtime PM ref is held for the devices
> > > > > and the call happens under lock_system_sleep()?
> > > > 
> > > > No, the whole synchronization scheme in the links code would have had to be
> > > > changed for that to really work.
> > > > 
> > > > And it really is about what is needed (at least in principle) to run your
> > > > device.  If you think you need device X with a driver to handle device Y
> > > > correctly, then either you need it all the time, from probe to remove, or
> > > > you just don't really need it at all.
> > > 
> > > Real life isn't as simple as that.
> > > 
> > > In this case, we have consumers (hotplug ports) which are doing fine
> > > if the driver for the supplier (NHI) is not loaded. But once it loads,
> > > the links must be in place.
> > 
> > Hmm.
> > 
> > What if it is not loaded and the system suspends.  Will everything work
> > as expected after the subsequent resume?
> 
> The short answer is yes.

OK

I think it's possible to add a link flag to address this case.

Namely, if that flag is passed to device_link_add(), the link will be
added in the DEVICE_LINK_ACTIVE state right away, but that will need to
be synchronized against all possible transitions of the consumer device
(at least).

It's better to do that in a separate patch for this reason IMO.

Thanks,
Rafael
