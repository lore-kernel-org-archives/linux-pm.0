From: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Devices eating too much power [was Re: Some
	thoughts on suspend/resume development]
Date: Sun, 13 Mar 2005 16:55:11 -0500
Message-ID: <1110750912.25040.12.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0503091111470.1117-100000@ida.rowland.org>
	<1110403931.8870.6.camel@desktop.cunningham.myip.net.au>
	<20050309214416.GG17034@elf.ucw.cz>
	<1110405336.8870.22.camel@desktop.cunningham.myip.net.au>
	<20050313181455.GD1579@elf.ucw.cz>
	<1110742612.12485.287.camel@localhost.localdomain>
	<20050313210322.GA7016@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============55070993161443305=="
In-Reply-To: <20050313210322.GA7016-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============55070993161443305==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-03-13 at 22:03 +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > What devices is this targetted at? Video should be handled
> > > > > already (or perhaps we want to power down graphics card when screen is
> > > > > blanked?). Disks spin down too. IRDA ports?
> > > > 
> > > > - Video
> > > 
> > > X/dpms handles these already.
> > 
> > Many GPUs will have frequency scaling like processors (e.g. ATI
> > Powerplay).  I don't think we currently support this.
> 
> Ugh, I did not know about this stuff. Ok.. Anyway that's X problem,
> right?

Well it is now :), but many components of these X drivers should be in
the kernel.  (e.g. X does its own pci probing)

> 
> > Also we don't really control display brightness.
> 
> But display brightness does not really belong here, right?

No, in some cases it's controlled by a separate ACPI device.

> 
> > > > Anything you might care to imagine :>
> > > 
> > > Well, I meant something that is not already handled. Like... what
> > > power-hungry device do we fail to properly handle today?
> > 
> > Wireless cards could be turned off when plugged into a physical media.
> > Many other devices remain on when not used (e.g. serial ports).
> > Probably most of them don't take up much power, but it would be nice to
> > do some experimentation and see.
> 
> I do not think wireless can be turned off when physical media is
> present... but it makes sense to be user option... called ifconfig
> wlan0 down. Driver should really power it down on ifconfig down.

Fair enough.  In the typical laptop, it may be a good idea though.

> 
> Serial ports should not eat energy when not opened; fix it in the
> driver.
> 
> What other devices do eat energy?

Sound cards

bridges (PCI, PCMCIA, USB, etc.)

> > I think this question really depends on architecture and hardware.
> > Also, I think we'll see more power management options available to us in
> > the near future.
> 
> Designing for hardware not yet available is usually bad idea.

Well, not always.  For example there are PCI express specs available, so
even though not every device uses the new power management capabilities
now, we know what to expect and exactly how it will work.

Another example... ACPI spec 3.0 defines a mechanism to throttle the
performance of devices other than processors.

Adam



--===============55070993161443305==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============55070993161443305==--
