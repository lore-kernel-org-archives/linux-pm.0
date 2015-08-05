From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v7 01/13] clk: qcom: Add support for GDSCs
Date: Wed, 05 Aug 2015 10:58:15 +0530
Message-ID: <55C19EEF.40505@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org> <1438076046-4706-2-git-send-email-rnayak@codeaurora.org> <20150731162240.GG6519@usrtlx11787.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150731162240.GG6519@usrtlx11787.corpusers.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: sboyd@codeaurora.org, mturquette@baylibre.com, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

[]..

>> +int gdsc_register(struct device *dev, struct gdsc **scs, size_t num,
>> +		  struct regmap *regmap)
>> +{
>> +	int i, ret;
>> +	struct genpd_onecell_data *data;
>> +
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->domains = devm_kcalloc(dev, num, sizeof(*data->domains),
>> +				     GFP_KERNEL);
>> +	if (!data->domains)
>> +		return -ENOMEM;
>> +
>> +	data->num_domains = num;
>> +	for (i = 0; i < num; i++) {
>> +		if (!scs[i])
>> +			continue;
>> +		scs[i]->regmap = regmap;
>> +		ret = gdsc_init(scs[i]);
>> +		if (ret)
>> +			return ret;
>
> By this time we have disabled the HW control and here we just leave it
> as that, do you expect any interesting consequences of this?
> Or do we just not care (this shouldn't happen anyways).

The only cases where this could happen are when the regmap apis fail,
which ideally should not if the data passed is correct. Besides if
regmap apis do end up failing, the one which disables HW control would
probably fail as well?

>
>> +		data->domains[i] = &scs[i]->pd;
>> +	}
>> +
>> +	return of_genpd_add_provider_onecell(dev->of_node, data);
>> +}
>> +
>> +void gdsc_unregister(struct device *dev)
>> +{
>> +	of_genpd_del_provider(dev->of_node);
>> +}
>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> [..]
>> +#ifdef CONFIG_QCOM_GDSC
>> +int gdsc_register(struct device *, struct gdsc **, size_t n, struct regmap *);
>> +void gdsc_unregister(struct device *);
>> +#else
>> +static inline int gdsc_register(struct device *d, struct gdsc **g, size_t n,
>> +				struct regmap *r)
>> +{
>> +	return -ENOSYS;
>
> This will cause qcom_cc_really_probe() to abort and unregister both its
> resets and clocks. I think you should just pretend that everything went
> fine and return 0...

qcom_cc_really_probe() ends up calling gdsc_register() only in cases
there are valid gdscs to be registered..

from drivers/clk/qcom/common.c
--
if (desc->gdscs && desc->num_gdscs)
	gdsc_register(...
--

..in which case I guess its fair to expect the platform with valid gdscs
to be registered has CONFIG_QCOM_GDSC enabled, and pretending everything
went fine might not be the right thing to do?
