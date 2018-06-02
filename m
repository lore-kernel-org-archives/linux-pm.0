From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] OPP: Allow same OPP table to be used for multiple genpd
Date: Fri, 01 Jun 2018 23:45:20 -0700
Message-ID: <152792192058.225090.13082340679675758540@swboyd.mtv.corp.google.com>
References: <8a352fd8787cefcb19c25ca1390301f874797b9c.1527674939.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8a352fd8787cefcb19c25ca1390301f874797b9c.1527674939.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2018-05-30 03:09:02)
> The OPP binding says:
> =

>         Property: operating-points-v2
> =

>         ...
> =

>         This can contain more than one phandle for power domain
>         providers that provide multiple power domains. That is, one
>         phandle for each power domain. If only one phandle is available,
>         then the same OPP table will be used for all power domains
>         provided by the power domain provider.
> =

> But the OPP core isn't allowing the same OPP table to be used for
> multiple domains. Update dev_pm_opp_of_add_table_indexed() to allow
> that.
> =

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
