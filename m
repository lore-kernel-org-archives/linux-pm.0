Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E11B34F483;
	Wed, 22 Apr 2026 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857453; cv=none; b=Vsbuh7VHIBGD1gIpMhPoqlG41VJOPzuUFAQwlviGFPCIvQP7iCSVQHwxvTr9rOX388lvZm8ewjju3oVRyt+Hog3rnoBQGwuF5E3P5IgkTBP4OooYOyCgidyNsLCcsNTc+hF8DJX3OXdSH/igAtSkIGlS4UIxgoWsum15euME1fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857453; c=relaxed/simple;
	bh=HNP7/Ly2fmpYkbHHqHZ+20Ii3h9E4ykECwdUZjI26UQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=dBDlIurvA6O2orWyCp+rw0Y946PNQf98PV28rmlAgQnbmZHEG4h9oS/dbWyi3D8Y0iiSiLUGYDtMvSgCQ/rbxZAHzvXDsgfKnPuihyS6XyMORlB9cf4+/NMyysNc147XCng6H8VS3IWd4cEV9m0lbbl+x01a2r5PA4Dq3XeeEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaYqL1Yl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaYqL1Yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B173BC19425;
	Wed, 22 Apr 2026 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776857453;
	bh=HNP7/Ly2fmpYkbHHqHZ+20Ii3h9E4ykECwdUZjI26UQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=FaYqL1YlDhE1HYa/LcbcDJ8V7tVVrSHb7V1o4IoHNll4KRUQ8H+M25mss1toKLIdW
	 OR3y0d9Qf8lk2QMWsX++1jl3Sxa5mfL82rHLfpC5eanFr9xHTgy7WwSgOLyGt2Nhp2
	 1EGpDUazMCn7F/u9n+FvUerpJJGa7LP1/HjgnMGX83syMgqD9D24gOyvQRe/Vfm7uK
	 H4KiJgUU8v4XRp6RCwlvyEolSzUDk0ax/C7biCu3EbT3p5fqEy2D8fgRg90Bd9uELF
	 slZhs258Q8kiLCP4wtbhut5X68vrk4CBixxNKpMQ43ldaVtEMQlmm5vXJlQADzEtD4
	 aw9ymdu6p91vA==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 13:30:47 +0200
Message-Id: <DHZNEABUEFY3.19CX7BFMMTBKT@kernel.org>
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
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
 <20260410104058.83748-3-ulf.hansson@linaro.org>
 <DHW8QV8K3CM1.307C6PW2BM5RN@kernel.org>
 <CAPDyKFpeSv+fg=YKJE_qc=Q5BfiJFn0tR7Ar8SncqrD0UW1P1g@mail.gmail.com>
In-Reply-To: <CAPDyKFpeSv+fg=YKJE_qc=Q5BfiJFn0tR7Ar8SncqrD0UW1P1g@mail.gmail.com>

On Wed Apr 22, 2026 at 12:25 PM CEST, Ulf Hansson wrote:
> Most of the static inline functions in device.h lacks documentation.
> Are you suggesting that we should move towards documenting all of
> them?

I'd prefer that, yes. After all, if they are defined in device.h, they are
public APIs, so they should ideally have documentation.

(If a function is only used throughout the driver core, it should be in
drivers/base/base.h instead.)
