From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v5 02/11] ACPI / PM: Assign the ->detach() callback when attaching the PM domain
Date: Fri, 19 Sep 2014 20:27:35 +0200
Message-ID: <1411151264-16245-3-git-send-email-ulf.hansson@linaro.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

As as preparation to simplify the detachment of devices from their PM
domains, we assign the ->detach() callback to genpd_dev_pm_detach().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/acpi/device_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 67075f8..eec5ed5 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1072,6 +1072,8 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 		acpi_dev_pm_full_power(adev);
 		acpi_device_wakeup(adev, ACPI_STATE_S0, false);
 	}
+
+	dev->pm_domain->detach = acpi_dev_pm_detach;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
-- 
1.9.1

