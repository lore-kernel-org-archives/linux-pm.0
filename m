From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
Date: Tue, 24 Mar 2015 07:12:03 +0100
Message-ID: <20150324061203.GO9742@pengutronix.de>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
 <20150323060706.GB4946@pengutronix.de>
 <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: fabio.estevam@freescale.com, mark.rutland@arm.com, marex@denx.de, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, dbaryshkov@gmail.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, lgirdwood@gmail.com, robh+dt@kernel.org, sre@kernel.org, devicetree@vger.kernel.org, broonie@kernel.org, kernel@pengutronix.de, galak@codeaurora.org, sebastien.szymanski@armadeus.com, shawn.guo@linaro.org, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 23, 2015 at 06:54:34PM +0100, Stefan Wahren wrote:
> Hi Sascha,
> 
> > It is very unusual to describe the regulators of a device on a register
> > level like this and to iomemap each register individually. I think you
> > should drop the registers here and put this knowledge into the driver
> > like (nearly?) all others do.
> 
> do mean dropping the base address of the regulator, too?

Yes.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
