From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 00:29:15 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0703230026500.11411@poirot.grange>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221444.00905.david-b@pacbell.net>
	<200703222310.39623.rjw@sisk.pl>
	<200703221556.08948.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703221556.08948.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, ben@simtec.co.uk
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Mar 2007, David Brownell wrote:

> On Thursday 22 March 2007 3:10 pm, Rafael J. Wysocki wrote:
> =

> > Well, I think the only clear distinction between the STR and "standby" =
is the
> > necessity to go through a boot-like procedure in order to resume from t=
he
> > former.
> =

> So what's a "boot-like procedure"?   Ten instructions?  A hundred?
> A thousand?  Ten thousand?  Does it take a certain amount of time?
> Does it perform certain operations?  Does it involve going through
> ACPI (or APM)?  If so, what about the fact that ACPI (or APM) are
> involved in "standby" resumes too (on platforms using them)?

Ok, on ARM / (at least embedded) ppc I would say - going through reset =

vector / toggling reset pin. Do these terms still make sense on =

hyper-threaded-cored-celled CPUs?

Thanks
---
Guennadi Liakhovetski
