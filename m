From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Wed, 30 Aug 2006 20:22:56 -0400
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A9555F@de01exm64.ds.mot.com>
References: <20060830225057.GG3923@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <20060830225057.GG3923@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Locke <matthew.a.locke@comcast.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

 =

> From: Pavel Machek [mailto:pavel@ucw.cz] =

> > It's an interesting question, and one we (Motorola) don't have hard =

> > data to support, yet. Our current implementation remembers =

> the OP in =

> > use before sleeping and resumes at the same OP. The =

> argument is that =

> > this corresponds to an application that is doing work at a =

> > steady-state level (say decoding video), but that has a =

> brief pause to =

> > wait for I/O or a timer (say, pausing until the next frame =

> time); then =

> > it makes sense that the level of effort required on resume =

> will be the =

> > same as before sleeping.
> =

> We may have confusion here.
> =

> On PC, it is definitely not possible to enter sleep state =

> between frames of video... because video is powered off.
> =

> On PC, sleep states are *system* sleep states. CPU sleep =

> states exist, too, but that's in-kernel implementation =

> detail. They are called C1..C4.
---

Well, we have some hardware where we can sleep everything but =

memory and some where we can also leave the display active (and =

backlit). In fact, however, today the latency for going to sleep =

is too great to do so between frames, so we just do a wait there. =

We would LIKE to be able to sleep there at some point in the =

future and would prefer a power model that made that cleanly =

part of a continuum of operating points.

However, we definitely DO sleep (with self-refreshing RAM) during =

relatively short periods, with the wakeup resulting from an =

interrupt from the RTC (which is self-powered and is set =

to timeout at the next scheduled timer when we go to sleep) =

or another hardware interrupt. We think of this as a system-level =

sleep state.

I'm not sure how you distinguish between a "system" sleep state =

and a "CPU" sleep state - seems like there's a collection of =

things that can be shut down or not; except for true OFF, there's
always something on.

Scott
