From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU
 controller
Date: Mon, 20 Mar 2017 13:36:11 -0400
Message-ID: <20170320173611.GA7398@htj.duckdns.org>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <20170320171511.GB3623@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35092 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbdCTRgO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 13:36:14 -0400
Content-Disposition: inline
In-Reply-To: <20170320171511.GB3623@htj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On Mon, Mar 20, 2017 at 01:15:11PM -0400, Tejun Heo wrote:
> > a) are tunable at all hierarchy levels, i.e. root group too
> 
> This usually is problematic because there should be a non-cgroup way
> of configuring the feature in case cgroup isn't configured or used,
> and it becomes awkward to have two separate mechanisms configuring the
> same thing.  Maybe the feature is cgroup specific enough that it makes
> sense here but this needs more explanation / justification.

A related issue here is that what the non-cgroup interface and its
interaction with cgroup should be.  In the long term, I think it's
better to have a generic non-cgroup interface for these new features,
and we've gotten it wrong, or at least inconsistent, across different
settings - most don't affect API accessible settings and just confine
the configuration requested by the application inside the cgroup
constraints; however, cpuset does it the other way and overwrites
configurations set by individual applications.

If we agree that exposing this only through cgroup is fine, this isn't
a concern, but, given that this is a thread property and can obviously
be useful outside cgroups, that seems debatable at the very least.

Thanks.

-- 
tejun
