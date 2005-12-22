From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Thu, 22 Dec 2005 17:13:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512221703280.17705-100000@netrider.rowland.org>
References: <Pine.LNX.4.50.0512221213070.9577-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============72261205039956522=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0512221213070.9577-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============72261205039956522==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 22 Dec 2005, Patrick Mochel wrote:

> My recommendation for the pcmcia case was that a subsystem shouldn't
> attempt to discover new devices during the device resume sequence. It
> should first deal with devices that are there (and bound to a driver).
> Then, it should try to discard devices that still have objects, and
> finally discover new devices that have been inserted.
> 
> The final two stages should, IMHO, happen after all other devices have
> been resumed and userspace is running once again. Implementing this will
> probably require a per-subsystem thread, leveraging existing code
> (subsystem threads) if possible.
> 
> I feel the same about binding/unbinding devices from drivers. In itself,
> it sounds like a hack, but I realize that USB devices are treated
> specially during suspend/resume. For the sake of getting it working, I
> would recommend also waiting until everything else is finished, then
> process those devices to bind them to their drivers.

While feasible for the resume end, that approach won't work for the
suspend side.  The driver can't be unbound until its suspend call arrives
(because before that the core doesn't know anything is happening), and
that's after userspace is already frozen.  Conversely, the driver has to
be unbound before the suspend call can return.

I noticed this problem when testing a version of usb-storage that had the
suspend/resume support commented out.  Unbinding it caused the child SCSI
host to be unregistered, which generated a hotplug event.  Likewise,
rebinding it registered the SCSI host.  Now obviously usb-storage isn't
going to cause this problem in the real world, but other drivers might.

I'm not so sure this approach really qualifies as a "hack".  If a driver 
doesn't have explicit support for suspend/resume, the best way to quiesce 
it is to unbind it.  The only alternative is to fail all of its I/O 
requests, which seems much less reliable.

Alan Stern


--===============72261205039956522==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============72261205039956522==--
