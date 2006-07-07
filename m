From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problem with suspend to RAM
Date: Fri, 7 Jul 2006 11:04:30 +0200
Message-ID: <20060707090429.GA24099@elf.ucw.cz>
References: <380D9721A8E2114485644D71E87C6AB2022138F8@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <380D9721A8E2114485644D71E87C6AB2022138F8@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rasmit.ranjan@wipro.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

>        I have some problem with suspend t RAM. I tried suspend to RAM
>    with different laptops. I am using kernel 2.6.15.4.
> =

>    The problem is sometimes it works and sometimes it does not. Sometimes
>    only the system suspends to RAM but does not resume. I read somewhere
>    that suspend to RAM behaves in this way. It is not stable in the
>    kernel. Is it so or is there something specific to do to make suspend
>    to RAM work? Please suggest.

It is stable, but there are problems with video handling. see
suspend.sf.net. Any problem outside video handling should go to kernel
bugzilla.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
