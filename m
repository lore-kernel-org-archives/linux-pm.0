From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Date: Mon, 28 May 2018 12:59:51 +0530
Message-ID: <ba22b1f2-3a9a-0e23-04ee-74e173c531c1@codeaurora.org>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
 <1526751291-17873-2-git-send-email-tdas@codeaurora.org>
 <20180522193139.GA21623@rob-hp-laptop>
 <20180523054846.zn7gftt6aqyibd26@vireshk-i7>
 <CAL_JsqL7VdSjerOioc5cSOyKAAXJuVnPJqp_WbTtwr11UUxq=A@mail.gmail.com>
 <cba1616d-ad12-599b-4351-3c7240de852a@codeaurora.org>
 <20180524054333.56vga66xrkfuqtkr@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524054333.56vga66xrkfuqtkr@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, Saravana Kannan <skannan@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hello Rob,

Could you please suggest if the below looks okay to be implemented?

On 5/24/2018 11:13 AM, Viresh Kumar wrote:
> On 24-05-18, 10:48, Taniya Das wrote:
>> Hello Rob, Viresh,
>>
>> Thank you for the comments. If I understand correctly, the device tree nodes
>> should look something like the below.
>>
>> Though I am not sure if any vendor name could be associated in the cpu
>> nodes.
> 
> Well Rob said Yes to that I think.
> 
>> Please suggest if my understanding is wrong.
>>
>> cpu@0 {
>> 	qcom,freq-domain = <&freq_domain_table0>;
>> 	…
>> };
>>
>> same follows for cpu 1/2/3
>>
>> cpu@400 {
>> 	qcom,freq-domain = <&freq_domain_table1>;
>> 	…
>> };
>> same follows for cpu 5/6/7
>>
>> freq_domain_table0 : freq_table {
>> 	reg = < >, < >, < > ;
>> 	reg-names = "perf_base", "lut_base", "en_base";
>> };
>>
>> freq_domain_table1 : freq_table {
>> 	reg = < >, < >, < > ;
>> 	reg-names = "perf_base", "lut_base", "en_base";
>> };
> 
> Mostly yes.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
