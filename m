From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Enable HWP by default
Date: Sat, 27 Feb 2016 01:02:55 +0100
Message-ID: <4148434.QIxDcbDEAv@vostro.rjw.lan>
References: <1456441759-4877-1-git-send-email-srinivas.pandruvada@linux.intel.com> <7409824.yRBnCff0bU@vostro.rjw.lan> <1456443231.17628.24.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54956 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755517AbcB0ABU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 19:01:20 -0500
In-Reply-To: <1456443231.17628.24.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org

On Thursday, February 25, 2016 03:33:51 PM Srinivas Pandruvada wrote:
> On Fri, 2016-02-26 at 00:19 +0100, Rafael J. Wysocki wrote:
> > On Thursday, February 25, 2016 03:09:19 PM Srinivas Pandruvada wrote:
> > > If the processor supports HWP, enable it by default without
> > > checking
> > > for the cpu model. This will allow to enable HWP in all supported
> > > processors without driver change.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > > .com>
> > 
> > Isn't that a bit risky in the face of recent experience?
> Good question. The current systems which are commercial, already have
> cpuid added in our list, so HWP will be enabled anyway.
> The one system we know there is an issue, hope we can debug before
> merge window start.
> If I don't do, I have to add few more ids to the list.
> 
> Let's wait for few more weeks to review and merge this. I will let
> anybody from the community comment, who are using Skylake.

I've queued up the patch for 4.6 to expose it a bit more.

It may stay in linux-next for now and I can always drop it if need be.

Thanks,
Rafael

