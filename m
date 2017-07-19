From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 0/9] cpufreq: transition-latency cleanups
Date: Wed, 19 Jul 2017 14:42:02 +0200
Message-ID: <2155547.8AYfQSCbsT@aspire.rjw.lan>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 19, 2017 03:42:40 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> This series tries to cleanup the code around transition-latency and its
> users. Some of the old legacy code, which may not make much sense now,
> is dropped as well. And some code consolidation is also done across
> governors.
> 
> Based of: v4.13-rc1
> Tested on: ARM64 Hikey board.

>From the first quick look this version is fine by me.

Unless I find anything of concern later, this will be queued up for 4.14.

Thanks,
Rafael

