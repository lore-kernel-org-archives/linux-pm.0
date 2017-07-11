From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PM / Domains: defer dev_pm_domain_set() until genpd->attach_dev succeeds if present
Date: Tue, 11 Jul 2017 11:53:05 -0700
Message-ID: <7hk23evm9a.fsf@baylibre.com>
References: <1498759251-11709-1-git-send-email-sudeep.holla@arm.com>
        <CAJZ5v0i42jjbm2M7fBjfPSu88gGz-Rxp3QBJM3uFggaN=8VkcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i42jjbm2M7fBjfPSu88gGz-Rxp3QBJM3uFggaN=8VkcA@mail.gmail.com>
        (Rafael J. Wysocki's message of "Tue, 4 Jul 2017 22:39:17 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Thu, Jun 29, 2017 at 8:00 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> If the genpd->attach_dev or genpd->power_on fails, genpd_dev_pm_attach
>> may return -EPROBE_DEFER initially. However genpd_alloc_dev_data sets
>> the PM domain for the device unconditionally.
>>
>> When subsequent attempts are made to call genpd_dev_pm_attach, it may
>> return -EEXISTS checking dev->pm_domain without re-attempting to call
>> attach_dev or power_on.
>>
>> platform_drv_probe then attempts to call drv->probe as the return value
>> -EEXIST != -EPROBE_DEFER, which may end up in a situation where the
>> device is accessed without it's power domain switched on.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Ulf, this looks like a genuine fix to me, any comments?
>

This looks like the right fix to me.

Acked-by: Kevin Hilman <khilman@baylibre.com>
