From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v7 8/8] interconnect: Allow endpoints translation via DT
Date: Thu, 2 Aug 2018 15:07:10 +0300
Message-ID: <3a7bb27a-0609-133b-08e9-8864f1ccc4bc@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-9-georgi.djakov@linaro.org>
 <804925d5927ccb6927b16f7e9a4aa05c@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <804925d5927ccb6927b16f7e9a4aa05c@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: skannan@codeaurora.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Saravana,

On 08/02/2018 01:57 AM, skannan@codeaurora.org wrote:
> On 2018-07-31 09:13, Georgi Djakov wrote:
>> Currently we support only platform data for specifying the interconnect
>> endpoints. As now the endpoints are hard-coded into the consumer driver
>> this may lead to complications when a single driver is used by multiple
>> SoCs, which may have different interconnect topology.
>> To avoid cluttering the consumer drivers, introduce a translation
>> function
>> to help us get the board specific interconnect data from device-tree.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/interconnect/core.c  | 62 ++++++++++++++++++++++++++++++++++++
>>  include/linux/interconnect.h |  7 ++++
>>  2 files changed, 69 insertions(+)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index 9fef180cf77e..d1b6adff0a3d 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
[..]
>> --- a/include/linux/interconnect.h
>> +++ b/include/linux/interconnect.h
>> @@ -17,6 +17,7 @@ struct device;
>>
>>  struct icc_path *icc_get(struct device *dev, const int src_id,
>>               const int dst_id);
>> +struct icc_path *of_icc_get(struct device *dev, const char *name);
>>  void icc_put(struct icc_path *path);
>>  int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>>
>> @@ -28,6 +29,12 @@ static inline struct icc_path *icc_get(struct
>> device *dev, const int src_id,
>>      return NULL;
>>  }
>>
>> +static inline struct icc_path *of_icc_get(struct device *dev,
>> +                      const char *name)
>> +{
>> +    return NULL;
>> +}
>> +
> 
> Might want to return PTR(-ENODEV) or some error code so that client
> doesn't have to do NULL check AND an error check?
> 
> -Saravana

NULL is returned when CONFIG_INTERCONNECT=n. Configuration of
interconnects by consumer drivers could be optional and that's why null
is returned instead of an error. The consumer drivers decide how to
proceed in this case and if there is a hard requirement for interconnect
support, then i would suggest to express it as a dependency in Kconfig.

Thanks,
Georgi
