From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
Date: Wed, 23 May 2018 09:59:53 +0530
Message-ID: <20180523042953.kcp2h5xtwjrjponn@vireshk-i7>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: linux-arm-kernel@lists.infradead.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22-05-18, 08:28, Sébastien Szymanski wrote:
> Check the max speed supported from the fuses for i.MX6ULL and update the
> operating points table accordingly.
> 
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
> 
> Changes for v3:
>  - none

@Sascha and Shawn: Can you guys please Ack this series if there is
nothing wrong with it ?

-- 
viresh
