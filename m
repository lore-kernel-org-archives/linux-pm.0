From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Toward runtime power management in Linux
Date: Thu, 25 Aug 2005 13:12:56 +1000
Message-ID: <1124939576.7876.4.camel@gaston>
References: <Pine.LNX.4.44L0.0507302219250.13423-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0030959369357503874=="
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============0030959369357503874==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> RTPM core: The scheme described above doesn't necessarily involve the
> PM core.  The notifications can be simple subroutine calls, perhaps
> with support from the bus subsystem.  It's not obvious how much core
> support we will need for RTPM, apart from the sysfs interface.
> 
> Recursion: A consequence of doing things this way is that the
> notifications can potentially use a lot of stack space as they
> progress up the device tree.  (I can't think of any simple
> non-recursive technique for implementing the scheme.)  Fortunately
> this probably won't be too bad; the notifications will stop when they
> reach a device that doesn't want to change its state (because it has
> other children).  So the recursion should not involve too many levels.
> Still, it is something to watch out for.

I think the locking is unmanageable if we do synchronous notification. I
think devices should issue a "request for link state change" and be
asynchronously notified of the actual change, though they might be
allowed to block if they are doing that from process and/or probe()
context (most of the time). I think the actual tree walking should be
done by a separate thread. That simplifies locking tremendously by
suppressing most deadlock conditions.

Another problem is the whole racyness of tree & list walking vs.
add/remove. We try to work around it in various ways that I think can't
work. See the small thread about pci_walk_bus() on lkml that exposes
that kind of races vs. device removal. I think we really need to
indroduce proper iterator objects that get notified on removal.

Racing with device addition is a different issue altogether. It means we
may add devices to already-walked part of the tree, thus have
inconsistent states... unless drivers are made properly aware that the
link state may not be full-on at probe time and deal with that.

> Context: A relatively recent change to the driver model core added a
> semaphore to struct device, and we will want to hold this semaphore
> while making state changes.  This immediately implies that RTPM needs
> a process context to run in.  Should we have a kernel thread or work
> queue specially devoted to RTPM activities (idle autosuspend and so
> forth)?

Might help.

Ben.



--===============0030959369357503874==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0030959369357503874==--
