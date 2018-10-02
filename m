From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Date: Tue, 2 Oct 2018 15:50:32 +0200
Message-ID: <20181002135032.GF26858@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
 <20181002122535.GY3439@hirez.programming.kicks-ass.net>
 <20181002125414.aufsalllqf25rwsq@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181002125414.aufsalllqf25rwsq@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 02, 2018 at 01:54:17PM +0100, Quentin Perret wrote:
> On Tuesday 02 Oct 2018 at 14:25:35 (+0200), Peter Zijlstra wrote:

> > Should we explicitly mention that this ignores idle costs?
> 
> More doc shouldn't hurt so I can add a little something if you feel it's
> needed.

Yes please, every time I read that thing I wonder about idle energy.
Then I remember we talked about this and it is expressly ignored.
