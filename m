Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E344B2E54BD;
	Fri,  6 Mar 2026 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802039; cv=none; b=rS3zqM4mYm+5R/+E2zIVl9cn6ZRsPlQ8PpdGuWz9AZapTF7d/y1hE04FE9J/yvM7oqra9U9zZDKwGE3Et6480o9cjj/6Go2v+KJOSC/+0bGKRnzgIJ2WvX3fgjUKy80E2tR7vBcmGmwNo7cSX8bI3zXSnwyOflCwP5ZSo8gEcuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802039; c=relaxed/simple;
	bh=SUilmRyxi9rSQ2L8Zu1tUGBe9n/KlEBwjbmt8lTSZZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf7qaBjA3m87qdZsHg44Q+pJlk6ivrP92XjNEe0D5lsGcRrlLgfpKFs3BDNsoljQydbXLJ7BjnI7kt2ZlVAfJaCyXhF/kyMdUs8+OG9GUckkNJd398yxJFebBrRJQ1va341dF2/u7pdSM2UvtfJGVoV4I7Qn6tSwtXv30+bIBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzXGg6rV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzXGg6rV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C1EC4CEF7;
	Fri,  6 Mar 2026 13:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772802038;
	bh=SUilmRyxi9rSQ2L8Zu1tUGBe9n/KlEBwjbmt8lTSZZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzXGg6rVmEJJG6AygVVVyC5TblHizjVm0/fiTm/TAugIDMsSYhg5s5vU4fdpnvQL1
	 lLWB1P9pUgPZ5fFLbjxnh1Zh5swrJmEEomAzl+WOu1XH1rti0ulKpuzmiW3Def6Wxh
	 fJvIYXw2QUG/UOyUol8+3BsSYK/JVrghOF4O1WOl4LeRazwSx4EqT6Xi0+MOv/gZmq
	 ouHiiLJdgZyKoRETncAhoajKoboLNKuG9Gxi+M3qEK/YV4mfAXfIQbjX7vkB50oeTF
	 jT+H55kOfCxtBjluOlRP2ToS/1wBfsDU6t+vWPukoJicc4pdk3P4VtAvRJukRjaqeg
	 suq05TtmZZeWQ==
Date: Fri, 6 Mar 2026 13:00:31 +0000
From: Lee Jones <lee@kernel.org>
To: amitsd@google.com
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v8 3/6] mfd: max77759: add register bitmasks and modify
 irq configs for charger
Message-ID: <20260306130031.GK183676@google.com>
References: <20260224-max77759-charger-v8-0-eb86bd570e9c@google.com>
 <20260224-max77759-charger-v8-3-eb86bd570e9c@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224-max77759-charger-v8-3-eb86bd570e9c@google.com>

On Tue, 24 Feb 2026, Amit Sunil Dhamne via B4 Relay wrote:

> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Add register bitmasks for charger function.
> In addition split the charger IRQs further such that each bit represents
> an IRQ downstream of charger regmap irq chip. In addition populate the
> ack_base to offload irq ack to the regmap irq chip framework.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: André Draszik <andre.draszik@linaro.org>
> ---
>  drivers/mfd/max77759.c       |  91 ++++++++++++++++++++--
>  include/linux/mfd/max77759.h | 176 ++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 230 insertions(+), 37 deletions(-)

Does this patch have any dependents or dependencies?

-- 
Lee Jones [李琼斯]
