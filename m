From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: comments on irc log
Date: Sat, 19 Mar 2005 10:15:24 +1100
Message-ID: <1111187725.1236.195.camel@gaston>
References: <1111113131.25179.73.camel@gaston>
	<20050318181317.GD18427@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============49570416757067637=="
In-Reply-To: <20050318181317.GD18427-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============49570416757067637==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-03-18 at 19:13 +0100, Pavel Machek wrote:

> 
> So it is basically "need very simple piece of documentation from
> notebook vendor" and some vendors are already wiling to share that
> info? Good.

Yes. At this point, I can wake up rv350 and rv280 mobilities with some
limitations (maybe not all panels, I don't get the DVI output right
yet, ...). The "piece of doc" might even be obtained from ATI there
since it's possible that this infos is in a standard place in the BIOS
image (like other tables already there).

> > 21:52:11< pavelm> I was playing with variable scheduling ticks here, hoping to save some power.
> > 21:52:31< pavelm> How big power savings should I expect?
> > 21:52:48< pavelm> What cpu will benefit most?
> > 21:53:04< pavelm> Is there easy way to measure it?
> > 
> > I played with that too on some PPCs and was surprised by the absence of benefit, but I might
> > have done something wrong, I need to instrument the stuff better.
> 
> Difference between HZ=100 and HZ=1000 was measuerd to be approx. as
> big as disk spinnned up vs. spinned down (i.e. watt or so) by
> seife.... Not *that* unimportant. But it took month or so to get that
> data, because he was basically measuring runtime from full to empty

Yes, it was also on some ppc's which is why I'm wondering if I did
something wrong in my experiment :) It may also be different for
different CPU models.

Ben



--===============49570416757067637==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============49570416757067637==--
