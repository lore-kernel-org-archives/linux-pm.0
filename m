Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6DB2E2DDD;
	Sat, 18 Apr 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776511443; cv=none; b=PL3kxYSNMYW7ddur3sEP8YIxgA46eaD0mGs8urE6djhITw3ukzhc0w/0FT+7Hk+G4KC9KczbF0dRYYEH8077J1rMYHvBcOHIs6Hon9e9T+Lr7bc19iOfWPIw0uQA2wuZucGydxLjxG3bQ3lstxIVkWtgdQwoA+3mWHtPsfyyHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776511443; c=relaxed/simple;
	bh=eEo8recsYatthAVX8i3XpCfdJmBlTwOldwA5txXfTHA=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version:
	 References:In-Reply-To; b=KEQk9y1vEfU/yhSSt+P0DFO1QB7/wu1iJ15YxIB7ACx5IM+LN7a5LIXwnOSYwdbTMaHDfWkzzhkpuMLUo0F48iuczCosDhyH+tE2hViZW2UonajZjDQgy/Y2purMOuGlAg/jRIXKtMfBsPb/QV4mfqG5SqT5ikTFE8zG59irM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRUaJJ1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRUaJJ1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CECC2BCB4;
	Sat, 18 Apr 2026 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776511442;
	bh=eEo8recsYatthAVX8i3XpCfdJmBlTwOldwA5txXfTHA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=PRUaJJ1iM6epHYiOIjQlTfnjmSXbddoHrBtt1ltAbN8rOdRMRccEq7H6dQsuNspFe
	 dKTAU22L1zT79Ep2tGhkisCBV+bI2NhFXAvaok+Qgd8T4kgn+KhGextsxgg7WLKHKE
	 5McNFB8vAl2Br290cEOG4n1VlEll25WdcSUiT6IYDt7tZmEKjW9GWkJpUngHqpLtP/
	 kMtiA1BcYlAF5Re21Y7z6B94KtjLtN8uC0FLh0BKtqirknbUn3ueKY57qOpoiTBzQp
	 NqsvOm0jka03qFk0llNq6mfZMIFpq+oTv857iVmDNkFInzSrCstNod5Y/wde4A59Ym
	 wQXG2pr17Sb/A==
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Apr 2026 13:23:56 +0200
Message-Id: <DHW8QV8K3CM1.307C6PW2BM5RN@kernel.org>
Subject: Re: [PATCH v2 2/9] driver core: Add dev_set_drv_queue_sync_state()
Cc: "Saravana Kannan" <saravanak@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <linux-pm@vger.kernel.org>, "Sudeep Holla" <sudeep.holla@kernel.org>,
 "Cristian Marussi" <cristian.marussi@arm.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Abel Vesa" <abel.vesa@oss.qualcomm.com>, "Peng
 Fan" <peng.fan@oss.nxp.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Maulik Shah"
 <maulik.shah@oss.qualcomm.com>, "Konrad Dybcio" <konradybcio@kernel.org>,
 "Thierry Reding" <thierry.reding@gmail.com>, "Jonathan Hunter"
 <jonathanh@nvidia.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 <driver-core@lists.linux.dev>
To: "Ulf Hansson" <ulf.hansson@linaro.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
 <20260410104058.83748-3-ulf.hansson@linaro.org>
In-Reply-To: <20260410104058.83748-3-ulf.hansson@linaro.org>

On Fri Apr 10, 2026 at 12:40 PM CEST, Ulf Hansson wrote:
> diff --git a/include/linux/device.h b/include/linux/device.h
> index e65d564f01cd..f812e70bdf22 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -994,6 +994,18 @@ static inline int dev_set_drv_sync_state(struct devi=
ce *dev,
>  	return 0;
>  }
> =20
> +static inline int dev_set_drv_queue_sync_state(struct device *dev,
> +					       void (*fn)(struct device *dev))

As this is a public function, please add some documentation.

> +{
> +	if (!dev || !dev->driver)
> +		return 0;
> +	if (dev->driver->queue_sync_state && dev->driver->queue_sync_state !=3D=
 fn)
> +		return -EBUSY;
> +	if (!dev->driver->queue_sync_state)
> +		dev->driver->queue_sync_state =3D fn;

I think this follows dev_set_drv_sync_state(), but I think it is worth poin=
ting
out that it is yet another blocker for moving towards
const struct device_driver.

> +	return 0;
> +}
> +
>  static inline void dev_set_removable(struct device *dev,
>  				     enum device_removable removable)
>  {
> --=20
> 2.43.0

