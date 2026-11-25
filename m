Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575816;
	b=0VJVQW3YRGkvjjOHPEULaDyIMxKV14lK6pO66lG7wppKTwhqW6cn/952AxKd7h2YIy7L
	 PXOgqI38Gp311zEx+eQ2nOG0YtxEwdCtl3hoSp/C6AR/0/MA0AYVEghdRFGJmFUHRVy8J
	 LiB12BYw2u+twwzTSsXgeLmqwj8GQ2VenrCqEIu5KNWqcKSUiDAks6YtcimK3WuftXVcX
	 wP7oVe/Zaqa6KHEVVZGxWJJpgup6BFvqwNGGJgywt61nj7pwnAn1IgqrfoziqUEjONdPJ
	 tLZOkoD2QxWNv7c+BhHZQWhW83Er1CqK7ARy6xSJA1RDpJVBHjLJrcMw2y8wioVhUgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XvCX2nUztLlSyLc3rr2QnMaB+ZFYgpn3Aqh+iE3xR/0=;
	b=muq49mMPnNbAhIKrELmrg+ggKvtLNttDKnS67KZFtLgrHTuqwNPg+ljmg4T2fTN6BqJB
	 BQ6BHbRxWy7O6jtGkI7dZK1dS56fDmtSpwR1TlxhCOiuPCSC3jqySLY+5oAiX2lNp11qW
	 GW/KXM9JjgzY+RBHzoRLz4TfZKy7GAY1osDDN1SFlgjJQTZj87weWlvNldfwQtflSedkM
	 OXnpkn9QXzVJ5sbdugwrFtZf9tICDNZrBmrSONQ9qfDtdmaHDW31LjRFB5S0FmYu4jceR
	 oLu7OTq+VCPKhD0T8Rv6NzIQLVKCPZC9+qRAssl9FY/V1e3fORjO23a4gDHM0YUN8Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K250yYr8;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F49606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F49606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K250yYr8
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33fb4680717so13541260eec.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795575815; x=1796180615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XvCX2nUztLlSyLc3rr2QnMaB+ZFYgpn3Aqh+iE3xR/0=;
        b=K250yYr8VhJKucuJrDdE4wC3EJVDYc1zcrQbeIN4v0mICSZKAv82YLJMJyMcVf4pQ+
         ozSVuKGtwSecHV771Mhe50NcBaQQZENBac2oR5vMM/LZxeGYuzaOSnog5Tj79lmeQsz7
         9qjf3SxFZ9RNtZH5lyYOaJlJyy8AK0vTbMS1dYO9Igdu7uxH7OJbnQM1mX/LUFG37Qko
         b4jKkyQstOQBNRE1Lq3edVuQdu14Ey3MwtPYoSSfT92lPQk49HjDkvTIORwVGGi+hble
         sq+yfQkFyB3n1lSMHHjh1GH280s+7aXlviiGCjXk+tzDK0LCC8jS1fYWayo+yXrbQibv
         6OGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795575815; x=1796180615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XvCX2nUztLlSyLc3rr2QnMaB+ZFYgpn3Aqh+iE3xR/0=;
        b=BSfXheLsAuf1lG4+wTJ/kd/0riirNpUBik0ptdMT8y0xR7sxTb7lYOC7T9WqEGJ/VS
         j5UpIuBZFI9beLMr2t0oXItGHMGUSxYXRvu+Rv/aI1PS+qyMuPcDwIXkHwxEU25AMnx5
         Mk/I1MyWGeDHN/myK/ybR04YltFkqOb7fl55yng9UWDuwnHPXT4DCLTV5/wISdP1LEdZ
         zkLx9xY2oNDN71D9TDLLivrpTuI/UCQnExmDi8YEmRbnesKTMTVEBHeEKxi+3uxWRRvA
         gLy1ZBHKFteor1OdcTjoEgp+ovLcHKpOuOzSNIltUQLuFbqt6dKU/0B+n3QWdT1t3wDt
         gCgg==
X-Forwarded-Encrypted: i=1; AL+hErGBX0fjnPJAg8yF3RMtFEQGhTHP51+ZHqAwZHv4PdxaxeyJlIxQtzL03usnHZRyLPgYeIucgz2Ucg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9jeNOnq2qiveWjh+2gFfO5kw6Miec9dSjd7S4Yy4ZNWuBBw3Sn
	13YN1EfCJh0MfHhNSwTekVBpLOtE+lWkoocv7jPu4zKayI0V5wFdS4Im
X-Gm-Gg: AZFdTZeHiKRJbkoePOqWr00R3GWnVyfYkNbrPWp/A4mvbeFhGJlPzlcbuXIYu6VF1Tx
	/H3pPqZLTHFY9NGLfiWfnKVDskxEdJ73uu42YsMGqpEj055LepWBasMrdMbgNIRy6UAu+uHh+YJ
	sWrc3LuBnMz8lF/Tyvb7n4Ge5lWq+6xMzz09euZXOWdA+KpHi2WtqzVm//3TsKhOu614MwPkT5G
	dthYvLIIEZOQeM1sBsUt6QfVwQJFg88+Rwnv46hFfF7sD2+ynOVU0xRLFK5P+bfn4mCCgiwX63a
	KShMRHU67eFcL8bOAjM0gwNXtyYYH7Z8jqvrIP5O1n/vaEwf7Q3uS6E5frHEBWArT7KBjCOjAQS
	ZB81eypYHl5/mzaiopINhPt/45mhOoPXrgfxxYBneEeGTW5iX8OfTryzxy94gmYby6owGCtFpVe
	ivIR8c2Cn+3dcDwxNcuS54PDQ2ktxrmvFFEAF9LaS2lRoXAbYTVNXZ6tbGZ6OX1uM6LemFwTS0l
	vJ2cQ+o+HJWScDurNsjLg/sQILBHgmgyCh+SOXnsEq101M3MNZ3HJZIMPyo6Aqvxtm6gXkOdLLb
	2AqKwd3t3I0CIpdj97WZcMsTS8Fl6R1UfA+9oWVkSBJIrN9yAXIqPTvVYy8BQaqNbWPyviI+IWc
	qDqlzw4aOL514TVUFvWtSEOSefbtddKNYt02dpJ/8NtyTwKELSdqE8K2G7ipYMZXxpnfW
X-Received: by 2002:a05:7301:150b:b0:36d:a466:9d0b with SMTP id 5a478bee46e88-3856ef47c9dmr16503589eec.19.1795575814384;
        Tue, 24 Nov 2026 19:03:34 -0800 (PST)
Received: from lwq-server.tail118c18.ts.net ([74.176.208.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm52243475eec.14.2026.11.24.19.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:03:33 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] thermal: rcar_gen3: fix the interrupt handler lifetimes
Date: Wed, 25 Nov 2026 11:03:24 +0800
Message-Id: <20261125030327.953450-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124095110.131258-1-shunsheng1218@gmail.com>
References: <20261124095110.131258-1-shunsheng1218@gmail.com>
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

This series fixes the order in which rcar_gen3_thermal_probe() and
->remove() create and release the interrupt handlers and the thermal
zones.

Patch 1 moves an existing check; it stands alone.

Patch 2 releases the handlers from ->remove(), before the runtime PM
reference is dropped and before devres unregisters the zones, and
undoes a partial interrupt request instead of leaving the first handler
behind.

Patch 3 requests the interrupts with IRQF_NO_AUTOEN, initialises every
sensor before the request, and enables the interrupts and their sources
only once all the thermal zones are registered.

The driver keeps its ->remove() callback and the existing polling
fallback when an interrupt cannot be requested.

Changes in v4:
 - Split into three patches.
 - Keep ->remove() and release the handlers explicitly instead of
   handing the teardown to devres.
 - Request the interrupts with IRQF_NO_AUTOEN and enable them after the
   zones are registered.

Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4,
CONFIG_ARCH_RENESAS and CONFIG_RCAR_GEN3_THERMAL.  No R-Car board was
available, so probe, the polling fallback, resume and teardown were not
exercised on hardware.

AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
author reviewed the reasoning and takes responsibility for the content.

Yaohan Li (3):
  thermal: rcar_gen3: check for sensors before reading the fuses
  thermal: rcar_gen3: release the interrupt handlers from ->remove()
  thermal: rcar_gen3: do not enable the interrupts before the zones
    exist

 drivers/thermal/renesas/rcar_gen3_thermal.c | 96 +++++++++++++++------
 1 file changed, 72 insertions(+), 24 deletions(-)

-- 
2.34.1

