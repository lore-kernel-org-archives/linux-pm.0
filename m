From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 15:56:07 -0700
Message-ID: <200703221556.08948.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221444.00905.david-b@pacbell.net>
	<200703222310.39623.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703222310.39623.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Thursday 22 March 2007 3:10 pm, Rafael J. Wysocki wrote:

> Well, I think the only clear distinction between the STR and "standby" is=
 the
> necessity to go through a boot-like procedure in order to resume from the
> former.

So what's a "boot-like procedure"?   Ten instructions?  A hundred?
A thousand?  Ten thousand?  Does it take a certain amount of time?
Does it perform certain operations?  Does it involve going through
ACPI (or APM)?  If so, what about the fact that ACPI (or APM) are
involved in "standby" resumes too (on platforms using them)?

And why wouldn't a standby mode be able to do any or all of those?


> So, I'd tend to think the STR is when the CPU(s) is(are) powered =

> down and if some platforms don't support that, they just don't support the
> STR.

That seems like a counterproductive restriction.  The only reason to
adopt it is if you care so much about ACPI that you insist on using
their state definitions even on systems that will never use ACPI.

For a system that supports several power saving modes but doesn't
have the ability to turn the CPU off, what conceivable value would
there be in saying it's not OK to use the "STR" label for any of
those states?

And thus, to say that the system is only **allowed** to expose one
of those power saving modes to Linux ... and that it must always
be called "standby"?  Even if, from an external perspective, it
acts just like an STR would act?

My answer:  there is NO value to such an arbitrary restriction.


> Also, I'd like to define "standby" and STR as system-wide low power states
> which involve the freezing of processes before entering them.

That should go without saying, since "echo NAME > /sys/power/state"
does that regardless of NAME.

- Dave
