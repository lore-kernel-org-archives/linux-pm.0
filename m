Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28343E09A;
	Sun, 20 Sep 2026 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925995; cv=none; b=WY352B1p/ERea3IWzZuID9n8toJfNqMTr97u3/SbUBlaTZrY/yOzJ5EghLME2sP6lGvfGPTb3CGbQLbvPS02sXcT+aqfG8UTfjr6QzjJOmZZKvADWMUyASpiAc1bMGfBJld0Gy9tMgwipwCD6NCZmqF3q36NvOYcToKXCeQh9GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925995; c=relaxed/simple;
	bh=8+H+gL1/Hzq0lYQaO8eMja+G+7FfFOglvKku6QLivc4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=O7d4uTje7Q9/9Bszn7YTvRV4AXdNJwNQS9fSap+1n8bQm83bLU3Mtr8QrBeYZxVYCLbA6iOc7L6F+unjpVEK5BdjUZaRFlD4drIbaEc7ZaBSVqYDCzxwteXicZEh0XK2Zu42D/x7/TDn2sBLDQH3zWXYnxs4MK/wVTPxTNLvtVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIWwfVH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIWwfVH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E061F0089C;
	Sun, 20 Sep 2026 17:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789925994;
	bh=9rx7oMky/f3emHeZ1IYk3kY41jLebnsAhERuxEXFF7c=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=MIWwfVH2YbmAyaZQ7wXtH4Lh4lOocbyKBG1Lz3zChQZUC9NcQ8Auh+Err/4cETBOI
	 dFjJqu1GozrKpzSqeGTP9nmjBkwqdGZR0mhJnq38EJw4r+SGzzFlQd/FqL8Zw2SCUo
	 IEtyoVxrSUH3C3V6LxkRxLVojigRxGSh4jAZyd4Mf4TfYI2GBVZ3bvUA/Xt1uTMuT8
	 V0KJ8FBkNojzQBxniplTHPulyXzcM5yYs61elpm2dTPLUJCIRQcnem12K0SYH/Mc1L
	 Tb94J+IEXbVaZ+16SoL+qxcLDOqawhPk8GmtRgjd2BSyBxSNt5B4pIAVrW0zHhArtk
	 dSCPsDgJxcyvw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/8] thermal/drivers/renesas/rzg3s: Convert
 calibration defaults to per-SoC match data
From: Jonathan Cameron <jic23@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Chris Paterson <Chris.Paterson2@renesas.com>, 
 Biju Das <biju.das@bp.renesas.com>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260918150730.122056-4-biju.das.jz@bp.renesas.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
 <20260918150730.122056-4-biju.das.jz@bp.renesas.com>
Date: Sun, 20 Sep 2026 18:39:26 +0100
Message-Id: <178992596602.706584.9614398230910896614.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=353;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=8+H+gL1/Hzq0lYQaO8eMja+G+7FfFOglvKku6QLivc4=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsBpnGkXbqBVQJx7Y/qhyo1BdFx1NFtKDhlEwX
 G1VfiZKKOqJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarAaZxEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiB0AD/wNueQzh1sC6QzKVFiwy7gq+KJZZxiHmXHmnelHd2Hm0mm
 OxLBBIcndN2AflaCAkjOmeDndknfbnAFWRalUNwyQZOFvXSjLWe2+0Iq5ZepXfoKn2Umq8qsqIe
 Y2fccwBnMPUeZsu4k1DwtnQI0VqHrmzPv7zVAvMHDI7el5hiZmPxRFb/gptH311LYCdLIwfcf8l
 k1Xm5Yq7jkuGkfLBtT6X6zY7ZetX4HrJhTYR0nQQF+lkDiqLCPOx5zKS8A/vH7TaGKLvJ/Ofni+
 BAc2woAl/yLM/F86vnRxcyTrtcrtvTi7WR7uLOOEgHueBnJT6YFVlHcfCruO3ULYVXLT7ENY9pL
 L5THsAFnJlvTxL3BZtqkOSZs3YGYa/CF/dCW+nGt9Dhyc7k3kyb3Gjnr8Tc1YO02P3U3AYrcl4X
 Kf0odrqGP0VXnq5kMohmBFRf/TyCb8JzapbpPB2Ah+qziETssJE6dwU58klzJNPN8tfQAIFLGvb
 94IFBOevIbpe1lSecd1gojWrFQHwVJ09HKa0Om0BDXIZEZi+lar4r4U0gNyZqpg6RMgrxU3yol/
 ZbsFlcWXNeDdhD64g0NybxJZ1tdB4o4U19FwcxFyQv1rdiCmckYc4EHkCrJKIwENiurGG5Cc7Ly
 C3oMcDX42hvbRs8lwAykB2PIRqjPrWJt3odPUkQ==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add the renesas,r9a08g046-tsu compatible string and its default
> (software) calibration constants for RZ/G3L, used when FUSE
> calibration values are missing.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
