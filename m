Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848912;
	b=Jclye8jrFIZyCVUye76fcFXVKlmdoAPeLr4rS8CKCxCOt5rFi2IddkWHuXk9iRTSwZqM
	 S/rLenZ/IkbjkOQ4eBiYQBv4RkWom6XR/8eHoiSDaF/ETz6fhRYriJNbBiSiZZmcKQGC1
	 sIimZPUJ9wo9Gj/gHH3oxsMM6eCRGefMYvNZX0QMcnashheVNy5gtevGdbdeH2v4GEnwI
	 bedyhR2I7l1MUr1vnwiHeDoVmJpIIgNC9qUMqpXG2OdAfQnLXE6YjMN1cUa47QytSftyX
	 kCkAQ5NJxCBRcr+D5sWF1E1EC+VGofX+9Hlfh+2Jd+DtSj06P9bOE5J8pKGe61SDrVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848912;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/riHJRVfpeFF3lEWpcDxMeiJkRBbWV257yieeWQx1Gc=;
	b=stEfvHeeavjXKyOfIWi1azWEBC3bYNqMeL0LxWKuyNaoUquzwqkDbpAW1h6b//OakImw
	 gwq6nUS3t0m8oUGUy/o6oCrpok8/aKqGRtcw6EJfzDly7DInwsRUISWby76PJdtttKtuu
	 kGPDNZMGDdMgJqZhnV1DCirJLyLtVdvS1Bw8A17/YwckSzC3osMRfJJg7q2sgWOhNHMZ9
	 1RYxUvfVtABg/mytcxH1CbW4ZmzAYCcfzuvtQMzF/0eydeEhG6O0kulYMudUHepdLrtxh
	 8DvAvZboUptjhd+kpu/oNExKm8UD0r/9uQknTeFzXhEYExbeYStJHTKOYINc0o3rtMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=ryP3PSsC;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669B606A323;
	Mon, 16 Nov 2026 17:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A669B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=ryP3PSsC
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A62E4BB;
	Mon, 16 Nov 2026 18:06:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794848762;
	bh=i1L4omYxVrpbv7tl1oB63F8nQWZdj/N4NtLRNEREMbM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ryP3PSsCUhv1pL6BZ3Q6bO5M7LHBGrxi/86py2Z6pPBDfsp1kTOXbi3twJQGrxSwR
	 UcgywHSKLGWh32FcgShkpKDXIgINg1GsDBsSyLUZG0q0c12t6mVTd5T4FA14tsS2Zh
	 t3hMpbS7wQaFQCOfNNcqK5foGeTdkMMuX3oOw7mU=
Message-ID: <110c2c49-1b65-4c39-a122-c454bc7fea2e@ideasonboard.com>
Date: Mon, 16 Nov 2026 19:08:25 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: core: Add genpd_dev_pm_attach_by_node()
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261023-pm_attach_by_node-v1-1-4dbaccdf8b0e@ideasonboard.com>
 <af65c273-70c5-4926-96e7-ab1089503286@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <af65c273-70c5-4926-96e7-ab1089503286@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi again,

On 10/11/2026 15:58, Tomi Valkeinen wrote:
> Hi,
> 
> On 23/10/2026 21:16, Tomi Valkeinen wrote:
>> genpd_dev_pm_attach_by_id() and genpd_dev_pm_attach_by_name() attach a
>> virtual device to a PM domain listed in the OF node of the passed
>> device.
>>
>> Some hardware blocks are described in a child node of a main device.
>> They have no device of their own, but they do have a PM domain of their
>> own. Neither function can attach that domain, as both parse only the OF
>> node of the device.
>>
>> An example case is TI's display subsystem and its OLDI (LVDS)
>> transmitters:
>>
>> dss@30200000 {
>>      power-domains = <...>;
>>
>>      oldi-transmitters {
>>          oldi@0 {
>>              power-domains = <...>;
>>          };
>>
>>          oldi@1 {
>>              power-domains = <...>;
>>          };
>>      };
>> };
>>
>> The OLDI TX blocks are not part of the DSS IP, but they are not quite
>> real devices either as they don't have registers of their own, and are
>> instead controlled via DSS registers.
>>
>> Add genpd_dev_pm_attach_by_node(), which is similar to
>> genpd_dev_pm_attach_by_id() but instead of looking for the power-domains
>> from the passed device's DT node, the DT node is passed explicitly. Also
>> add a matching wrapper function dev_pm_domain_attach_by_node().
> 
> Ping, any thoughts on this?

One more thing, if this change is ok, I'd like to somehow synchronize 
merging this with the display side patches, as it's a compile time 
dependency.

The easiest, at least to me, would be to merge this (with an ack from 
the relevant maintainers) along the display patches, via drm-misc-next.

  Tomi

> 
>   Tomi
> 
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
>> This is a new try for managing the OLDI power domains. Previously I
>> tried using auxiliary device/driver for OLDIs, and handling the PDs the
>> normal way:
>>
>> https://lore.kernel.org/all/20260529-beagley-ai-display- 
>> v3-12-7fefdc5d1adf%40ideasonboard.com/
>>
>> Then I realized an issue, mentioned in
>> Documentation/driver-api/driver-model/driver.rst: "-EPROBE_DEFER must
>> not be returned if probe() has already created child devices".
>>
>> The PD virtual devices used in this patch's approach do not hit the
>> issue as they don't get a driver, so they are not probed. The tidss
>> driver's OLDI part can then use normal pm_runtime_get/put functions to
>> manage the OLDI PDs.
>> ---
>>   drivers/base/power/common.c | 27 +++++++++++++
>>   drivers/pmdomain/core.c     | 97 ++++++++++++++++++++++++++++++++ 
>> +------------
>>   include/linux/pm_domain.h   | 19 +++++++++
>>   3 files changed, 117 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
>> index 9bef9248a705..a873541f9350 100644
>> --- a/drivers/base/power/common.c
>> +++ b/drivers/base/power/common.c
>> @@ -171,6 +171,33 @@ struct device 
>> *dev_pm_domain_attach_by_name(struct device *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_name);
>> +/**
>> + * dev_pm_domain_attach_by_node - Associate a device with a PM domain 
>> of a DT
>> + *                  node.
>> + * @dev: The device that uses the PM domain.
>> + * @np: The DT node with the PM domain.
>> + * @index: The index of the PM domain in @np.
>> + *
>> + * Like dev_pm_domain_attach_by_id(), but the PM domain is looked up
>> + * in @np instead of the OF node of @dev.
>> + *
>> + * Unlike dev_pm_domain_attach_by_id(), @dev may already be attached 
>> to a PM
>> + * domain of its own. The driver controls the power to the PM domain 
>> through
>> + * runtime PM of the returned virtual device, or through a device 
>> link to it.
>> + *
>> + * Returns the virtual created device when successfully attached to 
>> its PM
>> + * domain, NULL in case @np has no PM domain at @index, else an 
>> ERR_PTR().
>> + * Note that, to detach the returned virtual device, the driver shall 
>> call
>> + * dev_pm_domain_detach() on it, typically during the remove phase.
>> + */
>> +struct device *dev_pm_domain_attach_by_node(struct device *dev,
>> +                        struct device_node *np,
>> +                        unsigned int index)
>> +{
>> +    return genpd_dev_pm_attach_by_node(dev, np, index);
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_node);
>> +
>>   /**
>>    * dev_pm_domain_attach_list - Associate a device with its PM domains.
>>    * @dev: The device used to lookup the PM domains for.
>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>> index 052ec478dfcc..327fbd40c854 100644
>> --- a/drivers/pmdomain/core.c
>> +++ b/drivers/pmdomain/core.c
>> @@ -3462,34 +3462,16 @@ int genpd_dev_pm_attach(struct device *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>> -/**
>> - * genpd_dev_pm_attach_by_id - Associate a device with one of its PM 
>> domains.
>> - * @dev: The device used to lookup the PM domain.
>> - * @index: The index of the PM domain.
>> - *
>> - * Parse device's OF node to find a PM domain specifier at the 
>> provided @index.
>> - * If such is found, creates a virtual device and attaches it to the 
>> retrieved
>> - * pm_domain ops. To deal with detaching of the virtual device, the - 
>> >detach()
>> - * callback in the struct dev_pm_domain are assigned to 
>> genpd_dev_pm_detach().
>> - *
>> - * Returns the created virtual device if successfully attached PM 
>> domain, NULL
>> - * when the device don't need a PM domain, else an ERR_PTR() in case of
>> - * failures. If a power-domain exists for the device, but cannot be 
>> found or
>> - * turned on, then ERR_PTR(-EPROBE_DEFER) is returned to ensure that 
>> the device
>> - * is not probed and to re-try again later.
>> - */
>> -struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>> -                     unsigned int index)
>> +static struct device *genpd_dev_pm_attach_virt(struct device *dev,
>> +                           struct device_node *np,
>> +                           unsigned int index)
>>   {
>>       struct device *virt_dev;
>>       int num_domains;
>>       int ret;
>> -    if (!dev->of_node)
>> -        return NULL;
>> -
>>       /* Verify that the index is within a valid range. */
>> -    num_domains = of_count_phandle_with_args(dev->of_node, "power- 
>> domains",
>> +    num_domains = of_count_phandle_with_args(np, "power-domains",
>>                            "#power-domain-cells");
>>       if (num_domains < 0 || index >= num_domains)
>>           return NULL;
>> @@ -3502,10 +3484,14 @@ struct device 
>> *genpd_dev_pm_attach_by_id(struct device *dev,
>>       if (!virt_dev)
>>           return ERR_PTR(-ENOMEM);
>> -    dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
>> +    if (np == dev->of_node)
>> +        dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
>> +    else
>> +        dev_set_name(virt_dev, "genpd:%u:%s:%pOFP", index,
>> +                 dev_name(dev), np);
>>       virt_dev->bus = &genpd_bus_type;
>>       virt_dev->release = genpd_release_dev;
>> -    virt_dev->of_node = of_node_get(dev->of_node);
>> +    virt_dev->of_node = of_node_get(np);
>>       ret = device_register(virt_dev);
>>       if (ret) {
>> @@ -3513,8 +3499,13 @@ struct device *genpd_dev_pm_attach_by_id(struct 
>> device *dev,
>>           return ERR_PTR(ret);
>>       }
>> -    /* Try to attach the device to the PM domain at the specified 
>> index. */
>> -    ret = __genpd_dev_pm_attach(virt_dev, dev, index, num_domains, 
>> false);
>> +    /*
>> +     * Try to attach the device to the PM domain at the specified index.
>> +     * Pass 0 as the num_domains when np != dev->of_node, so that the 
>> dev's
>> +     * required OPPs are not used for the PD.
>> +     */
>> +    ret = __genpd_dev_pm_attach(virt_dev, dev, index,
>> +                    np == dev->of_node ? num_domains : 0, false);
>>       if (ret < 1) {
>>           device_unregister(virt_dev);
>>           return ret ? ERR_PTR(ret) : NULL;
>> @@ -3525,8 +3516,62 @@ struct device *genpd_dev_pm_attach_by_id(struct 
>> device *dev,
>>       return virt_dev;
>>   }
>> +
>> +/**
>> + * genpd_dev_pm_attach_by_id - Associate a device with one of its PM 
>> domains.
>> + * @dev: The device used to lookup the PM domain.
>> + * @index: The index of the PM domain.
>> + *
>> + * Parse device's OF node to find a PM domain specifier at the 
>> provided @index.
>> + * If such is found, creates a virtual device and attaches it to the 
>> retrieved
>> + * pm_domain ops. To deal with detaching of the virtual device, the - 
>> >detach()
>> + * callback in the struct dev_pm_domain are assigned to 
>> genpd_dev_pm_detach().
>> + *
>> + * Returns the created virtual device if successfully attached PM 
>> domain, NULL
>> + * when the device don't need a PM domain, else an ERR_PTR() in case of
>> + * failures. If a power-domain exists for the device, but cannot be 
>> found or
>> + * turned on, then ERR_PTR(-EPROBE_DEFER) is returned to ensure that 
>> the device
>> + * is not probed and to re-try again later.
>> + */
>> +struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>> +                     unsigned int index)
>> +{
>> +    if (!dev->of_node)
>> +        return NULL;
>> +
>> +    return genpd_dev_pm_attach_virt(dev, dev->of_node, index);
>> +}
>>   EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
>> +/**
>> + * genpd_dev_pm_attach_by_node - Associate a device with a PM domain 
>> of a DT
>> + *                 node.
>> + * @dev: The device that uses the PM domain.
>> + * @np: The DT node with the PM domain.
>> + * @index: The index of the PM domain in @np.
>> + *
>> + * Like genpd_dev_pm_attach_by_id(), but the PM domain is looked up in
>> + * @np instead of the OF node of @dev.
>> + *
>> + * The virtual device is named after @dev and @np. The required OPPs 
>> of @dev are
>> + * not linked to the PM domain.
>> + *
>> + * Returns the created virtual device if successfully attached PM 
>> domain, NULL
>> + * when @np has no PM domain at @index, else an ERR_PTR() in case of 
>> failures.
>> + * If the PM domain exists, but cannot be found or turned on, then
>> + * ERR_PTR(-EPROBE_DEFER) is returned.
>> + */
>> +struct device *genpd_dev_pm_attach_by_node(struct device *dev,
>> +                       struct device_node *np,
>> +                       unsigned int index)
>> +{
>> +    if (!np)
>> +        return NULL;
>> +
>> +    return genpd_dev_pm_attach_virt(dev, np, index);
>> +}
>> +EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_node);
>> +
>>   /**
>>    * genpd_dev_pm_attach_by_name - Associate a device with one of its 
>> PM domains.
>>    * @dev: The device used to lookup the PM domain.
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index f925614aebdb..c38c90d63c02 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -477,6 +477,9 @@ struct device *genpd_dev_pm_attach_by_id(struct 
>> device *dev,
>>                        unsigned int index);
>>   struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>>                          const char *name);
>> +struct device *genpd_dev_pm_attach_by_node(struct device *dev,
>> +                       struct device_node *np,
>> +                       unsigned int index);
>>   #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>>   static inline int of_genpd_add_provider_simple(struct device_node *np,
>>                       struct generic_pm_domain *genpd)
>> @@ -535,6 +538,13 @@ static inline struct device 
>> *genpd_dev_pm_attach_by_name(struct device *dev,
>>       return NULL;
>>   }
>> +static inline struct device *genpd_dev_pm_attach_by_node(struct 
>> device *dev,
>> +                             struct device_node *np,
>> +                             unsigned int index)
>> +{
>> +    return NULL;
>> +}
>> +
>>   static inline
>>   struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>>   {
>> @@ -560,6 +570,9 @@ struct device *dev_pm_domain_attach_by_id(struct 
>> device *dev,
>>                         unsigned int index);
>>   struct device *dev_pm_domain_attach_by_name(struct device *dev,
>>                           const char *name);
>> +struct device *dev_pm_domain_attach_by_node(struct device *dev,
>> +                        struct device_node *np,
>> +                        unsigned int index);
>>   int dev_pm_domain_attach_list(struct device *dev,
>>                     const struct dev_pm_domain_attach_data *data,
>>                     struct dev_pm_domain_list **list);
>> @@ -586,6 +599,12 @@ static inline struct device 
>> *dev_pm_domain_attach_by_name(struct device *dev,
>>   {
>>       return NULL;
>>   }
>> +static inline struct device *dev_pm_domain_attach_by_node(struct 
>> device *dev,
>> +                              struct device_node *np,
>> +                              unsigned int index)
>> +{
>> +    return NULL;
>> +}
>>   static inline int dev_pm_domain_attach_list(struct device *dev,
>>                   const struct dev_pm_domain_attach_data *data,
>>                   struct dev_pm_domain_list **list)
>>
>> ---
>> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
>> change-id: 20261023-pm_attach_by_node-13788662f3a1
>>
>> Best regards,
>> -- 
>> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>
> 

