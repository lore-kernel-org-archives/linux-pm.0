From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: intel-pstate driver not clocking down on Atom Z8750
Date: Mon, 26 Jun 2017 23:22:05 +0200
Message-ID: <1546394.yeB72YUSV0@aspire.rjw.lan>
References: <13898444.q12oX9ZNe5@aspire.rjw.lan> <CAAYJcCXPUE78PBN_njrnHseBUOPXsek48ac4RGh5Jx_mgvYpKg@mail.gmail.com> <1498436879.4671.22.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53034 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751381AbdFZV3a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2017 17:29:30 -0400
In-Reply-To: <1498436879.4671.22.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Christopher Williamson <home@chrisaw.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

On Sunday, June 25, 2017 05:27:59 PM Srinivas Pandruvada wrote:
> On Sun, 2017-06-25 at 18:37 -0400, Christopher Williamson wrote:
> > 4.8 and 4.12-rc6
> > 
> I just gave a quick test on a HP Cherrytrail laptop with 4.12 tip.
> Attached is the output, which show that this does scale.
> It is possible that you don't have any idle (C-states) or some task is
> keeping system busy.
> 
> I suggest:
> 1. Run turbostat and attach output.
> 2. Attach output of tools/power/x86/intel_pstate_tracer for a minute
> run.

The output of acpidump may be useful as well.

I'd suggest filing a bug at bugzilla.kernel.org against intel_pstate and
attaching all of the requested information there.

You don't have to provide a full problem description again, a link to the
initial message in this thread should suffice.

Thanks,
Rafael
