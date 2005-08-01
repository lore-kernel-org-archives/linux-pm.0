From: "Leo L. Schwab" <ewhac@best.com>
Subject: Re: Toward runtime power management in Linux
Date: Sun, 31 Jul 2005 19:10:55 -0700
Message-ID: <20050801021054.GA30859@best.com>
References: <Pine.LNX.4.44L0.0507302219250.13423-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============30344919131446701=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0507302219250.13423-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============30344919131446701==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 30, 2005 at 10:36:56PM -0400, Alan Stern wrote:
> An example will make this clearer.  A PCI bridge is a parent, with a
> PCI device as its child.  The set of device states for both the parent and 
> the child is {D0, D1, D2, D3}.  (Maybe some variants of D3 for special
> situations; let's not worry about the details.)  The link states will
> also be D0 - D3.  When the child want to go from D0 to D3, it first
>                                                            ^^^^^^^^
> changes the device's actual state and then notifies the parent about
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> the link change.
> ^^^^^^^^^^^^^^^

	Strong disagreement.  Power state changes must be allowed to fail
("Spin up the 15K RPM drive?  I'm sorry, there's only 3 Watts of power left
to spare").  So you must first ask the parent for a power state change
before you perform your own so it has the opportunity to deny the request.
Besides, in the case of USB, you may not have any power at all until you
notify the parent bus/hub manager to wake up.

> These notifications are one-way, child-to-parent only.  We don't need
> pre- and post-notifications; each message will inform the parent of a
> single link-state change, which the parent will then carry out.

	I don't see how this will work.  Bringing up power/resuming must
happen in parent-to-child order, otherwise endpoint devices may not have any
power at all when you try to bring them up.  Cutting off power/suspending
must happen in child-to-parent order, since parents can't know when it's
safe to cut off power until the child is completely quiesced.

> Idle-timeout RTPM: We certainly should have an API whereby userspace
> can inform the kernel of an idle-timeout value to use for
> autosuspending.  (In principle there could be multiple timeout values,
> for successively deeper levels of power saving.)  This cries out to be
> managed in a centralized way rather than letting each driver have its
> own API.  It's not so clear what the most efficient implementation
> will be.  Should every device have its own idle-timeout kernel timer?
> (That's a lot of kernel timers.)

	Whether you do it in user space or kernel space, you're going to
potentially schedule a lot of timers.

> Or should the RTPM kernel thread
> wake up every second to scan a list of devices that may have exceeded
> their idle timeouts?
>
	This could potentially make performance-conscious apps "hiccup"
once every second as this thread goes walking the list looking for
candidates to shut off.  Try to avoid this; if nothing is happening, nothing
should be running.

> Userspace support: It's easy to see how userspace could use sysfs to
> request a single device state change.  But what if the user wants to
> suspend an entire subtree?  [ ... ]

	If you wanted to get really fancy, you could establish via a
userspace API a named "device collection" which acts as a virtual device.
You then apply the state change to the device collection, and the kernel
percolates it through all the actual devices, taking locking into account.

					Schwab

--===============30344919131446701==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============30344919131446701==--
