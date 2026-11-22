Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795375222;
	b=NyrqIONvCSi8c7NO1/PVpMhINdpxDO3yCRLQHsFlR85DnGSxbyAecZkOZ4mhbWLlh971
	 Fb/jdx7E0XYAKR0tJjEEGTZdNY9yeIgTc8CeL8LkEDbNcEexS5Altz2SfJHoCA+i+cS4p
	 u13MLHdvTS4/veGQRsNtYf86TjmhRXsK9bZwpWK6uRcdZvwz4ozWv3ajP8nYy5Za13b9k
	 C+Fm7cqZeymOIi303PiJGAM9ckDbl+TEoI3yZ0Nn+ckRLLBrCBrEWsrGhSktzHG8VhDAM
	 xfrVaJ7cTdYKdWvWpvmljwTIsl3uVXr5EdBxKdvHAKXDURIhmvpU9Tz1++u7UD1AViQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375222;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=c5C5R6hCf0H1hugvKpSGEvB7OqykDwEdgPqEBhCAjFE=;
	b=3MDHH3ogbn3/61jfQG/q/R10fHb9fpeRWnSYysFO4BnHs1geAvGzp9Tz40JxzkffFR2A
	 1Muy9yEp+n70LPRujxkNEKef7zVlm8fsNJtDO/1stmDXzzOAwhnEG01LlY/RoMqXh7Tqc
	 xRSXmCyzosVUXek+nMbOrYX9PstQzEF8f4UYwCZ8gnp5YFeph6Dt3LpCquUB1nh48Er6Z
	 JkKoKybq5sOyxmsojm7iejWbdFhTBnpFhr1Qc/RSoiuEkzyW/JgP04afzJ3pjWBmluMJG
	 gZUTkxgCZ+iMviKoa2o8S9muzptUHmCJ3/GqZSe8kTE5cBMSpYozujlGIwLOw3aWLeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYwyl53r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F11606A334;
	Sun, 22 Nov 2026 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYwyl53r
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795375221;
	b=19QVqPiAfPlKv/a9ioU0Zk74frixXvP5qxl1XJnFY8pKMHAnB50LhPs2GNav2YoLPdu4
	 PoaLsNDyfnJJQNfmTF4rv3hSqCeuOgV6J5Dsw3S9CEFlFs08QD8Wp/5AkBpBQirudROOy
	 AXSyR5jqbPjoUeC4fuDSoigaNytgfT9kx36SyNZGAC2Qnu0nmCso1o01SwWkADEqG5sWP
	 c7WB7KcnMj+kr4YTNAAuWWNavAVqWQU2JwrpWm0AzR2FUHqDgNCMPDriLofFcjA7wmd+j
	 EuEGonU7ze4IU47UZLxb9Ox+/hRtFL0MkjDo8fElcKpqr1B375w7l3R2rWaG3HG2NZg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795375221;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=c5C5R6hCf0H1hugvKpSGEvB7OqykDwEdgPqEBhCAjFE=;
	b=eI94ikJ0WZYjvelA807Q1tZwXc6iEd1z8kqEwk4HmdYflCfOZF7J2VbVFS1hf9Yl77ty
	 +tfYestapa1WPwcdnWGEbBn+j+8i1mxt5q0puR8lGJRWqJONsIO3ymVjLJAW42bxvMq8G
	 71WtOObny00Sjw2vcxJTCM840eB5p7ftWZLV/VYWkdUWpfDKMP8y3beUOQgPSuCPqZmHK
	 EQBw01VBFHEF0dxge9DBGX2KXEsALZoIoN18ZCbHrd2VfNnExs19IrXLKczm7XQ1r2K4t
	 uUpgWUpGRSlqNVTOefoSJAHigPix8wkC6Z/Vj6I+WYpJEVMdw2/X4/pZE5HOuTKtkQA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B1FFE1F000C0;
	Sun, 22 Nov 2026 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795375221;
	bh=c5C5R6hCf0H1hugvKpSGEvB7OqykDwEdgPqEBhCAjFE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=aYwyl53rsMAkGqTlkNuIX3kBRRmgvfz3hkkofAwn+XI48PolIrV81tLZYcqPEvuLA
	 GDpUO8odD8xiSUdm6YRVtUTUDoDjUEYxhej0kyw2KP4bQfO/IoQ5sxYT05kwsuK92K
	 FGj7K5jJFXaTxF67EsuwodbsaSIbF9cA+0QX5IS+7ZMX5fF2GX2RRrn2feIHlI5paU
	 nyx7jPfH2hHXi0YHoYjzSoWl8QPz1UNpH3ZYYe18jdwbFtNgIgnmV+T3UOd6JtjtGJ
	 OlH1vy4Hu3jFxMoNNHggRfGJ03ItRj+xiGBirDibSx18dn813dnp92VopBZsQTotLQ
	 ivN/PXW73lMrw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 424E74C1D5;
	Sun, 22 Nov 2026 19:20:15 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Subject: [PATCH v2 0/2] power: supply: qcom_battmgr: Apply the USB host
 current limit early
Date: Mon, 23 Nov 2026 00:50:14 +0530
Message-Id: <20261123-vantage-battmgr-v2-0-03a419078d0a@yahoo.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6DIBREr2L+ujSCArWr3qNxAfRXaKIYoKTGe
 PeiXXf5JjNvVogYHEa4VisEzC46PxVgpwqMVdOAxD0KA6uZoJQKktWUVIm1SmkcAulajoIJeWl
 MC2U1B3y6z2G89z+Ob/1Ck3bN3rAuJh+W4zLTvfffnimpidS8o1w2Ump5W5T1/mz8CP22bV/Aa
 rbCwAAAAA==
X-Change-ID: 20261116-vantage-battmgr-945e626783c4
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joonhoe Kim <26rote@gmail.com>, 
 phone-devel@vger.kernel.org, Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795375214; l=1656;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=GKw0fAYD2THqTePsaxcaYFmMb0GJeDBVUvNBjHIW/Zg=;
 b=SFJJnRpQGclZd2uAF7+00OqMR0H8exJbdBYTv4wTtGPq9oz3g+Qfb0P1eG7h3wqOMPHYu6oi6
 62Cy0HQIredBebnY/x60ou5Pok96vvKDly07nh+aAa5BDt7fQ/GlajY
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Reply-To: venkat.yadlapati@yahoo.com

On the Motorola Signature the battery manager firmware keeps the input
current limit of a USB host port at the 100 mA allowed before
enumeration, so the phone discharges while it is connected to a
computer. The dwc3 controller reports the current the host grants
through usb-psy-name, and commit be5e7367bceb made the limit writable.

The controller reports it before the battery manager service is up
though, so the first patch keeps the limit and applies it once the
service comes up. The second one applies it only to SDP, CDP and USB PD
ports, like the downstream driver, so a dedicated charger is never
throttled to what the controller reports.

Tested on a Motorola Signature: connected to a computer it charges after
enumeration instead of discharging.

I used an LLM (Claude) to help write these patches and their commit
messages. I reviewed all of them and tested the result on the device.

---
Changes in v2:
- Drop the Assisted-by trailers and the LLM notes from the commit
  messages, the LLM use is stated in this cover letter.
- Link to v1: https://patch.msgid.link/20261116-vantage-battmgr-v1-0-7b59157377b7@yahoo.com

---
Venkat Yadlapati (2):
      power: supply: qcom_battmgr: Apply a USB input current limit set early
      power: supply: qcom_battmgr: Don't limit the input current of chargers

 drivers/power/supply/qcom_battmgr.c | 61 ++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 8 deletions(-)
---
base-commit: 7071d4750856abbc68dfe431acc58a1d45dd42e8
change-id: 20261116-vantage-battmgr-945e626783c4

Best regards,
--  
Venkat Yadlapati <venkat.yadlapati@yahoo.com>


