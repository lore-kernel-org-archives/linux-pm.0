From: David Brownell <david-b@pacbell.net>
Subject: Re: nokia 770 [was Re: community PM requirements...]
Date: Wed, 13 Dec 2006 14:55:59 -0800
Message-ID: <20061213225559.E80BF1E56CF@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20060914101704.GA17820@elf.ucw.cz>
	<457FEE17.8080806@gmail.com> <20061213210359.GC11843@elf.ucw.cz>
	<200612131332.58606.david-b@pacbell.net>
	<BBB6202A-4F06-4D2D-BD8E-DD34267D85E9@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <BBB6202A-4F06-4D2D-BD8E-DD34267D85E9@comcast.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: matthew.a.locke@comcast.net
Cc: linux-pm@lists.osdl.org, amit.kucheria@nokia.com, scott.preece@motorola.com, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

> >>>> Could you perhaps provide list of operating points for 770? It  =

> >>>> would help understanding a bit, I'd say.
> >>>
> >>> If there was a followup here, I missed it ...
> >>>
> >>> ISTR that it doesn't use (formal) operating points, and that ...
> >>
> >>  http://dynamicpower.sourceforge.net/dpm-omap.html
> >
> > That's the old DPM stuff not any of the newer proposals right?
>
> Example operating points were requested.  Using the operating points  =

> from DPM is fine for examples.

I read the query to be specifically about operating points
used in that product ... as giving better insight into the
real PM requirements for Linux-based products.

Examples of how one solution _could_ be used address another
purpose than highlighting requirements.


> > ... that's in addition to the reduced power idle, which didn't
> > seem to fit into the DPM framework in any obvious way.
>
> Actually, automatically reducing power at idle is what DPM is all  =

> about.  In DPM an operating point is mapped to the idle state so when  =

> the idle task is entered an operating point change is triggered.  The  =

> system can choose the best point for the idle task based on latency  =

> requirements, length of idle when using dynamic ticks, etc.

Hmm, that's something that somehow never came out in previous
discussions.  At least, not to me.  It's possible that the point
did come out, but got buried in all the noise.

So it would appear that an operating point (in DPM, anyway) is
a combination of clock, voltage, and probably other settings,
coupled with an implementation of the idle task and a policy
implemented by idle task ... yes?

Given that the clock API manages clock settings, and cpufreq
(for better or worse) handles CPU-specific clock and voltage,
you can still color me confused about how an "operating point"
would be a programming construct rather than a side effect of
those other APIs on an implementation.  (If anyone wants to
enlighten me, that should go into a new thread!)

- Dave
