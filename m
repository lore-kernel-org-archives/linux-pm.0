From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 6/7] PM / Domains: Factorize
 dev_pm_genpd_set_performance_state()
Date: Fri, 14 Dec 2018 16:17:42 +0530
Message-ID: <20181214104742.szicfipdffaegcoy@vireshk-i7>
References: <cover.1544782279.git.viresh.kumar@linaro.org>
 <f6153683d88cce25319945e4308bef46edaaaa54.1544782279.git.viresh.kumar@linaro.org>
 <CAPDyKFr7_Cn0N=pctuTdqzcUy9fg-fmpd5OgEFS9eRz-SFh1Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFr7_Cn0N=pctuTdqzcUy9fg-fmpd5OgEFS9eRz-SFh1Fw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 14-12-18, 11:40, Ulf Hansson wrote:
> Nitpick: Would be nice to remove the beginning "_" from both
> _genpd_reeval_performance_state() and _genpd_set_performance_state(),
> as to be consistent with existing function naming in genpd. However,
> it's not a big deal and can be done on top.

Actually it is used at some places and so I did the same for the
internal routines:

_genpd_power_on
_genpd_power_off
__genpd_runtime_suspend
__genpd_runtime_resume
__genpd_dev_pm_attach

-- 
viresh
