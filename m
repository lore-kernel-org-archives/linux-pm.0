Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD533343B;
	Fri,  8 May 2026 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261005; cv=none; b=A+QZfCACdyD1TGCufP851OCDTdZXfuYLGp7GhVvCaX2WeMxbr3nLMxxnMGX8vkmtxMBkLkKNxbSO2Ka4X87wkce08/L0x5wbS42FHJ8fnPh920G93j3wiDWRQ/nUgvna+euQTZdomWokQhdNWtGyWfEtilVfmmpnhWY6ehgUpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261005; c=relaxed/simple;
	bh=TFQkQXyKv84NgZJKUYb0Iy0idhOUNRSndREaqQZIkRk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qOde35RHs6N07Cil4Xr26Xg6uqcEd7/rFc081e7TzlVD6oYE3l6X+GwjpUu3QApuFAu9x89K1nNjS9iJrx4ocAqV7xf+pKDp1D9d1arTiCmkOEfkZUBdodw+kcVzvgui7fWf0XNg2O0vNq6X2vBbbmMvo9uA7BMfXHCHNGnEb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCgdHjfG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCgdHjfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA012C2BCF4;
	Fri,  8 May 2026 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778261005;
	bh=TFQkQXyKv84NgZJKUYb0Iy0idhOUNRSndREaqQZIkRk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=GCgdHjfGZXy8jGGE+xmSpJfA7e104Hd0MQ1+eazHw13oTcfTUS0g7Bx/0Ojk07LkA
	 wKSUSITlY3ljYTdo6nJgzELgkJ/3XBdoD1tg37Rz9ca6zSkrHhulQRmHY5cwZ+jq2/
	 B2hiqx1b0gpcrWqNHO+ka4O0Yt6V1zPmu7KvJfwRQjaPi8nVt0BCRoLQwEH3YFGvcP
	 QEhTmPHqW45DA8FwVgJuFjhARA/tbdtXFqZGka47L+BZhmoiyxDV+CKwTRHvvYHS73
	 1r5Eyn/0NDE1FZ0DOlZYBUgOXgeM0aXq9KHKmaa4cDlRyRtqVgLsMgnVY0vD1Gz3EP
	 jC5xmtMdHSHxg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 19:23:18 +0200
Message-Id: <DIDGWX6SA86X.29W19V2YX54GX@kernel.org>
Subject: Re: [PATCH v3 01/13] Revert "driver core: move dev_has_sync_state()
 to drivers/base/base.h"
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
 <20260508123910.114273-2-ulf.hansson@linaro.org>
In-Reply-To: <20260508123910.114273-2-ulf.hansson@linaro.org>

On Fri May 8, 2026 at 2:38 PM CEST, Ulf Hansson wrote:
> It turns out that the dev_has_sync_state() is needed outside the driver
> core. A subsequent change to the pmdomain subsystem starts making use of
> it.
>
> Fixes: 9db268212e0d ("driver core: move dev_has_sync_state() to drivers/b=
ase/base.h")

Hm...the commit was correct, it's just that you now want to use it outside =
of
the driver-core code, so I'd drop this tag.

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
