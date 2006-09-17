From: Pavel Machek <pavel@ucw.cz>
Subject: Re: cpufreq user<->kernel interface removal [was Re:
	community PM requirements/issues and PowerOP]
Date: Sun, 17 Sep 2006 15:20:19 +0200
Message-ID: <20060917132019.GN2741@elf.ucw.cz>
References: <20060914162623.GA6867@linux.intel.com>
	<20060917123759.GD2741@elf.ucw.cz>
	<acd2a5930609170610l14fef014k54dc60159dcf8703@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <acd2a5930609170610l14fef014k54dc60159dcf8703@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: lkml@elf.ucw.cz.kroah.org, Preece Scott-PREECE <scott.preece@motorola.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2006-09-17 17:10:36, Vitaly Wool wrote:
> Pavel,
> =

> On 9/17/06, Pavel Machek <pavel@ucw.cz> wrote:
> >?? zaurus uses cpufreq just fine, and you could do that on omap. You'd
> >not have powersavings coming out of powering down devices, but
> >otherwise it should be doable.
> =

> I do think you'd better broaden your views here ;)
> cpufreq as it is is not well-suitable for complex power management
> cases where you need to switch between multiple oscillators/clock
> sources/PLLs etc to gain the most efficien power management.
> Zaurus is not that complicated in PM AFAIK and I'm sure it could be
> even better if it used PowerOP or similar solution. :)

Well, I do think you'd better broaden your views here ;)
Solutions you propose are not well-suitable for big systems, like 8
cpu server box with 40 PCI devices.

What we need to do is something that works well from whole range, from
770 through thinkpad x60 to 8x Xeon server.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
