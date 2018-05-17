From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [v0 1/2] dt-bindings: clock: Introduce QCOM CPUFREQ FW bindings
Date: Thu, 17 May 2018 12:17:01 -0700
Message-ID: <5AFDD52D.2000201@codeaurora.org>
References: <1526549401-25666-1-git-send-email-tdas@codeaurora.org> <1526549401-25666-2-git-send-email-tdas@codeaurora.org> <20180517101438.du7xihojuhjxq77l@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517101438.du7xihojuhjxq77l@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Taniya Das <tdas@codeaurora.org>, robh@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, amit.kucheria@linaro.org
List-Id: linux-pm@vger.kernel.org

On 05/17/2018 03:14 AM, Viresh Kumar wrote:
> + Rob.
>
> On 17-05-18, 15:00, Taniya Das wrote:
>> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
>> SoCs. This is required for managing the cpu frequency transitions which are
>> controlled by firmware.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 68 ++++++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt

Isn't the prefix wrong? Shouldn't it be dt-bindings: cpufreq:?

-Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
