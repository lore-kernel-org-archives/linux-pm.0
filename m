From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 1/1] intel_pstate: Increase hold-off time before samples
 are scaled v2
Date: Wed, 24 Feb 2016 09:03:01 +0000
Message-ID: <20160224090301.GQ2854@techsingularity.net>
References: <1456237784-17205-1-git-send-email-mgorman@techsingularity.net>
 <1456264234.8680.155.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456264234.8680.155.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, Stephane Gasparini <stephane.gasparini@linux.intel.com>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Matt Fleming <matt@codeblueprint.co.uk>, Mike Galbraith <umgwanakikbuti@gmail.com>, Linux-PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 23, 2016 at 01:50:34PM -0800, Srinivas Pandruvada wrote:
> On Tue, 2016-02-23 at 14:29 +0000, Mel Gorman wrote:
> > Added a suggested change from Doug Smythies and can add a Signed-of=
f-
> > by
> > if Doug is ok with that.
> >=20
> > Changelog since v1
> > o Remove divide that is likely unnecessary			(ds
> > mythies)
> > o Rebase on top of linux-pm/linux-next
> >=20
> > The PID relies on samples of equal time but this does not apply for
> > deferrable timers when the CPU is idle. intel_pstate checks if the
> > actual
> > duration between samples is large and if so, the "busyness" of the
> > CPU
> > is scaled.
> >=20
> > This assumes the delay was a deferred timer but a workload may simp=
ly
> > have
> > been idle for a short time if it's context switching between a serv=
er
> > and
> > client or waiting very briefly on IO. It's compounded by the proble=
m
> > that
> > server/clients migrate between CPUs due to wake-affine trying to
> > maximise
> > hot cache usage. In such cases, the cores are not considered busy a=
nd
> > the
> > frequency is dropped prematurely.
> >=20
> > This patch increases the hold-off value before the busyness is
> > scaled. It
> > was selected based simply on testing until the desired result was
> > found.
> > Tests were conducted with workloads that are either client/server
> > based
> > or short-lived IO.
>=20
> Attached specpower comparison for Haswell EP Grantley server.=A0
>=20

So this looks like a bust in terms of specpower. It is incredibly
unfortunate though. There are basic workloads that are simply performin=
g
way below what the CPU is capable of unless the user is either willing
to tune power management or pin tasks to CPUs and hope for the best.
Ideally we want to reduce those forum postings that suggest disabling
intel_pstate entirely or setting performance.

Given that I'm very weak in the intel_pstate driver in general and was
relying on bisection to find problem commits, are there any others with
"have your cake and eat it twice" options? Ideally it would restore
performance to simple client/server workloads and ones that idle briefl=
y
on IO without getting red flagged by specpower.

--=20
Mel Gorman
SUSE Labs
