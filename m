From: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Devices eating too much power [was Re: Some
	thoughts on suspend/resume development]
Date: Sun, 13 Mar 2005 14:36:51 -0500
Message-ID: <1110742612.12485.287.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0503091111470.1117-100000@ida.rowland.org>
	<1110403931.8870.6.camel@desktop.cunningham.myip.net.au>
	<20050309214416.GG17034@elf.ucw.cz>
	<1110405336.8870.22.camel@desktop.cunningham.myip.net.au>
	<20050313181455.GD1579@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============45856252637254769=="
In-Reply-To: <20050313181455.GD1579-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============45856252637254769==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-03-13 at 19:14 +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > This isn't to say that we should copy Windows.  However it does show that 
> > > > > a very complex set of controls might not be needed.
> > > 
> > > Actually, as we already spindown and blank settings, we could finish
> > > here :-).
> > > 
> > > What devices is this targetted at? Video should be handled
> > > already (or perhaps we want to power down graphics card when screen is
> > > blanked?). Disks spin down too. IRDA ports?
> > 
> > - Video
> 
> X/dpms handles these already.

Many GPUs will have frequency scaling like processors (e.g. ATI
Powerplay).  I don't think we currently support this.

Also we don't really control display brightness.

> > - Hotplug devices

It would be nice to lower the power state of usb and pcmcia controllers,
when these devices are also in a lower power state.

> 
> > Anything you might care to imagine :>
> 
> Well, I meant something that is not already handled. Like... what
> power-hungry device do we fail to properly handle today?

Wireless cards could be turned off when plugged into a physical media.
Many other devices remain on when not used (e.g. serial ports).
Probably most of them don't take up much power, but it would be nice to
do some experimentation and see.

I think this question really depends on architecture and hardware.
Also, I think we'll see more power management options available to us in
the near future.

Adam



--===============45856252637254769==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============45856252637254769==--
