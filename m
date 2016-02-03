From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM: Avoid false-positive warnings in dev_pm_domain_set()
Date: Wed, 3 Feb 2016 14:18:30 +0100
Message-ID: <CAPDyKFpwyu4OYZo0yyM=8VEE75ONgwX2wF0j2OFZs-YnrWW-DA@mail.gmail.com>
References: <80793506.EZRY3UmSeu@vostro.rjw.lan>
	<CAPDyKFoCO6DY55+rsEhXqcA6dA12PvejroxDoS8G+SPKZsPWJA@mail.gmail.com>
	<CAJZ5v0hy_oUGqNRaYtao_WjK5c+ZutnYh-mUJjhc=eCoBum+KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hy_oUGqNRaYtao_WjK5c+ZutnYh-mUJjhc=eCoBum+KA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 3 February 2016 at 13:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Feb 3, 2016 at 10:58 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 30 January 2016 at 12:54, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> There is a WARN_ON() in dev_pm_domain_set() that triggers on attempts
>>> to set the pm_domain pointer for devices with a driver bound.
>>>
>>> However, that WARN_ON() triggers on attempts to clear the pointer
>>> too and the test it uses is based on checking the device's
>>> p->knode_driver pointer which still is set when the device bus
>>> type's/driver's ->remove callback has been executed.  This
>>> leads to false-positive warnings when bus type code calls
>>> dev_pm_domain_set() to clear the pm_domain pointer after
>>> invoking the driver's ->remove() callback.
>>>
>>> To avoid those false-positives, make dev_pm_domain_set() check
>>> if the pointer passed to it is NULL and skip the warning in
>>> that case.
>>>
>>> Fixes: 989561de9b51 (PM / Domains: add setter for dev.pm_domain)
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>  drivers/base/power/common.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Index: linux-pm/drivers/base/power/common.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/base/power/common.c
>>> +++ linux-pm/drivers/base/power/common.c
>>> @@ -146,7 +146,7 @@ void dev_pm_domain_set(struct device *de
>>>         if (dev->pm_domain == pd)
>>>                 return;
>>>
>>> -       WARN(device_is_bound(dev),
>>> +       WARN(pd && device_is_bound(dev),
>>>              "PM domains can only be changed for unbound devices\n");
>>
>> Perhaps this information then becomes a bit misleading, as it's okay
>> to clear the pointer, but not assign it to a valid PM domain.
>
> Well, this is a "you're doing a wrong thing" warning and it does say
> what the wrong thing is.  Does it have to be more specific?  I don't
> think so.

Okay! I don't have a strong opinion.

Feel free to add:
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
