From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
Date: Mon, 5 Mar 2018 22:11:12 +0100
Message-ID: <e6c78c81-f18d-c811-925d-5b1dd427fb65@linaro.org>
References: <cover.1520274879.git.amit.kucheria@linaro.org>
 <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, devicetree@vger.kernel.org
Cc: Ram Chandrasekar <rkumbako@codeaurora.org>, ilina@codeaurora.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05/03/2018 19:36, Amit Kucheria wrote:
> From: Ram Chandrasekar <rkumbako@codeaurora.org>
> 
> There is currently no way for the governor to be selected for each thermal
> zone in devicetree. This results in the default governor being used for all
> thermal zones even though no such restriction exists in the core code.
> 
> Add support for specifying the thermal governor to be used for a thermal
> zone in the devicetree. The devicetree config should specify the governor
> name as a string that matches any available governors. If not specified, we
> maintain the current behaviour of using the default governor.
> 
> Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Why not create a kernel parameter (eg. thermal.governor=) ? So everyone
can gain benefit of this feature. And in order to specify that from the
DT, add the 'chosen' node and bootargs with the desired kernel parameter?




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
