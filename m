From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Eas-dev] [PATCH V3 2/3] cpufreq: schedutil: Process remote
 callback for shared policies
Date: Thu, 20 Jul 2017 14:22:39 +0200
Message-ID: <20170720122239.licc6yjd7jwipcvk@hirez.programming.kicks-ass.net>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
 <3fbaa9aaba19bfff5ff25d2c4141e88fb83f1ea9.1499927699.git.viresh.kumar@linaro.org>
 <5968263D.1020801@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5968263D.1020801@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 13, 2017 at 07:02:37PM -0700, Saravana Kannan wrote:
> In all Qualcomm chipsets (well, at least the ones that have been used in
> Android devices so far), we can switch the frequency of any CPU from any
> other CPU. If we can do that even without fast switching, why wouldn't any
> theoretical fast switching be incapable of supporting this? Is this a
> limitation specific to x86 that we are assuming all architectures and
> platforms are going to have?

So the typical implementation of fast switching we're thinking of is the
CPU writing the DVFS request into a machine register. Now machine
registers are typically per logical CPU.

What style of fast switching were you thinking of?
