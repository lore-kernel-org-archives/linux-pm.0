From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 3/4] cpufreq: bmips-cpufreq: CPUfreq driver for
 Broadcom's BMIPS SoCs
Date: Wed, 8 Feb 2017 09:01:30 +0530
Message-ID: <20170208033130.GD14503@vireshk-i7>
References: <20170207215856.8999-1-code@mmayer.net>
 <20170207215856.8999-4-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20170207215856.8999-4-code@mmayer.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Markus Mayer <code@mmayer.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07-02-17, 13:58, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add the MIPS CPUfreq driver. This driver currently supports CPUfreq on
> BMIPS5xxx-based SoCs.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/Kconfig         |  10 +++
>  drivers/cpufreq/Makefile        |   1 +
>  drivers/cpufreq/bmips-cpufreq.c | 188 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 drivers/cpufreq/bmips-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
