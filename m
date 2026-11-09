Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187379;
	b=UO3ja11nSSOumPLdqjdbUDS6ZozpMhN7QCxlMnmBl5HEAjv864gVpZwt/dvGIqES2dXx
	 qTf4r9kLJlQOHyQrJ7f2zsWcANRaDQ3VWRnLG5b4xZ5F00Ka+BrHKljv4zrclaHid+VYB
	 4XLZJ0rZgbxx9A9OdS7oLefjO6AwasZ5kds6SFKSa9OwlXXkqt1HZctFa4oFCuxxUb/zo
	 djnAZAZiLJOhLgfK+W680vtgQ2Wmwxt7v55VV9xl9QI+pMP1ViF2wvZr35Dfsvs8j0PpG
	 eXtZzFdqBt9Wk+c7JT7eTay/Z+D7kM3xV4sqh/9TnpcNjlM29dHoAZDwk+yVvmAMzPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187379;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=57TiHluZF0TraOBXBCRHy4j9KLpKtaSSnS+xIB/HzZc=;
	b=CKytCftfSILjAeDJw2f4f0GrcUPLLBtY99PwBfCOTGwVhbRS/ofeoQ4cUtnyfa3ChMHS
	 ow7Y+5GCZ5Qg1+313uc4FoZrji27loz0xxNOti1X/5mnWv8ePg3ACvtW6qotU3ImobhEU
	 qK1ofg9vgvbWkrWXpe+n5nzaRc3FN1kfwggd91OMbaNPGmK09K6DjDZlCltFjcCME8Fef
	 4Wj44S/CVKjWrkvxHoIkjyfisjSVBBHNfA75qnDzREuaTusbbeOwVq0NTNmhZeAoLMSoY
	 fr7BWS98E3bR1X7dE7dHkZBpdfASUthq06KYTpW0fmlhICCo3XQMRTNoqWwP0S0r42Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3A606D834;
	Mon,  9 Nov 2026 01:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2681F00904;
	Mon,  9 Nov 2026 01:22:58 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id F00981828E8; Mon, 09 Nov 2026 02:22:59 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Fabricio Akio <fabricioakio@gmail.com>
Cc: Robin Snyders <robin@snyders.xyz>, David Heidelberg <david@ixit.cz>, 
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261008-qcom-smbx-psy-race-v1-1-cb49fe7b4336@gmail.com>
References: <20261008-qcom-smbx-psy-race-v1-1-cb49fe7b4336@gmail.com>
Subject: Re: [PATCH] power: supply: qcom_smbx: read the charging status
 without the power supply
Message-Id: <179418737996.1255445.2065619025083533810.b4-ty@b4>
Date: Mon, 09 Nov 2026 02:22:59 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Thu, 08 Oct 2026 17:56:18 -0300, Fabricio Akio wrote:
> smb_get_iio_chan() reads the charging status through
> power_supply_get_property(chip->chg_psy), but chip->chg_psy is assigned
> only when devm_power_supply_register() returns, and the power supply
> core already calls get_property() from inside the registration, for its
> uevents. If another driver has taken a reference to the supply by then,
> as a fuel gauge naming the charger in power-supplies does, the core lets
> the call through, and reading CURRENT_NOW or VOLTAGE_NOW dereferences
> the NULL chg_psy.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_smbx: read the charging status without the power supply
      commit: a291a224a0f42bafd7a3e013751f897662c3affc

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

