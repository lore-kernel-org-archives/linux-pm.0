From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v3 01/18] dt-bindings: power: battery: add
 constant-charge-current property
Date: Tue, 14 Feb 2017 16:46:46 -0800
Message-ID: <20170215004646.23607-1-liam@networkimprov.net>
References: <20170214094112.27426-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170214094112.27426-2-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, bonbons@linux-vserver.org, icenowy@aosc.xyz, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


On Tue, 14 Feb 2017 10:40:55 +0100 Quentin Schulz wrote:
> This adds the constant-charge-current property to the list of optional
> properties of the battery.
>
> The constant charge current is critical for batteries as they can't
> handle all charge currents.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>
> added in v3
>
>  Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++

Is constant-charge-current dependent on the battery (e.g. capacity, nominal voltage, etc) or the 
system (charger chip, input current/voltage, etc)?

It belongs in Doc.../power/supply/battery.txt if it's a characteristic of the battery.

Note, this page asserts that constant-current charging applies to NiMH batteries:
http://power-topics.blogspot.com/2016/05/constant-voltage-constant-current.html

Related properties to be added to battery.txt near-future in a patchset for the BQ24190 
charger are as follows. These are not currently in enum power_supply_property, so the actual names 
are still to be decided.

precharge-current-microamp:
   maximum charge current during precharge phase (typically 20% of battery capacity)

termination-current-microamp (or endcharge-current):
   a charge cycle terminates when the battery voltage is above recharge threshold,
   and the current is below this setting (typically 10% of battery capacity)


~.~
