From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V2 1/2] ARM: dts: imx7s: add temperature monitor support
Date: Mon, 5 Feb 2018 14:12:38 +0800
Message-ID: <20180205061237.GE31354@dragon>
References: <1516954180-26029-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1516954180-26029-1-git-send-email-Anson.Huang@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, edubezval@gmail.com, robh+dt@kernel.org, Linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com, rui.zhang@intel.com, aisheng.dong@nxp.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 26, 2018 at 04:09:39PM +0800, Anson Huang wrote:
> Add i.MX7 temperature monitor support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> no changes since V1.
>  .../devicetree/bindings/thermal/imx-thermal.txt      |  5 +++--

The bindings doc should be a separate patch or part of related
imx-thermal driver patch ...

>  arch/arm/boot/dts/imx7s.dtsi                         | 20 ++++++++++++++++++++

..., and shouldn't be mixed with dts changes.

Shawn
