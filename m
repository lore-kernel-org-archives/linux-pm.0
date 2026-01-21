Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE3F42848D;
	Wed, 21 Jan 2026 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981147; cv=none; b=gHG7NywTzulylqrHJAGhVAvtA7q2WRuNIOObWlzm9QmzwdBLoQEipgkHvM2rJy3jxYCYItUL2+WLqta5osS5hYe0dNQN+kxQjNe03/XMqRGvh8nLBAKRqNSKx4IkSoqZuDijJrSxqsWfRC3SFjCy6dlfO/6CcNTv1bZSSoU6QzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981147; c=relaxed/simple;
	bh=4et9JHew/IdYpHrx5sJKZe5TCwDkvEZYKQ+G1qbL3W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrf0NrfpD5zMR4mNb7Sgw2NSTvRDoy/l2v4MM8TGqBV10aaCm33P8iOGmsNNYy3HkLCxpymUQyEMpBGlQW5CSmGs1DHFHETwaiqXGZVZEmhd0qHXReoUHCBInF01+VHWpjyVatHGfDB359aA+ZdeMtgKWICnk3ZZwxY46uu1gz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV79uVea; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV79uVea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F812C116D0;
	Wed, 21 Jan 2026 07:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768981147;
	bh=4et9JHew/IdYpHrx5sJKZe5TCwDkvEZYKQ+G1qbL3W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eV79uVeaXCUcFkxkK93//P7zK/5ptiki/tM815EvPgOl29+XW6dhZmMBsBYVEWtLB
	 w7wBp5MjTYVnFv/hFi0Q1C0VDtt/VMtSJ6xcw/guwQ3k1GF81G3LakcAOakN121mLO
	 hFN7dXogNqqI4fG7iU9AeITbJRIV49WOPPE5d7cEJ/jVRwQUbzsY6ceyITX3Xx8cRE
	 LzY29mroVsFS9Ey+rATQtxyQFjC2P96fGuoTrddIIFtCtLFo3yzdo/jOoMPGviDpBB
	 Bfq1TkdU0d7RlaQdl90UskBJPKRBYun5G5V1XH49koZE9aYT2DiG0lJIPUSJrvQXNg
	 XFNCT93IWwHKA==
Date: Wed, 21 Jan 2026 13:09:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	srini@kernel.org, neil.armstrong@linaro.org, sre@kernel.org,
	sboyd@kernel.org, krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
	luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com,
	Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v8 07/10] phy: qualcomm: eusb2-repeater: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <aXCClgUXYJPEpVbE@vaman>
References: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
 <20260114092742.13231-8-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114092742.13231-8-angelogioacchino.delregno@collabora.com>

On 14-01-26, 10:27, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrate an USB Repeater device, used to
> convert between eUSB2 and USB 2.0 signaling levels, reachable
> in a specific address range over SPMI.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device for EUSB2
> and initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.

Acked-by: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod
