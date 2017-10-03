From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] PM / Sleep / ACPI: Some cleanups and clarifications
Date: Tue,  3 Oct 2017 09:11:05 +0200
Message-ID: <1507014669-1502-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

This series contains four patches which are re-submitted as a subset from an
earlier posted series [1]. These changes addresses cleanups/clarifications to
the code and do not include any functional changes.

[1]
https://www.spinics.net/lists/arm-kernel/msg603856.html

Kind regards
Uffe

Ulf Hansson (4):
  PM / ACPI: Restore acpi_subsys_complete()
  PM / Sleep: Remove pm_complete_with_resume_check()
  PM / ACPI: Split code validating need for runtime resume in
    ->prepare()
  PM / ACPI: Split acpi_lpss_suspend_late|resume_early()

 drivers/acpi/acpi_lpss.c         | 31 +++++++++++++++++-----
 drivers/acpi/device_pm.c         | 56 ++++++++++++++++++++++++++++++----------
 drivers/base/power/generic_ops.c | 23 -----------------
 include/linux/pm.h               |  1 -
 4 files changed, 66 insertions(+), 45 deletions(-)

-- 
2.7.4

