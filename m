From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: comments on irc log
Date: Fri, 18 Mar 2005 22:23:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503182205040.30560-100000@netrider.rowland.org>
References: <1111195262.25179.201.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============13138553476527326=="
In-Reply-To: <1111195262.25179.201.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============13138553476527326==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 19 Mar 2005, Benjamin Herrenschmidt wrote:

> > > I wonder if we need to quiesce the controller in fact for FREEZE.
> > > Probably not. Just stop all queue processing and refuse URBs. The hcca
> > > will still get updated, but who cares ? it will end up beeing saved in
> > > an inconsistent state in the suspend image, so what ? On resume, we will
> > > have rebooted, we can "clean it up".
> > > 
> > > This is sort-of breaking the rule of "no DMA", and thus is not suitable
> > > for kexec (which is ok, kexec currently uses the separate "shutdown"
> > > callback which must switch DMA off), but would fix the problem for
> > > suspend to disk...
> > 
> > What problem? suspend seems to +/- work with suspend-to-disk just
> > now. I'd really hate to have to think about "some memory may change
> > behind my back" during suspend. I think "no DMA" is a good rule.
> 
> Well, it's not that simple. It may work for you and not for others, and
> it will definitely introduce complications with the current scheme since
> it seems we +/- have to suspend USB busses (and possibly disconnect some
> devices) at freeze time...

It may not be as bad as I made it sound...  The time required is probably 
on the order of 20 - 30 ms per bus for freeze/suspend + resume.

> Note that this will become a non-issue when instead of waking everybody
> up, we just wake the devices on the disk path, we can do the real
> suspend initially for the others.
> 
> For now, it might be interesting to not shut down the OHCI (not sure
> about E/UHCI's tho) as just letting it touch the HCCA isn't an issue
> (only for the freeze before snapshot tho, not when getting rid of the
> loader kernel, but in this case, what we do is more like kexec and we
> might prefer using shutdown callbacks to that effect).

If I understand correctly EHCI is no problem at all, since the I/O queues 
can be turned off independently from the controller itself.

But there might be a different problem.  If a USB driver is not modular,
then what happens when the swsusp boot kernel loads the memory image?  It
FREEZEs all the devices first, right?  So that the image kernel gets
control back with the devices in a known good state.  If you allowed a
device to continue doing DMA during this FREEZE (even if it's just OUT
transfers, not writing to memory), it could end up reading arbitrary
invalid data which would cause a device error.

This problem would be eliminated if the boot kernel's driver was aware
that a resume-from-disk was in progress.  I've heard that suspend2 can
offer such a feature; can it be added to swsusp?  Using a special flags 
value for the FREEZE would be sufficient.

Alan Stern


--===============13138553476527326==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============13138553476527326==--
