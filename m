From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 16:08:57 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503231544550.631-100000@ida.rowland.org>
References: <Pine.LNX.4.50.0503221709080.16154-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37923177946966335=="
In-Reply-To: <Pine.LNX.4.50.0503221709080.16154-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============37923177946966335==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 22 Mar 2005, Patrick Mochel wrote:

> On Tue, 22 Mar 2005, Alan Stern wrote:
> 
> > When per-device locking gets added to the driver model, this can be
> > handled by making the PM core lock all devices before starting STR and
> > unlock them all after waking up.  Then any user process trying to resume a
> > device in the middle will block until the system is fully awake.
> 
> That's not a sane design. You do not want 1 function locking and another
> unlocking. That's trouble waiting to happen. We can solve that problem
> today using a single semaphore to synchronize all PM calls. If a runtime
> PM request comes in while a system PM request is being processed, that
> process will block until the semaphore is dropped (when the system is
> resumed). It will serialize all runtime PM calls, but those are not
> performance-critical operations, and it shouldn't matter too much.

1 function locking and another unlocking?  Not being aware of all the
details of the system-power-management code, I kind of assumed STR looked
something like this:

	void suspend_to_ram()
	{
		suspend all devices
		turn off main power
		/* Zzzz... */
		resume all devices
	}

So what's wrong with changing it into:

	void suspend_to_ram()
	{
		lock all devices
		suspend all devices
		turn off main power
		/* Zzzz... */
		resume all devices
		unlock all devices
	}

I agree that your single-semaphore idea would also work to prevent 
unwanted resumes during a system sleep.  But it doesn't protect against 
the possibility of devices being removed or added while the PM core is 
traversing its lists.  Locking does protect against that -- or rather, it 
will once the mechanisms have been added to the driver model core.

Now maybe the list traversal doesn't need protection.  Something like 
"Always suspend next the most recently added device that hasn't already 
been suspended" would probably work okay.  But given that during a system 
sleep transition the PM core is supposed to be in control of all devices 
for the entire time they are suspended, doesn't it make sense to have it 
lock them?

Alan Stern


--===============37923177946966335==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============37923177946966335==--
