From: Sylwester Nawrocki <snjw23@gmail.com>
Subject: Re: [PATCH 2/4] hwmon: exynos4: Move thermal sensor driver to driver/mfd
 directory
Date: Sat, 03 Mar 2012 13:21:34 +0100
Message-ID: <4F520CCE.1030409@gmail.com>
References: <1330772767-16120-1-git-send-email-amit.kachhap@linaro.org> <1330772767-16120-3-git-send-email-amit.kachhap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1330772767-16120-3-git-send-email-amit.kachhap@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: linux-pm@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, lenb@kernel.org, linaro-dev@lists.linaro.org, lm-sensors@lm-sensors.org, eduardo.valentin@ti.com, durgadoss.r@intel.com, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On 03/03/2012 12:06 PM, Amit Daniel Kachhap wrote:
> This movement is needed because the hwmon entries and corresponding
> sysfs interface is a duplicate of utilities already provided by
> driver/thermal/thermal_sys.c. The goal is to place it in mfd folder
> and add necessary calls to get the temperature information.
>
> Signed-off-by: Amit Daniel Kachhap<amit.kachhap@linaro.org>
> Signed-off-by: Donggeun Kim<dg77.kim@samsung.com>
> ---
>   Documentation/hwmon/exynos4_tmu |   81 ------
>   Documentation/mfd/exynos4_tmu   |   81 ++++++
>   drivers/hwmon/Kconfig           |   10 -
>   drivers/hwmon/Makefile          |    1 -
>   drivers/hwmon/exynos4_tmu.c     |  514 ---------------------------------------
>   drivers/mfd/Kconfig             |   10 +
>   drivers/mfd/Makefile            |    1 +
>   drivers/mfd/exynos4_tmu.c       |  514 +++++++++++++++++++++++++++++++++++++++
>   8 files changed, 606 insertions(+), 606 deletions(-)
>   delete mode 100644 Documentation/hwmon/exynos4_tmu
>   create mode 100644 Documentation/mfd/exynos4_tmu
>   delete mode 100644 drivers/hwmon/exynos4_tmu.c
>   create mode 100644 drivers/mfd/exynos4_tmu.c

Please consider adding -M option to git format-patch next time, which
would make the patch smaller and would let to see clearly what's moved
and what has changed.

--
Thanks,
Sylwester
