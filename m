From: "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH] cpufreq: Fix kobject memleak
Date: Tue, 30 Apr 2019 16:33:26 +1000
Message-ID: <20190430063326.GC32393@eros.localdomain>
References: <815f7c7cea02e05c90d5bf678ea8717f01cc9f63.1556604312.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <815f7c7cea02e05c90d5bf678ea8717f01cc9f63.1556604312.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, tobin@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 30, 2019 at 11:35:52AM +0530, Viresh Kumar wrote:
> Currently the error return path from kobject_init_and_add() is not
> followed by a call to kobject_put() - which means we are leaking the
> kobject.
> 
> Fix it by adding a call to kobject_put() in the error path of
> kobject_init_and_add().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Tobin fixed this for schedutil already.

For what its worth:

 Reviewed-by: Tobin C. Harding <tobin@kernel.org>

Thanks Viresh, one less for me to do!

	Tobin
