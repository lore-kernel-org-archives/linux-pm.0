From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Date: Tue, 26 Apr 2005 02:23:14 -0400
Message-ID: <20050426062314.GC3951@neo.rr.com>
References: <1114458325.983.17.camel@localhost.localdomain>
	<Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
	<20050425145831.48f27edb.akpm@osdl.org>
	<20050425221326.GC15366@redhat.com>
	<20050425232330.GG27771@neo.rr.com>
	<1114489949.7111.43.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============08220480610561065=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1114489949.7111.43.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linux-USB <linux-usb-devel@lists.sourceforge.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, alexn@dsv.su.se, gud@eth.net, Adam Belay <abelay@novell.com>, Dave Jones <davej@redhat.com>, linux-pci@atrey.karlin.mff.cuni.cz, Jeff Garzik <jgarzik@pobox.com>, cramerj@intel.com
List-Id: linux-pm@vger.kernel.org

--===============08220480610561065==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 26, 2005 at 02:32:29PM +1000, Benjamin Herrenschmidt wrote:

-->snip

> 
> I don't like this notion of "stop" separated from power states anyway, I
> think it just doesn't work in practice.

Yeah, after giving it some additional thought, I think there are better ways.

> 
> Ben.
> 

Ok, here's a new idea.

For many devices "->suspend" and "->resume" with pm_message_t is exactly what
we need.  However, as we support more advanced power management features, such
as runtime power management, or power containers, we need something a little
more specific.  The exact power state must be specified among other issues.

We might do something like this:

Keep "->suspend" and "->resume" around unchanged. (so the states would
probably remain as PMSG_FREEZE and PMSG_SUSPEND).  If the driver doesn't
support the more advanced PM methods just use these.  They work well enough
for system sleep states etc.

Alternatively drivers could support a more rich power management interface
via the following methods:


change_state - changes a device's power state

change_state(struct device * dev, pm_state_t state, struct system_state * sys_state, int reason);  
@dev - the device
@state - the target device-specific power state
@sys_state - a data structure containing information about the intended global system power state
@reason - why the state must be changed (ex. RUNTIME_PM, SYSTEM_SLEEP, SYSTEM_RESUME, etc.)


halt - acts somewhat like PMSG_FREEZE, stops device activity, doesn't change power state

halt(struct device * dev, struct system_state * sys_state, int reason);
@dev - the device
@sys_state - a data structure containing information about the intended global system power state
@reason - why we are halting operation (ex. RUNTIME_CHANGES (like cpufreq), SYSTEM_SLEEP, SHUTDOWN, REBOOT)  


contine - resumes from a "halt"

continue(struct device * dev, struct system_state * sys_state, int reason);
@dev - the device
@sys_state - a data structure containing information about the intended global system power state
@reason - why we are resuming operation (ex. RUNTIME_CHANGES (like cpufreq), SYSTEM_RESUME)  


When changing system state, we call "change_state" for every device with power
resources.  Devices that do not directly consume power or have power states
will not implement "change_state" so we will call "halt" and "continue"
instead.

When shutting down the system, halt has the option of turning off the device,
as it will see the SHUTDOWN reason.  So it's a driver-knows-best approach
instead of assuming everything must be turned off, or everything must just be
stopped.

So in theory, with cpufreq, we could stop userspace, ->halt every device
(drivers won't do anything if they know it's not necessary), change the
frequency, and then resume operation.

We may want to create structures like pm_message_t for "change_state", "halt",
and "continue".  Pavel, do you have any thoughts on this?

This is just a rough idea... I look forward to any comments or suggestions.

Thanks,
Adam

--===============08220480610561065==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============08220480610561065==--
