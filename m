From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 31 Aug 2006 00:50:57 +0200
Message-ID: <20060830225057.GG3923@elf.ucw.cz>
References: <1ac6c8e2a817eb0e11257b47199872f8@comcast.net>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01A95132@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A95132@de01exm64.ds.mot.com>
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

> > You bring up a more interesting area to look at integrating =

> > sleep states and operating points.  Can we add some hooks =

> > that allow us to define which operating point is selected at =

> > resume?  Need to think about that a bit:)
> ---
> =

> It's an interesting question, and one we (Motorola) don't have hard
> data to support, yet. Our current implementation remembers the OP
> in use before sleeping and resumes at the same OP. The argument is
> that this corresponds to an application that is doing work at a =

> steady-state level (say decoding video), but that has a brief pause
> to wait for I/O or a timer (say, pausing until the next frame time);
> then it makes sense that the level of effort required on resume will
> be the same as before sleeping.

We may have confusion here.

On PC, it is definitely not possible to enter sleep state between
frames of video... because video is powered off.

On PC, sleep states are *system* sleep states. CPU sleep states exist,
too, but that's in-kernel implementation detail. They are called
C1..C4.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
