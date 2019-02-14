From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 2/2] PM / Domains: Mark "name" const in dev_pm_domain_attach_by_name()
Date: Thu, 14 Feb 2019 10:23:50 -0800
Message-ID: <155016863043.115909.10810905918164847994@swboyd.mtv.corp.google.com>
References: <20190214181249.2749-1-dianders@chromium.org> <20190214181249.2749-2-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214181249.2749-2-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Quoting Douglas Anderson (2019-02-14 10:12:49)
> As of the patch ("PM / Domains: Mark "name" const in
> genpd_dev_pm_attach_by_name()") it's clear that the name in
> dev_pm_domain_attach_by_name() can be const.  Mark it as so.  This
> allows drivers to pass in a name that was declared "const" in a
> driver.
>=20
> Fixes: 27dceb81f445 ("PM / Domains: Introduce dev_pm_domain_attach_by_nam=
e()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
