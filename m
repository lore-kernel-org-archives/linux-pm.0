From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH -next] cpufreq: scpi: fix error return code in scpi_cpufreq_init()
Date: Thu, 08 Feb 2018 11:05:41 +0100
Message-ID: <2101717.6379XIZ7aP@aspire.rjw.lan>
References: <1516673342-170261-1-git-send-email-weiyongjun1@huawei.com> <15661228-4bb6-233e-b81b-8f51f4579616@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <15661228-4bb6-233e-b81b-8f51f4579616@arm.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Wei Yongjun <weiyongjun1@huawei.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 23, 2018 11:14:41 AM CET Sudeep Holla wrote:
> 
> On 23/01/18 02:09, Wei Yongjun wrote:
> > Fix to return a negative error code from the clk_get() error handling
> > case instead of 0, as done elsewhere in this function.
> > 
> 
> Thanks for catching this.
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Patch applied, thanks!

