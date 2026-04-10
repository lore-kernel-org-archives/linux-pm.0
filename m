Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03738A299
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817669; cv=none; b=pKcFRT01VtALzKvCQpFYVnssb4Mtz+cIWCKve2+Yf4TpNzuZ/5RSFwyf0/Ad+rGtgFffx+BlPrzCvmcD7gChG6WKRvN2JuyjgXBW4gerPcTiP2d0SdxL6SM5bzQL/xmj8PZ7I/V97NBVKjU4/tiXQqoTt6GdCDkcU0CP48/agBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817669; c=relaxed/simple;
	bh=LiIgfKRUPkxLgWxsD2Rxri8doxXg15GJD56xje37HYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUMPXGV5ZhyoWKeJyvYrzDplFF+SluIUTRdmh9C5CgmexzHmSXQgF+ZIJIS9Kz1JZXoA96TKhk16Dw+M0/5c2cKhUHtvkpw2hfF8A1rxC2r54AVvWFb+soIeZV9UvbyTXR0bEGyw/gVgazRoUhpme/U6oSuzCWP34gvy5+7XiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AtVfsK5j; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtVfsK5j"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38ded5277e5so15349461fa.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775817666; x=1776422466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1NWY+BWGARd3KdW9zy3+VOHdHry2FwciZ1/FvhAvLg=;
        b=AtVfsK5jPCVR5J1USbJ4C94Ejbyh8UlOchYoFyYN6MO0oJvOjICWgAdV5Lz2mfLcId
         Qi1t9uWF1c87ThxEJ2kRwWWUHr/yuh5yXNPR6A3DOSZ/2BD7pTlu8bXNlWbJOgu+X2C4
         e2XOQOR05+dTrdkAdZThDr9ef9YJvzUcuFIdetWOiLZslTqsSAMxOGC+I0kUH8ls3yMH
         /Pg3i6UOFfPe75YxdexHtyPTlOsnXHBCRVat6byhiyvXfQml7oaIWCYJ0FzkUzUFXC0W
         /kPO2kXnAxhjjsAoHTwah9599OcgtqGm5bqDPATtlZIe/I7/6+URoKTVC/fGjRMpx030
         MQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817666; x=1776422466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1NWY+BWGARd3KdW9zy3+VOHdHry2FwciZ1/FvhAvLg=;
        b=I0illPbz1obNPx9+WXCkaU8LHH6W89s9z9wDdW85s8ZQLI7io7HRp9/rrM/r6dGKiz
         LhW/8MsGoqoen+8Uj7qCF7oBiACFo9LspHkYQzSKs2LTNmloBax7j6XJQhjp4EdLQVbg
         lbbXuRUePA4Sc1INQdHegMKkaG+y+jPl58fWQb+FJMmpgjpr1zUgbO0PNNI8fgb5gB1w
         2QC0klCsD3G8B/sdP2KbMYSFeXUUSvck3J9w1UpwYCsOL7aq2hR87Gb2PAfD6iW8HAZC
         WCmDkO2fdPc5yKcbee8EXn1zybpW51HxXdhOarLXoqArBD0a5OalIaRAaN6Dc4f9DKXI
         LjCA==
X-Forwarded-Encrypted: i=1; AJvYcCX5PnuxA2XOsQOp7shzNfContwxWEjujq+JFcp/G4h8/gmjlODWu1LXaZB4i6tV31KdwgbJZWdc3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRhgmooAwwdfwWW9RzXdsvCb4HHip+l68bB501C2XzzgZa/SAC
	RD3nRNYY5fF9WeppyzfB32qkIKqneNfuGucFIXeF/wD/oiwDHuqaJHsWgsJZ2BFMYO4=
X-Gm-Gg: AeBDiesNkBl8KsV0cf/Bo1fdm/JeE26YfDjKBLHu6QGfHP2348Qwq6mg/AflWbvNQAT
	OzWpDBcQbiO00gt5nBFgf6s7W5hrj+Hmop+f5QQnfG9aF3EadwcSLfdfIy/s0+93fUFVFhFPsHh
	XOlU21DO8t7edecqbZQUm87cTvOjaTDJvSvL15UZTtfETSQ5zesF35b2ooMqOtz+AIhSE/zm5/j
	DWL1ymdFV4qiFURD0i34IBZuFW+sqW6eFmM0AnnUqNNmkgWYQDmsnA+ZtsA6jEl6OCISKCiyagi
	5huCE9I5QUAArUhIcc2cOCS89/sWfdFhLLqd6UhLLSWnI8vIFCVuA/eaxgX1oAVCvTSDwRjx038
	FuKSBWSQGJ9yz8fkFKcVDMKrkb4x8++I9+DL6Pg6iCHXP7fJoJQM6IrghPwf214Fy+ucCKKa4i0
	ba+nxEp+P2zvIkDpWYmDYWz6i69u7eNSM0GWUvcXiL3XqKKmrNeWnTu+2XACJqOqCfQQWyWKPB
X-Received: by 2002:a05:651c:f1c:b0:38b:50c7:8239 with SMTP id 38308e7fff4ca-38e4befac2dmr9365121fa.21.1775817666197;
        Fri, 10 Apr 2026 03:41:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495455acsm5588331fa.23.2026.04.10.03.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:41:05 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] driver core / pmdomain: Add support for fined grained sync_state
Date: Fri, 10 Apr 2026 12:40:43 +0200
Message-ID: <20260410104058.83748-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the introduction [1] of the common sync_state support for pmdomains
(genpd), we have encountered a lot of various interesting problems. In most
cases the new behaviour of genpd triggered some weird platform specific bugs.

That said, in LPC in Tokyo me and Saravana hosted a session to walk through the
remaining limitations that we have found for genpd's sync state support. In
particular, we discussed the problems we have for the so-called onecell power
domain providers, where a single provider typically provides multiple
independent power domains, all with their own set of consumers.

Note that, onecell power domain providers are very common. It's being used by
many SoCs/platforms/technologies. To name a few:
SCMI, Qualcomm, NXP, Mediatek, Renesas, TI, etc.

Anyway, in these cases, the generic sync_state mechanism with fw_devlink isn't
fine grained enough, as we end up waiting for all consumers for all power
domains before the ->sync_callback gets called for the supplier/provider. In
other words, we may end up keeping unused power domains powered-on, for no good
reasons.

The series intends to fix this problem. Please have a look at the commit
messages for more details and help review/test!

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/

Ulf Hansson (9):
  driver core: Enable suppliers to implement fine grained sync_state
    support
  driver core: Add dev_set_drv_queue_sync_state()
  pmdomain: core: Move genpd_get_from_provider()
  pmdomain: core: Add initial fine grained sync_state support
  pmdomain: core: Extend fine grained sync_state to more onecell
    providers
  pmdomain: core: Export a common function for ->queue_sync_state()
  pmdomain: renesas: rcar-gen4-sysc: Drop GENPD_FLAG_NO_STAY_ON
  pmdomain: renesas: rcar-sysc: Drop GENPD_FLAG_NO_STAY_ON
  pmdomain: renesas: rmobile-sysc: Drop GENPD_FLAG_NO_STAY_ON

 drivers/base/core.c                       |   7 +-
 drivers/pmdomain/core.c                   | 205 ++++++++++++++++++----
 drivers/pmdomain/renesas/rcar-gen4-sysc.c |   1 -
 drivers/pmdomain/renesas/rcar-sysc.c      |   1 -
 drivers/pmdomain/renesas/rmobile-sysc.c   |   3 +-
 include/linux/device.h                    |  12 ++
 include/linux/device/driver.h             |   7 +
 include/linux/pm_domain.h                 |   3 +
 8 files changed, 197 insertions(+), 42 deletions(-)

-- 
2.43.0

