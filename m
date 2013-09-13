From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 181/228] cpufreq: move freq change notifications to
	cpufreq core
Date: Fri, 13 Sep 2013 16:53:13 +0100
Message-ID: <20130913155313.GA12758@n2100.arm.linux.org.uk>
References: <cover.1379063063.git.viresh.kumar@linaro.org> <fd43341751c7a00d2f4eedf48d6338f866b26a52.1379063063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fd43341751c7a00d2f4eedf48d6338f866b26a52.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 13, 2013 at 06:32:07PM +0530, Viresh Kumar wrote:
> +		read_lock_irqsave(&cpufreq_driver_lock, flags);
> +		notify = !(cpufreq_driver->flags & CPUFREQ_ASYNC_NOTIFICATION);
> +		read_unlock_irqrestore(&cpufreq_driver_lock, flags);

I don't think this needs to be read under a lock - if this bit changes
dynamically, then there's something very wrong.
