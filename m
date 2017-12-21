From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v5 05/15] devicetree: bindings: Document qcom,hfpll
Date: Thu, 21 Dec 2017 14:56:49 +0530
Message-ID: <dbd699f1-2798-594e-b34f-39510d4e4e60@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-6-git-send-email-sricharan@codeaurora.org>
 <20171220211147.p555i5eest3ycsbc@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171220211147.p555i5eest3ycsbc@rob-hp-laptop>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, david.brown@linaro.org, viresh.kumar@linaro.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 12/21/2017 2:41 AM, Rob Herring wrote:
> On Tue, Dec 19, 2017 at 09:24:50PM +0530, Sricharan R wrote:
>> From: Stephen Boyd <sboyd@codeaurora.org>
>>
>> Adds bindings document for qcom,hfpll instantiated within
>> the Krait processor subsystem as separate register region.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  .../devicetree/bindings/clock/qcom,hfpll.txt       | 46 ++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.txt
> 
> "dt-bindings: " is the preferred subject prefix. Otherwise,
> 

 ok, will update for the next version.

> Reviewed-by: Rob Herring <robh@kernel.org>

 Thanks.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
