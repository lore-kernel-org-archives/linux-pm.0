From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Devices eating too much power [was Re: Some thoughts
	on suspend/resume development]
Date: Mon, 14 Mar 2005 00:11:15 +0100
Message-ID: <20050313231115.GA26692@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0503091111470.1117-100000@ida.rowland.org>
	<1110403931.8870.6.camel@desktop.cunningham.myip.net.au>
	<20050309214416.GG17034@elf.ucw.cz>
	<1110405336.8870.22.camel@desktop.cunningham.myip.net.au>
	<20050313181455.GD1579@elf.ucw.cz>
	<1110742612.12485.287.camel@localhost.localdomain>
	<20050313210322.GA7016@elf.ucw.cz>
	<1110750912.25040.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============54011270512120602=="
In-Reply-To: <1110750912.25040.12.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============54011270512120602==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Ne 13-03-05 16:55:11, Adam Belay wrote:
> On Sun, 2005-03-13 at 22:03 +0100, Pavel Machek wrote:
> > > Also we don't really control display brightness.
> > 
> > But display brightness does not really belong here, right?
> 
> No, in some cases it's controlled by a separate ACPI device.

I meant "I do not think we want to control display brightness by
runtime suspend/resume". It may be a kernel job, but not for runtime
suspend/resume. Backlight is really individual setting as much as
power managment one. Even old monitors had brightness/contrast
buttons, even if it did not spare any energy.

> > Serial ports should not eat energy when not opened; fix it in the
> > driver.
> > 
> > What other devices do eat energy?
> 
> Sound cards

Yep, hw should power them down when not opened.

> bridges (PCI, PCMCIA, USB, etc.)

Agreed, bridges are interesting. Other stuff seems to be covered.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============54011270512120602==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============54011270512120602==--
