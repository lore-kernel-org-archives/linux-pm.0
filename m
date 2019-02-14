From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/2] PM / Domains: Mark "name" const in genpd_dev_pm_attach_by_name()
Date: Thu, 14 Feb 2019 10:23:44 -0800
Message-ID: <155016862432.115909.9670639610937764563@swboyd.mtv.corp.google.com>
References: <20190214181249.2749-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214181249.2749-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Quoting Douglas Anderson (2019-02-14 10:12:48)
> The genpd_dev_pm_attach_by_name() simply takes the name and passes it
> to of_property_match_string() where the argument is "const char *".
> Adding a const here allows a later patch to add a const to
> dev_pm_domain_attach_by_name() which allows drivers to pass in a name
> that was declared "const" in a driver.
>=20
> Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device b=
y name to genpd")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
