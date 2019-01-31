From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] PM / OPP: Remove unused parameter of _generic_set_opp_clk_only()
Date: Thu, 31 Jan 2019 08:35:00 -0800
Message-ID: <154895250022.169292.11355732570610088435@swboyd.mtv.corp.google.com>
References: <e2e83f314120f078f7e24fbd5393decb9940a067.1548923105.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e2e83f314120f078f7e24fbd5393decb9940a067.1548923105.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2019-01-31 00:25:13)
> The previous frequency value isn't getting used in the routine
> _generic_set_opp_clk_only(), drop it.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
