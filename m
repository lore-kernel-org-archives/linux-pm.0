From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Date: Tue, 26 Apr 2005 11:16:03 +0200
Message-ID: <20050426091603.GA1824@elf.ucw.cz>
References: <1114458325.983.17.camel@localhost.localdomain>
	<Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
	<20050425145831.48f27edb.akpm@osdl.org>
	<20050425221326.GC15366@redhat.com>
	<20050425232330.GG27771@neo.rr.com>
	<1114489949.7111.43.camel@gaston>
	<20050426062314.GC3951@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73087041714377032=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050426062314.GC3951@neo.rr.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Adam Belay <abelay@novell.com>, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>, alexn@dsv.su.se, Greg KH <greg@kroah.com>, gud@eth.net, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, Jeff Garzik <jgarzik@pobox.com>, cramerj@intel.com, Linux-USB <linux-usb-devel@lists.sourceforge.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============73087041714377032==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > I don't like this notion of "stop" separated from power states anyway, I
> > think it just doesn't work in practice.
> 
> Yeah, after giving it some additional thought, I think there are better ways.
> 
> > 
> > Ben.
> > 
> 
> Ok, here's a new idea.
> 
> For many devices "->suspend" and "->resume" with pm_message_t is exactly what
> we need.  However, as we support more advanced power management features, such
> as runtime power management, or power containers, we need something a little
> more specific.  The exact power state must be specified among other
> issues.

Okay, maybe. But not by adding 3 new callbacks that mirror existing
functionality.

> We might do something like this:
> 
> Keep "->suspend" and "->resume" around unchanged. (so the states would
> probably remain as PMSG_FREEZE and PMSG_SUSPEND).  If the driver doesn't
> support the more advanced PM methods just use these.  They work well enough
> for system sleep states etc.
> 
> Alternatively drivers could support a more rich power management interface
> via the following methods:
> 
> 
> change_state - changes a device's power state
> 
> change_state(struct device * dev, pm_state_t state, struct system_state * sys_state, int reason);  
> @dev - the device
> @state - the target device-specific power state
> @sys_state - a data structure containing information about the intended global system power state
> @reason - why the state must be changed (ex. RUNTIME_PM,
> SYSTEM_SLEEP, SYSTEM_RESUME, etc.)

If drivers really need to know system state and reason, just put it
into pm_message_t. I wanted to add "flags" there from the begining,
serving similar purpose as your "reason".

> halt - acts somewhat like PMSG_FREEZE, stops device activity, doesn't change power state
> 
> halt(struct device * dev, struct system_state * sys_state, int reason);
> @dev - the device
> @sys_state - a data structure containing information about the intended global system power state
> @reason - why we are halting operation (ex. RUNTIME_CHANGES (like cpufreq), SYSTEM_SLEEP, SHUTDOWN, REBOOT)  

If it is similar to PMSG_FREEZE, just pass PMSG_FREEZE and put
* sys_state  and reason into pm_message_t.

> contine - resumes from a "halt"
> 
> continue(struct device * dev, struct system_state * sys_state, int reason);
> @dev - the device
> @sys_state - a data structure containing information about the intended global system power state
> @reason - why we are resuming operation (ex. RUNTIME_CHANGES (like cpufreq), SYSTEM_RESUME)  

Now, here you have a point. resume() should get pm_message_t,
too. This should be rather easy to change (simple matter of coding),
and we have agreed before that it is good idea. Patches welcome.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============73087041714377032==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73087041714377032==--
