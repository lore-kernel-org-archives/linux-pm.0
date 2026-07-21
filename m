Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5E443E3D
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626155; cv=none; b=O2Itbwm1SV0Chec+2oE0zWTMYpiiQo1hdVvl4+/L8ewgAqFev3Lc11OnZ9wG9yyuBnsvfCdvJ45L5lhhHkSqmTlTtzyCwc1p5b63qlCEQa5ZDblyjQS4z11Acy4Gf9ef6tQT63UEHZHobTDoaAq62JTQbMNCCKV6QIUxf8lY9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626155; c=relaxed/simple;
	bh=/4X0t21/O4+G9aKODvcsjfWhNZ6g+1ps49Del/TMlEA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JV8YP3CX22/JGTRJhQK1arXGx1vTJ9Bzjo9A3Q/uFNOfKxhb7vOm6IT3CuxC22xrv5zR7sfE2CkrNeXfRw0IqpqA/+BygfaWrczU5lHwjM6soyu/PqEMCW02j1qZI17LkRRMUAcGGsD+gq1h9gVP+hCM+LibjxmrbxVXTqyJhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwNzD8SM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwNzD8SM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF091F0156E
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784626153;
	bh=CDJLucVT4R47Wn7AWbEmW80xVYNcqomm0n8kCgC52XU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=dwNzD8SMh2MvQuc5sqz/UiAJTf62dy5g1tNLKvIcNpR92JwKHLAbZnKG9zCBN8eWq
	 MrMH8Tz5rckp13IJsdjv8FCdR/wCh0SvhD1tRPvykWBRuB9Kny3MJE6D5tXUvYHLHt
	 e9gTI02n1YSCvtA0u1kXTJ3kd2eHnzpDLAfSEvOfMaZZI/B4hx/ZyaRIOYW86JlTiQ
	 IPv6esWtjqeIdRSL8wUW7vbywDMIugP2XsNzIUDt6tdWpkHynX0moFyZVGQRbxPn39
	 hFvVMs6Q2rXSSoFf/d9HonPzb2zIyNObWSCt1AOf3fTGHn+Iu2f840V/wstBPCrnNf
	 wVnpoyAQ5kJ8A==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b2a44a3b66so881667e87.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 02:29:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YzrpWCGH6klzjjVESH730h2Qk9F77XWcLWXtLuLNdXRis3OPw23
	FSh4042WIQtKXndaDUaCDKHF5Wp+4iCioWmc6egwvFSFFo+u8hR1BQyjMX05e6Zn/O9om1vbECH
	KioDYz/nVedW5+G6ceauVKNK/7BZUnNyI0PVHtRfnkA==
X-Received: by 2002:a05:6512:1328:b0:5b0:eda:de2a with SMTP id
 2adb3069b0e04-5b28f998d04mr3384385e87.35.1784626152102; Tue, 21 Jul 2026
 02:29:12 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 09:29:11 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 09:29:10 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260714-arm-psci-system_reset2-vendor-reboots-v23-8-e7453c548c21@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-8-e7453c548c21@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 09:29:10 +0000
X-Gmail-Original-Message-ID: <CAMRc=McxoC6711rmXmPb9t21bBsTeBMJ3ieZ1XhyTqMLaMS-4Q@mail.gmail.com>
X-Gm-Features: AUfX_my1mbfO1VN9YoJGd-EpwSTRR3Y3NySq4UuDtatqCVxMuFBT8FxEQjVt8Jo
Message-ID: <CAMRc=McxoC6711rmXmPb9t21bBsTeBMJ3ieZ1XhyTqMLaMS-4Q@mail.gmail.com>
Subject: Re: [PATCH v23 08/13] mfd: core: Add firmware-node support to MFD cells
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, mfd@lists.linux.dev, 
	Srinivas Kandagatla <srini@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Sebastian Reichel <sre@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	John Stultz <john.stultz@linaro.org>, Moritz Fischer <moritz.fischer@ettus.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jul 2026 19:16:36 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> MFD core has no way to register a child device using an explicit firmware
> node. This prevents drivers from registering child nodes when those nodes
> do not define a compatible string. One such example is the PSCI
> "reboot-mode" node, which omits a compatible string as it describes
> boot-states provided by the underlying firmware.
>
> Extend struct mfd_cell with a named firmware-node field to identify a
> child node under the MFD parent. The node is added to the MFD child
> device during registration when none is assigned by device tree, ACPI,
> or software matching.
>
> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/mfd/mfd-core.c   | 142 ++++++++++++++++++++++++++++++++++++++++-------
>  include/linux/mfd/core.h |  10 ++++
>  2 files changed, 131 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 7aa32b90cf1e..ba9682ead2ca 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/acpi.h>
> +#include <linux/fwnode.h>
>  #include <linux/list.h>
>  #include <linux/property.h>
>  #include <linux/mfd/core.h>
> @@ -22,6 +23,7 @@
>  #include <linux/regulator/consumer.h>
>
>  static LIST_HEAD(mfd_of_node_list);
> +static LIST_HEAD(mfd_named_fwnode_list);
>  static DEFINE_MUTEX(mfd_of_node_mutex);
>
>  struct mfd_of_node_entry {
> @@ -30,10 +32,91 @@ struct mfd_of_node_entry {
>  	struct device_node *np;
>  };
>
> +struct mfd_named_fwnode_entry {
> +	struct list_head list;
> +	struct device *dev;
> +	struct fwnode_handle *fwnode;
> +};
> +
>  static const struct device_type mfd_dev_type = {
>  	.name	= "mfd_device",
>  };
>
> +static int mfd_claim_named_fwnode(struct platform_device *pdev,
> +				  struct fwnode_handle *fwnode)
> +{
> +	struct mfd_named_fwnode_entry *entry, *iter;
> +
> +	entry = kzalloc_obj(*entry, GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->dev = &pdev->dev;
> +	entry->fwnode = fwnode_handle_get(fwnode);
> +
> +	scoped_guard(mutex, &mfd_of_node_mutex) {
> +		list_for_each_entry(iter, &mfd_named_fwnode_list, list)
> +			if (iter->fwnode == fwnode) {
> +				fwnode_handle_put(entry->fwnode);
> +				kfree(entry);
> +				return -EAGAIN;
> +			}
> +
> +		list_add_tail(&entry->list, &mfd_named_fwnode_list);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Temporary MFD-local cleanup for named non-OF child fwnodes.
> + * Remove/rework this when platform core starts owning and dropping
> + * dev->fwnode references for these devices.
> + */
> +static void mfd_release_named_fwnode(struct platform_device *pdev)
> +{
> +	struct mfd_named_fwnode_entry *entry, *tmp;
> +
> +	scoped_guard(mutex, &mfd_of_node_mutex) {
> +		list_for_each_entry_safe(entry, tmp, &mfd_named_fwnode_list, list)
> +			if (entry->dev == &pdev->dev) {
> +				if (dev_fwnode(&pdev->dev) == entry->fwnode)
> +					device_set_node(&pdev->dev, NULL);
> +				fwnode_handle_put(entry->fwnode);
> +				list_del(&entry->list);
> +				kfree(entry);
> +			}
> +	}
> +}
> +
> +static int mfd_claim_of_node_to_dev(struct platform_device *pdev,
> +				    struct device_node *np)
> +{
> +	struct mfd_of_node_entry *of_entry, *iter;
> +
> +	of_entry = kzalloc_obj(*of_entry, GFP_KERNEL);
> +	if (!of_entry)
> +		return -ENOMEM;
> +
> +	of_entry->dev = &pdev->dev;
> +	of_entry->np = of_node_get(np);
> +
> +	/* Skip if OF node has previously been allocated to a device */
> +	scoped_guard(mutex, &mfd_of_node_mutex) {
> +		list_for_each_entry(iter, &mfd_of_node_list, list)
> +			if (iter->np == np) {
> +				of_node_put(of_entry->np);
> +				kfree(of_entry);
> +				return -EAGAIN;
> +			}
> +
> +		list_add_tail(&of_entry->list, &mfd_of_node_list);
> +	}
> +
> +	device_set_node(&pdev->dev, of_fwnode_handle(np));
> +	return 0;
> +}
> +
>  #if IS_ENABLED(CONFIG_ACPI)
>  struct match_ids_walk_data {
>  	struct acpi_device_id *ids;
> @@ -111,19 +194,11 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
>  				    struct device_node *np,
>  				    const struct mfd_cell *cell)
>  {
> -	struct mfd_of_node_entry *of_entry;
>  	u64 of_node_addr;
>
> -	/* Skip if OF node has previously been allocated to a device */
> -	scoped_guard(mutex, &mfd_of_node_mutex) {
> -		list_for_each_entry(of_entry, &mfd_of_node_list, list)
> -			if (of_entry->np == np)
> -				return -EAGAIN;
> -	}
> -
>  	if (!cell->use_of_reg)
>  		/* No of_reg defined - allocate first free compatible match */
> -		goto allocate_of_node;
> +		return mfd_claim_of_node_to_dev(pdev, np);
>
>  	/* We only care about each node's first defined address */
>  	if (of_property_read_reg(np, 0, &of_node_addr, NULL))
> @@ -134,18 +209,7 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
>  		/* No match */
>  		return -EAGAIN;
>
> -allocate_of_node:
> -	of_entry = kzalloc(sizeof(*of_entry), GFP_KERNEL);
> -	if (!of_entry)
> -		return -ENOMEM;
> -
> -	of_entry->dev = &pdev->dev;
> -	of_entry->np = of_node_get(np);
> -	scoped_guard(mutex, &mfd_of_node_mutex)
> -		list_add_tail(&of_entry->list, &mfd_of_node_list);
> -
> -	device_set_node(&pdev->dev, of_fwnode_handle(np));
> -	return 0;
> +	return mfd_claim_of_node_to_dev(pdev, np);
>  }
>
>  static int mfd_add_device(struct device *parent, int id,
> @@ -156,6 +220,7 @@ static int mfd_add_device(struct device *parent, int id,
>  	struct resource *res;
>  	struct platform_device *pdev;
>  	struct mfd_of_node_entry *of_entry, *tmp;
> +	struct fwnode_handle *fwnode;
>  	bool disabled = false;
>  	int ret = -ENOMEM;
>  	int platform_id;
> @@ -224,6 +289,37 @@ static int mfd_add_device(struct device *parent, int id,
>
>  	mfd_acpi_add_device(cell, pdev);
>
> +	/* named_fwnode is a fallback only when no OF/ACPI match and no swnode */
> +	if (!pdev->dev.fwnode && !cell->swnode && cell->named_fwnode) {

Use dev_fwnode() instead of pdev->dev.fwnode.

> +		struct device_node *named_np;
> +
> +		fwnode = device_get_named_child_node(parent, cell->named_fwnode);
> +		if (!fwnode) {
> +			ret = -ENODEV;
> +			goto fail_alias;
> +		}
> +
> +		named_np = to_of_node(fwnode);
> +		if (named_np) {
> +			ret = mfd_claim_of_node_to_dev(pdev, named_np);
> +			fwnode_handle_put(fwnode);
> +			if (ret == -EAGAIN)
> +				ret = -EBUSY;
> +			if (ret)
> +				goto fail_alias;
> +		} else {
> +			ret = mfd_claim_named_fwnode(pdev, fwnode);
> +			if (ret) {
> +				fwnode_handle_put(fwnode);
> +				if (ret == -EAGAIN)
> +					ret = -EBUSY;
> +				goto fail_alias;
> +			}
> +			device_set_node(&pdev->dev, fwnode);
> +			fwnode_handle_put(fwnode);
> +		}

What is the reason to have this split into OF and fwnode functions? I don't
really see why you would need to do it twice, isn't fwnode sufficient for the
OF node case too?

> +	}
> +
>  	if (cell->pdata_size) {
>  		ret = platform_device_add_data(pdev,
>  					cell->platform_data, cell->pdata_size);
> @@ -295,6 +391,7 @@ static int mfd_add_device(struct device *parent, int id,
>  	if (cell->swnode)
>  		device_remove_software_node(&pdev->dev);
>  fail_of_entry:
> +	mfd_release_named_fwnode(pdev);
>  	scoped_guard(mutex, &mfd_of_node_mutex) {
>  		list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
>  			if (of_entry->dev == &pdev->dev) {
> @@ -382,7 +479,10 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
>  	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
>  					       cell->num_parent_supplies);
>
> +	get_device(&pdev->dev);
>  	platform_device_unregister(pdev);
> +	mfd_release_named_fwnode(pdev);
> +	put_device(&pdev->dev);
>  	return 0;
>  }
>
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index faeea7abd688..8daa83dd31ea 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -80,6 +80,16 @@ struct mfd_cell {
>
>  	/* Software node for the device. */
>  	const struct software_node *swnode;
> +	/*
> +	 * Name of a child firmware node under the MFD parent device.
> +	 *
> +	 * Used only as a fallback when no firmware node is assigned to MFD
> +	 * child and no software node is provided.
> +	 *
> +	 * For Device Tree parents, lookup is by base node name only
> +	 * (the part before '@'). Unit-addresses are not matched.
> +	 */

Side note: struct mfd_cell could really use a proper kernel doc but that's out
of scope of this series.

> +	const char *named_fwnode;
>
>  	/*
>  	 * Device Tree compatible string
>
> --
> 2.34.1
>
>

Bartosz
