From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 16:44:21 -0700
Message-ID: <200703221644.22760.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221556.08948.david-b@pacbell.net>
	<Pine.LNX.4.60.0703230026500.11411@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0703230026500.11411@poirot.grange>
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
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, ben@simtec.co.uk
List-Id: linux-pm@vger.kernel.org

On Thursday 22 March 2007 4:29 pm, Guennadi Liakhovetski wrote:
> On Thu, 22 Mar 2007, David Brownell wrote:
> =

> > On Thursday 22 March 2007 3:10 pm, Rafael J. Wysocki wrote:
> > =

> > > Well, I think the only clear distinction between the STR and "standby=
" is the
> > > necessity to go through a boot-like procedure in order to resume from=
 the
> > > former.
> > =

> > So what's a "boot-like procedure"?   Ten instructions?  A hundred?
> > A thousand?  Ten thousand?  Does it take a certain amount of time?
> > Does it perform certain operations?  Does it involve going through
> > ACPI (or APM)?  If so, what about the fact that ACPI (or APM) are
> > involved in "standby" resumes too (on platforms using them)?
> =

> Ok, on ARM / (at least embedded) ppc I would say - going through reset =

> vector / toggling reset pin.

However, I would also say that it makes plenty of sense to talk about
an STR state that doesn't involve such a reset.


> Do these terms still make sense on  hyper-threaded-cored-celled CPUs?

"Reset", sure ... though there are lots of types of reset.
And "boot-like procedure" is inherently vague though.

- Dave
