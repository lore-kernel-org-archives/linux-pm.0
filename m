From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v12 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Date: Fri, 14 Dec 2018 09:39:39 +0530
Message-ID: <822086a5-a3ca-f44c-33be-5a51894f39d5@codeaurora.org>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-2-git-send-email-tdas@codeaurora.org>
 <154468968610.19322.9386616050590076502@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154468968610.19322.9386616050590076502@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hello Stephen,

On 12/13/2018 1:58 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-12-12 23:49:53)
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>> new file mode 100644
>> index 0000000..2b82965
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>> @@ -0,0 +1,172 @@
> [...]
>> +- reg-names
>> +       Usage:          Optional
>> +       Value type:     <string>
>> +       Definition:     Frequency domain name i.e.
>> +                       "freq-domain0", "freq-domain1".
>> +
>> +- freq-domain-cells:
> 
> Should be #freq-domain-cells? Or maybe #qcom,freq-domain-cells?
> 

Updated in the next series.

>> +       Usage:          required.
>> +       Definition:     Number of cells in a freqency domain specifier.
>> +
>> +* Property qcom,freq-domain
>> +Devices supporting freq-domain must set their "qcom,freq-domain" property with
>> +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
>> +
>> +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
