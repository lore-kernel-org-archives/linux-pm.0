From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V2 1/2] ARM: dts: imx6ul: use nvmem-cells for cpu speed
 grading
Date: Wed, 26 Sep 2018 17:20:06 +0800
Message-ID: <20180926092004.GE26692@dragon>
References: <1537154264-23252-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1537154264-23252-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 17, 2018 at 11:17:43AM +0800, Anson Huang wrote:
> On i.MX6UL, accessing OCOTP directly is wrong because the ocotp clock
> needs to be enabled first, so use the nvmem-cells binding instead.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> no change since V1.

Okay, I just applied v1 of this patch.

Shawn
