From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v6 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
Date: Fri, 20 Jul 2018 17:55:44 +0300
Message-ID: <3f8fa550-f789-ac04-9d9a-186d596c98f7@linaro.org>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-7-georgi.djakov@linaro.org>
 <8d2fd280-9cd7-f612-b663-ec4bcdd129cb@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8d2fd280-9cd7-f612-b663-ec4bcdd129cb@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Bailon <abailon@baylibre.com>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mka@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Alexandre,

On 07/11/2018 06:42 PM, Alexandre Bailon wrote:
> On 07/09/2018 05:51 PM, Georgi Djakov wrote:
>> Add driver for the Qualcomm interconnect buses found in msm8916 based
>> platforms.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/interconnect/Kconfig        |   5 +
>>  drivers/interconnect/Makefile       |   1 +
>>  drivers/interconnect/qcom/Kconfig   |  10 +
>>  drivers/interconnect/qcom/Makefile  |   2 +
>>  drivers/interconnect/qcom/msm8916.c | 499 ++++++++++++++++++++++++++++
>>  5 files changed, 517 insertions(+)
>>  create mode 100644 drivers/interconnect/qcom/msm8916>>

[..]

>> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst,
>> +			u32 avg, u32 peak)
>> +{
>> +	struct qcom_icc_provider *qp;
>> +	struct qcom_icc_node *qn;
>> +	struct icc_node *node;
>> +	struct icc_provider *provider;
>> +	u64 avg_bw = icc_units_to_bps(avg);
>> +	u64 peak_bw = icc_units_to_bps(peak);
>> +	u64 rate = 0;
>> +	int ret = 0;
>> +
>> +	if (!src)
> NIT: I think that src can't be NULL (there is a if statement to avoid it
> in apply_constraints()).

Yes, true!

Thanks,
Georgi
