From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / QoS: Drop PM_QOS_FLAG_REMOTE_WAKEUP
Date: Fri, 13 Oct 2017 08:32:18 +0200
Message-ID: <CAPDyKFoxooS3QE6vjKr3DNOV6YadV8u0Btw8SWTGdL=EwAxLiQ@mail.gmail.com>
References: <1853660.GWc8KbUC1W@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1853660.GWc8KbUC1W@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 13 October 2017 at 02:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The PM QoS flag PM_QOS_FLAG_REMOTE_WAKEUP is not used consistently
> and the vast majority of code simply assumes that remote wakeup
> should be enabled for devices in runtime suspend if they can
> generate wakeup signals, so drop it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

With a minor nitpick below, please add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/acpi/device_pm.c    |    6 ++----
>  drivers/base/power/domain.c |    4 +---
>  drivers/base/power/sysfs.c  |   28 ----------------------------
>  include/linux/pm_qos.h      |    1 -
>  4 files changed, 3 insertions(+), 36 deletions(-)

I found the flag to also be mentioned in the
Documentation/power/pm_qos_interface.txt, could please remove that
part as well.

[...]

Kind regards
Uffe
