Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961446DFE3;
	Sun,  4 Oct 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136002; cv=none; b=TJeFMMhHxww9ZYwKEooJjJuw0/AH2qB/0Pr5+OiCM+lX5D1eyT5GbOrRwsCjiqdeqRV2EwMlNd7yhtV4ERYDrL5nrhWwJR1WPZYwMFP7jethNnlEOj3/GHv5LONBCGe/pGyghG4OsQdMyqEBDWPGXltZGrn/H3xVa5VOEteFvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136002; c=relaxed/simple;
	bh=v0xrrBf1xuLShqFGnK8zaunNoXZsrY9DCQw6T6lnJKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qMRzeEcsd+17nPCEj0jIPJwwvMojwtyrYJ6risxj4zaCIMy+VHOHA+yP1PT10abORipLr+33WYGuyGho8jYtfWVkMcp0iWVOVSiHYRtTsNcgjxJXl5ScHTdlftmimQF2EgnDv4OV5rGKZ9UxKG+iXo8zv/ZI7N3Euj1Ligqu/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3381F00898;
	Sun,  4 Oct 2026 17:46:41 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D04A4180A51; Sun, 04 Oct 2026 19:46:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 "Mark A. Greer" <mgreer@animalcreek.com>, 
 Anton Vorontsov <anton@enomsg.org>, Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260928-rbrue-suez-upstreaming-bq24190_charger-no-reset-regs-sys-suspend-v1-1-9a7689f12c05@gmail.com>
References: <20260928-rbrue-suez-upstreaming-bq24190_charger-no-reset-regs-sys-suspend-v1-1-9a7689f12c05@gmail.com>
Subject: Re: [PATCH RESEND] power: supply: bq24190_charger: don't reset
 registers across system suspend
Message-Id: <179113599782.190565.11023865790657472548.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:46:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 28 Sep 2026 17:26:17 -0500, Ryan Brue wrote:
> bq24190_pm_suspend() calls bq24190_register_reset(), which returns every
> register to its power-on default, and bq24190_pm_resume() does it again
> before re-applying the probe-time configuration. On any board that wires
> the charger's interrupt this makes system suspend unusable.
> 
> The reset re-arms the chip's 40 s i2c watchdog. bq24190_set_config() turns
> that watchdog off at probe, deliberately: as the comment there explains,
> the same write also takes the part out of default mode into host mode.
> Nothing pets it while the system is asleep, so it expires, resets the
> registers again and pulses INT. The charger interrupt is a system wake
> source -- armed unconditionally in probe since commit f385e6e2a153 ("power:
> bq24190_charger: Use PM runtime autosuspend"), and still enabled by default
> after the conversion to the wake irq API [1] -- so the pulse wakes the
> machine.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq24190_charger: don't reset registers across system suspend
      commit: e0844bd22a9f97885882bde3c4a441710e895240

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

