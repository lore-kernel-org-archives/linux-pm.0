From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v4 1/7] interconnect: Add generic on-chip interconnect API
Date: Sat, 9 Jun 2018 22:15:41 +0300
Message-ID: <625a529a-ae01-8615-e89b-409a20596806@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-2-georgi.djakov@linaro.org>
 <ffd493a7-8c01-3f6b-074f-b4b67707dc83@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ffd493a7-8c01-3f6b-074f-b4b67707dc83@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Bailon <abailon@baylibre.com>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, skannan@codeaurora.org, seansw@qti.qualcomm.com, khilman@baylibre.com, mturquette@baylibre.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, bjorn.andersson@linaro.org, robh+dt@kernel.org, linux-arm-msm@vger.kernel.org, davidai@quicinc.com, vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Alexandre,

On 8.06.18 г. 18:57, Alexandre Bailon wrote:
> On 03/09/2018 10:09 PM, Georgi Djakov wrote:
>> This patch introduce a new API to get requirements and configure the
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
>>  Documentation/interconnect/interconnect.rst |  96 ++++++
>>  drivers/Kconfig                             |   2 +
>>  drivers/Makefile                            |   1 +
>>  drivers/interconnect/Kconfig                |  10 +
>>  drivers/interconnect/Makefile               |   1 +
>>  drivers/interconnect/core.c                 | 489 ++++++++++++++++++++++++++++
>>  include/linux/interconnect-provider.h       | 109 +++++++
>>  include/linux/interconnect.h                |  40 +++
>>  8 files changed, 748 insertions(+)
>>  create mode 100644 Documentation/interconnect/interconnect.rst
>>  create mode 100644 drivers/interconnect/Kconfig
>>  create mode 100644 drivers/interconnect/Makefile
>>  create mode 100644 drivers/interconnect/core.c
>>  create mode 100644 include/linux/interconnect-provider.h
>>  create mode 100644 include/linux/interconnect.h
>>

[..]

>> +
>> +/**
>> + * icc_link_create() - create a link between two nodes
>> + * @src_id: source node id
> I guess src_id has become node and is not an id anymore,
> so it should be updated.

Yes, absolutely!

>> + * @dst_id: destination node id
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int icc_link_create(struct icc_node *node, const int dst_id)
>> +{

Thanks,
Georgi
