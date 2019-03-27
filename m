From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dt-bindings: hwmon (pwm-fan) Remove dead
 "cooling-*-state" properties
Date: Wed, 27 Mar 2019 16:17:30 +0000
Message-ID: <14a24871-f22d-a500-8f49-922d0374ddca@arm.com>
References: <afde4ebd929821d63b5172c8e70e15f0725a4b49.1553006788.git.robin.murphy@arm.com>
 <CAJKOXPd12YPvL61nu0TDWze4pBuQK=KbJCrc5wh-tACsRQt37g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJKOXPd12YPvL61nu0TDWze4pBuQK=KbJCrc5wh-tACsRQt37g@mail.gmail.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arnd@arndb.de, olof@lixom.net
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, jdelvare@suse.com, heiko@sntech.de, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, Krzysztof Kozlowski <krzk@kernel.org>, jonathanh@nvidia.com, kgene@kernel.org, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org, linux@roeck-us.net
List-Id: linux-pm@vger.kernel.org

[ +Arnd, Olof ]

On 19/03/2019 15:06, Krzysztof Kozlowski wrote:
> On Tue, 19 Mar 2019 at 15:54, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> The old "cooling-{min,max}-state" properties for thermal bindings were
>> ratified to "cooling-{min,max}-level" by commit eb168b70dea5 ("of:
>> thermal: Fix inconsitency between cooling-*-state and cooling-*-level"),
>> which were later removed entirely by commit e04907dbc259 ("dt-bindings:
>> thermal: Remove "cooling-{min|max}-level" properties").
>>
>> The pwm-fan binding, however, was apparently in-flight in parallel with
>> that ratification, and so managed to introduce an example of the old
>> properties which escaped the scope of the later cleanup and has thus
>> continued to be dutifully copied for new boards despite being useless.
>> Clean up these remaining undocumented anachronisms to minimise any
>> further confusion.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> Presented as one big hwmon patch for simplicity, but the DT changes
>> can quite easily be broken out by platform if maintainers prefer.
>>
>> Robin.
>>
>>   Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 2 --
>>   arch/arm/boot/dts/exynos4412-odroidu3.dts           | 2 --
>>   arch/arm/boot/dts/exynos5410-odroidxu.dts           | 2 --
>>   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 2 --
> 
> Probably you should send it directly to arm-soc maintainers so it
> would go with other DT changes. In such case:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Indeed, it had crossed my mind that routing this through arm-soc might 
make sense - Arnd, Olof, would you agree? And if so, should I resend to 
the arm-soc alias or might you be able to pick it directly?

Thanks to everyone for the acks!

Robin.

> 
> Best regards,
> Krzysztof
> 
>>   arch/arm/boot/dts/imx6qdl-emcon.dtsi                | 2 --
>>   arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts  | 2 --
>>   arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi       | 2 --
>>   arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi       | 2 --
>>   8 files changed, 16 deletions(-)
>>
