From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4] thermal: imx: fix for dependency on cpu-freq
Date: Wed, 21 Nov 2018 10:59:53 +0530
Message-ID: <20181121052953.oqzdncf5dm7fwhsd@vireshk-i7>
References: <1542776563-6716-1-git-send-email-Anson.Huang@nxp.com>
 <20181121052053.hcc3xgfx4dgkydd2@vireshk-i7>
 <DB3PR0402MB3916E94B9CF644707801AE74F5DA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916E94B9CF644707801AE74F5DA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 21-11-18, 05:28, Anson Huang wrote:
> Since there is similar case of DEFER PROBE for the case of imx_init_from_nvmem_cells
> check, should I create another patch of same fix for it in V5 patch set?

Send that as a separate patch please. Thanks.

-- 
viresh
