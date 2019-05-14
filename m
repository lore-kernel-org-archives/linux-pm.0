From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 0/2] Allow imx6qp PU domain off in suspend
Date: Tue, 14 May 2019 23:35:38 +0200
Message-ID: <2135871.ArgiegidzK@kreacher>
References: <cover.1556636234.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1556636234.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 30, 2019 5:06:10 PM CEST Leonard Crestez wrote:
> On imx6qp power gating on the PU domain is disabled because of errata
> ERR009619. However power gating during suspend/resume can still be
> performed.
> 
> Changes since V4:
>  * Rename GENPD_FLAG_NO_RUNTIME_OFF to GENPD_FLAG_RPM_ALWAYS_ON
> Link to v4: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=110829
> 
> Implemented with a new core flag because otherwise distinguishing
> between "runtime off" and "suspend off" is very complicated. Link to
> previous much older attempts:
> 
> v3: https://lkml.org/lkml/2018/7/6/698
> v2: https://lkml.org/lkml/2018/7/5/564
> v1: https://lkml.org/lkml/2018/7/2/357
> 
> Leonard Crestez (2):
>   PM / Domains: Add GENPD_FLAG_RPM_ALWAYS_ON flag
>   soc: imx: gpc: Use GENPD_FLAG_RPM_ALWAYS_ON for ERR009619
> 
>  drivers/base/power/domain.c |  8 ++++++--
>  drivers/soc/imx/gpc.c       | 13 +++++++++++--
>  include/linux/pm_domain.h   |  4 ++++
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 
> -- 

Both patches applied, thanks!
