Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3100412FF75
	for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2024 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349869; cv=none; b=c5XwtYF3n+XXZfRmoR6UES+yrusxktsnEvznQ6FiIEPWPH3A0f+eb9VhKo8Pe+nMazHdU4eu9wH452DhmwqZAGl28Ehof6+pQClGl6uU236rXF90S+HQJe4yhvRgc2pZ266v9daKX7WNSKq90uZKOakZOcwjv3iAHsigdmykZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349869; c=relaxed/simple;
	bh=uMk476Qfvq8I+MBT3lTJPgD7xu89awd0nrAdkxuUy2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OHgtMDOT/lOEl8BsyruuGQiqdqCmKfenZRWkw87kfbtklpb7UPvURxVaEO4TzQlneuN0eXNolWdjjd1nX2/Mv1Ctb5JdqBkrzIUAfD7fhY6rQbUOfxa5KH6VC09MirSP8cSKvRkJ4a+Klm53n2NZNL6278/V2Zq71/UlcM58NtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by michel.telenet-ops.be with bizsmtp
	id CAX42C0060SSLxL06AX4s5; Wed, 17 Apr 2024 12:31:04 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rx2Ye-009LEL-0Q;
	Wed, 17 Apr 2024 12:31:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rx2Xe-00FLRx-Am;
	Wed, 17 Apr 2024 12:29:26 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] pmdomain: renesas: rcar-sysc: Cleanups and R-Car M3-W quirk handling
Date: Wed, 17 Apr 2024 12:29:21 +0200
Message-Id: <cover.1713348705.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

	Hi all,

According to the hardware team, R-Car H3 ES1.0 and R-Car M3-W have a
rare quirk where powering down the A3IR, A3VC, and A3VP power domains
requires an extra delay of 1 µs.  So far upstream never handled that,
but the BSP has a fix[1].  As support for R-Car H3 ES1.x was dropped in
v6.4, only R-Car M3-W still needs to be handled.

The BSP fix relies on hard-coded string comparisons of power domain
names, and thus applies to all R-Car Gen3 SoCs (many introduced after
the original fix was written) having domains with a matching name,
whether they are affected or not.  Hence I took the opportunity to
refactor the R-Car SYSC driver first, and came up with a less-intrusive
fix.

Thanks for your comments!

[1] https://github.com/renesas-rcar/linux-bsp/commit/495e47e390499c522197352a08f423e8a3b41e83

Geert Uytterhoeven (4):
  pmdomain: renesas: rcar-sysc: Absorb rcar_sysc_ch into rcar_sysc_pd
  pmdomain: renesas: rcar-sysc: Split R-Car M3-W and M3-W+ sub-drivers
  pmdomain: renesas: rcar-sysc: Remove rcar_sysc_nullify() helper
  pmdomain: renesas: rcar-sysc: Add R-Car M3-W power-off delay quirk

 drivers/pmdomain/renesas/Makefile             |  4 +-
 .../{r8a7796-sysc.c => r8a77960-sysc.c}       | 34 +++------
 .../{r8a7796-sysc.c => r8a77961-sysc.c}       | 28 ++------
 drivers/pmdomain/renesas/rcar-sysc.c          | 70 ++++++++-----------
 drivers/pmdomain/renesas/rcar-sysc.h          |  9 +--
 5 files changed, 43 insertions(+), 102 deletions(-)
 copy drivers/pmdomain/renesas/{r8a7796-sysc.c => r8a77960-sysc.c} (64%)
 rename drivers/pmdomain/renesas/{r8a7796-sysc.c => r8a77961-sysc.c} (69%)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
