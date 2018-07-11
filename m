From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: marvell: Add documentation for the
 Armada 3700 AVS binding
Date: Wed, 11 Jul 2018 09:51:53 -0600
Message-ID: <20180711155153.GA13702@rob-hp-laptop>
References: <20180704132524.23640-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180704132524.23640-1-gregory.clement@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Ken Ma <make@marvell.com>, Victor Gu <xigu@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>, Hua Jing <jinghua@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 04, 2018 at 03:25:24PM +0200, Gregory CLEMENT wrote:
> Extend the documentation of the Armada 37xx SoC with the Adaptive Voltage
> Scaling (AVS) registers.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Changelog:
> v1 -> v2:
>  - Add Acked-by: from Viresh Kumar
>  - Add the dt mailing list in copy
> 
>  .../bindings/arm/marvell/armada-37xx.txt         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
