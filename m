From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1] cpufreq: tegra20: Fix imbalanced clock enable count
Date: Thu, 24 May 2018 11:36:59 +0200
Message-ID: <2304436.qRMBXhMGsN@aspire.rjw.lan>
References: <20180522211420.2006-1-digetx@gmail.com> <20180523055817.subrv6oeckfecpcp@vireshk-i7> <db300fa3-ae83-059f-eae0-0808c3cb33fb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <db300fa3-ae83-059f-eae0-0808c3cb33fb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 23, 2018 11:30:39 AM CEST Dmitry Osipenko wrote:
> On 23.05.2018 08:58, Viresh Kumar wrote:
> > On 23-05-18, 00:14, Dmitry Osipenko wrote:
> >> Tegra20-cpufreq driver missed enabling the CPU clocks. This results in a
> >> clock-enable refcount disbalance on PLL_P <-> PLL_X reparent, causing
> >> PLL_X to get disabled while it shouldn't. Fix this by enabling the clocks
> >> on the driver probe.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>
> >> CPUFreq maintainers,
> >>
> >> Please take into account that this patch is made on top of my recent
> >> series of patches [0] "Clean up Tegra20 cpufreq driver" that was fully
> >> reviewed, but seems not applied yet. Let me know if you prefer to re-spin
> >> the [0], including this patch into the series.
> >>
> >> [0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=45321
> > 
> > This is already picked by Rafael and is sitting in pm/bleeding-edge
> > branch. Should get merged into linux-next in a day or two.
> 
> Neat, thank you for letting me know.

It actually is there in my linux-next branch, but linux-next proper is not
taking new material this week AFAICS.

You'll see this in linux-next on Monday, most probably.
