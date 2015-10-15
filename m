From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/5] cpufreq: create cpu/cpufreq/policyX directories
Date: Thu, 15 Oct 2015 12:25:03 +0530
Message-ID: <20151015065503.GB19018@linux>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
 <dd7e6cab3e879e94305c0fca1ea6033e79d166ca.1444583718.git.viresh.kumar@linaro.org>
 <561C0A8B.5010509@codeaurora.org>
 <20151013033912.GN5386@linux>
 <561D5B85.4010103@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <561D5B85.4010103@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 13-10-15, 12:29, Saravana Kannan wrote:
> But we don't need to track track of "present-cpus" separately
> though. We could do the for_each_cpu_and() when we create the
> symlinks for the first time. And after that, we can just use the
> subsystem interface callbacks (cpufreq_add_dev() and
> cpufreq_remove_dev()) to keep the symlinks updated.
> 
> I don't see any place where keeping track of this separately is more
> efficient. This would save some memory savings when the number of
> CPUs is large and also simplify the code because we won't have to
> keep another field up to date.

It is still required to track when can we free the policy.

-- 
viresh
