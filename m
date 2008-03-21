From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch 2.6.25-rc6 1/7] crosslink ACPI and "real"
	device nodes
Date: Fri, 21 Mar 2008 16:34:31 +0800
Message-ID: <1206088471.4109.56.camel__8762.57073036886$1206375029$gmane$org@localhost.localdomain>
References: <200803201408.33466.david-b@pacbell.net>
	<200803201409.28330.david-b@pacbell.net>
	<1206081808.4109.23.camel@localhost.localdomain>
	<200803210031.35174.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803210031.35174.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2008-03-21 at 00:31 -0700, David Brownell wrote:
> On Thursday 20 March 2008, Zhao Yakui wrote:
> > On Thu, 2008-03-20 at 14:09 -0700, David Brownell wrote:
> > > From: David Brownell <dbrownell@users.sourceforge.net>
> > > 
> > > Add cross-links between ACPI device and "real" devices in sysfs,
> > > exposing otherwise-hidden interrelationships between the various
> > > device nodes which ACPI creates.  As a representative example one
> > > hardware device is exposed as two logical devices (PNP and ACPI):
> > > 
> > >   .../pnp0/00:06/
> > >   .../LNXSYSTM:00/device:00/PNP0A03:00/device:15/PNP0B00:00/
> > > 
> > > The PNP device gets a "firmware_node" link pointing to the ACPI device.
> > > The ACPI device has a "physical_node" link pointing to the PNP device.
> > > Linux drivers currently bind only to the "physical" device nodes.
> >  
> > Very good idea. 
> > But maybe there is a lot of ACPI devices on the laptops. And we take a
> > little care about the association between the acpi device and "real"
> > device.
> 
> Are you suggesting that the ACPI nodes shouldn't exist at all?
> Or that something is wrong with how they're set up or used?
No. The ACPI nodes should exist. What I said is whether it is necessary
to create the link for all the ACPI devices between the ACPI device and
"real" node device.  Of course it is also OK if link is created for the
ACPI device with the ability to wake the sleeping system. 
> For now, there's some confusion.  Devices listed in ACPI tables
> have one or two extra sysfs device nodes.  I think *something*
> should help sort out the confusion -- this patch (originally
> from Zhang Rui, a co-worker of yours) is the only help for that
> which I've seen so far.  Do you propose some other solution?
> If so, what is it ... and what are its advantages?
> > Maybe it is more useful if the link is set up for the acpi device with
> > the _PRW object. Maybe the link that points to ACPI device with the _PRW
> > object is created in the /sys/power/.
> 
> That's way too many "maybes" for my taste!  Maybe I don't see
> how "_PRW" could be the only interesting thing, when most of
> the ACPI nodes don't even *have* such records ... and when not
> all power-manageable devices are even known to ACPI.
Sorry. What I means is that the link(point to the ACPI device with the
ability to wake the sleeping system) is created in the /sys/power/. 
After doing so, we can easily check which device has the ability to wake
the sleeping system. (The _PRW object indicates that the device have the
ability to wake the sleeping system). 
> 
> The notion of adding ACPI-specific stuff to generic areas (like
> /sys/power) really bothers me...
> 
> - Dave
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
