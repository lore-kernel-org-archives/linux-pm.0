From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 10:10:58 -0700
Message-ID: <200703221010.59040.david-b@pacbell.net>
References: <20070320015846.636692000@sipsolutions.net>
	<200703211625.23253.david-b@pacbell.net>
	<1174557785.3944.74.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174557785.3944.74.camel@johannes.berg>
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

On Thursday 22 March 2007 3:03 am, Johannes Berg wrote:

> > And remember that the implementor must make various decisions in
> > any case, since the SOC probably has half a dozen distinct
> > low power states, but Linux can only name two of them.
> =

> Actually, now that we have everybody using .valid

Seems kind of temporary, so long as pm_set_ops() doesn't
enforce that as a requirement ...


> we can add an =

> arbitrary amount of them if we wish :>

For as many as can be #defined, yes.  But such #defines will
be rare; adding a new one would mean updating pm_states[]
plus maybe other code, and there are other structural issues
with that notion ... especially the way suspend() methods
have no way to determine the semantics of the target state.

- Dave
