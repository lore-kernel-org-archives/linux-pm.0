From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 04/11] sched,x86: Enable Turbo Boost Max Technology
Date: Wed, 24 Aug 2016 20:08:54 +0200
Message-ID: <20160824180854.GA1398@gmail.com>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1471559812-19967-5-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20160824101853.GA25705@gmail.com>
 <20160824175057.GA5032@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160824175057.GA5032@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, peterz@infradead.org, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> Ingo,
> 
> This feature will be a clear benefit for client machines and
> less clear on servers.
> 
> This feature is most beneficial to single threaded workload running on
> a single socket that operates in mostly Turbo mode.  Client platform
> like Broadwell High End Desktop is the first one that supports it.
> Enablng this feature for such platform by default will be a win as it
> runs single threaded workload much of the time (10%-15% peformance
> upside).
> 
> On the other hand, a heavily loaded server that rarely operates in Turbo
> mode will benefit much less from this feature.  There is some overhead
> incurred by migrating load to the favored cores.  Some server folks
> have asked us to be cautious here and not to turn on ITMT scheduling
> by default.   Even so, when the server is lightly loaded, this feature
> can still be a win.  That said, this is future looking as we don't have
> any server with this feature today.
> 
> So if we take the approach to enable this feature by default for only
> single node system (using that as a criteria for client), will that seem
> reasonable to you?

I suppose that would work. Peter, any objections to such an approach?

Thanks,

	Ingo
