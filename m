From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: nforce2: Remove meaningless return
Date: Thu, 6 Dec 2018 09:50:25 +0530
Message-ID: <20181206042025.njiw3rzmgmzb6ki4@vireshk-i7>
References: <20181205155751.15945-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205155751.15945-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05-12-18, 10:57, Yangtao Li wrote:
> Delete a line of meaningless return and some useless blank lines. In a function
> whose return type is void, returning on the last line is not required.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v2:
> -revert modify of MODULE_
> -delete some blank lines
> ---
>  drivers/cpufreq/cpufreq-nforce2.c | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
