From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/5] ARM: dts: imx6sx: Use nvmem-cells for tempmon
Date: Wed, 18 Oct 2017 10:29:45 +0800
Message-ID: <20171018022943.GF18810@dragon>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
 <3cda26e557510055f05cea92b81678743e0ea9e3.1500041281.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3cda26e557510055f05cea92b81678743e0ea9e3.1500041281.git.leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 14, 2017 at 05:11:09PM +0300, Leonard Crestez wrote:
> On imx6sx accessing OCOTP directly is wrong because the ocotp clock
> needs to be enabled first. Use the nvmem-cells binding instead.
> 
> This requirement does not apply to older imx6qdl chips because there the
> ocotp access clock (clk_ipg_s) is always enabled.
> 
> This is visible by comparing the "System Clocks, Gating, and Override"
> tables (OCOTP rows) in the 6DQ and 6SX manuals:
> http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6SXRM.pdf
> http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
> 
> This happens to work right now because the ocotp clock might be enabled
> for some other reason. In particular the it might be enabled from the
> bootloader and it only gets disabled late during boot in
> clk_disable_unused, after imx-thermal has completed probing.
> 
> If imx-thermal is compiled as a module then the system can hang on
> probe.
> 
> Reported-by: Lothar Waﬂmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
> Signed-off-by: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>

I applied patch #4 and #5 to IMX tree for avoiding merge conflict.  Rui
will drop them from thermal tree.

Shawn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
