Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6C3B8BCC;
	Tue,  2 Jun 2026 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392127; cv=none; b=edpv/krad9DkSQwWaBgb114RALj8vrTCeJMzI5G5M7Ksa78RjscvxEldM3cZqdS5erGzp7O07R31s5Q9vjZaX5MBNvccLJ+pMrR9xsoqYsAnGFsyboxOxK5pD95LMQkm+l3R+lIpNK0HvErLXu5g8Wo4f7oCBcgM2r9aLurJYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392127; c=relaxed/simple;
	bh=KTPH9d936NwJo1Mh8SKDjuMqfRnkaJQv8x8L+m3wKDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RmQ2qPSjh+9N/dMDdNxvQZdwIckWEvQimHgdZPBY+VfZJ+3N8+v9HGcOp8tkMGKjVR61cmRl2GjZyC8mY8WpmT/0LTqpOGf5b94ZZJP9PnCzJ0H+yfa1VmaSuDbDXgilCHOYZgK0BGfcTRA7MfPkUKqeW78rPDAxEc4LAPZwgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=Vxx+fi9L; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="Vxx+fi9L"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E8CC3EBCB;
	Tue,  2 Jun 2026 09:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1780392117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maGfiGz3651+9ETMqgNHD/f7aiB1wQ/AjvE6R8VGXXI=;
	b=Vxx+fi9L+xvtMCBx2WMAULseztxHFuXU2JTI/sXyp0FaYxsgNw80TM9+Jm6hXAYfTJ7Aq7
	7SXCtKmYxQ9Rhyp0Po+fWUe5NwcqPBB7OjFsuL3a+VRJHPUtpkjl+3W0UIs26KgxDOYwkh
	jC6hzuQKRsLDml2Im/cmYzMo8LNxg+YWmPtOV0HvswolZh14KzBPcRLHS4T7xm77S2B2vI
	M+5OJ6ITUclTgvQyAqGn+teiDVBjb7WcLa6BQjOiDOzzxnBKLtMccKpLq79nqVjWSo6j8X
	YG4E4qJhe9a8DnKIaQTWMnFz0Sgbxfns3ULTUj/LNBe45Qj3aG1BiQCXdLQZUg==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Tue, 02 Jun 2026 11:21:21 +0200
Subject: [PATCH 1/3] m68k: coldfire/5441x: define RSR cause bits
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-coldfire-rcm-power-on-reason-v1-1-fbc3eab0c016@yoseli.org>
References: <20260602-coldfire-rcm-power-on-reason-v1-0-fbc3eab0c016@yoseli.org>
In-Reply-To: <20260602-coldfire-rcm-power-on-reason-v1-0-fbc3eab0c016@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sebastian Reichel <sre@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780392115; l=1818;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=KTPH9d936NwJo1Mh8SKDjuMqfRnkaJQv8x8L+m3wKDs=;
 b=iPeHe8UOvqgUQxCf0yUrmta7s0BpvX0JtaPXa32cOwPUi2fMRMIT8m3WafnCkitFkHAUH3kvk
 wv7CqEW8YeWA7mL76dSzXfIwIXPTlyROxS57YRJsittWBQcQ92IBjdm
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGZnDm+qP+IIE8q7fl0ylzs7vW7XFxPlmP9Riz87oMhwGzvZZIRYplOiORTbDN4OXFi+K8S2y2wJ8ELCaUF0EYbuKfNpj66kov/TBETXf91nZVoCTSEd5oiOHPUy0ZWxAVHyVHYvFebNY7AvzJ3lwSgiyYVHRb3qBly/HEuWT3b0eg/9zAdM6HpyoKevIj6OrQ2Vd9YNKpuoNFww5O3G3J2pO+gQsOqZ+sx23SLGeri912Jce4X53gaqVGP0yw+/XcvDwx/KK9V/NlfOeLQ9vLhwxat1T0K1eM8xFbdboKRCu6vrqJtqumZptPM87DF74+OnKHNzc5wncqIWGB4RswGFz4rRd7XXfVdi2gIywrbBwd3PSjJsl3YCs8I756AFP4B/yTCaDkQuFZBbQzUDvxmjbXXwMiEFHRtnI7AGA7ore7sSnFa/yd508ZBNM6CcPsQBvtaCsN8Qv+8J1Bgyq18UG5R5uYl2nPy840dZ7fH2Rj9InLZQdqeeQ45znRaFSUonsW2iHquDou/DFAqYzejRw/SHIhZ25ocN0R0u4xbdu9lLjsWIrTFvXV7Xp2AKcmpjQk5yyDVhBy8PBwaVq5ffi1j4v2K1bVLRNdCBNEd/vL+JYwO9S+IX4VS+FK9J24abYDWGha3UNSl6EOuR5WU0ZGdHoEqwbFwA0D/HO69Ng
X-GND-State: clean

The Reset Controller Module on the m5441x already had its RCR and RSR
register addresses declared in this header, but the layout of RSR was
missing. Add the bit definitions for every cause documented in the
MCF54418 Reference Manual, chapter 12.3.2:

  bit 7  Reserved
  bit 6  Reserved
  bit 5  SOFT       software reset                          0x20
  bit 4  LOC        PLL loss of clock                       0x10
  bit 3  POR        power-on reset                          0x08
  bit 2  EXT        external reset pin                      0x04
  bit 1  WDRCORE    core watchdog timer timeout             0x02
  bit 0  LOL        PLL loss of lock                        0x01

The RSR register at 0xec090001 is 8-bit read-only and latches the
cause (or causes) of the most recent reset until the next one.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 arch/m68k/include/asm/m5441xsim.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
index f48cf63bd782..3c086274f4da 100644
--- a/arch/m68k/include/asm/m5441xsim.h
+++ b/arch/m68k/include/asm/m5441xsim.h
@@ -28,6 +28,13 @@
 #define	MCF_RCR_SWRESET		0x80		/* Software reset bit */
 #define	MCF_RCR_FRCSTOUT	0x40		/* Force external reset */
 
+#define	MCF_RSR_SOFT		0x20		/* Last reset caused by software */
+#define	MCF_RSR_LOC		0x10		/* Last reset caused by PLL loss of clock */
+#define	MCF_RSR_POR		0x08		/* Last reset caused by power-on */
+#define	MCF_RSR_EXT		0x04		/* Last reset caused by external pin */
+#define	MCF_RSR_WDRCORE		0x02		/* Last reset caused by core watchdog */
+#define	MCF_RSR_LOL		0x01		/* Last reset caused by PLL loss of lock */
+
 /*
  *  Interrupt Controller Modules.
  */

-- 
2.39.5

