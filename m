From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V2 2/2] cpufreq: imx6q: add 696MHz operating point for
 i.mx6ul
Date: Fri, 2 Feb 2018 08:47:15 +0800
Message-ID: <20180202004713.GC20833@dragon>
References: <1515235360-1628-1-git-send-email-Anson.Huang@nxp.com>
 <1515235360-1628-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1515235360-1628-2-git-send-email-Anson.Huang@nxp.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 06, 2018 at 06:42:40PM +0800, Anson Huang wrote:
> Add 696MHz operating point for i.MX6UL, only for those
> parts with speed grading fuse set to 2b'10 supports
> 696MHz operating point, so, speed grading check is also
> added for i.MX6UL in this patch, the clock tree for each
> operating point are as below:
> 
> 696MHz:
>     pll1                       696000000
>        pll1_bypass             696000000
>           pll1_sys             696000000
>              pll1_sw           696000000
>                 arm            696000000
> 528MHz:
>     pll2                       528000000
>        pll2_bypass             528000000
>           pll2_bus             528000000
>              ca7_secondary_sel 528000000
>                 step           528000000
>                    pll1_sw     528000000
>                       arm      528000000
> 396MHz:
>     pll2_pfd2_396m             396000000
>        ca7_secondary_sel       396000000
>           step                 396000000
>              pll1_sw           396000000
>                 arm            396000000
> 198MHz:
>     pll2_pfd2_396m             396000000
>        ca7_secondary_sel       396000000
>           step                 396000000
>              pll1_sw           396000000
>                 arm            198000000
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
