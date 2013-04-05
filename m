From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V5 0/4] cpufreq: exynos5440: support for cpufreq driver
Date: Fri, 05 Apr 2013 14:38:26 +0200
Message-ID: <2949363.nNl2A6XIoS@vostro.rjw.lan>
References: <1364457923-8499-1-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1364457923-8499-1-git-send-email-amit.daniel@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Inderpal Singh <inderpal.singh@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thursday, March 28, 2013 01:35:18 PM Amit Daniel Kachhap wrote:
> Submitting the V5 version of exynos5440 cpufreq driver. This patchset addresses
> all the coding and design concerns raised especially by Viresh.
> 
> Changes in V5:
> * Removed the unnecessary DT look up entry from mach-exynos5-dt.c.
> * Fixed all coding and comments issue raised by Viresh.
> 
> Changes in V4:
> * Added dev_err logs instead of pr_err.
> * Used the devm_ioremap_resource API.
> * Implemented several coding guidelines and minor error comments from Sylwester,
>   Russell and Viresh.
> 
> Changes in V3:
> * Converted the driver to probe based as suggested by Viresh. This is also
>   beneficial for multiplatform kernel.
> * Other coding guidelines related changes.
> * Moved the DT node outside cpu0 node as the driver is now a platform
>   driver.
> 
> Changes in V2:
> * Added OPP library support to parse DT parameters.
> * Removed a hack to handle interrupts in bootup.
> * Implemented other review comments from Viresh and Inder.
> 
> All these patches are dependent on Thomas Abraham common clock patches.
> (http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg15860.html)
> This whole patch series is based on 3.9-rc4.
> 
> Amit Daniel Kachhap (4):
>   cpufreq: exynos: Add cpufreq driver for exynos5440
>   cpufreq: exynos: Remove error return even if no soc is found
>   arm: exynos: Enable OPP library support for exynos5440
>   arm: dts: Add cpufreq controller node for Exynos5440 SoC
> 
>  .../bindings/cpufreq/cpufreq-exynos5440.txt        |   28 ++
>  arch/arm/boot/dts/exynos5440.dtsi                  |   12 +
>  arch/arm/mach-exynos/Kconfig                       |    2 +
>  drivers/cpufreq/Kconfig.arm                        |    9 +
>  drivers/cpufreq/Makefile                           |    1 +
>  drivers/cpufreq/exynos-cpufreq.c                   |    2 +-
>  drivers/cpufreq/exynos5440-cpufreq.c               |  474 ++++++++++++++++++++
>  7 files changed, 527 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
>  create mode 100644 drivers/cpufreq/exynos5440-cpufreq.c

Is this for me or the Samsung tree?

If it's for me, I need ACKs from the Samsung tree maintainers.  Also, please
address the Viresh's comments.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
