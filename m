From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC] Disabling Devices
Date: Mon, 9 May 2005 11:04:53 -0400
Message-ID: <20050509150452.GC27448@neo.rr.com>
References: <20050509021528.GB27448@neo.rr.com>
	<Pine.LNX.4.44L0.0505091012400.5325-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============24931677538229069=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0505091012400.5325-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============24931677538229069==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2005 at 10:26:20AM -0400, Alan Stern wrote:
> On Sun, 8 May 2005, Adam Belay wrote:
> 
> > One potentially important aspect of power management is the ability for the
> > user to disable a device that he or she does not intend to use.  Our current
> > model does not allow for this.  Calling PMSG_SUSPEND won't cut it, because it
> > might enable wake events and is expecting the system to sleep.  It seems we
> > need to implement something specifically for this case.  Also, there is the
> > posibility of resource rebalancing, which requires yet another slightly
> > different behavior.
> > 
> > Consider if a user wanted to disable a pci bus...  If the bus was just
> > suspended, it would be straightforward, put all the children to sleep and
> > then turn off the bus.  However, in the case of disabling it (as in "do not
> > use me") all of the child devices would actually need to be unregistered.
> > 
> > Furthermore, take an ethernet controller as an example.  When suspending, just
> > run the driver specific logic.  When disabling, you actually want to unregister
> > from the net class interface.
> 
> You're taking this too far.  "Disable", as in "do not use me", really 
> requires nothing more than that the device be suspended (with remote 
> wakeup turned off) and that the driver respond to requests with an error.
> 
> What you describe is more like "do your best to pretend this device 
> doesn't exist at all"!  I don't see any need to unregister anything, 
> unload drivers, or take other special action.

Really this is an implementation detail.  The point I was trying to make is
that we don't currently have a way of even suspending devices without wakeup.
However, "pretend this device doesn't exist" seems logical to me, it frees
memory and removes clutter.

> 
> 
> > As another issue, how should we handle surprise removal between suspend and
> > resume?  It seems like we would need to tell the resume method about this.
> 
> I don't know how it should be handled in other subsystems.  With USB, we 
> detect the removal at or close to the time when we attempt to resume the 
> device.  Of course USB is peculiar, in that the drivers don't bind 
> directly to the devices (they bind to interfaces within the devices).  
> Hence by the time the drivers' ->resume gets called, there's a good chance 
> we already know the device is gone.
> 
> But even if we didn't know, it wouldn't matter much.  The driver would
> encounter a rash of errors as it tried to communicate with the missing
> device, and they would end abruptly when we learned that the device had
> been disconnected.

Most drivers aren't this smart, and not every bus will be happy with drivers
tearing through the remains of previously removed hardware.

> 
> In any case, isn't it up to the bus to detect new devices and removals?  
> Why should removal during suspend be treated any differently from removal 
> at any other time when the device is not in use?

It's a very different situation.  Take PCI as an example...  If the device has
been removed while suspended, the goal changes from "restore this device" to
"free up this saved state information and unregister stuff".

Notice how surprise removal is connected and related with manual device
disabling.  We need to have unregistration infustructure anyway, why not
handle device disabling completely?

Also, there is no way to ensure that a removal will not occur during a reduced
power state (dynamic power management) that wasn't invoked by suspend.  So, in
short, hotplug drivers will need to be really robust.  I think the PM
subsystem should try to be helpful here when it can.

Finally, we need to have device resume routines rescan for child devices.

Adam

--===============24931677538229069==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============24931677538229069==--
