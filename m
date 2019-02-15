From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Mark "name" const in
 genpd_dev_pm_attach_by_name()
Date: Fri, 15 Feb 2019 08:32:05 +0530
Message-ID: <20190215030205.g6ntaiec3kscsaoi@vireshk-i7>
References: <20190214181249.2749-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214181249.2749-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 14-02-19, 10:12, Douglas Anderson wrote:
> The genpd_dev_pm_attach_by_name() simply takes the name and passes it
> to of_property_match_string() where the argument is "const char *".
> Adding a const here allows a later patch to add a const to
> dev_pm_domain_attach_by_name() which allows drivers to pass in a name
> that was declared "const" in a driver.
> 
> Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device by name to genpd")

Not sure if this should be counted as a fix.

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/base/power/domain.c | 2 +-
>  include/linux/pm_domain.h   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

For both the patches:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
