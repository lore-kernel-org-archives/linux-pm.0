Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612931AA87;
	Fri, 29 May 2026 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780092129; cv=none; b=d8uhZH3LL43BCB/5uJkThu2Klm0RQszDSEs5zg5BxlDEsSwGUZ/n9w55dDoYYZmbGmuGtVzBmGaChKC5/kruOOcPa5RC6ufUHGOOA3vBeymqc6P3VTEQdliIoVJuY/msEWFXHA2qLMcthpdhCzC5tyfu9YmLsc1mjeBuSp4wXqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780092129; c=relaxed/simple;
	bh=Qodmhk9/5OeHg0v54jw3stQ8TiDnx1bG58Az4cPluEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQXbxaqNM9g/YDgVzShwo1J60Loe2eCuXKJdqTbHh9n5K/mFQ3lwk2Txsn6RCKrU6WPAxP1YpGbzfg6wV+lrX5861id4n0s+2VeVfq3Sw1xHd4qBcuqjrTS7Gt0jprCTQsbYG7kPTJKREXmcnBXDXx08WS+QhZtaR0wpNrn+iZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJxYZCaw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJxYZCaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6AD1F00893;
	Fri, 29 May 2026 22:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780092128;
	bh=BPEbrvvQAzNpfGL52FhYthqiF/e4hVDDeDLmdGEm930=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hJxYZCawRQCJDet7RbbBxOcM6cDDG5/iiY9fCWcwN31fdH5IijixpVm2bSAwQ1cjK
	 46VV5ZrKrG9b+geWcsEqluc7YluMjTa9aDxyO0XbyKfW3iGjNlsPi54EyZkqgwg6kG
	 DPGD5cq2MVcOs2sTY5i7jnDEdJZGRxzQLY18YYKA+cnKlrdynOTyY4KRHgJ4cwz00l
	 VJZrsaYBqlWYU/PmDv7ojSIg3eUABElDL7C5mSTvRauAD357uSeoQ1Lb/SyrWvNYyY
	 UihkXydrzVZ50UITwZBTjc6iQM9R1OajxmT2LAw9HARyM5+lLkyV2EjkBgUu6kVx9B
	 FP357Zhn3+tOQ==
Date: Sat, 30 May 2026 06:02:01 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 1/6] power: Drop unused assignment of
 platform_device_id driver data
Message-ID: <ahoM2TVy6gXCYewa@tzungbi-laptop>
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
 <ba3589f74a12d86fb02ecb9fa2e89532188c22a0.1780048925.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba3589f74a12d86fb02ecb9fa2e89532188c22a0.1780048925.git.u.kleine-koenig@baylibre.com>

On Fri, May 29, 2026 at 12:18:16PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> The driver explicitly set the .driver_data member of struct
> platform_device_id to zero without relying on that value. Drop this
> unused assignments.
> 
> While touching this array unify spacing, use a named initializer for
> .name and drop trailing commas after the list terminators.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
