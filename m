From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH 3/3] ARM: dts: stm32: add thermal sensor support on
 STM32MP157c
Date: Mon, 3 Dec 2018 10:47:27 +0100
Message-ID: <5feb7b44-aff0-1d53-bdf6-79e06dcb3a2f@st.com>
References: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
 <1538734081-26585-4-git-send-email-david.hernandezsanchez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1538734081-26585-4-git-send-email-david.hernandezsanchez@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi David,

On 10/5/18 12:08 PM, David HERNANDEZ SANCHEZ wrote:
> Add configuration on DT for thermal sensor driver
> 
> Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi 
> b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 661be94..e90b9f6 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -84,6 +84,31 @@

Applied on stm32-next.

Thanks.
Alex
