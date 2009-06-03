From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Driver Core: Add platform device arch data V2
Date: Wed, 3 Jun 2009 10:56:37 +0200
Message-ID: <200906031056.38364.rjw__23390.6493209817$1244019464$gmane$org@sisk.pl>
References: <20090601101614.10720.93804.sendpatchset@rx1.opensource.se>
	<aec7e5c30906012133w74d7d843jccad99c564a308ec@mail.gmail.com>
	<87d49mk5zl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87d49mk5zl.fsf@deeprootsystems.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: paul@pwsan.com, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 02 June 2009, Kevin Hilman wrote:
> Magnus Damm <magnus.damm@gmail.com> writes:
> 
> > 2009/6/2 Rafael J. Wysocki <rjw@sisk.pl>:
> >> On Monday 01 June 2009, Rafael J. Wysocki wrote:
> >>> On Monday 01 June 2009, Magnus Damm wrote:
> >>> > From: Magnus Damm <damm@igel.co.jp>
> >>> >
> >>> > Allow architecture specific data in struct platform_device V2.
> >>> > The structure pdev_archdata is added to struct platform_device,
> >>> > similar to struct dev_archdata in struct device.
> >>> >
> >>> > Useful for architecture code that needs to keep extra data
> >>> > associated with each platform device. This data shall not
> >>> > be accessed by platform drivers, only architecture code.
> >>> >
> >>> > Needed for platform device runtime PM.
> >>>
> >>> What exactly do you need this data for?
> >
> > I'd like to keep a hardware block id associated with each platform
> > device on our SoC.
> > Please have a look at "PATCH [04/04] sh: Runtime platform device PM mockup",
> > http://patchwork.kernel.org/patch/26421/
> 
> And in OMAP, we will keep a pointer to an SoC-specific struct of
> HW specific data to be used in idle/wakeup decision making.
> 
> >> Anyway, I think you can introduce something like:
> >>
> >> struct <your arch>_platform_device {
> >>    struct platform_device dev;
> >>    <some type> <your arch data>;
> >>    ...
> >> };
> >>
> >> define your platform devices using the struct above and pass its dev member to
> >> the functions that need 'struct platform_device' as an argument.
> >>
> >> Then you won't need to add arch members to 'struct platform_device' itself.
> >
> > Thanks for your suggestion. I'm usually a friend of wrapping
> > structures and using offsetof(), but in this case I don't think it
> > will work very well.
> 
> Neither do I in this case...
> 
> > I'd like to keep a SoC specific hardware block id in this architecture
> > specific struct. Then let the arch specific functions
> > platform_device_idle() and platform_device_wakeup() use this hardware
> > block id to locate which clocks to stop and which power domains to
> > fiddle with within the SoC. If we only consider this on-SoC case then
> > wrapping and offsetof() works well.
> >
> > However, a typical embedded system has a wide range of platform
> > devices. Some are for the SoC itself and some are for external
> > devices, like on board ethernet controlllers (not on chip like the SoC
> > platform devices). And since idle() and wakeup() work with struct
> > platform device, with a wrapped data structure we need some way to
> > check if the platform data is actually wrapped and offsetof() is
> > valid. I guess we could use some platform device specific flag for
> > this, but that seems overly complicated in my opinion. And modifying
> > idle() and wakup() to take arch specific structures is not so good
> > since we want to use the same platform driver on multiple
> > architectures.
> 
> Also, there many cases where platform_devices are not declared
> statically and using the wrapper method doesn't work well if you are
> using platform_device_alloc().  In addition to not being able to use
> container_of() etc.  the memory allocated potentially lasts longer than
> the existence of the platform_device.

OK, that is a valid point.

Best,
Rafael
