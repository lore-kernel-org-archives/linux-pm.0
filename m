From: Pavel Machek <pavel@ucw.cz>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Sun, 24 Sep 2006 01:39:28 +0200
Message-ID: <20060923233928.GG21187@elf.ucw.cz>
References: <20060919182011.GC7099@elf.ucw.cz>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01BB2D20@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DD01BB2D20@de01exm64.ds.mot.com>
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
Cc: Matthew Locke <matthew.a.locke@comcast.net>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > ... because Sharp & notebook manufacturers =

> > > > actually play fair.
> > > ---
> > > =

> > > Depends, of course, on your definition of "fair". The CE =

> > manufacturers =

> > > are investing a lot of work in Linux, either directly or through =

> > > hiring developers and working through distributors. And =

> > they're giving =

> > > their enhancements back to the community, which is what was =

> > generally =

> > > considered "fair" for open-source development. The power management
> > =

> > Well, CE equipment usually uses obsolete, heavily modified =

> > kernels, and developed in-house (as opposed by community). =

> > Yes, it is nice that Motorola uses Linux and not WindowsCE...
> ---
> =

> There are perfectly sensible business reasons why device manufacturers
> need to freeze their development on old kernels (and other components)
> for long periods of time. Are you saying this is "unfair" to the
> developers? I understand that it makes the patches less useful, in
> many cases, but unfair?

No, I call "you may not use your own kernel on your own hardware",
even if manufacturer of that hardware is using your code and code is
GPLed "unfair". Being locked onto old kernel is unfortunate, but fair.

> I do hope that Motorola, and other CE manufacturers, will start working
> more closely with the community.  The CE Linux Forum was set up in

Yep, I hope so, too.

> > ... =

> > > I expect modifiable kernels in the future, but that =

> > requires a lot of =

> > > extra engineering (beyond just making the device
> > > work) to harden the non-open elements so that malicious =

> > kernel changes =

> > > couldn't compromise them. None of the
> > =

> > What is the issue here? I thought that GSM stack runs on =

> > separate CPU, anyway? And in practice, it is probably =

> > possible to flash your equipment... Like small shops offering =

> > "unlocking" do it all the time.
> =

> The issue is "due diligence" - a manufacturer could be held liable
> for damage done by a modified device if they have not made a good
> faith effort to make such modification either (a) safe or
> (b) very difficult. Yes, this is non-value-add work, but there are
> people in the world who do malicious things, and manufacturers are
> very worried about courts finding that they were negligent in
> not making a greater effort to stop such malicious people.

Well, I believe Motorola is going a bit further than "due
diligence". Making directories inaccessible on running system (not
even read only!) was probably not mandatory, right? And even M$
smartphones support end-user updating of firmware.

> There are also, of course, contractual issues with carriers and
> content owners, who could also sue if a manufacturer didn't make a
> sufficient effort to protect the terms of the contract. The
> carriers and content owners are continually raising the bar on the
> level of protection they require.

Yep, I see it sucks being phone manufacturer. But you have separate
CPU doing GSM stack in current cellphones, right? I believe you even
use AT commands for communication... That should be about as hard as
pcmcia card to "harden", and yes, people are routinelly selling pcmcia
GSM cards.

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
