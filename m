From: "Jordan Crouse" <jordan.crouse-5C7GfCeVMHo@public.gmane.org>
Subject: Re: comments on irc log
Date: Mon, 21 Mar 2005 13:06:12 -0700
Message-ID: <20050321130612.135d726e@cosmic.amd.com>
References: <1111113131.25179.73.camel@gaston>
	<20050318181317.GD18427@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============87061931891652256=="
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
To: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============87061931891652256==
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 18 Mar 2005 19:13:17 +0100
"Pavel Machek" <pavel-+ZI9xUNit7I@public.gmane.org> wrote:

> > 21:52:11< pavelm> I was playing with variable scheduling ticks here,
> > hoping to save some power. 21:52:31< pavelm> How big power savings
> > should I expect? 21:52:48< pavelm> What cpu will benefit most?
> > 21:53:04< pavelm> Is there easy way to measure it?
> > 
> > I played with that too on some PPCs and was surprised by the absence
> > of benefit, but I might have done something wrong, I need to
> > instrument the stuff better.
> 
> Difference between HZ=100 and HZ=1000 was measuerd to be approx. as
> big as disk spinnned up vs. spinned down (i.e. watt or so) by
> seife.... Not *that* unimportant. But it took month or so to get that
> data, because he was basically measuring runtime from full to empty
> battery.

Have any of these patches been published?  I've been playing with
variable ticks too, and I would like to see what other people have been
doing (as so far, the only thing I've managed to do is commit crimes
against nature and the idle loop).

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>





--===============87061931891652256==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============87061931891652256==--
