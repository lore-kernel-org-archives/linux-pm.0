From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v1.1] ARM: multi_v7_defconfig: Enable power sequence for
 Odroid U3
Date: Mon, 9 Jan 2017 13:24:43 -0300
Message-ID: <d8ee24b1-9d6b-e76f-b5ef-71706efbf9e5@osg.samsung.com>
References: <20170107085203.4431-5-krzk@kernel.org>
 <20170107091651.10560-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170107091651.10560-1-krzk@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Chen <peter.chen@nxp.com>, ulf.hansson@linaro.org, Markus Reichl <m.reichl@fivetechno.de>, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org, hverkuil@xs4all.nl, broonie@kernel.org, stern@rowland.harvard.edu, Sylwester Nawrocki <s.nawrocki@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hello Krzysztof,

I think it would had been clearer if the subject prefix was "[PATCH v1.1 4/4]" :)

On 01/07/2017 06:16 AM, Krzysztof Kozlowski wrote:
> Odroid U3 needs a power sequence for lan9730, if it was enabled by
> bootloader.  Also enable the USB3503 HSCI to USB2.0 driver (device
> is present on Odroid U3).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 

Do you think that makes sense to also enable GPIO_SYS for debugging
purposes as you do in patch 3/4?

In any case the patch looks good to me:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
