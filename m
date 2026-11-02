Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657115;
	b=NH1di+jA8higVi8S2Z9tISPAL0NFArrbXPWW+NgAaYWotoVVkkoLELWk1AraJ91EEu73
	 Ek5L9RVInC2dzJyvno2cZ3DTpFqJGMEcYVftzHiHYKHbl4cDoyFgwiz53duL5FHi+7lvK
	 Oc/fKCeN9oQPPn7/ryi4OC7g7ggrG9nZtB2YaPCmttqANXiGsW5aGEPVT7v36TR0ThNwX
	 l8m6RQjjiy7Il1fs+V7B5PIfFpbntFqFUHz/VdSmx1EY9sjPMnOYVZ16hl6OEZZXkJ+oZ
	 062ACOxN9QKY5fH9JbszYIu2PSrEB+/un42S6NWlVxBqpdxjONDx8YjTdhdkC6XhdSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=po9LaFR4COBNDjXRaH0sos9yo8To8XsMCK5cpaZoeE0=;
	b=eerClWjGxzLJOAyZSJ8NEjWyPzflEKyRYB3tMtSd3VUeKeUucciLP9g9d6GCjzRpJgMW
	 Sly5Gp75TmY9GvNmC8Qr7e0XPn3nWPBrXTKy0TafFsPtV7xx8DvVkVRorlvdyzDntOfGE
	 lMEQd//1KQX2S/j0U6uM2y1lUItAuV63nBFXV7wQYjERbrRcaEKmJbjckQKbFlCpYToHV
	 +8wDrK/Nlz4LH+LQ+FAIcWrxs4T2EhuIV72nbD3AntXVU9ZFILLV4iNZlwSWbpXeY7Wm/
	 GkMzbwd5uYNHJxmjJaO1ubwqeY5EnmwEawz30+cl9h6s5aqKt/mvI94PhUz727xh6rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JgsAov36;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF85606EEA9
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 22:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF85606EEA9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JgsAov36
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35829219da8so116495eec.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 14:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793657114; x=1794261914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=po9LaFR4COBNDjXRaH0sos9yo8To8XsMCK5cpaZoeE0=;
        b=JgsAov36eHCi4xcxestGz2HdshrJ6ho9n42lUOpL6lQKXpCOfBnFjnryy5u/3Azz2R
         QBtXmKBE3qHG+ej0F5TintEHwkU0I+8of94h0KvhAr7BAoyXbzqsaz3k0dHYzSvxt0mh
         o9A8yJabfYDnFshUU1blgx1XfoBhbZJKvCM2n/P+aj3JfgvU5o8LMzckGXLJRLE8RmOb
         1+prHhFrgG8VBkIw5oi/uib42Kh+n3PbXGiU3YCJX/Oqyel0V0ZDbMGMO+s/L4PS9HIg
         lWFDXvfliB3FFhQThiqrrtnABhPt+I2JzcIfkxI0MRNb4e8X8kTqIoLfG9HDNyaGjXPM
         X3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657114; x=1794261914;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=po9LaFR4COBNDjXRaH0sos9yo8To8XsMCK5cpaZoeE0=;
        b=MYUgoCSKkz/jz0yUBfB6jG08MHaQ+16Jg6VjJZTKbOhTpRtIre5F3Fk8orLBLqhTzQ
         khUw4Jg06/n3q7Qb4hvwihis6DJRXLeyh359MzSwGwMhbH7lrlRrPEwFiTQbkApgx2o7
         L+c1qwQKF+QDWczL1pxR6a/TBb5pP0HBjcIMdIJNUzzPBC/gkcl8n+0D/ih208ZH8x/9
         pna+qXeRSZt5lN9BCTFoL/wG2U5KW7TgAUS0K/b9KDGOmTPdNLyDJO3d4mXWddw9b3/5
         bZReutCkeHQAwaPuJavp+kL5TCW+/hEygL7anfvLwaXceZqwD05cMSVATve8dTiKmbWi
         xGdQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2OsFgLz63qvOUFKztFJXmH1X0N0yaS/xkmsMmIJKN/QNH/Ye2hg/P4jY2sUll0tZBW6NrDFU/0A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9UQMjd8WhAMwq4IE4Z9iQ09J0YK1Nkanue+Ym2torahWzAUaOT
	sbocVr3Y6fl20zEcdhqGOnRHVb9MFb5euLWkCThHr6H0kz30uUQ3MMuo
X-Gm-Gg: AYBFou1yFirfAVOIrKg0IvguVz6m4SWwBjDlYZ80J5C6H3kB8jvmQSjZxvUbC9c16Cw
	lOLPYNfYWVI2TRIBltKAcoWC1sYblRVe5Me8W+3PES37CsnsV2V/HMe2aFmln5iU1BSqxgy2fA2
	NBi5NDYtaih7D+0+v2afgjfzBF5ICxVb1tk6pvt4VuTvzY9rGxDKdwHZFjRB4ksL1nWib0OUOtP
	8FLld3czs6qw8h9KUJEnkBUSQ46pyj4706V92lL6DwBIhxVp8Co2fMAJV0iJztP3ou4p0COq9Qz
	yNDL0oMGt0r+xEeIESKtSx/hJq5PlV6jJv1sSt/U/OehHUOzjdSyAschx01kyOxuC51oT9Igixb
	bNsVDARAYUhRnE6LE3TuEfGboC5rs4kJftKc77W+P2kHFOnb3bWBq/ZZMZGqj1sjxnBe1tei+ob
	BgmY1Y3RC4IIKtrWl1utAFtZosrwmXNodRytBLw2wvo+JyyQdAZun4j2Z+hjP9nWNoxtFat2CVN
	cDso+XHKjjpDR3gZQnoOtfcmQ1OJ1rt/fpA/VmzKjllx86P2WNVfCIXM089Uq8zAuUoJDx9z0gf
	j7qw48XynIPNeg6VzvkbnaYYlVsfekeY1iOFgTO0VQ88lKePYNkqzF4dudesM9B4Sg==
X-Received: by 2002:a05:7301:4d12:b0:369:dc59:7a6f with SMTP id 5a478bee46e88-36a422042d2mr15983030eec.1.1793657114197;
        Mon, 02 Nov 2026 14:05:14 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm46670346eec.15.2026.11.02.14.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:05:11 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Vladyslav Tymoshchuk <tvlad744@gmail.com>
Cc: andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	sre@kernel.org,
	krzk@kernel.org,
	lumag@kernel.org,
	casey.connolly@linaro.org,
	johan@kernel.org,
	jishnu.prakash@oss.qualcomm.com,
	kamal.wadhwa@oss.qualcomm.com,
	daniel@quora.org,
	neil.armstrong@linaro.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] soc: qcom: pmic_glink: Hold back notifications over system sleep
Date: Tue,  3 Nov 2026 07:05:09 +0900
Message-ID: <20261102220510.1721-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261022164151.592-1-tvlad744@gmail.com>
References: <20261022164151.592-1-tvlad744@gmail.com>
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

I tried the series with suspend-to-idle on a Lenovo Y700 Gen 5
(TB323FU, Kaanapali/SM8850, FSA4480 on the SBU lines). This is v7.3
with out-of-tree board support. v7.3 does not have c7c56b6ec077, and
I left the UCSI connector work on system_wq as well. So only the
series kept the workers off the suspended devices. Without it, this
setup crashed on a DP sink unplugged during suspend, as in [3] of your
cover letter.

- Monitor (pin assignment C) unplugged during suspend, default wakeup
  settings: the UCSI notification woke the system within a second.
  The held-back notifications were passed on right after the tasks
  were thawed. The altmode worker, fsa4480_set() and the UCSI
  connector work ran only then. No I2C errors, no reset.

- The same with ucsi_glink wakeup disabled: no wakeup. The
  notifications waited until the power key and were passed on after
  resume.

- Charger plugged in during suspend, qcom_battmgr wakeup enabled and
  ucsi_glink wakeup disabled: woke up 0.3 s after the plug-in.

Two things I saw on this board, both the same without the series:

- Plug-in of a DP sink during suspend (two runs with the series and
  one without, each after an unplug during suspend in the same boot):
  the firmware sends an altmode notification right away and a DP one
  13 s later. The UCSI connector change only comes 13 s after that,
  so the system wakes up 26 s after the plug-in.

- After an unplug during suspend, the DP controller is resumed before
  the held-back altmode notification is passed on. It tries to train
  the link to the monitor that is gone (about 10 s of timeouts), which
  delays passing on the notifications by as much. It also leaves the
  DP PHY initialised. So on the next resume the USB PHY init times out
  and the dwc3 resume fails with -110. The plug-in runs above ended
  that way, without USB.

A plug-in during suspend after a fresh boot, without the series, does
not hit the PHY problem. It still ends without a display, for another
reason in UCSI; I'll report that separately.

Tested-by: Joonhoe Kim <26rote@gmail.com> # SM8850

Thanks,
Joonhoe Kim
