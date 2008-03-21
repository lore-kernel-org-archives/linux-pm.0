From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc6 1/7] crosslink ACPI and "real"
	device nodes
Date: Fri, 21 Mar 2008 02:04:15 -0700
Message-ID: <200803210204.15843.david-b__47486.3929478035$1206090462$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
	<200803210031.35174.david-b@pacbell.net>
	<1206088471.4109.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1206088471.4109.56.camel@localhost.localdomain>
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
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 21 March 2008, Zhao Yakui wrote:
> On Fri, 2008-03-21 at 00:31 -0700, David Brownell wrote:
> > > > The PNP device gets a "firmware_node" link pointing to the ACPI dev=
ice.
> > > > The ACPI device has a "physical_node" link pointing to the PNP devi=
ce.
> > > > Linux drivers currently bind only to the "physical" device nodes.
> > >  =

> > > Very good idea. =

> > > But maybe there is a lot of ACPI devices on the laptops. And we take a
> > > little care about the association between the acpi device and "real"
> > > device.
> > =

> > Are you suggesting that the ACPI nodes shouldn't exist at all?
> > Or that something is wrong with how they're set up or used?
> =

> No. The ACPI nodes should exist. What I said is whether it is necessary
> to create the link for all the ACPI devices between the ACPI device and
> "real" node device.  Of course it is also OK if link is created for the
> ACPI device with the ability to wake the sleeping system. =


The confusion exists for all ACPI device nodes that
mirror "real" device nodes (like PNP or PCI devices).

It's *not* limited to wake-capable devices.


> > For now, there's some confusion. =A0Devices listed in ACPI tables
> > have one or two extra sysfs device nodes. =A0I think *something*
> > should help sort out the confusion ...

(Minor correction:  *most* devices listed in ACPI tables have
the problem of extra sysfs nodes.  A few don't; like buttons.)


> Sorry. What I means is that the link(point to the ACPI device with the
> ability to wake the sleeping system) is created in the /sys/power/. =

> After doing so, we can easily check which device has the ability to wake
> the sleeping system. =


There's no need for symlinks to do that ... or ACPI.

I've been meaning to repost my script that scans sysfs
for the wakeup-capable devices ... I updated it a short
while ago to work right without "legacy" sysfs nodes.

- Dave
