From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: adjust _PSS[0] freqeuency
Date: Thu, 16 Jun 2016 03:23:41 +0200
Message-ID: <1688029.LNMYJLLlPf@vostro.rjw.lan>
References: <1465971179-7832-1-git-send-email-srinivas.pandruvada@linux.intel.com> <2223313.a2PmTKX7X3@vostro.rjw.lan> <1465981336.4343.3.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42996 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753209AbcFPBTb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 21:19:31 -0400
In-Reply-To: <1465981336.4343.3.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Wednesday, June 15, 2016 02:02:16 AM Srinivas Pandruvada wrote:
> On Wed, 2016-06-15 at 01:23 +0200, Rafael J. Wysocki wrote:
> > On Tuesday, June 14, 2016 11:12:59 PM Srinivas Pandruvada wrote:
> > > Intel P State uses max P-State as the max turbo P-State. This max
> > > P-State
> > > can be limited by ACPI _PSS table entry 0. After
> > > 'commit 9522a2ff9cde ("cpufreq: intel_pstate: Enforce _PPC
> > > limits")''
> > > the _PSS table entry[0] will be used to cap max performance for
> > > enterprise and performance server by default.
> > > 
> > > Even though this is correct processing, but when the performance
> > > results
> > > are compared with the version before the above commit, then
> > > obviously the
> > > results will be worse, if the _PSS table entry 0 is not the max
> > > turbo
> > > P-State.
> > > 
> > > This change will change the _PSS table entry 0 to the max turbo
> > > frequency
> > > if turbo is enabled in the BIOS. In this way, the performance will
> > > be
> > > comparable to the version without _PSS/_PPC support.
> > > 
> > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > > .com>
> > > ---
> > >  drivers/cpufreq/intel_pstate.c | 22 ++--------------------
> > >  1 file changed, 2 insertions(+), 20 deletions(-)
> > 
> > Nice. :-)
> > 
> > I guess I should add a Fixes tag pointing to commit 9522a2ff9cde to
> > this?
> Yes we can.

OK, applied with a rewritten changelog.

Thanks,
Rafael

