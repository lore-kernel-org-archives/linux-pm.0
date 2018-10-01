From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: imx6q: read OCOTP through nvmem for
 imx6ul/imx6ull
Date: Mon, 1 Oct 2018 11:24:26 +0530
Message-ID: <20181001055426.w5rp4nfleh4tog3k@vireshk-i7>
References: <1536893962-11200-1-git-send-email-Anson.Huang@nxp.com>
 <1536893962-11200-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536893962-11200-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-pm@vger.kernel.org

On 14-09-18, 10:59, Anson Huang wrote:
> On i.MX6UL/i.MX6ULL, accessing OCOTP directly is wrong because
> the ocotp clock needs to be enabled first. Add support for reading
> OCOTP through the nvmem API instead.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
