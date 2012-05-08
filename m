From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/6] hwmon: exynos4: Move thermal sensor
 driver to driver/thermal directory
Date: Tue, 8 May 2012 13:16:32 -0700
Message-ID: <20120508131632.49d0ac99.akpm@linux-foundation.org>
References: <1336493898-7039-1-git-send-email-amit.kachhap@linaro.org>
	<1336493898-7039-2-git-send-email-amit.kachhap@linaro.org>
	<1336493898-7039-3-git-send-email-amit.kachhap@linaro.org>
	<1336493898-7039-4-git-send-email-amit.kachhap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1336493898-7039-4-git-send-email-amit.kachhap@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue,  8 May 2012 21:48:15 +0530
Amit Daniel Kachhap <amit.kachhap@linaro.org> wrote:

> This movement is needed because the hwmon entries and corresponding
> sysfs interface is a duplicate of utilities already provided by
> driver/thermal/thermal_sys.c. The goal is to place it in thermal folder
> and add necessary functions to use the in-kernel thermal interfaces.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> ---
>  Documentation/hwmon/exynos4_tmu              |   81 ----
>  Documentation/thermal/exynos_thermal         |   52 +++
>  drivers/hwmon/Kconfig                        |   10 -
>  drivers/hwmon/Makefile                       |    1 -
>  drivers/hwmon/exynos4_tmu.c                  |  514 --------------------------

Please cc the hwmon people?  Jean Delvare <khali@linux-fr.org>, Guenter
Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

>  drivers/thermal/Kconfig                      |    9 +
>  drivers/thermal/Makefile                     |    1 +
>  drivers/thermal/exynos_thermal.c             |  409 ++++++++++++++++++++
>  include/linux/platform_data/exynos4_tmu.h    |   83 ----
>  include/linux/platform_data/exynos_thermal.h |   83 ++++
