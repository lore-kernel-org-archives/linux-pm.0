From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V7 1/3] dt-bindings: fsl: scu: make power domain
 compatible  string SoC specific
Date: Thu, 18 Oct 2018 13:24:35 -0500
Message-ID: <20181018182435.GA27382@bogus>
References: <1539883285-7990-1-git-send-email-aisheng.dong@nxp.com>
 <1539883285-7990-2-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1539883285-7990-2-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 18 Oct 2018 17:25:57 +0000, "A.s. Dong" wrote:
> As the power domain API might change in the future for new SoCs, although
> in a very low possibility, it's still better to make the compatible string
> more SoC specific to avoid the possible version change for new SoCs.
> 
> Due to there're still no users in kernel, it's safe to update it without
> breaking anything.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v6->v7:
>  * keep "fsl,scu-pd" as fall back compatible string
> v5->v6:
>  * new patch
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
