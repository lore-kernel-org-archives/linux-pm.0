From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: broken probe deferred for power-domains
Date: Wed, 27 Feb 2019 03:18:41 +0100
Message-ID: <20190227021841.GA26337@centauri.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org
Cc: agraf@suse.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Rob,

Your patch e01afc325025 ("PM / Domains: Stop deferring probe
at the end of initcall") breaks deferred probe for power domains.

The patch looks like this:

+++ b/drivers/base/power/domain.c
@@ -2253,7 +2253,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
                mutex_unlock(&gpd_list_lock);
                dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
                        __func__, PTR_ERR(pd));
-               return -EPROBE_DEFER;
+               return driver_deferred_probe_check_state(dev);
        }


Having two drivers (both using module_platform_driver),
one being a PD provider and one being a PD consumer.

Before your patch:
The PD consumer driver calls dev_pm_domain_attach(),
and gets EPROBE_DEFER until the PD provider driver
has been probed successfully.

(The PD provider driver needs some regulators, so it
is only successfully probed after the regulator driver
has been probed successfully.)

Anyway, dev_pm_domain_attach() returned success after
the some deferred probes.


After your patch:
dev_pm_domain_attach() return ENODEV,
which comes from driver_deferred_probe_check_state().
Since it returns ENODEV rather than EPROBE_DEFER,
the PD consumer driver fails to probe.


The problem is related to your other patch 25b4e70dcce9
("driver core: allow stopping deferred probe after init").

driver_deferred_probe_check_state() returns ENODEV if
initcalls_done == true.

initcalls_done is set from late_initcall(deferred_probe_initcall),
in drivers/base/dd.c:
       driver_deferred_probe_trigger();
       flush_work(&deferred_probe_work);
       initcalls_done = true;

This does not seem very robust, since

#1 It does not handle the case where two drivers have been
deferred (put in the deferred probe pending list),
where additionally one of the drivers has to be probed
before the other.

(We would need to call driver_deferred_probe_trigger() + flush_work()
at least twice to handle this.)

#2 Since this code is run from late_initcall(),
initcalls_done might get set before other drivers using late_initcall()
have even had a chance to run.
I can imagine that a driver using late_initcall() + EPROBE_DEFER
will absolutely not work with this code.


This patch fixes #1, but not #2.
However, I assume that even this change would not work if we have 3
drivers, where each driver a > b > c has to be probed, in that order.
(and all of them were placed in the deferred probe pending list).

Suggestions and patches are welcome.


diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a823f469e53f..3443cb78be9b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -288,7 +288,6 @@ static int deferred_probe_initcall(void)
        driver_deferred_probe_trigger();
        /* Sort as many dependencies as possible before exiting initcalls */
        flush_work(&deferred_probe_work);
-       initcalls_done = true;
 
        /*
         * Trigger deferred probe again, this time we won't defer anything
@@ -297,6 +296,8 @@ static int deferred_probe_initcall(void)
        driver_deferred_probe_trigger();
        flush_work(&deferred_probe_work);
 
+       initcalls_done = true;
+
        if (deferred_probe_timeout > 0) {
                schedule_delayed_work(&deferred_probe_timeout_work,
                        deferred_probe_timeout * HZ);



Kind regards,
Niklas
