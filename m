From: Pavel Machek <pavel@suse.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 31 Aug 2006 14:04:54 +0200
Message-ID: <20060831120454.GS3923@elf.ucw.cz>
References: <20060830225057.GG3923@elf.ucw.cz>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01A9555F@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A9555F@de01exm64.ds.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Preece Scott-PREECE <scott.preece@motorola.com>
Cc: Matthew Locke <matthew.a.locke@comcast.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > We may have confusion here.
> > =

> > On PC, it is definitely not possible to enter sleep state =

> > between frames of video... because video is powered off.
> > =

> > On PC, sleep states are *system* sleep states. CPU sleep =

> > states exist, too, but that's in-kernel implementation =

> > detail. They are called C1..C4.
> ---
> =

> Well, we have some hardware where we can sleep everything but =

> memory and some where we can also leave the display active (and =

> backlit). In fact, however, today the latency for going to sleep =

> is too great to do so between frames, so we just do a wait there. =

> We would LIKE to be able to sleep there at some point in the =

> future and would prefer a power model that made that cleanly =

> part of a continuum of operating points.
> =

> However, we definitely DO sleep (with self-refreshing RAM) during =

> relatively short periods, with the wakeup resulting from an =

> interrupt from the RTC (which is self-powered and is set =

> to timeout at the next scheduled timer when we go to sleep) =

> or another hardware interrupt. We think of this as a system-level =

> sleep state.
> =

> I'm not sure how you distinguish between a "system" sleep state =

> and a "CPU" sleep state - seems like there's a collection of =

> things that can be shut down or not; except for true OFF, there's
> always something on.

Well, even in "true OFF", RTC keeps ticking. And in "disk" state
(swsusp), machine is basically "true OFF" but it still retains state.

								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
