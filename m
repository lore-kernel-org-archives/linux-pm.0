From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq: do some cleanup
Date: Mon, 18 Feb 2019 10:30:02 +0530
Message-ID: <20190218050002.a2xb2o6w3s63xfv6@vireshk-i7>
References: <20190216155527.11839-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190216155527.11839-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16-02-19, 10:55, Yangtao Li wrote:
> The informations come from the coccinelle tool.
> 
> drivers/cpufreq/longhaul.c:854:2-3: Unneeded semicolon
> drivers/cpufreq/pcc-cpufreq.c:271:2-3: Unneeded semicolon
> 
> Yangtao Li (2):
>   cpufreq: pcc-cpufreq: remove unneeded semicolon
>   cpufreq: longhaul: remove unneeded semicolon
> 
>  drivers/cpufreq/longhaul.c    | 2 +-
>  drivers/cpufreq/pcc-cpufreq.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh
