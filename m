From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Funky "Blue screen" issue while rebooting from X
	with 2.6.18-git21
Date: Sun, 8 Oct 2006 23:51:10 +0200
Message-ID: <20061008215110.GF4152@elf.ucw.cz>
References: <9a8748490610041316w3ad442a6rf8f5fc5189fd72ac@mail.gmail.com>
	<20061008174759.GF6755@stusta.de> <20061008183406.GA4496@ucw.cz>
	<9a8748490610081446y6103a9b1o491ce87250beabfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <9a8748490610081446y6103a9b1o491ce87250beabfb@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-pm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

Hi!

> >> > I have a strange "problem" with 2.6.18-git21 that I've never had with
> >> > any previous kernel. If I open up an xterm in X, su to root and
> >> > 'reboot' (or 'shutdown -r now') I instantly get a blue screen that
> >> > persists until the box actually reboots.
> >>
> >> Pavel, is this a known issue or should Jesper bisect?
> >
> >Jesper should show it is kernel problem and not userland race.
> >
> =

> Jesper will try to do that ;-)
> =

> =

> >If userspace does kill -15 -1; kill -9 -1, and X fails to shut down in
> >time, it is userland problem ('should wait for X to shut down').
> >
> =

> Well, I just checked my initscript that is run when going into
> runlevels 0 & 6, and it does this :
> =

> (...)
> =

> # Kill all processes.
> # INIT is supposed to handle this entirely now, but this didn't always
> # work correctly without this second pass at killing off the processes.
> # Since INIT already notified the user that processes were being killed,
> # we'll avoid echoing this info this time around.
> if [ ! "$1" =3D "fast" ]; then # shutdown did not already kill all proces=
ses
>  /sbin/killall5 -15
>  /bin/sleep 5
>  /sbin/killall5 -9
> fi

...so, if X takes more than five seconds to shut down, you kill it
with -9, resulting in blue screen. Too bad, and not an kernel problem.

Try inserting something like

	while ps -aux | grep myXserver;
		sleep 1;
	done

alternatively, remove/shorten the sleep and you should experience blue
screen in 2.6.17.

> kernels, but since somewhere in the 2.6.18-rc series I've experienced
> this "blue screen" problem once in a while and I've also had a problem
> with the screen going all white when switching from X to a plain tty
> and back (once it goes white it stays that way permanently until I
> reboot) - I *never* see those issues when running 2.6.17.x and
> earlier.

Maybe something got slower in 2.6.18?
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
