From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: comments on irc log
Date: Fri, 18 Mar 2005 19:13:17 +0100
Message-ID: <20050318181317.GD18427@elf.ucw.cz>
References: <1111113131.25179.73.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70733223336163475=="
In-Reply-To: <1111113131.25179.73.camel@gaston>
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

--===============70733223336163475==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> I've browsed the IRC log and have a few notes/comments/replies:
> 
> 21:38:01< pavelm> At one point someone at intel was looking onto s-t-ram on smp machine...
> 21:38:13< pavelm> ...is he/she still working on that?
> 21:38:51< pavelm> Airplane-like machine was toshiba laptop; I did nnot open it.
> 21:39:24< pavelm> DC=dual core... aha, I parsed it wrong.
> 
> Pavel: Paulus has that working on an SMP PowerMac. The simplest/safest way to do that
> is to implement some kind of hotplug CPU (even if the CPU isn't physically turned off,
> just "park" it in some kind of sleep loop or so), and only trigger the system-wide STR
> after you have stopped all CPUs but one. He left usrland the
> responsibility to do that.

I do not want to leave that to userland, because we need it during
swsusp resume, too, and userland is not available at that
point. Otherwise I agree (and have some code from Li that implements
it that way).

> 21:43:34< nigel> Luming: I was meaning one where the chip itself gets completely powered down and needs a complete reconfigure on wake.
> 21:43:39< pavelm> ;-< well, when BIOS at least posts the card, things are easy.
> 
> Note that I have some code for POST'ing some radeon's that might be adapt-able. The only
> "issue" is I don't know how to extract from the x86 BIOS ROM the proper sequence of values
> for the SDRAM mode register (SDRAM chip init). This is write-only obviously so I can't just
> read the values before sleep and POST the chip with those like I do for the rest of the
> chip. I know values for Mac laptops, not x86.

So it is basically "need very simple piece of documentation from
notebook vendor" and some vendors are already wiling to share that
info? Good.

> 21:52:11< pavelm> I was playing with variable scheduling ticks here, hoping to save some power.
> 21:52:31< pavelm> How big power savings should I expect?
> 21:52:48< pavelm> What cpu will benefit most?
> 21:53:04< pavelm> Is there easy way to measure it?
> 
> I played with that too on some PPCs and was surprised by the absence of benefit, but I might
> have done something wrong, I need to instrument the stuff better.

Difference between HZ=100 and HZ=1000 was measuerd to be approx. as
big as disk spinnned up vs. spinned down (i.e. watt or so) by
seife.... Not *that* unimportant. But it took month or so to get that
data, because he was basically measuring runtime from full to empty
battery.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============70733223336163475==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============70733223336163475==--
