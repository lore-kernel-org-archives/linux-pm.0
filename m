From: Scott Wood <oss@buserror.net>
Subject: Re: [PATCH v1 4/4] clk: qoriq: Add clockgen support for lx2160a
Date: Tue, 26 Feb 2019 15:30:29 -0600
Message-ID: <9aef7eea60ccf4a4aaa65e46e17b615aa73b5caf.camel@buserror.net>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
         <1551132245-6089-5-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551132245-6089-5-git-send-email-vabhav.sharma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vabhav Sharma <vabhav.sharma@nxp.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel-owner@vger.kernel.org
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, Andy Tang <andy.tang@nxp.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2019-02-26 at 10:11 +0000, Vabhav Sharma wrote:
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> 
> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/clk/clk-qoriq.c         | 12 ++++++++++++
>  drivers/cpufreq/qoriq-cpufreq.c |  1 +
>  2 files changed, 13 insertions(+)

Acked-by: Scott Wood <oss@buserror.net>

-Scott
