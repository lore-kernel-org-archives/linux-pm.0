From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v5 10/15] devicetree: bindings: Document qcom,kpss-gcc
Date: Thu, 21 Dec 2017 14:57:25 +0530
Message-ID: <15a73b8a-796e-cd2a-fb4c-3cb913076887@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-11-git-send-email-sricharan@codeaurora.org>
 <20171220211328.wbhaxcisz6bzxxql@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171220211328.wbhaxcisz6bzxxql@rob-hp-laptop>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 12/21/2017 2:43 AM, Rob Herring wrote:
> On Tue, Dec 19, 2017 at 09:24:55PM +0530, Sricharan R wrote:
>> From: Stephen Boyd <sboyd@codeaurora.org>
>>
>> The ACC and GCC regions present in KPSSv1 contain registers to
>> control clocks and power to each Krait CPU and L2. Documenting
>> the bindings here.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |  7 +++++
>>  .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  | 32 ++++++++++++++++++++++
>>  2 files changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

 Thanks !!

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
