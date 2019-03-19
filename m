From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] dt-bindings: hwmon (pwm-fan) Remove dead
 "cooling-*-state" properties
Date: Tue, 19 Mar 2019 16:06:27 +0100
Message-ID: <CAJKOXPd12YPvL61nu0TDWze4pBuQK=KbJCrc5wh-tACsRQt37g@mail.gmail.com>
References: <afde4ebd929821d63b5172c8e70e15f0725a4b49.1553006788.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <afde4ebd929821d63b5172c8e70e15f0725a4b49.1553006788.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, jdelvare@suse.com, heiko@sntech.de, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, jonathanh@nvidia.com, thierry.reding@gmail.com, kgene@kernel.org, shawnguo@kernel.org, linux@roeck-us.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, 19 Mar 2019 at 15:54, Robin Murphy <robin.murphy@arm.com> wrote:
>
> The old "cooling-{min,max}-state" properties for thermal bindings were
> ratified to "cooling-{min,max}-level" by commit eb168b70dea5 ("of:
> thermal: Fix inconsitency between cooling-*-state and cooling-*-level"),
> which were later removed entirely by commit e04907dbc259 ("dt-bindings:
> thermal: Remove "cooling-{min|max}-level" properties").
>
> The pwm-fan binding, however, was apparently in-flight in parallel with
> that ratification, and so managed to introduce an example of the old
> properties which escaped the scope of the later cleanup and has thus
> continued to be dutifully copied for new boards despite being useless.
> Clean up these remaining undocumented anachronisms to minimise any
> further confusion.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Presented as one big hwmon patch for simplicity, but the DT changes
> can quite easily be broken out by platform if maintainers prefer.
>
> Robin.
>
>  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 2 --
>  arch/arm/boot/dts/exynos4412-odroidu3.dts           | 2 --
>  arch/arm/boot/dts/exynos5410-odroidxu.dts           | 2 --
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 2 --

Probably you should send it directly to arm-soc maintainers so it
would go with other DT changes. In such case:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

>  arch/arm/boot/dts/imx6qdl-emcon.dtsi                | 2 --
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts  | 2 --
>  arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi       | 2 --
>  arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi       | 2 --
>  8 files changed, 16 deletions(-)
>
