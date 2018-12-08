From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v11 5/8] interconnect: qcom: Add sdm845 interconnect
 provider driver
Date: Sat, 8 Dec 2018 02:24:03 +0200
Message-ID: <ee392578-2dbc-7e60-be37-483729e922d1@linaro.org>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
 <20181207152917.4862-6-georgi.djakov@linaro.org>
 <20181207233010.GE14307@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207233010.GE14307@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, dianders@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

Thanks for looking into this.

On 8.12.18 1:30, Matthias Kaehlcke wrote:
> Hi Georgi,
> 
> not a full review, only one thing I just stumbled across:
> 
> On Fri, Dec 07, 2018 at 05:29:14PM +0200, Georgi Djakov wrote:
>> From: David Dai <daidavid1@codeaurora.org>
>>
>> Introduce Qualcomm SDM845 specific provider driver using the
>> interconnect framework.
>>
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  .../bindings/interconnect/qcom,sdm845.txt     |  24 +
>>  drivers/interconnect/Kconfig                  |   5 +
>>  drivers/interconnect/Makefile                 |   1 +
>>  drivers/interconnect/qcom/Kconfig             |  13 +
>>  drivers/interconnect/qcom/Makefile            |   5 +
>>  drivers/interconnect/qcom/sdm845.c            | 836 ++++++++++++++++++
>>  .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
>>  7 files changed, 1027 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>>  create mode 100644 drivers/interconnect/qcom/Kconfig
>>  create mode 100644 drivers/interconnect/qcom/Makefile
>>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
>>
>> ...
>>
>> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
>> new file mode 100644
>> index 000000000000..f594dd6f500f
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/sdm845.c
>>
>> ...
>>
>> +static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
>> +{
>> +	struct qcom_icc_node *qn;
>> +	int ret, i;
>> +
>> +	bcm->addr = cmd_db_read_addr(bcm->name);
>> +	if (!bcm->addr) {
>> +		dev_err(dev, "%s could not find RPMh address\n",
>> +			bcm->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (cmd_db_read_aux_data_len(bcm->name) < sizeof(struct bcm_db)) {
>> +		dev_err(dev, "%s command db missing or partial aux data\n",
>> +			bcm->name);
>> +		return -EINVAL;
>> +	}
> 
> cmd_db_read_aux_data_len() is in the process of being removed, see
> ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in
> cmd_db_read_aux_data()") in arm-soc/for-next
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?h=for-next&id=ed3cafa79ea756be653d22087c017af95ea78a49

Yes, exactly. I have a fix that lives as a separate patch [8/8] and will squash it here.

BR,
Georgi
