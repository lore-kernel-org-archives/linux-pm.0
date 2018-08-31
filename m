From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1 02/10] dt-bindings: thermal: Fix a typo in
 documentation
Date: Fri, 31 Aug 2018 10:14:20 +0200
Message-ID: <b8083ad2-f98d-9d66-212e-25bd34c9cec7@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <08b528ddc26adcb57539b1ac9d352850d7d80bfb.1533815718.git.amit.kucheria@linaro.org>
 <20180824232423.GD25163@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824232423.GD25163@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 25/08/2018 01:24, Eduardo Valentin wrote:
> On Thu, Aug 09, 2018 at 06:02:34PM +0530, Amit Kucheria wrote:
>> c(1) + x(1) was actually meant to be c(1) * x(1).
>>
>> While we're at it, add some brackets to make it nicer to read.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index cc553f0952c5..751104213d08 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -152,7 +152,7 @@ Optional property:
>>    Elem size: one cell	the sensors listed in the thermal-sensors property.
>>    Elem type: signed	Coefficients defaults to 1, in case this property
>>  			is not specified. A simple linear polynomial is used:
>> -			Z = c0 * x0 + c1 + x1 + ... + c(n-1) * x(n-1) + cn.
>> +			Z = (c0 * x0) + (c1 * x1) + ... + (c(n-1) * x(n-1)) + cn.
> 
> To be honest, I would prefer if this looks like:
> +			Z = c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1) + cn.
> 
> The extra bracketing seams unnecessary confusion

I agree, the brackets don't change the computation ordering, they are
pointless.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
