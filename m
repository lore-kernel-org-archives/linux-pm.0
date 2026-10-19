Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792436898;
	b=m4UIYKoY4Md3kj58hf1DKMWEdcX3syj+0DAGq37qKp1fKEkyOnloqM9uEgjlMTiW973p
	 zla0rqPmwPB+HV9RnNYxA3fy0dV6uxbNu7HxU5hv6DMKp5hW2WKhd6kOeSCyB8nQ+75mk
	 mOvR8W3Xr+c5cMTyeHpqNWW/yVu2qO1hy7VBfEtXyx4P49nRiWgXsCEexN84A987rVuys
	 crqim3qB4QZNsX/VgKDhfBG54SsjpKQiaFCc8xVIp1muZeMi/5Z8wifWLL8J9RENqwZqC
	 dWxIUvj+ES/WjhYQ75tKSXi1LGcC24SAPGUfq/PeVqikb5FWETTfohCvYTW9on+OJrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436898;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=8F60DGjKx7m9cj1oGlVJjVJk5368qBtW3tXs28RxwAA=;
	b=eO0VuaaBbReS6NSZSQ4IrPmyc+LsfnoL/QWPYAYkzJ3vbt9wkBloPGwovdn9rhhlf/vE
	 rWJOloqtl03H4kDChj+IzEt40cPypYqAivJMlWaZ5/8A/ZRrx6r2LsqjdB3ddktLp7Dgh
	 y6R1z1odrV7jkF47O3TF3bpm4quPZBIOvRI1sOeSXV+6kZ46o+rsJ3nkbMlHNlGNRfvLf
	 duvosA3yB7zsnlNJ9ZYfm8LXE103GP0QR9KzvLIwBhzU2q0tBUubjrff/fwPKn3VIz44q
	 bHLDlDZpOR0Yc3yk0mFUjJLhrTTuS56NiFAkQ9nCIjtiYZdW/Y9osH+8bouvrAojhjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+SosaJH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995AB606A31E;
	Mon, 19 Oct 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+SosaJH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792436898;
	b=F5bWtYWWTiNodaVlaZfjIKTD8mBaxe+6CoH+CtJQTxktogAwqxSwOVgdQ5ZEsRH+EAmd
	 ws4FZNLMa3rRydgtBK9g8YQYGs+/5cdJNo08mMEjBdau3hZAvf7dy7k04pelvdtxY0iFl
	 NXcl4nAD/8GcTGTduTJD+XzCW/JvT0h7zWLAQYJ3MQeIOkRbmajGz4I55oyl2GZYdj40o
	 2fV2nseone3cGUZ03lkxvA7hVMWdyIZXWBKTiGp8iB/dCm5mId+xxrLkXvxsuUySzFmGz
	 QbLSf6C/rVc/rbobCEvtop0fAlWu5rzclmCSx54E4QaO1KqcknxzqqfhNBo2IcgI3EA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792436898;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=8F60DGjKx7m9cj1oGlVJjVJk5368qBtW3tXs28RxwAA=;
	b=lsCR353rNZ0Kw5K6hLJ0Otw8z4LZm+85Ie1WsQagUZvO3OQfp4Ft4X82uMbZcMhL73eb
	 3wIqWqr2hpNpAdhelT7UVJrLoZvyUVSTbxdQG7oJEiZS+pQYsPn8i3zajaRxTm9RzEbJl
	 sRmw3TqnU9lseStk2MDVNNm051HmA8WLue5w3ejffKs06svpAkTasKzDa4ZP5mk2z9eG4
	 Q4O4n1N5eSy20qFViS+ljRojs6E8H3uVEUkuJ7i5NSOiIW4lZHI6vUIEdEkrNW0fNsgSe
	 r3HWK0i1nZQH3qVQb8DT2MMUNw/8XE+rvv1u05qFWXLi4hnRKZ9PfNP/Is5vlrwL/pg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 41F071F000C5;
	Mon, 19 Oct 2026 19:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792436898;
	bh=8F60DGjKx7m9cj1oGlVJjVJk5368qBtW3tXs28RxwAA=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=F+SosaJHDOTGvqMdPkH2NDIlyg152UMlXUFCd8J9/bTuP5HiQjQt1yYADdfFKJdUL
	 96XDSTpNj7kSr2C1YZvwAavYC+rguP5h6/4T3MbiXy6qnzkuVEo9he7Vzw8FmgqdCB
	 9ZFcSJZBQGNK0Ry9pm6Qr8jdb1eXmfsB5dVh9XiX+HKL7bI5eAxOxAVreA31pA5NBS
	 uwfUMRP6psru4+yVl1q9R2tujp8QYujKYlw5Chu6uxAtFZTDsieYffEMitfvlit20j
	 MXRdfgoUUB4iRLJYrlZ0oocVjuYCv4bOFuMufJxclXz4VUUVlapNUErvnyg7gORlsE
	 j+v6kNrRBjJhA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 95102400AB;
	Mon, 19 Oct 2026 19:08:16 +0000 (UTC)
From: Rinat Muhamedgaliev via B4 Relay <devnull+rinat.muhamedgaliev.gmail.com@kernel.org>
Subject: [PATCH v8] bq27xxx: support interchangeable OnePlus 6/6T fuel
 gauges
Date: Mon, 19 Oct 2026 22:08:15 +0300
Message-Id: <20261019-master-v8-0-2517e41c8992@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OwVLDIBAG4FfpcBZlKYHgyffoeIBlk+CYxIGYq
 dPJuwvttGrH4w/77b8nlilFyux5d2KJ1pjjPJXQPuwYDm7qicdQMpNCamGl4aPLCyXug3BdsNp
 q6lgZ/kjUxeN50eH1kvOnfyNcqq4T3mXiPrkJh/o0p9jH6emyrv4PMS9z+jpfsqq651raXktXx
 YGLRqLZE4LR5qUfXXx/xHlktXRtbgwE/LCGCy48gVYKMAS4Z/o3szemC0Pl9xqkNRLonpn/mSn
 MQYeqbYNF8+fIbdu+AXijMnRzAQAA
X-Change-ID: 20260927-master-bd0afd9696ef
To: linux-pm@vger.kernel.org
Cc: pali@kernel.org, sre@kernel.org, afd@ti.com, 
 konrad.dybcio@oss.qualcomm.com, david@ixit.cz, krzk@kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436896; l=1896;
 i=rinat.muhamedgaliev@gmail.com; s=default; h=from:subject:message-id;
 bh=CD8dFs9AlJtwpKfUnsvq0wg/Q2D+U0BfFeHkOTnO1ao=;
 b=0PD716yO6KNtHjWDCzFcCPrl+bGIv771UFfFBdxZ+zubSRm7gaQ+5S4MRostIbW2Fl+A5BbGC
 EEJiTt3pvN9D+iaKVJCoQ4xxhmVmd2VXUMumhnPc8HUNN1UFBrXxeoK
X-Developer-Key: i=rinat.muhamedgaliev@gmail.com; a=ed25519;
 pk=qkYQO8LRlRErWiLzlpK8jHbRIxv8+7v06+ytcxX8mec=
X-Endpoint-Received: by B4 Relay for rinat.muhamedgaliev@gmail.com/default
 with auth_id=1072
X-Original-From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Reply-To: rinat.muhamedgaliev@gmail.com

OnePlus 6 and 6T battery packs can contain either a bq27411 or a bq27541
fuel gauge. The two chips require different register maps.

The DeviceType check now lives in the bus-neutral battery core, where it
uses the existing register-map and control-register helpers. For bq27411
and bq27541, it compares the type selected by the compatible with the
reported type and chooses the detected profile.

Tested on a OnePlus 6T with DeviceType 0x0541 (bq27541): 4.338 V, 100%
capacity, 27.8 C, and Full/Good status. Testing on DeviceType 0x0421
(bq27411) hardware would be appreciated.

Changes in v8:
- Move DeviceType detection to the bus-neutral battery core.
- Use the existing register map and control-command definitions.
- Link to v7: https://patch.msgid.link/20261019-master-v7-0-a1fc488d9c77@gmail.com

Changes in v7:
- Determine the expected DeviceType through an extensible chip switch.
- Mark the probe-time list for extension with DeviceType-capable fuel gauges.
- Link to v6: https://patch.msgid.link/20261019-master-v6-0-c4b36129721e@gmail.com

Changes in v6:
- Compare the detected model with the compatible-selected model.
- Support both BQ27411-to-BQ27541 and BQ27541-to-BQ27411 detection.

Changes in v5:
- Report detected and expected DeviceType values instead of hard-coding chip names.
- Describe an unknown DeviceType as unrecognized.

Changes in v4:
- Drop the generic compatible and binding update.
- Keep the established OnePlus DTS unchanged.

---
Rinat Muhamedgaliev (1):
      power: supply: bq27xxx: detect bq27541 behind bq27411 compatible

 drivers/power/supply/bq27xxx_battery.c | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
---
base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
change-id: 20260927-master-bd0afd9696ef

Best regards,
--  
Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>


