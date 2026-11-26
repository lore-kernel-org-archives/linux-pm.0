Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654425;
	b=KGi0EnVjPmH68KWnIfzSgjmxF1Cem6eUcWy84dvG4n85wCf1wjRS4ZMlMOo5wOxb16i/
	 2AkObKiuZYQU5mXC5seKZ8fqOij2MoaDIvG8hoWEMIDMbVA918X/AZMjlHbQ6XKx2+iNh
	 B3Uw0c5rSXiMLwt8xAZP0Ah8T2RRrgBF640SgW/Ui7i2JKEtbzUJg3OZgj/ef4IaKE2c7
	 Ye7upspWYdQHHp0Ks7povqzzaCiw1K7f5ByBWLAvf7B82wa2sQKGsvvKH+qIhzCEUNy+Q
	 8syPF9Cr8KeEz0q6LJis2M2TWE+0DBM2gWZhDVMT645WElWjXrD86PKG/53SQ+AT8Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654425;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=BfUbrfcWKMoy+pKBRu70MfKcmBdGx7NyqTgjx5w0TRk=;
	b=q/LWt/kL0E5mM3ooX4IoRiJEyBiQDU1cpn8WGZgbApa2d4lhKZT34akr7An0ktBAlShu
	 ECXylvbulCQnltgFceeyh+EXYJe14KHn0GQUO/eV0nzASP40nP9r6Yf0/g7L46ZR7rXYM
	 6OW1BElh/yNvBHhT5xJ4nmQ/L/cmTQDBTm1U4vX8f/SDV3WrVHnKV5sgTJAxzASUivm1x
	 2g494eR0kRA20E0jmblSX1Lr9F4F6I3imfJ/K+w5/pcuBX+ew4cMHuWWO1dKfov16IQp8
	 LCYRVWRAWOCB0le2gK3wzmdl3cP7l94hoyeqdwmM6n2YJoYGe9/5gUYCPHkTbkmPaeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWFOSdKN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB6606A686;
	Thu, 26 Nov 2026 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWFOSdKN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795654424;
	b=tA55ixD9GyFXtrcv12Er/eDQTQkmVzEUFZY0JX/Tdd6JQFNbiPEY0HiJuFw8dDh3yj8v
	 8rmlPiuTbmwwafayFh4V47E3zqJDN/rODU7252FqWx40R2hdn+f21HHcYlaqgJhIAsRcU
	 fQqRXdieQxo8lTUVKkeBoL8d1AEiiodIQT1F7w7NgLJkVdXzUtmEkfn3gfrCyWa+fzMvz
	 ZMePXoBkgqgHO4ifHBjJLbAMQK9zdxrf1zS2ynJtytIWNbM8lNINEkSMY2n1Mk6uM+Ya0
	 H1H7E7WLroFZRrNea8eYXTMY0WBNED+Ags2vKapLYRDM88h4n4AluSZ4R5QUOspdS2g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795654424;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=BfUbrfcWKMoy+pKBRu70MfKcmBdGx7NyqTgjx5w0TRk=;
	b=TuWPpSlzOzIyMnDcxHcLiCIEA9NCvAoKfnNtM1GMaMpvuOHfuv40N6lhjWvWhXRZt7++
	 jKrq/RZxVLl0GEpeHpF3j/WgGnONT9Icm67znzBV+dyayT8zMHagSZX3R0GlzGGqz+LQ4
	 Osj+7bYUg4DsZiXGFMGd4doUux36abbMpP3+yj7I7SAazWj2zSC0kqUNWgsaSNOwwOVFt
	 zSbcsobsREK2O0pnTRH9ehTZzGR+cOs0IGBzWDtt81FpvjA8wl0K/lYk4tgDJ8pOwuEGc
	 gj23mLjp2Z6DmhCXZUNMvVnwsoLUUw4ZUBLPl9eGYlBHAR+sEvAoHNFrWpdfgU5aH/w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 581A91F000D0;
	Thu, 26 Nov 2026 00:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795654424;
	bh=BfUbrfcWKMoy+pKBRu70MfKcmBdGx7NyqTgjx5w0TRk=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=JWFOSdKNFaxmStRglzyGP/K7Dg7Vxh540UZwwldmNZCURUG5bfWKwDaOKuCK9SPJL
	 cEZV7DMfrQ9DTr74Uz5qL1xOMa4aaWQC8jAjdMENq247zTQ+IRFnt2t6VWxk0+sjbI
	 bOQKry3POcbBif6l+ev7kldmrsaVtreVTHFUcvpjxGiVCXytLpmVWG9uKWDQ/KtpBz
	 2aBP9DyilFjroeViqL+vU4m9HYVqn/Yliym2mgin+pUevvXbS16GqI4t0O3djlt4uD
	 pIlC8BSqboT2JSO9+11OaemGYwBmKWjxL/Rmm6EuucuJkKIai7Hc3FH63bBzt5Yick
	 7vUlt3aumKMUw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D989D4D130;
	Thu, 26 Nov 2026 00:53:22 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com, 
 lukasz.luba@arm.com
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] thermal/drivers/mediatek/lvts_thermal: CALSCALE,
 overflow, locking, and IRQ NULL fixes
Date: Thu, 26 Nov 2026 00:53:21 +0000
Message-Id: <20261126005321.71799-1-iasnezhkov@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795654401; l=1422;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=1leBQV0oOy+uaHay4Mtb/7QLKwo9KRyb8z4zbg9Ip+0=;
 b=DeRs6vSDkiq3HlMNkbRcNnW3B5O7KAkhffqnwDzmX6U2qhxHqi0eXsj9mhdRLyfXYaWKli22y
 GRhmRV3HisQCtTnGthdRZ2KmLygbd82pbzpxD0EvLttrM4wcePGGj9V
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com

This four-patch series fixes four bugs in
drivers/thermal/mediatek/lvts_thermal.c:

1. Write LVTS_CALSCALE_CONF (0x300) to the LVTS_CALSCALE register instead
   of overwriting a local variable and discarding it.
2. Avoid 32-bit overflow and unsigned truncation in
   lvts_temp_to_raw_mt7988(), and skip converting high == INT_MAX in
   lvts_set_trips() while masking high-offset IRQ.
3. Serialize lvts_set_trips() with a per-controller spinlock_t in
   struct lvts_ctrl so concurrent updates across thermal zones on the
   same controller cannot corrupt shared thresholds or LVTS_MONINT via
   unsynchronized RMW.
4. Check lvts_ctrl->sensors[i].tz before calling
   thermal_zone_device_update() in lvts_ctrl_irq_handler() for disabled
   or DT-absent sensor slots.

Found and drafted with an AI coding assistant while bringing up MT6789.

Ilia Snezhkov (4):
  thermal/drivers/mediatek/lvts_thermal: write LVTS_CALSCALE in
    lvts_ctrl_configure()
  thermal/drivers/mediatek/lvts_thermal: avoid 32-bit overflow in
    lvts_temp_to_raw_mt7988() and INT_MAX trips
  thermal/drivers/mediatek/lvts_thermal: serialize lvts_set_trips() per
    controller
  thermal/drivers/mediatek/lvts_thermal: skip sensors without a thermal
    zone in IRQ

 drivers/thermal/mediatek/lvts_thermal.c | 30 ++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

-- 
2.54.0 (Apple Git-157)



