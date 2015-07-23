From: Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v6 01/13] clk: qcom: Add support for GDSCs
Date: Thu, 23 Jul 2015 12:09:08 +0300
Message-ID: <55B0AF34.2000706@mm-sol.com>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org> <1437549069-29655-2-git-send-email-rnayak@codeaurora.org> <55B03495.8050902@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <55B03495.8050902@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, srinivas.kandagatla@linaro.org, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org

<snip>

>> +
>> +int gdsc_register(struct device *dev, struct gdsc **scs, size_t num,
>> +          struct regmap *regmap)
>> +{
>> +    int i, ret;
>> +    struct genpd_onecell_data *data;
>> +
>> +    data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +    if (!data)
>> +        return -ENOMEM;
>> +
>> +    data->domains = devm_kcalloc(dev, num, sizeof(*data->domains),
>> +                     GFP_KERNEL);
>> +    if (!data->domains)
>> +        return -ENOMEM;
>> +
>> +    data->num_domains = num;
>> +    for (i = 0; i < num; i++) {
>> +        if (!scs[i])
>> +            continue;
>> +        scs[i]->regmap = regmap;
>> +        ret = gdsc_init(scs[i]);
>> +        if (ret)
>> +            return ret;
>> +        data->domains[i] = &scs[i]->pd;
>> +    }
>> +
>> +    return of_genpd_add_provider_onecell(dev->of_node, data);
>> +}
> 
> EXPORT_SYMBOL?
> 
>> +
>> +void gdsc_unregister(struct device *dev)
>> +{
>> +    of_genpd_del_provider(dev->of_node);
>> +}
> 
> EXPORT_SYMBOL?

Stephen, gdsc_register/unregister are internal to the qcom clk driver
why to export them?

-- 
regards,
Stan
