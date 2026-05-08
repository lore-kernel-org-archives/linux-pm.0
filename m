Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E033A029;
	Fri,  8 May 2026 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264603; cv=none; b=rmand87pwyknHgwcGAAUC6TrDFVLYIqLeqK50v/7GXZEfls4Emwlp2qNKfaDRPq1z/8WnBZZWBQ93l6SRmUgnIet4XfWz+Jan1OzWbXCim1z3E64C4HksdGoGZRmXuuh6NxGXQtBtge2XamIR+mTcMYslagyBFf6M05iUrdKnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264603; c=relaxed/simple;
	bh=PT33hPVUf3Z1XzPwnKsjfQUflnA93EQa7d+QeZmaP5Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=IeezmbtPigQlYfSrwCa6PiKmFSIFkfEHxw67GPk3QKV4azvsYcSCAmqJeb3JssFbQaWs4Uk4SMz3P9KGLecmsSGuJ4LYG0X+p4dnxkBxECM87shxx75DCMwrLRift34qWBISKruEU605Zaix2vY+aQ9UpxNy8gQ3QmfNJWloEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpeBLG1T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpeBLG1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5C2C2BCB0;
	Fri,  8 May 2026 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778264603;
	bh=PT33hPVUf3Z1XzPwnKsjfQUflnA93EQa7d+QeZmaP5Q=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qpeBLG1TYeibesM13Z5pX3y8bJ4F7lEefoKDKJ4p4ivXV9zAHRU8316aYlrMSo2wS
	 X0RcaKa62KqRQbclf7DUgo5ktHnBasfQ//QtgMlYyVfbeW9xGZY1NgB6taZhGyBTRd
	 X0XvKUG+gwEOLlVuWqjiKoAr1x+u1qZB2IkOZc7yidJIGQa2NL1BmkHuJ71hEUZw57
	 6xwdy3h7Ei19mYCoElxRmfcOw18cTley7QSnipUiQL9Ij0E0WTeHWHUy51tLfkwkDr
	 sBGjJ0xby4ddnQAkxfwrLhy+qC7qKxgRjGhabzAKhPNHs3+pHea3umsqWjiOUJf4fe
	 g7o1Ng220ox/Q==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 20:23:17 +0200
Message-Id: <DIDI6UCUFTWA.3GANQE923DAP9@kernel.org>
Subject: Re: [PATCH v3 02/13] driver core: Enable suppliers to implement
 fine grained sync_state support
Cc: "Saravana Kannan" <saravanak@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <driver-core@lists.linux.dev>, <linux-pm@vger.kernel.org>, "Sudeep Holla"
 <sudeep.holla@kernel.org>, "Cristian Marussi" <cristian.marussi@arm.com>,
 "Kevin Hilman" <khilman@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Abel Vesa" <abel.vesa@oss.qualcomm.com>, "Peng
 Fan" <peng.fan@oss.nxp.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Maulik Shah"
 <maulik.shah@oss.qualcomm.com>, "Konrad Dybcio" <konradybcio@kernel.org>,
 "Thierry Reding" <thierry.reding@gmail.com>, "Jonathan Hunter"
 <jonathanh@nvidia.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
To: "Ulf Hansson" <ulf.hansson@linaro.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
 <20260508123910.114273-3-ulf.hansson@linaro.org>
In-Reply-To: <20260508123910.114273-3-ulf.hansson@linaro.org>

On Fri May 8, 2026 at 2:38 PM CEST, Ulf Hansson wrote:
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 30b416588617..c8be24af92c3 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -196,6 +196,24 @@ static inline void dev_sync_state(struct device *dev=
)
>  		dev->driver->sync_state(dev);
>  }
> =20
> +static inline bool dev_has_queue_sync_state(struct device *dev)
> +{
> +	struct device_driver *drv;
> +
> +	if (!dev)
> +		return false;
> +	drv =3D READ_ONCE(dev->driver);
> +	if (drv && drv->queue_sync_state)
> +		return true;
> +	return false;
> +}
> +
> +static inline void dev_queue_sync_state(struct device *dev)
> +{

Let's add device_lock_assert(dev), as this function requires it to be held.

> +	if (dev->driver && dev->driver->queue_sync_state)
> +		dev->driver->queue_sync_state(dev);
> +}

<snip>

> @@ -1175,6 +1188,25 @@ static void device_links_flush_sync_list(struct li=
st_head *list,
> =20
>  		put_device(dev);
>  	}
> +
> +	if (!q_list)
> +		return;
> +
> +	list_for_each_entry_safe(dev, tmp, q_list, links.queue_sync) {
> +		list_del_init(&dev->links.queue_sync);

Hm...this is called without the device_links_write_lock() held, so this loo=
ks
like this could this race with the list_del_init() from
device_links_driver_cleanup() and create an infinite loop.

(The other list iterator above might have the same issue.)

> +
> +		if (dev !=3D dont_lock_dev)

This is pre-existing, but I think it would be good to add a device_lock_ass=
ert()
call for this as well.

> +			device_lock(dev);
> +
> +		device_links_write_lock();
> +		dev_queue_sync_state(dev);
> +		device_links_write_unlock();
> +
> +		if (dev !=3D dont_lock_dev)
> +			device_unlock(dev);
> +
> +		put_device(dev);
> +	}
>  }
