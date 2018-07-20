From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v6 1/8] interconnect: Add generic on-chip interconnect API
Date: Fri, 20 Jul 2018 17:33:10 +0300
Message-ID: <cf2dbddd-1da2-d995-3fc8-b8cab8195a3c@linaro.org>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-2-georgi.djakov@linaro.org>
 <5ccc5117-4fff-b066-1309-139b7e874d0a@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5ccc5117-4fff-b066-1309-139b7e874d0a@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Bailon <abailon@baylibre.com>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mka@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Alexandre,

On 07/11/2018 07:21 PM, Alexandre Bailon wrote:
> On 07/09/2018 05:50 PM, Georgi Djakov wrote:
>> This patch introduces a new API to get requirements and configure the
>> interconnect buses across the entire chipset to fit with the current
>> demand.
>>
>> The API is using a consumer/provider-based model, where the providers are
>> the interconnect buses and the consumers could be various drivers.
>> The consumers request interconnect resources (path) between endpoints and
>> set the desired constraints on this data flow path. The providers receive
>> requests from consumers and aggregate these requests for all master-slave
>> pairs on that path. Then the providers configure each participating in the
>> topology node according to the requested data flow path, physical links and
>> constraints. The topology could be complicated and multi-tiered and is SoC
>> specific.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---

[..]

>> +static int apply_constraints(struct icc_path *path)
>> +{
>> +	struct icc_node *next, *prev = NULL;
>> +	int ret;
>> +	int i;
>> +
>> +	for (i = 0; i < path->num_nodes; i++, prev = next) {
>> +		struct icc_provider *p;
>> +
>> +		next = path->reqs[i].node;
>> +		/*
>> +		 * Both endpoints should be valid master-slave pairs of the
>> +		 * same interconnect provider that will be configured.
>> +		 */
>> +		if (!prev || next->provider != prev->provider)
>> +			continue;
>> +
>> +		p = next->provider;
>> +
>> +		aggregate_provider(p);
>> +
>> +		/* set the constraints */
>> +		ret = p->set(prev, next, p->avg_bw, p->peak_bw);
> I'm confuse here.
> In path_init(), the first reqs' node takes the node.
> But here, this same element is assigned to prev, which is used as src by
> set(). For me this looks like prev and next have been inverted.

Ok, right. Will change the order of reqs to go from the source to the
destination.

Thanks,
Georgi

>> +		if (ret)
>> +			goto out;
>> +	}
>> +out:
>> +	return ret;
>> +}
>> +
