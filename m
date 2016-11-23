From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Set EPP/EPB to 0 in performance mode
Date: Wed, 23 Nov 2016 02:41:55 +0100
Message-ID: <3082292.lE3RZvZN3d@vostro.rjw.lan>
References: <1479858269-175501-1-git-send-email-srinivas.pandruvada@linux.intel.com> <CAJZ5v0h5Qx-_p2wfAqDjEt4jQ6h86mHCSfuRaewqumGgONGidQ@mail.gmail.com> <1479864022.20426.12.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46606 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752790AbcKWBnM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 20:43:12 -0500
In-Reply-To: <1479864022.20426.12.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Tuesday, November 22, 2016 05:20:22 PM Srinivas Pandruvada wrote:
> On Wed, 2016-11-23 at 01:53 +0100, Rafael J. Wysocki wrote:
> > On Wed, Nov 23, 2016 at 1:42 AM, Rafael J. Wysocki <rafael@kernel.org
> > > wrote:
> > > 
> > > 
> [...]
> 
> > > > invalid */
> > > > +                       if (cpu_data->epp_saved < 0)
> > > > +                               goto skip_epp;
> > > > +
> > This can be avoided too I suppose if epp_saved is initialized with
> > the
> > initial value of the EPP.
> This is not only for initialization, but transient MSR read failures
> later (which shouldn't happen, but for the completeness). So if you
> weren't able to read for some unknown reason, then you shouldn't
> restore.

OK, fair enough.

Thanks,
Rafael

