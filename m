From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2] PM / OPP: 'UNKNOWN' status of opp-table->shared
Date: Thu, 16 Jun 2016 15:52:07 +0200
Message-ID: <CAJZ5v0hPh6nxg3zNGOxYhArBv=hTL9StPL0eCN5zhv=mutZyow@mail.gmail.com>
References: <5909c884def1438bc2da83dbcc3c6ebddc28bba0.1466083891.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5909c884def1438bc2da83dbcc3c6ebddc28bba0.1466083891.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 16, 2016 at 3:33 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> dev_pm_opp_get_sharing_cpus() returns 0 even in the case where the OPP
> core doesn't know if the table is shared or not. It is working for most
> of the platforms, as the OPP table was never created and we returned
> -ENODEV then.
>
> But in case of one of the platforms (Jetson TK1) at least, the situation
> is a bit different. The OPP table is created (somehow) before
> dev_pm_opp_get_sharing_cpus() is called and so we returned 0. The caller
> of this routine treated that as 'CPUs don't share OPPs' and that had bad
> consequences on performance.
>
> Fix this by creating a converting 'shared_opp' to an enum.
> dev_pm_opp_get_sharing_cpus() returns -EINVAL now in case the status in
> access-unknown, so that the caller can handle it accordingly (cpufreq-dt
> considers that as 'all CPUs share the table').
>
> Fixes: 6f707daa3833 ("PM / OPP: Add dev_pm_opp_get_sharing_cpus()")
> Reported-and-tested-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I've queued it up, but I rewrote the changelog.

Please check in bleeding-edge.

Thanks!
