Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912213;
	b=OeCdsN+A3EAERNWvyYacPnHtb+m6Q/+N4QhmzJqNW3qvJOvMLQvmWQXLNPFAEdlDZfJo
	 /0K4errt7XvANWmaTTg0rFHfFECI0lOZyuFe+gFQ8grYIgj8v+GzI5ChXSQGbmKlvktCO
	 iuJcnZZVbNnefq1aoKm//nLkcuwgVoxaAZUkCMUcNGdePMVVdYv/Szo6dsF1ZuqVyzwtd
	 GAtn73PPxQzUFCLUiV23JDiD9l1fTRvMXXyO8/It5xjrmrZe40vTHLTRofj6T33F9skCN
	 gZyeqjyMxGbkHHr/A294nkdJeXWVsNenl+R+3QnX4ktYZIhcsV94n0nlnn/Zs36Juug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fWKlG9ut9OnjMEtwMHS/T3DByfAeHsUx60jI3HbYtPM=;
	b=N5EIgOUofZGGBI+YjCjxJlBYUU5LaFiZIrs9vbjyS09sOwG429B5k3f0my0p99cSlJBk
	 erGCFDTqh0Kj18CP5/psnieLKdfj0bMxX66YRfLAYJOm2Xvi9ergLhMZBbu2Gna3F4kxN
	 kAv61na0ttspVliQtAKlpdFFXmBcSRb/5x2lN7kM7nVEsIRxporRkOmxoM3U9ba2OqS4S
	 tjQDd4fpApmR+keBl1D7Hnp4W1IhbWjN3+xl2XXO0Fqe4DNWgj2twCb3ihe2mvbwG/Hcs
	 u0VkfYQ9wmPypaaQultjpavXdXtUM2VuMZAa4TmVWovW0t+o0Fx1V4PwVrd/Sgpas0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAnPmUwK;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD53606A32A
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 10:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD53606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAnPmUwK
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so4840115e9.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 02:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794912211; x=1795517011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fWKlG9ut9OnjMEtwMHS/T3DByfAeHsUx60jI3HbYtPM=;
        b=QAnPmUwKicRTx4iRInpZcqPhNbEAaGbB4dWv9Evoal4CifofIpC6D7oUbrgXVF+6MO
         joZGzr6V/UDwuCGmlky5/aQKoVaMeVuu298kOV7dQdv0ox/yWFwlHheivp7PtqAuXhOo
         Ou4M4a5/AnL0x0L2HRDIhN9b5qZhyVspQbyd0bXKE53abcuORMwgdu80RTT3EwPQwwW6
         wIU7cFLLlraiUQSvOBJ5DpLsJ51Wh7NWwJ3UmOGIVesJOO/gXcx5cqELSviO70/xi/BG
         y1WknTjvwugybOPGG0ovXe2SupMjJISN9Mr2+SGkB9wGTQFvMSUTePlTM7qabndTqJCD
         b24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794912211; x=1795517011;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fWKlG9ut9OnjMEtwMHS/T3DByfAeHsUx60jI3HbYtPM=;
        b=NETgRwm6CM5y4WQ5lfv9WgLgoEHhwEuFHUDa/vOOZW62kbMYe+L7ZUNPrZXyH/JKPX
         I3YICz3PMGrHJe90kuFfr2wFFoymWVG01cNSSIp0WKYmD30A4VlfoQBbjZVEQjfHZ3yu
         9+K5t3L4bEkosAhfWvREOYcfLQR/0JvtELxfXy/hPZVaLL+4s9j797loQLNJTo24GVpd
         8IoU2CGFyo+1YFQZbREarDP8s+BeLM7QWtCTWeDWKG5QfaAbKb7TDdoUyPjBlsgVkOfA
         2aluCcfEBgHZjq85N80MdBNVyHA6NKYYVMJkLulC5qYf2MD4Dw0LhoF2+L908wAurR4g
         e6yQ==
X-Gm-Message-State: APuU4Z+H5bEFMpdgIvUEodW6bZ/oEK07kiY+56RHbFHYfA1/ndFoglEw
	InvWINYULQtU9OwGVgd8bbRNIfwXZai7usF9C8q+3FTcZ1uqwBGTglEO3WGEFirQ1eiDHQ==
X-Gm-Gg: AYBFou0/F/5rphlSr6EOwBBhhC2evIW6pkGvO8Q0oXW2n1KPLL8jbbKbKNvXTnoVu2p
	9NPVHO0681j6fdRrqH35zfyyOWMTIURI3M4w36nyQKq+dt/ZdLRl405hnKvy8AMmq/P7E+m54BL
	Z88Xxs3SkO/77B/wkGFj4Emj80MEXVQtT42ZisvnOwqsmEpxasLIRcEb/p6pr4InGLe7a/oZSvP
	T9wkKKBO8GWCxxzQs0Mc4vae2aNYnMx8heaiIxVFn1LkYTry2pOz9axrOgnIWV07NkJ2aw9CgZy
	nUAIzNIMjwH/d+GQKOPSxqjV6riAA0oB0nHaUghUs4U2ikeaglOX/95vhBc982Iz/+XMqYwT8z9
	IbblFzojoxGpWanCCg0rh72FAbTnM90VdGLwU7i8ypAoeRNFgtcFJm/sZxuE/cQ6NtWyKH/vZTJ
	c9m/k635CkUW91OJkrxJno8e8tiaK6WUrEPiD1vff61zvpc4BTBid0sdC1hPMLBJK/1wptKlboN
	zXIZla+lqw0nReVYy8oXpQYZM0BVdA+N7aZZaQc1ZYKVCuDH2zXUCQOeUnh01TWcgYTt9sUpqKO
	xemV046oyy4=
X-Received: by 2002:a05:600c:c176:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4bb7837a1d5mr49452725e9.5.1794912210884;
        Tue, 17 Nov 2026 02:43:30 -0800 (PST)
Received: from dl360p ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783e9288sm61091805e9.15.2026.11.17.02.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:43:30 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH 0/2] power: supply: add standalone S2MU106 fuel gauge (Samsung Galaxy XCover5)
Date: Tue, 17 Nov 2026 13:43:26 +0300
Message-ID: <20261117104328.1176951-1-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This supersedes "[PATCH v1 0/3] power: supply: s2mu005-battery: add
S2MU106" (https://lore.kernel.org/all/20261116074000.355176-1-tadilhusrev@gmail.com/),
which I am withdrawing rather than sending a v2 of.

That series extended s2mu005-battery.c/its binding with a
samsung,s2mu106-fuel-gauge compatible falling back to
samsung,s2mu005-fuel-gauge. Sashiko AI's review pointed out that the
fallback is unsound: a board using it binds through the plain
samsung,s2mu005-fuel-gauge compatible with no guard at all, which
still exercises s2mu005_fg_get_voltage_avg()/get_current_avg()
against MONOUT registers the S2MU106 doesn't have, and the resulting
garbage current_avg can flip the reported POWER_SUPPLY_STATUS. Patch
3/3 of that series added a has_monout flag to keep the S2MU106 match
entry out of that path, but the binding still allowed the unguarded
fallback, which is the actual hole.

Rather than patch around that, this series gives the S2MU106 fuel
gauge its own compatible and its own standalone driver. It only
shares the S2MU005's STATUS/RVBAT/RCURCC/RSOC register layout and
scaling, not its device-tree node shape or its MONOUT path, so there
is nothing to usefully fall back to. samsung,s2mu005-fuel-gauge and
s2mu005-battery.c are untouched by this series.

Both patches were drafted with an AI coding assistant (Claude Code,
Anthropic); I reviewed every line, built both (arm64, 0 warnings),
ran checkpatch --strict and dt_binding_check (clean), and tested the
driver live on a Samsung Galaxy XCover5 (Exynos850; re-confirmed
2026-11-17, kernel 7.4.0-rc1-00023-gdcb8b91fb779+ #30): it probes, and
/sys/class/power_supply/s2mu106-battery/ reports plausible voltage,
capacity and charging-status values that track the device's actual
state, confirmed across a flash/reboot cycle.

Adil Hüsrev Tepe (2):
  dt-bindings: power: supply: add samsung,s2mu106-fuelgauge
  power: supply: s2mu106-fuelgauge: add standalone driver

 .../power/supply/samsung,s2mu106-fuelgauge.yaml | 47 ++++++++
 drivers/power/supply/Kconfig                    |  8 ++
 drivers/power/supply/Makefile                   |  1 +
 drivers/power/supply/s2mu106-fuelgauge.c        | 240 +++++++++++++++++++++++
 4 files changed, 296 insertions(+)
