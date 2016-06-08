From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Platform-specific suspend/resume code in drivers
Date: Wed, 8 Jun 2016 13:45:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1606081340050.2191-100000@iolanthe.rowland.org>
References: <57584736.7020201@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <57584736.7020201@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mason <slash.tmp@free.fr>
Cc: Sebastian Frias <sf84@laposte.net>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mans Rullgard <mans@mansr.com>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 8 Jun 2016, Mason wrote:

> On 07/06/2016 17:06, Alan Stern wrote:
> 
> > On Tue, 7 Jun 2016, Mason wrote:
> >
> >> Another point of confusion for me is this: drivers are supposed to
> >> be shared among platforms, right? So my platform-specific suspend
> >> code should be enabled only if my platform is detected at run-time?
> > 
> > Is your device platform-specific?  If it is then the driver is also
> > platform-specific, and so no part of the driver will be called at
> > runtime unless your platform is detected.
> 
> Specifically, my platform uses
> drivers/net/ethernet/aurora/nb8800.c  => 3 entries in of_match_table.
> drivers/tty/serial/8250/8250_core.c (CONFIG_SERIAL_8250_RT288X variant)
> 
> and also the XHCI USB3 driver, and AHCI SATA driver, wouldn't I need to
> save the context for these too?

Those drivers should already take care of their own contexts.  Is 
there anything platform-specific you need to do in addition?  Consider 
xHCI as an example case -- what more does it need?

> > If the device isn't platform-specific then the driver has to work on a 
> > bunch of different platforms.  It should be written to be 
> > platform-independent as much as possible.
> > 
> >> So this means I need to add in the probe function, for every driver
> >> my platform uses:
> >>
> >>   if (platform == MY_PLATFORM) {
> >>     ops.suspend = my_suspend;
> >>     ops.resume  = my_resume;
> >>   }
> >>
> >> Is that correct?
> > 
> > No.  For one thing, you only have to worry about the 
> > platform-independent drivers -- you know that the platform-specific 
> > ones won't get used unless your platform is present.
> 
> I guess the thermal driver is platform-specific, but most devices
> are third-party IP blocks, so there is a "common" driver upstream.
> But I would need a platform-specific suspend/resume sequence,
> just for my platform.

Why?  What sort of platform-specific things do you need to do?

> > For another, the driver should be written in a way that doesn't require
> > this sort of code.  The ops pointer (not any of the structure's members
> > -- a pointer to the structure) should be set by the platform-dependent
> > part of the driver that handles initialization.
> 
> I don't understand. If my platform loses context on suspend, then
> I must save/restore it. But this wasteful operation should not be
> imposed on other platforms.

More details, please.

Alan Stern
