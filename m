From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Sat, 18 Feb 2006 16:04:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0602181531290.4115-100000@netrider.rowland.org>
References: <20060217210445.GR3490@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79143912847975861=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060217210445.GR3490@openzaurus.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Phillip Susi <psusi@cfl.rr.com>, Kernel development list <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>
List-Id: linux-pm@vger.kernel.org

--===============79143912847975861==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 17 Feb 2006, Pavel Machek wrote:

> > If there is no better way to tell for sure that the device that is 
> > now there is not the same as the one that was there, then the kernel 
> > must assume the user did not do something stupid and continue to use 
> 
> Must?! Are you Linus or what?

Technical issues aside, the question about recogizing formerly-attached 
devices when waking up from a system sleep is really about 
user-friendliness.  The choice between what Phillip is advocating and what 
the rest of us have been saying is a policy choice, one that the kernel 
can't easily avoid making.

Given that this is a policy decision, it might not be such a bad idea to 
ask Andrew or Linus for their opinion.  In fact, I'll do that right now.


To summarize the background:

When a hotpluggable bus (USB for sure, possibly others as well) loses 
power, the hardware interprets this as a disconnection of all attached 
devices.  When power is restored, it appears to the kernel as though a 
completely new set of devices has now been plugged in.

This is unfriendly for people whose motherboard/USB-controller hardware
doesn't supply minimal power during hardware- or software-suspend.  Any
mounted filesystems on a USB storage device get blown away when the system
resumes, since the kernel thinks the device was unplugged.

In principle the kernel is capable of detecting that a device present on a
port during resume is very similar to the device that had been present
during the suspend.  Through a combination of checks (descriptors, serial
numbers, superblocks, maybe others) it could try to verify this and then
keep the device data structures intact, as though the device had been
connected all along.

The advantage is that people wouldn't lose half-stored data on their
removable drives, they wouldn't have unmount before suspending and remount 
after resuming, and they would be able to suspend with their root
filesystem on a USB drive without causing a panic upon resume.

The disadvantage is that sometimes people do switch removable drives or
removable media while the system is asleep.  If the kernel gets fooled
into thinking the new device is the same as the old one, it would proceed
to destroy the data on the new device by overwriting it with data from the
old one.  (Not to mention that this kind of approach is contrary to the
USB specification.)

On the other hand, it's what Windows does.  We don't want people to say 
that Linux is incapable of implementing a feature that Windows has had for 
a long time.  :-)


So the question is: What should the kernel do?  Assume the device has 
changed (as it does now) or make some checks to see if it might still be 
the same (dangerous though that may be)?

If you really want to waffle, you can recommend that the capability to do
this be present but normally disabled, controlled by a flag somewhere in
/sys/kernel -- thus pushing the decision off to userspace.

Alan Stern


--===============79143912847975861==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79143912847975861==--
