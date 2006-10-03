From: <rasmit.ranjan@wipro.com>
Subject: Re: Suspend to disk with PCMCIA card plugged in with
	kernel 2.6.16.28
Date: Tue, 3 Oct 2006 11:20:05 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB202902D60@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@ucw.cz
Cc: deepti.chotai@wipro.com, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

 =


> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz] =

> Sent: Sunday, October 01, 2006 10:35 PM
> To: Rasmit Ranjan (WT01 - Semiconductors & Consumer Electronics)
> Cc: linux-pm@lists.osdl.org; Deepti Chotai (WT01 - =

> Semiconductors & Consumer Electronics)
> Subject: Re: [linux-pm] Suspend to disk with PCMCIA card =

> plugged in with kernel 2.6.16.28
> =

> Hi!
> =

> > 	I have a PCMCIA card hosting a USB port. I am facing =

> some problems =

> > while trying to suspend my laptop to disk . Given below are =

> some of my =

> > observations:
> > =

> > 1. With kernel 2.6.15.4, my system does not get suspended =

> to disk with =

> > the PCMCIA card plugged in. I went through the mailing list =

> and found =

> > a mail thread desribing the same.
> > =

> http://lists.infradead.org/pipermail/linux-pcmcia/2006-January/003123.
> > ht
> > ml
> > =

> > This seems to be the breakage in resume path and not fixed =

> in 2.6.15.4.
> > So the final thing is, I have to remove my PCMCIA card =

> before trying =

> > to suspend my system to disk.
> > =

> > 2. With the kernel 2.6.16.28, the above breakage seems to =

> be fixed. So =

> > I tried suspending my system to disk with my PCMCIA card plugged in =

> > but without any device connected to the USB port of the =

> PCMCIA card. =

> > This works fine. My system responds fine, suspends to disk properly =

> > and resumes back as well.
> > =

> > 3. Now I try a step ahead and tried suspending the system =

> to disk with =

> > the PCMCIA card plugged in as well as a USB speaker/webcam =

> connected =

> > to the USB port of PCMCIA card. This also works fine. My system is =

> > suspended and resumed properly.
> > =

> > 4. Now again going a step ahead. I plugged in my PCMCIA =

> card, then I =

> > connected a USB speaker to the USB port of the card and started =

> > playing a song. Now I suspended the system to disk while =

> the transfer =

> > was in progress( song was being played). But this time my system =

> > hangs. This happens with other isochronous devices like webcam and =

> > bulk device like USB key as well. So suspend to disk fails =

> if any USB =

> > transfer is in progress ( through the USB port of my PCMCIA card).
> > =

> > I tried debugging the problem and used kdb to find out the =

> reason. For =

> > all the devices I found out the following thing :
> > =

> > The system hangs in following path: usb_disconnect --> =

> > usb_disable_device --> put_device.
> > After put_device the system hangs. As I was in kdb mode I could not =

> > save the stack trace.
> > =

> > Is it a known kernel problem with 2.6.16.28 ? Please suggest.
> =

> Reproduce it with 2.6.18, then it is bugzilla time, or post =

> to linux-usb mailing list.

Thanks Pavel. I tried with kernel 2.6.18. It worked fine with bulk
device ( USB key). But does not work with isochronous device and system
hangs. This time I did not have kdb so could not figure out where did it
hang.
Is it that for 2.6.16.28, this path is still broken for some cases like
suspend to disk when transfer is in progress??
> 								Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) =

> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> =
