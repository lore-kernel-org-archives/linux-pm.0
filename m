Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319124;
	b=tSd0RQ0n2hAR/Zv+UYMs6oOy+EJR0eOdu8uXUJ0anC0hjLNdRO43WNTl40LOYtnJQO4f
	 yJO/AwtCErTUEAxrSDpWI64dibjhggS8XE8dfJV+WyiC2JwaIxuDN7jRvT0UHyj0ZzZvA
	 CAvTktx3oXd7/VOn4jIIVaY+aHoxLruFDwtNi/GQxKLfjEjd5r2orTw5NynKIwIeX3o5i
	 J5MlE8TQgf6/NmSvR8Y8cw33B4ec8USZUUy+ASzPCFvvMm2u0VbsSQnMxORXv5b69tzJO
	 Zv119ZHPQ08IRePety3OBf/llIks+78oTd0DyBm2l7F/cchddG65PuTGA9vJ88earLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319124;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=uHow6QOszXOkN5yF2veB3FufvRHTvXRueei1d1KGbKE=;
	b=K/18VTuIuVDWcEA5tME3Y3NczwxZ5eaeulyLmzf9UFCl3zAwLtEYr99QY3F3lwv6C3Ju
	 1vlCMVPWbAqHI1yYGFUg+B69xKSNEwR2JAEMG6NRl7goT6ZZJRzy/G1r9wb1EDhXeMAax
	 qi6jChszqv4E4P6U4s3wi1glrQO6g6bl+p+TqcXcalwc/kCWj9Qlufr66pPGLRLmjJbSg
	 /dVytv+rFwNKvC3nrSNEhtkrWM6MxB0X/Ha+ciL6mpwphxbKayD4rO6X1fusBcPlqUlNF
	 KVJQFlVDhOxFBSMYjKYv/OQqkV7ectbveafzWNUs9Zv9lAvUqCJi6h6THRf/+raMshQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=nc0YgS1c;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1517606A32A;
	Tue, 10 Nov 2026 13:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1517606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=nc0YgS1c
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07183C14;
	Tue, 10 Nov 2026 14:56:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794318979;
	bh=05nYYjfAerXmMV8VYG5FAo9qX9ncuzGlXQsA8W6/cVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nc0YgS1cBbQ7BEkBdsPxjjSpZNoTpaU+LTTRrA01ep/HVF0W23Qp6D2jUt4GlDtFe
	 QSTUAqTMOc+/x7frGMvxC7+s3AgEDmr+9mmsQ5Qh0vbB2Z5nNsMLwtVmmPJVv4nMsg
	 HX/LpyTCmGUouWIKVqar88lTLX07RK3n05x96k2A=
Message-ID: <af65c273-70c5-4926-96e7-ab1089503286@ideasonboard.com>
Date: Tue, 10 Nov 2026 15:58:37 +0200
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
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261023-pm_attach_by_node-v1-1-4dbaccdf8b0e@ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261023-pm_attach_by_node-v1-1-4dbaccdf8b0e@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 23/10/2026 21:16, Tomi Valkeinen wrote:
> genpd_dev_pm_attach_by_id() and genpd_dev_pm_attach_by_name() attach a
> virtual device to a PM domain listed in the OF node of the passed
> device.
> 
> Some hardware blocks are described in a child node of a main device.
> They have no device of their own, but they do have a PM domain of their
> own. Neither function can attach that domain, as both parse only the OF
> node of the device.
> 
> An example case is TI's display subsystem and its OLDI (LVDS)
> transmitters:
> 
> dss@30200000 {
>      power-domains = <...>;
> 
>      oldi-transmitters {
>          oldi@0 {
>              power-domains = <...>;
>          };
> 
>          oldi@1 {
>              power-domains = <...>;
>          };
>      };
> };
> 
> The OLDI TX blocks are not part of the DSS IP, but they are not quite
> real devices either as they don't have registers of their own, and are
> instead controlled via DSS registers.
> 
> Add genpd_dev_pm_attach_by_node(), which is similar to
> genpd_dev_pm_attach_by_id() but instead of looking for the power-domains
> from the passed device's DT node, the DT node is passed explicitly. Also
> add a matching wrapper function dev_pm_domain_attach_by_node().

Ping, any thoughts on this?

  Tomi

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> This is a new try for managing the OLDI power domains. Previously I
> tried using auxiliary device/driver for OLDIs, and handling the PDs the
> normal way:
> 
> https://lore.kernel.org/all/20260529-beagley-ai-display-v3-12-7fefdc5d1adf%40ideasonboard.com/
> 
> Then I realized an issue, mentioned in
> Documentation/driver-api/driver-model/driver.rst: "-EPROBE_DEFER must
> not be returned if probe() has already created child devices".
> 
> The PD virtual devices used in this patch's approach do not hit the
> issue as they don't get a driver, so they are not probed. The tidss
> driver's OLDI part can then use normal pm_runtime_get/put functions to
> manage the OLDI PDs.
> ---
>   drivers/base/power/common.c | 27 +++++++++++++
>   drivers/pmdomain/core.c     | 97 +++++++++++++++++++++++++++++++++------------
>   include/linux/pm_domain.h   | 19 +++++++++
>   3 files changed, 117 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 9bef9248a705..a873541f9350 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -171,6 +171,33 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_name);
>   
> +/**
> + * dev_pm_domain_attach_by_node - Associate a device with a PM domain of a DT
> + *				  node.
> + * @dev: The device that uses the PM domain.
> + * @np: The DT node with the PM domain.
> + * @index: The index of the PM domain in @np.
> + *
> + * Like dev_pm_domain_attach_by_id(), but the PM domain is looked up
> + * in @np instead of the OF node of @dev.
> + *
> + * Unlike dev_pm_domain_attach_by_id(), @dev may already be attached to a PM
> + * domain of its own. The driver controls the power to the PM domain through
> + * runtime PM of the returned virtual device, or through a device link to it.
> + *
> + * Returns the virtual created device when successfully attached to its PM
> + * domain, NULL in case @np has no PM domain at @index, else an ERR_PTR().
> + * Note that, to detach the returned virtual device, the driver shall call
> + * dev_pm_domain_detach() on it, typically during the remove phase.
> + */
> +struct device *dev_pm_domain_attach_by_node(struct device *dev,
> +					    struct device_node *np,
> +					    unsigned int index)
> +{
> +	return genpd_dev_pm_attach_by_node(dev, np, index);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_node);
> +
>   /**
>    * dev_pm_domain_attach_list - Associate a device with its PM domains.
>    * @dev: The device used to lookup the PM domains for.
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 052ec478dfcc..327fbd40c854 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3462,34 +3462,16 @@ int genpd_dev_pm_attach(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>   
> -/**
> - * genpd_dev_pm_attach_by_id - Associate a device with one of its PM domains.
> - * @dev: The device used to lookup the PM domain.
> - * @index: The index of the PM domain.
> - *
> - * Parse device's OF node to find a PM domain specifier at the provided @index.
> - * If such is found, creates a virtual device and attaches it to the retrieved
> - * pm_domain ops. To deal with detaching of the virtual device, the ->detach()
> - * callback in the struct dev_pm_domain are assigned to genpd_dev_pm_detach().
> - *
> - * Returns the created virtual device if successfully attached PM domain, NULL
> - * when the device don't need a PM domain, else an ERR_PTR() in case of
> - * failures. If a power-domain exists for the device, but cannot be found or
> - * turned on, then ERR_PTR(-EPROBE_DEFER) is returned to ensure that the device
> - * is not probed and to re-try again later.
> - */
> -struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> -					 unsigned int index)
> +static struct device *genpd_dev_pm_attach_virt(struct device *dev,
> +					       struct device_node *np,
> +					       unsigned int index)
>   {
>   	struct device *virt_dev;
>   	int num_domains;
>   	int ret;
>   
> -	if (!dev->of_node)
> -		return NULL;
> -
>   	/* Verify that the index is within a valid range. */
> -	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
> +	num_domains = of_count_phandle_with_args(np, "power-domains",
>   						 "#power-domain-cells");
>   	if (num_domains < 0 || index >= num_domains)
>   		return NULL;
> @@ -3502,10 +3484,14 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>   	if (!virt_dev)
>   		return ERR_PTR(-ENOMEM);
>   
> -	dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
> +	if (np == dev->of_node)
> +		dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
> +	else
> +		dev_set_name(virt_dev, "genpd:%u:%s:%pOFP", index,
> +			     dev_name(dev), np);
>   	virt_dev->bus = &genpd_bus_type;
>   	virt_dev->release = genpd_release_dev;
> -	virt_dev->of_node = of_node_get(dev->of_node);
> +	virt_dev->of_node = of_node_get(np);
>   
>   	ret = device_register(virt_dev);
>   	if (ret) {
> @@ -3513,8 +3499,13 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>   		return ERR_PTR(ret);
>   	}
>   
> -	/* Try to attach the device to the PM domain at the specified index. */
> -	ret = __genpd_dev_pm_attach(virt_dev, dev, index, num_domains, false);
> +	/*
> +	 * Try to attach the device to the PM domain at the specified index.
> +	 * Pass 0 as the num_domains when np != dev->of_node, so that the dev's
> +	 * required OPPs are not used for the PD.
> +	 */
> +	ret = __genpd_dev_pm_attach(virt_dev, dev, index,
> +				    np == dev->of_node ? num_domains : 0, false);
>   	if (ret < 1) {
>   		device_unregister(virt_dev);
>   		return ret ? ERR_PTR(ret) : NULL;
> @@ -3525,8 +3516,62 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>   
>   	return virt_dev;
>   }
> +
> +/**
> + * genpd_dev_pm_attach_by_id - Associate a device with one of its PM domains.
> + * @dev: The device used to lookup the PM domain.
> + * @index: The index of the PM domain.
> + *
> + * Parse device's OF node to find a PM domain specifier at the provided @index.
> + * If such is found, creates a virtual device and attaches it to the retrieved
> + * pm_domain ops. To deal with detaching of the virtual device, the ->detach()
> + * callback in the struct dev_pm_domain are assigned to genpd_dev_pm_detach().
> + *
> + * Returns the created virtual device if successfully attached PM domain, NULL
> + * when the device don't need a PM domain, else an ERR_PTR() in case of
> + * failures. If a power-domain exists for the device, but cannot be found or
> + * turned on, then ERR_PTR(-EPROBE_DEFER) is returned to ensure that the device
> + * is not probed and to re-try again later.
> + */
> +struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> +					 unsigned int index)
> +{
> +	if (!dev->of_node)
> +		return NULL;
> +
> +	return genpd_dev_pm_attach_virt(dev, dev->of_node, index);
> +}
>   EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
>   
> +/**
> + * genpd_dev_pm_attach_by_node - Associate a device with a PM domain of a DT
> + *				 node.
> + * @dev: The device that uses the PM domain.
> + * @np: The DT node with the PM domain.
> + * @index: The index of the PM domain in @np.
> + *
> + * Like genpd_dev_pm_attach_by_id(), but the PM domain is looked up in
> + * @np instead of the OF node of @dev.
> + *
> + * The virtual device is named after @dev and @np. The required OPPs of @dev are
> + * not linked to the PM domain.
> + *
> + * Returns the created virtual device if successfully attached PM domain, NULL
> + * when @np has no PM domain at @index, else an ERR_PTR() in case of failures.
> + * If the PM domain exists, but cannot be found or turned on, then
> + * ERR_PTR(-EPROBE_DEFER) is returned.
> + */
> +struct device *genpd_dev_pm_attach_by_node(struct device *dev,
> +					   struct device_node *np,
> +					   unsigned int index)
> +{
> +	if (!np)
> +		return NULL;
> +
> +	return genpd_dev_pm_attach_virt(dev, np, index);
> +}
> +EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_node);
> +
>   /**
>    * genpd_dev_pm_attach_by_name - Associate a device with one of its PM domains.
>    * @dev: The device used to lookup the PM domain.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f925614aebdb..c38c90d63c02 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -477,6 +477,9 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>   					 unsigned int index);
>   struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>   					   const char *name);
> +struct device *genpd_dev_pm_attach_by_node(struct device *dev,
> +					   struct device_node *np,
> +					   unsigned int index);
>   #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>   static inline int of_genpd_add_provider_simple(struct device_node *np,
>   					struct generic_pm_domain *genpd)
> @@ -535,6 +538,13 @@ static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>   	return NULL;
>   }
>   
> +static inline struct device *genpd_dev_pm_attach_by_node(struct device *dev,
> +							 struct device_node *np,
> +							 unsigned int index)
> +{
> +	return NULL;
> +}
> +
>   static inline
>   struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>   {
> @@ -560,6 +570,9 @@ struct device *dev_pm_domain_attach_by_id(struct device *dev,
>   					  unsigned int index);
>   struct device *dev_pm_domain_attach_by_name(struct device *dev,
>   					    const char *name);
> +struct device *dev_pm_domain_attach_by_node(struct device *dev,
> +					    struct device_node *np,
> +					    unsigned int index);
>   int dev_pm_domain_attach_list(struct device *dev,
>   			      const struct dev_pm_domain_attach_data *data,
>   			      struct dev_pm_domain_list **list);
> @@ -586,6 +599,12 @@ static inline struct device *dev_pm_domain_attach_by_name(struct device *dev,
>   {
>   	return NULL;
>   }
> +static inline struct device *dev_pm_domain_attach_by_node(struct device *dev,
> +							  struct device_node *np,
> +							  unsigned int index)
> +{
> +	return NULL;
> +}
>   static inline int dev_pm_domain_attach_list(struct device *dev,
>   				const struct dev_pm_domain_attach_data *data,
>   				struct dev_pm_domain_list **list)
> 
> ---
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> change-id: 20261023-pm_attach_by_node-13788662f3a1
> 
> Best regards,
> --
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 

