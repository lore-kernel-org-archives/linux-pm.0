From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 4 Sep 2006 11:06:45 +0200
Message-ID: <20060904090626.GJ9991@elf.ucw.cz>
References: <200609032240.k83MeRhV014303@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200609032240.k83MeRhV014303@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Cc: scott.preece@motorola.com, matthew.a.locke@comcast.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sun 2006-09-03 17:40:27, Scott E. Preece wrote:
> =

> | From: Pavel Machek<pavel@ucw.cz>
> | =

> | On Sun 2006-09-03 17:12:22, Scott E. Preece wrote:
> | > | From: Pavel Machek<pavel@ucw.cz>

> | > Not speaking to either of the current code submissions, I would say t=
hat
> | > having a kernel interface for defining OPs and a kernel interface for
> | > setting the OP, was a reasonably clean interface.
> | =

> | Well, me and Rafael disagree, and you do not really listen to
> | arguments. Now you can either fix the interface, or try to submit code
> | to lkml despite our NAKs. Go ahead and prepare for some flaming...
> ---
> =

> I think I'm listening to arguments just as much as you guys are! We just
> disagree. What are your criteria for "a clean interface"? Why do you
> think that n separate set-parameter() interfaces, with no consistency
> relationship between them, are cleaner than one define-op() and one
> set-op() interface?

Because we already have cpufreq-set-parameter() interface and
enter-suspend-state() interface. We can't really get rid of them.

If you add set-op() replacing both cpufreq-set-parameter() and
enter-suspend-state(), we'll end up with two different interfaces for
each interface; that's considered "mess".
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
