From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] PM / Domains: defer dev_pm_domain_set() until
 genpd->attach_dev succeeds if present
Date: Mon, 17 Jul 2017 09:01:51 +0200
Message-ID: <CAPDyKFqJf+stWC4FAbXAxXgZgCXxc3KOPyG3YS008EWmH6vAcw@mail.gmail.com>
References: <1498759251-11709-1-git-send-email-sudeep.holla@arm.com> <1500029508-7103-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1500029508-7103-1-git-send-email-sudeep.holla@arm.com>
Sender: stable-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "# v4 . 0+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 14 July 2017 at 12:51, Sudeep Holla <sudeep.holla@arm.com> wrote:
> If the genpd->attach_dev or genpd->power_on fails, genpd_dev_pm_attach
> may return -EPROBE_DEFER initially. However genpd_alloc_dev_data sets
> the PM domain for the device unconditionally.
>
> When subsequent attempts are made to call genpd_dev_pm_attach, it may
> return -EEXISTS checking dev->pm_domain without re-attempting to call
> attach_dev or power_on.
>
> platform_drv_probe then attempts to call drv->probe as the return value
> -EEXIST != -EPROBE_DEFER, which may end up in a situation where the
> device is accessed without it's power domain switched on.
>
> Fixes: f104e1e5ef57 ("PM / Domains: Re-order initialization of generic_pm_domain_data")
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: <stable@vger.kernel.org> # v4.0+
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/domain.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Hi,
>
> I have added Cc/Fixes tags based on the original commit that caused the issue.
> I need to workout a patch that can cleanly apply before commit 989561de9b51
> ("PM / Domains: add setter for dev.pm_domain"), i.e. for v4.0.x to v4.4.x
> This patch should apply from v4.5.x onwards.

Thanks for checking this.

Perhaps we should change the stable tag to # v4.5+ instead then?
Otherwise the stable people will just report problems when trying to
apply it.

>
> Let me know if I got anything wrong.
>
> v1->v2: Moved dev_pm_domain_set(dev, NULL) from genpd_free_dev_data
>
> Regards,
> Sudeep

[...]

Kind regards
Uffe
