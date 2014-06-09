From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] cpufreq: governor: remove copy_prev_load from 'struct
 cpu_dbs_common_info'
Date: Mon, 9 Jun 2014 12:52:48 +0200
Message-ID: <20140609105248.GA25705@amd.pavel.ucw.cz>
References: <d4241c6ef57c901dde270380cce74e24effa4852.1402291351.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d4241c6ef57c901dde270380cce74e24effa4852.1402291351.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, srivatsa.bhat@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

On Mon 2014-06-09 10:54:17, Viresh Kumar wrote:
> 'copy_prev_load' was recently added by commit: 18b46ab (cpufreq: governor: Be
> friendly towards latency-sensitive bursty workloads).
> 
> It actually is a bit redundant as we also have 'prev_load' which can store any
> integer value and can be used instead of 'copy_prev_load' by setting it to zero
> when we don't want to use previous load.
> 
> So, drop 'copy_prev_load' and use 'prev_load' instead.
> 
> Update comments as well to make it more clear.
> 
> There is another change here which was probably missed by Srivatsa during the
> last version of updates he made. The unlikely in the 'if' statement was covering
> only half of the condition and the whole line should actually come under it.
> 
> Also checkpatch is made more silent as it was reporting this (--strict option):
> 
> CHECK: Alignment should match open parenthesis
> +		if (unlikely(wall_time > (2 * sampling_rate) &&
> +						j_cdbs->prev_load)) {
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
