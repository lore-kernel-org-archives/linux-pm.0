From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 01/18] dt-bindings: power: battery: add
 constant-charge-current property
Date: Wed, 22 Feb 2017 15:25:28 -0600
Message-ID: <20170222212528.vo7fbayactwfzgao@rob-hp-laptop>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux@armlinux.org.uk, wens@csie.org, icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de, maxime.ripard@free-electrons.com, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 14, 2017 at 10:40:55AM +0100, Quentin Schulz wrote:
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
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index d78a4aa..3e830fe 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -7,6 +7,7 @@ Optional Properties:
>   - voltage-min-design-microvolt: drained battery voltage
>   - energy-full-design-microwatt-hours: battery design energy
>   - charge-full-design-microamp-hours: battery design capacity
> + - constant-charge-current-microamp: battery constant charge current

Kind of long, though so are the others. Maybe just 
"constant-charge-microamp" as uA implies current.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
