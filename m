From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v8 11/13] clk: qcom: gdsc: Use PM clocks to control gdsc
 clocks
Date: Thu, 13 Aug 2015 09:53:23 +0530
Message-ID: <55CC1BBB.5090804@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org> <1438857474-20262-12-git-send-email-rnayak@codeaurora.org> <20150811065224.GA2839@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150811065224.GA2839@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 08/11/2015 12:22 PM, Stephen Boyd wrote:
> On 08/06, Rajendra Nayak wrote:
>> +
>> +static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
>> +{
>> +	int ret, i = 0, j = 0;
>> +	struct gdsc *sc = domain_to_gdsc(domain);
>> +	struct of_phandle_args clkspec;
>> +	struct device_node *np = dev->of_node;
>> +
>> +	if (!sc->clock_count)
>> +		return 0;
>> +
>> +	ret = pm_clk_create(dev);
>> +	if (ret) {
>> +		dev_dbg(dev, "pm_clk_create failed %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	sc->clks = devm_kcalloc(dev, sc->clock_count, sizeof(sc->clks),
>> +				       GFP_KERNEL);
>> +	if (!sc->clks)
>> +		return -ENOMEM;
>> +
>> +	while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
>> +					   &clkspec)) {
>> +		if (match(clkspec.args[0], sc->clocks, sc->clock_count)) {
>
> I'm lost. I was hoping we could just make up a clkspec on the
> stack and pass it over to of_clk_get_from_provider() without
> having to go through the np of the client device.

Sorry, can you elaborate a little more on 'make up a clkspec on
the stack'? I don't seem to be able to figure out.

  The point being
> to avoid forcing this code from knowing about the consumer
> binding or connection name choice for each device. Instead, it

I am not associating connection names but internal clock ids with
the corresponding gdsc. I don;t see how this is forcing the code
to know consumer DT bindings. However, it is forcing the client
device to have all clocks that need to be controlled listed in DT,
which I assume should be the case.

> assumes that it's a #clock-cells=<1> binding and gets the clocks
> by passing the 1 cell data without calling
> of_parse_phandle_with_args().

Yes, the code did assume #clock-cells=<1>, which is what all of
the existing clock controllers used in QCOM SoCs use.

>
> Now, one downside of that approach is that it's DT centric (also
> of_clk_get_from_provider() is not an exported symbol yet). So I'm
> really starting to lean towards exposing __clk_create_clk() (or
> some better named "provider" function) that will allow clk
> providers to turn their clk_hw structure into a struct clk
> pointer. That avoids the DT centric design, and avoids binding
> the provider to the connection ids too.

Again, there are no connection ids used here. I can explore the approach
of associating clk_hw structs to gdscs and avoiding anything to do with
a DT lookup. I seem to however fail to understand why we need this to
have nothing to do with DT though. Do you think the clocks for a given
device which need to be controlled along with the power switch (gdsc)
should *not* be associated/listed within its DT node?
