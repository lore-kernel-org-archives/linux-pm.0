From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 2/6] thermal:exynos4: TMU Common clock framework support
 for TMU (Thermal Monitoring Unit)
Date: Fri, 19 Apr 2013 23:38:04 +0530
Message-ID: <CAK9yfHxWq5CrhY=A2HMZnH3SQww2sPTBM_zQ9hoinyk1zger7g@mail.gmail.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	<1366389493-8239-3-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1366389493-8239-3-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org

On 19 April 2013 22:08, Lukasz Majewski <l.majewski@samsung.com> wrote:
> This patch modifies exynos_thermal.c file to use clk_disable_unprepare()
> and clk_prepare_enable() instead of clk_{enable|disable}.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---

I have already submitted a similar patch for this:
http://permalink.gmane.org/gmane.linux.power-management.general/33310


-- 
With warm regards,
Sachin
