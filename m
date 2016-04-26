From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/4] clk: renesas: Clock Domain fixes
Date: Tue, 26 Apr 2016 10:33 +0300
Message-ID: <1849807.IPH4zQTRa3@avalon>
References: <1461654582-668-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1461654582-668-1-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

Thank you for the patches.

For the whole series,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Tuesday 26 Apr 2016 09:09:38 Geert Uytterhoeven wrote:
> 	Hi Mike, Stephen,
> 
> This patch series contains fixes for the Renesas CPG/MSTP and CPG/MSSR
> Clock Domains:
>   1. Postpone calls to pm_genpd_init(), as all local setup of the
>      generic_pm_domain structure should have been completed before
>      calling pm_genpd_init(),
>   2. Use always-on governor for Clock Domains, to prevent their status
>      from being shown as "off-0" in
>      /sys/kernel/debug/pm_genpd/pm_genpd_summary.
> 
> I plan to queue these up with other clock updates in
> clk-renesas-for-v4.7, and send a pull request later.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (4):
>   clk: renesas: mstp: Postpone call to pm_genpd_init()
>   clk: renesas: mstp: Use always-on governor for Clock Domain
>   clk: renesas: cpg-mssr: Postpone call to pm_genpd_init()
>   clk: renesas: cpg-mssr: Use always-on governor for Clock Domain
> 
>  drivers/clk/renesas/clk-mstp.c         | 3 +--
>  drivers/clk/renesas/renesas-cpg-mssr.c | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)

-- 
Regards,

Laurent Pinchart

