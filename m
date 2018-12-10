From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 4/6] dt-bindings: cp110: document the thermal
 interrupt capabilities
Date: Mon, 10 Dec 2018 17:05:18 -0600
Message-ID: <20181210230518.GA10816@bogus>
References: <20181204190332.10351-1-miquel.raynal@bootlin.com>
 <20181204190332.10351-5-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181204190332.10351-5-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, David Sniatkiwicz <davidsn@marvell.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue,  4 Dec 2018 20:03:30 +0100, Miquel Raynal wrote:
> The thermal IP can produce interrupts on overheat situation.
> Describe them.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/arm/marvell/cp110-system-controller.txt     | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
