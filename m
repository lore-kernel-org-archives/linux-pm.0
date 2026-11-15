Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794808994;
	b=47Jf6ltlLUe7DjzJ438WUQCushmymEsft55r5QNf7TOOI9wK0J3+ye/liyrfrTjkdVcK
	 T3HaU5n68ecxaFlV6BXfvc5S3wXVsB3OzAP9B3j6Ets8YhkTbUqoV4EMf4DDODL3tbLI1
	 MNRF7Z3YV9JdT5vj9bpTyHhHlQ/cyL22WYRhFb1oMAxUUxZH9dvIVNWFbjgSq06EerYLd
	 Ueg++miWLwXZj0jvMwHn/k05dtHedp4YtJXe9QAzW+avJkSBfjRRCJ916dQZmeq3py4oh
	 zyVV8ykxfyyXMmy7Gn9DN7AyKbfYejcR+p5MFLEKic1eLzRG2fwpPbNayofv0bXmxWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808994;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=A4kci3d+TKIuwHTaCLLWhGccxriCzQfD42Bpixzod40=;
	b=VkbMYoQsfCQ66J2GZp34MET0gDnYgcS7E88TLU+QjDIYxbuoVJo/Oed1LwrR525db4fe
	 Ic+wbC0F49dtb10/lAOB5h4D8aYwvEB+R+f2CphnB6X5GouLnkcutGHkYwV5+TwlzG9MD
	 3Ps9FPZOIvcnoVjMl24awmjw87tnWDHZuLB/1sx5NYdbhiEZnVu8Dpd/p1/pRmU887dyl
	 S5ta3yhRF4AlC0s6cPjh3Gg6ue9GUgQoi4Zu3/RfDCe8Xi36peL6i/Brs5NhLk5bAqkIk
	 hgDKl+DFrNHY9FMueVwKs6OKkwfrXzQpfWDLSwIuYPPPadT9FF8WQilL9D4cFvbaWSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=YVDXOoC8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA82606A31C;
	Mon, 16 Nov 2026 06:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FA82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=YVDXOoC8
ARC-Seal: i=1; a=rsa-sha256; t=1794808971; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LgLiGoQXZIW99+PQRitTR+n6SfV4b6lRn5mua0be+QfqoQs6wjFOxSIsmUlk95IweRINhUpfVEVmkB+IhX4mxIygP+1iqE92PHRyoyQf7rJZQZQCLs0AxNTnb8/ILy7J0z12Ch4EKlwAJSC74bD77m0/uPeSz2+VAQGHr5Dp6rI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794808971; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A4kci3d+TKIuwHTaCLLWhGccxriCzQfD42Bpixzod40=; 
	b=GjB+nc8ZebrsgXfqN0M5Xk2PBuhtgoV+TWAMP1E5hFwm/5Ct99j72/zexDFVm62p1M+fjPf/9GghF+l8gAUNRytcTTFOk2CPzfZdVbzHCqW5pHUBwFchPINxhgG3EhMLHOIOuokRcntfV7dLGWErxFyLiNdULeIOruKUlfg3P5k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=YVDXOoC8tHaflIUnM8Pp7S5nVsmESt+8ex8V8qR9UDlF21RKJ/LodrP2kO/N0IXetVWDvANBFKnTj/jHM7pgOp1Ro4FoymWaPyHPCNN0BBWRMLh9hb58dUfo+BB0MmxZZl1bST/spTBtqVX1Jpa3YVT0iDVkRlS4dae/CwPa2EY=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=A4kci3d+TKIuwHTaCLLWhGccxriCzQfD42Bpixzod40=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794808969279286.4316885900321;
	Sun, 15 Nov 2026 22:02:49 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id E2E1E18136E; Mon, 16 Nov 2026 00:13:02 +0100 (CET)
Date: Mon, 16 Nov 2026 00:13:02 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, John Stultz <john.stultz@linaro.org>, 
	Moritz Fischer <moritz.fischer@ettus.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Andy Yan <andyshrk@163.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v27 02/10] power: reset: reboot-mode: Add support for
 predefined reboot modes
Message-ID: <avo7dUvBvULHCOY1@venus>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
 <20261029-arm-psci-system_reset2-vendor-reboots-v27-2-fa4b3ff1359b@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eqbzq5wgarwaxbec"
Content-Disposition: inline
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-2-fa4b3ff1359b@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.637.76
X-ZohoMailClient: External


--eqbzq5wgarwaxbec
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v27 02/10] power: reset: reboot-mode: Add support for
 predefined reboot modes
MIME-Version: 1.0

Hi,

On Thu, Oct 29, 2026 at 02:30:56PM +0530, Shivendra Pratap wrote:
> reboot-mode based drivers can define a reboot-mode by adding it under
> the reboot-mode node in device tree. This limits such drivers, to define
> any predefined reboot-modes statically within the driver and creates a
> dependency on device-tree.
>=20
> Extend the reboot-mode framework to support driver-defined predefined
> reboot modes. Add a centralized initcall to initialize driver state
> along with predefined modes.
>=20
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/nvmem-reboot-mode.c  |   7 +-
>  drivers/power/reset/qcom-pon.c           |   7 +-
>  drivers/power/reset/reboot-mode.c        | 192 ++++++++++++++++++++++---=
------
>  drivers/power/reset/syscon-reboot-mode.c |   7 +-
>  include/linux/reboot-mode.h              |  26 ++++-
>  5 files changed, 175 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/rese=
t/nvmem-reboot-mode.c
> index d260715fccf6..700732ed0f5b 100644
> --- a/drivers/power/reset/nvmem-reboot-mode.c
> +++ b/drivers/power/reset/nvmem-reboot-mode.c
> @@ -51,8 +51,11 @@ static int nvmem_reboot_mode_probe(struct platform_dev=
ice *pdev)
>  	if (!nvmem_rbm)
>  		return -ENOMEM;
> =20
> -	nvmem_rbm->reboot.dev =3D &pdev->dev;
> -	nvmem_rbm->reboot.write =3D nvmem_reboot_mode_write;
> +	ret =3D reboot_mode_driver_init(&nvmem_rbm->reboot, &pdev->dev,
> +				      nvmem_reboot_mode_write, NULL,
> +				      NULL, 0);
> +	if (ret)
> +		return ret;
> =20
>  	nvmem_rbm->cell =3D devm_nvmem_cell_get(&pdev->dev, "reboot-mode");
>  	if (IS_ERR(nvmem_rbm->cell)) {
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-po=
n.c
> index cd7ba680b841..55aaa99d88b6 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -84,9 +84,12 @@ static int qcom_pon_probe(struct platform_device *pdev)
>  	reason_shift =3D (long)of_device_get_match_data(&pdev->dev);
> =20
>  	if (reason_shift !=3D NO_REASON_SHIFT) {
> -		pon->reboot_mode.dev =3D &pdev->dev;
> +		error =3D reboot_mode_driver_init(&pon->reboot_mode, &pdev->dev,
> +						qcom_pon_reboot_mode_write, NULL,
> +						NULL, 0);
> +		if (error)
> +			return error;
>  		pon->reason_shift =3D reason_shift;
> -		pon->reboot_mode.write =3D qcom_pon_reboot_mode_write;
>  		error =3D devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
>  		if (error) {
>  			dev_err(&pdev->dev, "can't register reboot mode\n");
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/rebo=
ot-mode.c
> index 328fa37598df..fd61de226383 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -30,12 +30,12 @@ struct reboot_mode_sysfs_data {
>  	struct list_head head;
>  };
> =20
> -static inline void reboot_mode_release_list(struct reboot_mode_sysfs_dat=
a *priv)
> +static void reboot_mode_release_list(struct list_head *head)
>  {
>  	struct mode_info *info;
>  	struct mode_info *next;
> =20
> -	list_for_each_entry_safe(info, next, &priv->head, list) {
> +	list_for_each_entry_safe(info, next, head, list) {
>  		list_del(&info->list);
>  		kfree_const(info->mode);
>  		kfree(info);
> @@ -119,6 +119,80 @@ static int reboot_mode_notify(struct notifier_block =
*this,
>  	return NOTIFY_DONE;
>  }
> =20
> +/**
> + * reboot_mode_driver_init - Initialize reboot-mode state
> + * @reboot: reboot mode driver object to initialize
> + * @dev: backing device
> + * @write: write callback to program a single magic value
> + * @write_array: write callback to program multiple magic values
> + * @predefined_modes: optional predefined reboot-mode table
> + * @predefined_mode_count: number of entries in @predefined_modes
> + *
> + * Exactly one write callback must be provided by the driver.
> + *
> + * This function must be called with a valid @dev before calling
> + * reboot_mode_register().
> + *
> + * Returns: 0 on success or -EINVAL if callback/predefined mode configur=
ation
> + * is invalid.
> + */
> +int reboot_mode_driver_init(struct reboot_mode_driver *reboot,
> +			    struct device *dev,
> +			    int (*write)(struct reboot_mode_driver *reboot, unsigned int magi=
c),
> +			    int (*write_array)(struct reboot_mode_driver *reboot,
> +					       const u32 *magic, u32 count),
> +			    const struct reboot_mode_entry *predefined_modes,
> +			    size_t predefined_mode_count)
> +{
> +	if (!reboot || !dev)
> +		return -EINVAL;
> +
> +	if (!write =3D=3D !write_array)
> +		return -EINVAL;
> +
> +	memset(reboot, 0, sizeof(*reboot));
> +	reboot->dev =3D dev;
> +	reboot->write =3D write;
> +	reboot->write_array =3D write_array;
> +	reboot->predefined_modes =3D predefined_modes;
> +	reboot->predefined_mode_count =3D predefined_mode_count;
> +	INIT_LIST_HEAD(&reboot->head);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(reboot_mode_driver_init);
> +
> +static struct mode_info *reboot_mode_create_info(struct device *dev, con=
st char *mode,
> +						 const u32 *magic, int count)
> +{
> +	struct mode_info *info;
> +
> +	if (!mode || mode[0] =3D=3D '\0') {
> +		dev_err(dev, "invalid mode name\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	info =3D kzalloc_obj(*info, GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);

info =3D kzalloc_obj(*info);

Otherwise:

Acked-by: Sebastian Reichel <sebastian@collabora.com>

Greetings,

-- Sebastian

> +
> +	info->mode =3D kstrdup_const(mode, GFP_KERNEL);
> +	if (!info->mode) {
> +		kfree(info);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	if (!memchr_inv(magic, 0, count * sizeof(u32))) {
> +		dev_dbg(dev, "reboot mode %s with zero magic values\n", mode);
> +		info->count =3D 0;
> +	} else {
> +		memcpy(info->magic, magic, count * sizeof(u32));
> +		info->count =3D count;
> +	}
> +
> +	return info;
> +}
> +
>  static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
>  {
>  	struct reboot_mode_sysfs_data *priv;
> @@ -160,11 +234,38 @@ static int reboot_mode_create_device(struct reboot_=
mode_driver *reboot)
>  	return 0;
> =20
>  error:
> -	reboot_mode_release_list(priv);
> +	reboot_mode_release_list(&priv->head);
>  	kfree(priv);
>  	return ret;
>  }
> =20
> +static int reboot_mode_add_predefined_modes(struct reboot_mode_driver *r=
eboot)
> +{
> +	const struct reboot_mode_entry *modes =3D reboot->predefined_modes;
> +	struct mode_info *info;
> +	size_t i;
> +
> +	if (!modes)
> +		return 0;
> +
> +	for (i =3D 0; i < reboot->predefined_mode_count; i++) {
> +		if (modes[i].name && strpbrk(modes[i].name, "\n ,/"))
> +			return -EINVAL;
> +
> +		if (!modes[i].count || modes[i].count > ARRAY_SIZE(modes[i].magic))
> +			return -EINVAL;
> +
> +		info =3D reboot_mode_create_info(reboot->dev, modes[i].name,
> +					       modes[i].magic, modes[i].count);
> +		if (IS_ERR(info))
> +			return PTR_ERR(info);
> +
> +		list_add_tail(&info->list, &reboot->head);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * reboot_mode_register - register a reboot mode driver
>   * @reboot: reboot mode driver
> @@ -173,7 +274,7 @@ static int reboot_mode_create_device(struct reboot_mo=
de_driver *reboot)
>   */
>  int reboot_mode_register(struct reboot_mode_driver *reboot)
>  {
> -	struct mode_info *info =3D NULL;
> +	struct mode_info *info;
>  	struct property *prop;
>  	struct device_node *np =3D reboot->dev->of_node;
>  	size_t len =3D strlen(PREFIX);
> @@ -183,52 +284,36 @@ int reboot_mode_register(struct reboot_mode_driver =
*reboot)
> =20
>  	INIT_LIST_HEAD(&reboot->head);
> =20
> -	for_each_property_of_node(np, prop) {
> -		memset(magic, 0, sizeof(magic));
> -
> -		if (strncmp(prop->name, PREFIX, len))
> -			continue;
> -
> -		count =3D device_property_count_u32(reboot->dev, prop->name);
> -
> -		if (count <=3D 0 || count > ARRAY_SIZE(magic) ||
> -		    device_property_read_u32_array(reboot->dev, prop->name, magic, cou=
nt)) {
> -			dev_dbg(reboot->dev, "reboot mode %s without magic number\n",
> -				prop->name);
> -			continue;
> -		}
> -
> -		info =3D kzalloc_obj(*info);
> -		if (!info) {
> -			ret =3D -ENOMEM;
> -			goto error;
> -		}
> -
> -		if (!memchr_inv(magic, 0, count * sizeof(u32))) {
> -			dev_dbg(reboot->dev, "reboot mode %s with zero magic values\n",
> -				prop->name);
> -			info->count =3D 0;
> -		} else {
> -			memcpy(info->magic, magic, count * sizeof(u32));
> -			info->count =3D count;
> -		}
> -
> -		info->mode =3D kstrdup_const(prop->name + len, GFP_KERNEL);
> -		if (!info->mode) {
> -			ret =3D -ENOMEM;
> -			goto error;
> -		} else if (info->mode[0] =3D=3D '\0') {
> -			kfree_const(info->mode);
> -			ret =3D -EINVAL;
> -			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
> -				prop->name);
> -			goto error;
> +	if (np) {
> +		for_each_property_of_node(np, prop) {
> +			memset(magic, 0, sizeof(magic));
> +			if (strncmp(prop->name, PREFIX, len))
> +				continue;
> +
> +			count =3D device_property_count_u32(reboot->dev, prop->name);
> +
> +			if (count <=3D 0 || count > ARRAY_SIZE(magic) ||
> +			    device_property_read_u32_array(reboot->dev, prop->name, magic, co=
unt)) {
> +				dev_dbg(reboot->dev, "reboot mode %s without magic number\n",
> +					prop->name);
> +				continue;
> +			}
> +
> +			info =3D reboot_mode_create_info(reboot->dev, prop->name + len,
> +						       magic, count);
> +			if (IS_ERR(info)) {
> +				ret =3D PTR_ERR(info);
> +				goto error;
> +			}
> +
> +			list_add_tail(&info->list, &reboot->head);
>  		}
> -
> -		list_add_tail(&info->list, &reboot->head);
> -		info =3D NULL;
>  	}
> =20
> +	ret =3D reboot_mode_add_predefined_modes(reboot);
> +	if (ret)
> +		goto error;
> +
>  	reboot->reboot_notifier.notifier_call =3D reboot_mode_notify;
>  	register_reboot_notifier(&reboot->reboot_notifier);
> =20
> @@ -239,7 +324,6 @@ int reboot_mode_register(struct reboot_mode_driver *r=
eboot)
>  	return 0;
> =20
>  error:
> -	kfree(info);
>  	reboot_mode_unregister(reboot);
>  	return ret;
>  }
> @@ -272,7 +356,7 @@ static inline void reboot_mode_unregister_device(stru=
ct reboot_mode_driver *rebo
>  	if (!priv)
>  		return;
> =20
> -	reboot_mode_release_list(priv);
> +	reboot_mode_release_list(&priv->head);
>  	kfree(priv);
>  }
> =20
> @@ -282,17 +366,11 @@ static inline void reboot_mode_unregister_device(st=
ruct reboot_mode_driver *rebo
>   */
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>  {
> -	struct mode_info *info;
> -	struct mode_info *next;
> -
>  	unregister_reboot_notifier(&reboot->reboot_notifier);
> +	reboot->reboot_notifier.notifier_call =3D NULL;
>  	reboot_mode_unregister_device(reboot);
> =20
> -	list_for_each_entry_safe(info, next, &reboot->head, list) {
> -		list_del(&info->list);
> -		kfree_const(info->mode);
> -		kfree(info);
> -	}
> +	reboot_mode_release_list(&reboot->head);
> =20
>  	return 0;
>  }
> diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/res=
et/syscon-reboot-mode.c
> index e0772c9f70f7..7d3a95e8dfd7 100644
> --- a/drivers/power/reset/syscon-reboot-mode.c
> +++ b/drivers/power/reset/syscon-reboot-mode.c
> @@ -45,8 +45,11 @@ static int syscon_reboot_mode_probe(struct platform_de=
vice *pdev)
>  	if (!syscon_rbm)
>  		return -ENOMEM;
> =20
> -	syscon_rbm->reboot.dev =3D &pdev->dev;
> -	syscon_rbm->reboot.write =3D syscon_reboot_mode_write;
> +	ret =3D reboot_mode_driver_init(&syscon_rbm->reboot, &pdev->dev,
> +				      syscon_reboot_mode_write, NULL,
> +				      NULL, 0);
> +	if (ret)
> +		return ret;
>  	syscon_rbm->mask =3D 0xffffffff;
> =20
>  	syscon_rbm->map =3D syscon_node_to_regmap(pdev->dev.parent->of_node);
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 29ae39935d69..560d8b4d67ac 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -4,14 +4,38 @@
> =20
>  #include <linux/types.h>
> =20
> +struct reboot_mode_entry {
> +	const char *name;
> +	u32 magic[3];
> +	u32 count;
> +};
> +
>  struct reboot_mode_driver {
>  	struct device *dev;
>  	struct list_head head;
> +	/*
> +	 * Optional predefined reboot-mode table.
> +	 *
> +	 * Must be initialized before reboot_mode_register() and remain valid
> +	 * until reboot_mode_unregister().
> +	 *
> +	 * If a predefined mode name duplicates a DT-defined mode name,
> +	 * the DT-defined mode takes precedence.
> +	 */
> +	const struct reboot_mode_entry *predefined_modes;
> +	size_t predefined_mode_count;
> +	int (*write_array)(struct reboot_mode_driver *reboot, const u32 *magic,=
 u32 count);
>  	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
> -	int (*write_array)(struct reboot_mode_driver *reboot, const u32 *magic,=
 int count);
>  	struct notifier_block reboot_notifier;
>  };
> =20
> +int reboot_mode_driver_init(struct reboot_mode_driver *reboot,
> +			    struct device *dev,
> +			    int (*write)(struct reboot_mode_driver *reboot, unsigned int magi=
c),
> +			    int (*write_array)(struct reboot_mode_driver *reboot,
> +					       const u32 *magic, u32 count),
> +			    const struct reboot_mode_entry *predefined_modes,
> +			    size_t predefined_mode_count);
>  int reboot_mode_register(struct reboot_mode_driver *reboot);
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot);
>  int devm_reboot_mode_register(struct device *dev,
>=20
> --=20
> 2.34.1
>=20
>=20

--eqbzq5wgarwaxbec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr6PH4ACgkQ2O7X88g7
+pp/nQ/8CucU+QLfnlmffj8d/tuprNMRpfXln09QvCQMM7L7H5Kzfr2uUeXL/a5A
SDqtA3Oh9V5QWzcp0O4oZKDg22xmvcuDQlU5o6835mqOWUtyG9FKwIwXXfr00RQT
GNaE1VWAFrKOrM4fiEressXmf5DSJb2IJtoVE/7hzz/tW1HGsUk7HJcOlrwDYMVb
45c2EWIM8Y00LNbh6vFZOyisURHScCrzodJ1WmboprNC7Xq2VAF/S/zZgwnuoXeL
4UOnAyAcrgC1f+KE8k1/aPdWrv/624IoP5qo15x9srV1jzYUu9wfsUanhWflZ/qF
8mRomKxrpZ7X8WpopnWkDHiNKhilcO5yKpmwiIi6h7PvIBZupuWOoH7Kr+lB2YqW
19frzY2I82xZJoqpT0VIKewtCYa/LkyGPdIDdEpV5rJWI9YludUXc4g8U5j3OkG1
gxodmhGArJ+PSxSoZHfKjI3eEFzfFKFyl+PCzgMeftJMF0tfloyaEwW98H9Atv44
3Lc6ecmYa2G+mr5Ad+nddbsEIvA1oQorIqKujT90TpnrONbW1kROz8iNyZ8Pp6Jk
lG8fn5qZJcp2Q7kSkFYvrb7RqNjs6zRAhLQ+vZAlOAnTir7hh4vs/HoBIZt5TwgL
Hnb9mqQjj250U5DeGaLDEOZmrEs2GH565lu1RU7+4Yh4l6P23z0=
=0Ka3
-----END PGP SIGNATURE-----

--eqbzq5wgarwaxbec--
