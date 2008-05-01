From: Pavel Machek <pavel@ucw.cz>
Subject: Re: console (ttyX) forgot the font after hibernation
Date: Thu, 1 May 2008 18:15:24 +0200
Message-ID: <20080501161524.GB26089@elf.ucw.cz>
References: <200805011742.23548.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200805011742.23548.toralf.foerster@gmx.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu 2008-05-01 17:42:23, Toralf F=F6rster wrote:
> Hello,
> =

> under my (stable) Gentoo I use the consolefont lat9w-10 instead of the de=
fault
> (and much larger) font. If I hibernate my ThinkPad T41 and wake it up aga=
in,
> the console uses the default font instead :-(
> =

> This doesn't happen with suspend to ram, only if I hibernate the system:
> =

> tfoerste@n22 ~/devel/linux-2.6 $ uname -a
> Linux n22 2.6.24-gentoo-r4 #4 Sun Apr 20 12:16:18 CEST 2008 i686 Intel(R)=
 Pentium(R) M processor 1700MHz GenuineIntel GNU/Linux
> =

> I tested this with 2.6.25 and older kernels, always I goi the described b=
ehaviour.

It always worked like this, and I'm not sure it is worth fixing. You
can use framebuffer console to "fix" this.. or perhaps we could add
save/restore of font data, but I'm unlikely to code that patch.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
