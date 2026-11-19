Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094590;
	b=S8M9RVwe13Lc6ogJNJ8fzfftOEs90LKKY2vlZfNd5ZtNaNOikyUStpbbOgJ4xlk24VMe
	 Cc8REbm9Y120aNvvyOeG0gGwKZ6seD77pW2dFOpW6pBEdDjAmLt1o4/BJh4qse6iSbci1
	 Zvu3QS/3i0Nanew09kW/ualEpn/RGL+Aer4SJXaEdkVkdJp1sVWQcr1K3RhJL8qHT8fU+
	 z34sC7oXuc73u09NxJZ9qaBLyroRuD4Q6qrV5rk5O3Ld7AE6281Z0dU4hNvpVGEtNDGr0
	 DXbKe3S9hJv5mfYPgYDKfx7TXf2kVVaqebAo/ZUp6uFYMZh/gU8CXHyZfQPrudTjY9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094590;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+3mziW4OTR0bVGWOCf4uOQHEgv/QROyf9E3+q1WrjGw=;
	b=qAFaOUBlEpw1hCJ6iZfSaH89By/z5uNqlZCsoFe+KbJN33i2t/CsKqO9kbgszjvd26MW
	 TmJ9A3TYH9vbzDkPAhw81WwIzzlyb7gn9WXl02GeZljBgI9xBd49v2ATYodg/kTQwrDfX
	 7GtnUDZjn9RamhSm3iS9Ie7W0iLeIrjtdpuEa2WjtDKeSBS56ykfprYEp8Gterjsbp+Dz
	 iNh/n16Eyg9vbLS9/e3rKRazdY/tSXiTBmH+2TXTz82Sw4xv8kNLRFUsXtY79/5F8PvoE
	 wZaDdPr+rsiR2Czpy91+XyFdBB21OcrRtQihaP5oTeRlhrUiyv54eojcjr0kKHugPPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE3606A320;
	Thu, 19 Nov 2026 13:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E41A1F000C5;
	Thu, 19 Nov 2026 13:23:06 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Ulf Hansson <ulfh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] pmdomain: ti/core: Miscellaneous cleanups
Date: Thu, 19 Nov 2026 14:22:56 +0100
Message-ID: <cover.1795094118.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series contains two cleanups for the TI OMAP2+ PRM driver,
and removes a now-unused generic_pm_domain_data member.

This has been tested on BeagleBone Black.

Thanks for your comments!

Geert Uytterhoeven (3):
  pmdomain: ti: omap_prm: Use pm_clk_no_clocks()
  pmdomain: ti: omap_prm: Remove dummy generic_pm_domain_data handling
  pmdomain: core: Remove unused generic_pm_domain_data.data

 drivers/pmdomain/ti/omap_prm.c | 15 +--------------
 include/linux/pm_domain.h      |  1 -
 2 files changed, 1 insertion(+), 15 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
