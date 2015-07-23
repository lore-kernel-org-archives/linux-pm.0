From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v6 03/13] clk: qcom: gdsc: Use PM clocks to control gdsc
 clocks
Date: Thu, 23 Jul 2015 14:04:24 +0530
Message-ID: <55B0A710.9080209@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org> <1437549069-29655-4-git-send-email-rnayak@codeaurora.org> <55B03CE9.4050903@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <55B03CE9.4050903@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 07/23/2015 06:31 AM, Stephen Boyd wrote:
> On 07/22/2015 12:10 AM, Rajendra Nayak wrote:
>> @@ -104,6 +105,37 @@ static int gdsc_disable(struct generic_pm_domain
>> *domain)
>>       return gdsc_toggle_logic(sc, false);
>>   }
>> +static int gdsc_attach(struct generic_pm_domain *domain, struct
>> device *dev)
>> +{
>> +    int ret;
>> +    struct gdsc *sc = domain_to_gdsc(domain);
>> +    char **con_id, *con_ids[] = { "core", "iface", NULL };
>
> const?
>
> This is where I get scared of sniffing too much SoC glue. What's to
> enforce the "core", and "iface" naming scheme? What's to enforce there
> being two clocks vs. one? Maybe a better approach would be to use
> of_clk_get() and iterate through all clocks of the device, or to encode
> the clock names in the gdsc structure.

I had the clock names in the gdsc structure in v5. I should probably go
back to having it that way.
