Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795373677;
	b=MN9NiPtkNp1zFeOhvs7sk2WMvBxQ6OJ53SohWJQnq71xg+my0tslD4i92uQvV3iJQuym
	 PAE7SZTNxLsXqbdTR6hp+ftMfbXqqvpgKXOhppYy5XEWlH75853c+5qBk/nR1lsMd0WLP
	 wzHUqpW8JVl3li2BuW6bzTsMJmsEqyRd4fYVDvPomADtWOhOkh6tmwbF61QP7ywZ7Uklx
	 n4Lu6VG9i3HQsZJJXJ4f9gETlKfJ3ET0jyWRE+EQWv787rZZmx/UKHORfLQmX0LK0YobQ
	 5UR45DUH/ECVsdJudhwQEdbLaoCLKP4nolBdyxnrkKcr9hgSKh0kilskmGurpWWH9Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Uf40K/pvodARX4TFG1e6YUSwIbzlkO0+M9Bn1ppfz2s=;
	b=hiaSgHhOCC55gynn8hBS6e+6ytFoVF2Nox0GXjHuyrU4E3iou4CCcfvn10g9CGXnlBhe
	 uMZjtM6nEHrknRdKwLnimQVkn2xQhqHXYztrLKFwB2ekZ/JAm5XjB8JoL0tQY2VNzF8PU
	 mAAP8Eut5MvsNgBrhCAze2wy98u2H0OWpAi42NbzTDY/h5GUkPASGOzN6STOVa1nkCRus
	 5M5u2HTHnKKB5JjgcwEqsGr2JleHvqRyIeJaG1tXgJVkDmJYSxLKoqx+YcMconK5P/Zhv
	 BmfuDvvU9ieO56kPveFG9pnAjTGj8SIjNj3FT+9eatObjm8PEqe6zbLBHr5U7+LtM6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Iaef/p1i";
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55927606A32A
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 18:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55927606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iaef/p1i
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b86fcbd647so4124473a12.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 10:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795373676; x=1795978476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uf40K/pvodARX4TFG1e6YUSwIbzlkO0+M9Bn1ppfz2s=;
        b=Iaef/p1imBWOYDmFzHXqlV2pxfpBABeFA3v8p4Ao3xWCNO/2WMkjIK7UFKLAhGbkHQ
         POed4MhGLKUu+6WzHKcEYOMAiZGIVKDdsXbgRwFtg2SHdsDPHWxeyWalcdAD9kuW/EHa
         fLWSGH4J3uVWyTPAMWv1VATk9VdtjOeKAPfUKTV19sQ+Ksi88M6REDfSGrWMI2//5o3P
         aQCBEHFmcqwOjQAUvvpM/hm3+UIs1vrw6rkhSgjoHSbMyZ1O5mrJRs7D0VOj58zirupa
         iVsYC2JQTx5oJtocVzDklyBNANhQMYjhcFbv2lxkTH+D5wK5q02dgXjHcFavYOTM5zR9
         OOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795373676; x=1795978476;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uf40K/pvodARX4TFG1e6YUSwIbzlkO0+M9Bn1ppfz2s=;
        b=CgFlE/LDw6NdfLGJ8gKyif5BmrQKbGgk407Vsf1uH4iiR6agHaFGhG1qE8w5JfZE4d
         7QlPt98OM20XvxjMJvMxetyBxEWhG+5nSdr/Wd7wNYTOnqVXccACsyiSYzpsq2g7jGQP
         yzzNkW2AVk2bnHEbeYA0LBvpfruKMMVUWY+/aWhrFCIbFqFamamA+0/SuqTneq0c2cCv
         8v2+TK2SjmI30/ikmtYTY2UiVDhk2wRXj9bwHcri3QQ213RI5Hyng8mMrqtBajzfpYRK
         GXjy8mQlK0uX9tvzkTPx/616XQWOYT8Dwor4Lz2mcyCV1fk4PSWdWoIpAFjH5GJe1u6T
         3c3g==
X-Forwarded-Encrypted: i=1; AL+hErFn8eYlCO4RqU90aNiSU7dwdmF2aLtXrzniAFq/z5AQG3FrBn2rvYhRb65VgG17n4RP+hVKVQ82gQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z//jaE5nQ+ccah0JocXvTPunpTpbYiOEv0oxaUCUxD/um9SDfMJ
	dmQtjDiE5yNl/swUPGRf/tZ5/ezzixf3yj3XCXgs9eblSuAYIDVFnNkDpBVhmTYj+P8=
X-Gm-Gg: AZFdTZeIOfL/srlcfzX9fYSPFdetOcoJMdLuuz1LdIpK3YAyTPkdBMDXv6HIVdHltOd
	n9ZMQkKprV/VCxjyYI6IJJSPnYX+KpX5YktHflaVqpL5BZOYycHn9ffrA4YqraQcH5kfpLORAYQ
	IOWagCPNtrbZhXeQaoXwUXuA2PLv8jET0EfV0rysA39JkYx68DlQ/kch7I9wEWLWWhYS+oI4Lrx
	7hb4azhpyjVB/kmMuXgYuolMGmZqlMVmaLsR6yQJ7yQqW1i1cRQ6Y/jeS7t9OTXcogJpq2yoYL3
	3QDem5BYTip9emQ4vNmcyS20nl8UAl1vqpDs6gvoWJCDc1BFv5Fmyxc+Zrxay5GUWpZbMSaprJ4
	i+3axfhdrPwb8FEs04mDGSitkb8/Vs+x/uqCAyinUbKH+ItgzPuYuuFZFaMnYpkXQVgdRVJTZC4
	pF2sttX6tVYeG3PzO1mDb8z0RKJTgpqzgixk8CGt2nCh2CVoScWAzzS1wyaPRu8iIMUkwhQM86g
	S+iy80DQVIO7u1h6Dyd2PIMWEDQP2CHuNoYYtHmVymvvFmDt8q+YA/3VmSgIqQbYaTCB/48mlH0
	+5j9w0SMC9Ov68VGhzeOMIwFiA==
X-Received: by 2002:a05:6402:22ed:b0:6b1:c285:f8d8 with SMTP id 4fb4d7f45d1cf-6ba1fb0ff8cmr5919856a12.11.1795373675341;
        Sun, 22 Nov 2026 10:54:35 -0800 (PST)
Received: from dl360p ([195.155.168.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba7b9570e9sm2385762a12.36.2026.11.22.10.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:54:33 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] power: supply: s2mu005-battery: add S2MU106 (Samsung Galaxy XCover5)
Date: Sun, 22 Nov 2026 21:54:30 +0300
Message-ID: <20261122185429.557309-2-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DN05PYTW4NV6.SOA0NRNOJBAR@disroot.org>
References: <20261116074000.355176-1-tadilhusrev@gmail.com> <6afc2f77.2bb6edcb.1518d5.5d4f@mx.google.com> <DN05PYTW4NV6.SOA0NRNOJBAR@disroot.org>
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

On Fri, 20 Nov 2026 21:22:14 +0530, Kaustabh Chakraborty wrote:
> Actually, this one was just fine. I didn't look at the patches
> meticulously but it seems like it does belong here. The correct approach
> would be to adjust the driver correctly so that it accepts both.
>
> The compatible patch is, in fact incorrect. The driver clearly uses two
> separate compatibles for the two devices, so there should not be any
> fallback.

Hi Kaustabh,

Thanks for taking a look. To be precise about what I was reacting to: the
unsoundness wasn't that the same driver matches two compatibles -- patch 3
did add a distinct match entry for each, with has_monout set correctly per
chip. It's that patch 1's binding declared the S2MU106 compatible as a
fallback to the S2MU005 one:

compatible = "samsung,s2mu106-fuel-gauge", "samsung,s2mu005-fuel-gauge";

That pattern exists so a kernel with no S2MU106-specific knowledge still
binds correctly via the old compatible alone. It doesn't hold here: a DT
node that lists only the old compatible (no S2MU106 string at all) still
matches s2mu005-battery.c's existing entry and takes the has_monout=true
path, reading MONOUT registers the S2MU106 doesn't have.

You're right that the actual fix is narrower than what I did: drop the
fallback from the binding (require samsung,s2mu106-fuel-gauge on its own),
keep extending s2mu005-battery.c as patches 2-3 did. I went further and
withdrew the whole series for a standalone driver, partly because I'd also
talked myself into a chip sharing three register offsets and their scaling
with another, on its own I2C address, not really belonging in that other
chip's device tree node/driver file. That's a shape preference more than a
bug fix, and I should have said so as a separate point rather than folding
it into the same withdrawal.

The standalone series (dt-bindings: power: supply: add
samsung,s2mu106-fuelgauge + power: supply: s2mu106-fuelgauge: add standalone
driver) is already out and hasn't had review yet. If you still think
reusing s2mu005-battery.c (minus the fallback) is the better shape, I'd
rather hear that case on that thread than have it settled by default --
I don't have a strong attachment either way beyond not wanting the MONOUT
bug back.

(Resent for the lists: my two earlier copies of this reply went out as
HTML and vger rejected both, so only you received them. Sorry for the
duplicate.)

Adil
