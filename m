From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v10 3/7] interconnect: Allow endpoints translation via DT
Date: Wed, 5 Dec 2018 17:59:34 +0200
Message-ID: <5590be39-de5a-f962-3d6f-835552e5956f@linaro.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-4-georgi.djakov@linaro.org>
 <CAE=gft5Z7-Ri07iZesq57bqLpsStvJF3y_TSm+Cz=h-pGqJzyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft5Z7-Ri07iZesq57bqLpsStvJF3y_TSm+Cz=h-pGqJzyw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>, maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Evan,

On 12/1/18 02:38, Evan Green wrote:
> On Tue, Nov 27, 2018 at 10:04 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> Currently we support only platform data for specifying the interconnect
>> endpoints. As now the endpoints are hard-coded into the consumer driver
>> this may lead to complications when a single driver is used by multiple
>> SoCs, which may have different interconnect topology.
>> To avoid cluttering the consumer drivers, introduce a translation function
>> to help us get the board specific interconnect data from device-tree.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/interconnect/core.c           | 156 ++++++++++++++++++++++++++
>>  include/linux/interconnect-provider.h |  17 +++
>>  include/linux/interconnect.h          |   7 ++
>>  3 files changed, 180 insertions(+)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index 3ae8e5a58969..ebc42ef9fa46 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>>  #include <linux/slab.h>
>> +#include <linux/of.h>
>>  #include <linux/overflow.h>
>>
>>  static DEFINE_IDR(icc_idr);
>> @@ -193,6 +194,159 @@ static int apply_constraints(struct icc_path *path)
>>         return ret;
>>  }
>>
>> +/* of_icc_xlate_onecell() - Xlate function using a single index.
> 
> It would be nice if translate were spelled out instead of xlate in the
> description portion (throughout).

Ok, done.

>> + * @spec: OF phandle args to map into an interconnect node.
>> + * @data: private data (pointer to struct icc_onecell_data)
>> + *
>> + * This is a generic xlate function that can be used to model simple
>> + * interconnect providers that have one device tree node and provide
>> + * multiple interconnect nodes. A single cell is used as an index into
>> + * an array of icc nodes specified in the icc_onecell_data struct when
>> + * registering the provider.
>> + */
[..]
>> +/**
>> + * of_icc_get() - get a path handle from a DT node based on name
>> + * @dev: device pointer for the consumer device
>> + * @name: interconnect path name
>> + *
>> + * This function will search for a path two endpoints and return an
> 
> path between two endpoints
> 

Ok.

>> + * icc_path handle on success. Use icc_put() to release constraints when
>> + * they are not needed anymore.
>> + * If the interconnect API is disabled, NULL is returned and the consumer
>> + * drivers will still build. Drivers are free to handle this specifically,
>> + * but they don't have to. NULL is also returned when the "interconnects"
> 
> I'm not sure the sentence starting with "Drivers are free" adds much.
> Also, you mention that null is returned when the interconnect API is
> disabled both above and below. We probably only need it once.
> 

So it depends on the driver how to handle it. If an enabled interconnect
is a hard requirement for a driver to work, it can choose to fail. If it
is optional, the driver can succeed and continue and all bandwidth
requests will be silently ignored.

>> + * DT property is missing.
>> + *
>> + * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
>> + * when the API is disabled or the "interconnects" DT property is missing.
>> + */
>> +struct icc_path *of_icc_get(struct device *dev, const char *name)
>> +{
>> +       struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
>> +       struct icc_node *src_node, *dst_node;
>> +       struct device_node *np = NULL;
>> +       struct of_phandle_args src_args, dst_args;
>> +       int idx = 0;
>> +       int ret;
>> +
>> +       if (!dev || !dev->of_node)
>> +               return ERR_PTR(-ENODEV);
>> +
>> +       np = dev->of_node;
>> +
>> +       /*
>> +        * When the consumer DT node do not have "interconnects" property
>> +        * return a NULL path to skip setting constraints.
>> +        */
>> +       if (!of_find_property(np, "interconnects", NULL))
>> +               return NULL;
>> +
>> +       /*
>> +        * We use a combination of phandle and specifier for endpoint. For now
>> +        * lets support only global ids and extend this is the future if needed
> 
> s/is the future/in the future/

Ok.

>> +        * without breaking DT compatibility.
>> +        */
>> +       if (name) {
>> +               idx = of_property_match_string(np, "interconnect-names", name);
>> +               if (idx < 0)
>> +                       return ERR_PTR(idx);
>> +       }
>> +
>> +       ret = of_parse_phandle_with_args(np, "interconnects",
>> +                                        "#interconnect-cells", idx * 2,
>> +                                        &src_args);
>> +       if (ret)
>> +               return ERR_PTR(ret);
>> +
>> +       of_node_put(src_args.np);
>> +
>> +       if (!src_args.args_count || src_args.args_count > 1)
> 
> This could be src_args.argc_count != 1
> 
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       ret = of_parse_phandle_with_args(np, "interconnects",
>> +                                        "#interconnect-cells", idx * 2 + 1,
>> +                                        &dst_args);
>> +       if (ret)
>> +               return ERR_PTR(ret);
>> +
>> +       of_node_put(dst_args.np);
>> +
>> +       if (!dst_args.args_count || dst_args.args_count > 1)
> 
> Similarly, this could be dst_args.args_count != 1

Yes, and actually it might be even better if i move these checks to
of_icc_get_from_provider().

>> +               return ERR_PTR(-EINVAL);
>> +
>> +       src_node = of_icc_get_from_provider(&src_args);
>> +
>> +       if (IS_ERR(src_node)) {
>> +               if (PTR_ERR(src_node) != -EPROBE_DEFER)
>> +                       dev_err(dev, "error finding src node: %ld\n",
>> +                               PTR_ERR(src_node));
>> +               return ERR_CAST(src_node);
>> +       }
>> +
>> +       dst_node = of_icc_get_from_provider(&dst_args);
>> +
[..]>
> With these nits fixed:
> 
> Reviewed-by: Evan Green <evgreen@chromium.org>
> 

Thanks,
Georgi
