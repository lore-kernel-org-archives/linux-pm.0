From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 05/14] cpufreq: cpu0: don't validate clock on clk_put()
Date: Wed, 9 Jul 2014 10:42:50 -0400
Message-ID: <53BD54EA.4020207@ti.com>
References: <cover.1404231535.git.viresh.kumar@linaro.org> <a5279afda849ca394552dbae6a1364769da0dc98.1404231535.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <a5279afda849ca394552dbae6a1364769da0dc98.1404231535.git.viresh.kumar@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net, shawn.guo@linaro.org
Cc: nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, t.figa@samsung.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, thomas.ab@samsung.com, arvind.chauhan@arm.com, spk.linux@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 July 2014 12:32 PM, Viresh Kumar wrote:
> CPU clk is not optional for this driver and probe would fail if it couldn't find
> a suitable clock.
> 
> And so, while calling clk_put() we don't need to validate clocks.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
