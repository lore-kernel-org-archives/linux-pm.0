From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 11:13:04 -0700
Message-ID: <200703221113.05518.david-b@pacbell.net>
References: <20070320015846.636692000@sipsolutions.net>
	<200703221010.59040.david-b@pacbell.net>
	<1174583912.3588.25.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174583912.3588.25.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, Dirk Behme <dirk.behme@de.bosch.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Nicolas Pitre <nico@cam.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

On Thursday 22 March 2007 10:18 am, Johannes Berg wrote:
> On Thu, 2007-03-22 at 10:10 -0700, David Brownell wrote:
> =

> > especially the way suspend() methods
> > have no way to determine the semantics of the target state.
> =

> I can't parse that.

Look at docs for most any SOC processor and you'll see that
not only does it have a variety of lowpower states, but that
each of them has various rules about what works there and
what doesn't.

So long as driver suspend() methods have no some way to see
how far they "must" shut down for a given target sleep state,
there is only limited utility to defining such states.

That's because the state would only really apply to the cpu
specific code ... drivers must assume the worst case, precluding
the primary reasons to use those less-deep system states.

I just reposted my clk_must_disable() patches; I think it's time
to merge them.  They address that issue for one of the most
common type of rule for system sleep states ... at least, in
terms of interface.  Platform support will still be an issue,
but at least the issue won't be "crippled by bad design".

- Dave
