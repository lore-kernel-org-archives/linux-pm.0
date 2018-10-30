From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V8 3/5] dt-bindings: fsl: scu: update power domain binding
Date: Tue, 30 Oct 2018 14:30:27 -0500
Message-ID: <20181030193027.GA26215@bogus>
References: <1540739690-23750-1-git-send-email-aisheng.dong@nxp.com>
 <1540739690-23750-4-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1540739690-23750-4-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "hange-folder>?" <toggle-mailboxes@bogus>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 28 Oct 2018 15:19:44 +0000, "A.s. Dong" wrote:
> Update the power domain binding with #power-domain-cells 1 format.
> The first cell can be a global SCU power domain and the 2nd cell
> the device ID. With this approach, we may remove all the sub power
> domain nodes from device tree which can relief the device tree a lot.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v7->v8:
>  * new patch
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 37 +++++-----------------
>  1 file changed, 8 insertions(+), 29 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
