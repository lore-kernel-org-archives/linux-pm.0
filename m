From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/6] thermal: exynos: Add kernel thermal
 support for exynos platform
Date: Tue, 8 May 2012 13:16:16 -0700
Message-ID: <20120508131616.f60c1f90.akpm@linux-foundation.org>
References: <1336493898-7039-1-git-send-email-amit.kachhap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1336493898-7039-1-git-send-email-amit.kachhap@linaro.org>
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

On Tue,  8 May 2012 21:48:12 +0530
Amit Daniel Kachhap <amit.kachhap@linaro.org> wrote:

> This patchset introduces a new generic cooling device based on cpufreq that
> can be used on non-ACPI platforms. As a proof of concept, we have drivers for
> the following platforms using this mechanism now:
> 
>  * TI OMAP (git://git.linaro.org/people/amitdanielk/linux.git omap4460_thermal)
>  * Samsung Exynos (Exynos4 and Exynos5) in the current patchset.
>  * Freescale i.MX (git://git.linaro.org/people/amitdanielk/linux.git imx6q_thermal)
> 
> These patches have been reviewed by Rui Zhang (https://lkml.org/lkml/2012/4/9/448)

But we don't have explicit Reviewed-by:s for the changelogs?

> who seems to agree with them in principle, but I haven't had any luck getting them
> merged, perhaps a lack of maintainer bandwidth.
> 
> ACPI platforms currently have such a mechanism but it is wrapped in ACPI'isms
> that we don't have on ARM platforms. If this is accepted, I'm proposing to
> convert over the ACPI thermal driver to use this common code too.
