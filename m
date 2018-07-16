From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 19/23] dt-bindings: thermal: armada: add reference to
 new bindings
Date: Mon, 16 Jul 2018 10:03:55 -0600
Message-ID: <20180716160355.GA15444@rob-hp-laptop>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-20-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180716144206.30985-20-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 16, 2018 at 04:42:02PM +0200, Miquel Raynal wrote:
> New bindings (using a syscon) are available for AP806 and CP110
> compatibles. Add a reference to these files from the original
> documentation.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/thermal/armada-thermal.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
