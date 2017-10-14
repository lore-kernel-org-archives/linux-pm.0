From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] ARM: imx: Enable cpuidle for i.MX6DL starting at 1.1
Date: Sat, 14 Oct 2017 23:05:05 +0800
Message-ID: <20171014150503.GO8833@dragon>
References: <800ef25ed868f303bb2aece5dba59d395340f25d.1507722933.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <800ef25ed868f303bb2aece5dba59d395340f25d.1507722933.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Bai Ping <ping.bai@nxp.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 11, 2017 at 03:08:23PM +0300, Leonard Crestez wrote:
> Enable cpuidle support on i.MX6DL starting from IMX_CHIP_REVISION_1_1.
> 
> This also makes the code cleaner because 6q and 6dl actually have
> different revision histories.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
