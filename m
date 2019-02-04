From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: tegra124: add missing of_node_put()
Date: Mon, 4 Feb 2019 14:26:07 +0530
Message-ID: <20190204085607.7uax2zt7jve445cz@vireshk-i7>
References: <20190204074854.1538-1-tiny.windzz@gmail.com>
 <20190204081856.GD19087@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204081856.GD19087@ulmo>
Sender: stable-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, rjw@rjwysocki.net, jonathanh@nvidia.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04-02-19, 09:18, Thierry Reding wrote:
> On Mon, Feb 04, 2019 at 02:48:54AM -0500, Yangtao Li wrote:
> > of_cpu_device_node_get() will increase the refcount of device_node,
> > it is necessary to call of_node_put() at the end to release the
> > refcount.
> > 
> > Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
> > Cc: <stable@vger.kernel.org> # 4.4+
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > v2:
> > - move of_node_put() to the very end
> > ---
> >  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Acked-by: Thierry Reding <treding@nvidia.com>


Applied. Thanks.

-- 
viresh
