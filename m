From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] dt-bindings: hwmon (pwm-fan) Remove dead
 "cooling-*-state" properties
Date: Fri, 22 Mar 2019 08:46:33 +0800
Message-ID: <20190322004632.GN12513@dragon>
References: <afde4ebd929821d63b5172c8e70e15f0725a4b49.1553006788.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, jdelvare@suse.com, heiko@sntech.de, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, krzk@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com, kgene@kernel.org, linux@roeck-us.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 19, 2019 at 02:54:04PM +0000, Robin Murphy wrote:
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
>  arch/arm/boot/dts/imx6qdl-emcon.dtsi                | 2 --

Acked-by: Shawn Guo <shawnguo@kernel.org>
