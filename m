From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] Power domains for platform bus type
Date: Tue, 1 Feb 2011 00:10:45 +0100
Message-ID: <201102010010.46096.rjw__14125.8106021725$1296515566$gmane$org@sisk.pl>
References: <201101300107.19389.rjw@sisk.pl>
	<20110131225902.GD27856@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110131225902.GD27856@angua.secretlab.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, January 31, 2011, Grant Likely wrote:
> On Sun, Jan 30, 2011 at 01:07:19AM +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > This is something we discussed during the last Linux Plumbers Conference.
> > 
> > The problem appears to be that the same device may be used in different
> > systems in different configurations such that actions necessary for the
> > device's power management can vary from one system to another.  In those
> > cases the drivers' power management callbacks are generally not sufficient,
> > because they can't take the configuration of the whole system into account.
> > 
> > I think this issue may be addressed by adding objects that will represent
> > power domains and will provide power management callbacks to be executed
> > in addition to the device driver's PM callbacks, which is done by the patch
> > below.
> > 
> > Please have a look at it and tell me what you think.
> 
> In general it looks okay.  I agree with Alan's comment that it
> probably belongs outside the platform device pm ops.  It's the sort of
> thing that should be available to *any* device, regardless of bus
> type.

I'd rather say any subsystem.  Anyway, I'm not sure how many subsystems
will find it useful at the core level except for platform.

> ie. it is conceivable that some spi and i2c devices would be in
> need to be in the same power_domain.

So there's spi and i2c.  Anything else?

> It slightly worries me about the amount of code required to manage all the
> nested levels of pm_ops.  I wonder if there is a better way to manage
> them.

I'm not really sure.  The amount of code is kind of proportional to the
number of different callbacks in struct dev_pm_ops ...

> Also, what is the use case for having 2 sets of power_domain ops?  My
> gut tells me that you'd only want to do post ops on the
> {freeze,suspend,poweroff} path and pre ops on the {resume,thaw,restore}
> path.  It seems overly engineered to me, but I may be missing
> something fundamental.

Well, that's a part of the RFC, actually. :-)

For the subsystems I've worked with (PCI, ACPI, PNP to some extent) one set
would be sufficient, but I don't know of every possible use case.

Thanks,
Rafael
