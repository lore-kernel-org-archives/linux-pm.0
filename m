Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617690;
	b=WBgrcAoM5cGqDHByu29FTY3J8yL4FqXWoNdJ0VKgsUlDk77K2sGSiaF/TLCp6wpHsgez
	 f1fi8StNYVw3hCT1+ReEExzks/BYR89LVKyT5GXYCJEP0zgPtVyhNTPbLw0q0pYMZk/ry
	 4FH7Q296H28vFu/TdhR8nN9ASZ3ditrMUQpi3YwducjFSP2FnOWlPnkTuf8fnoT6g5HWn
	 8ugtRGvJHMmbpMDyxx8GcyQWRbrNJPuW2WbZD0S+YxnBrTBVknBH6vT+ruba5Tzs6m2nE
	 xJs6aYDZj0aFiPQ3ISmVnbkyw24KhyTZAKRcuhUFE/gl1hcCURjYeBXYHifxmRUfPOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C8wAVDCriQKpBgX/jVo0IgbeLC43EIblU+w+9MjzIuA=;
	b=U3MR+Evfe2Skc+F+lHuKls5SmMH+tfiyWcgy/PToe7QQAUMYLjgOyz0pYkl6mY6mOlRs
	 pN/6Is3/KjMrIEPDq1Ft1g8F/6o+eO4gbYw7VlRusOT8D9+mtlF0BLxsI0MFI6Pg/e+B0
	 6FRzWMA7YOJTiBnhRk3ZJOUPsQm/UuvG4CainSsMDIQJivEf6YsyP/FgeVSQuDoV94dj5
	 jnecG9OXOUe5RH0bAHVdmGhZMN+DLgN+4iBUfeQ3KizLAgKXqteMFgEtApP/9+szOYiJJ
	 vEU+TGffmzXiK6kQH87d28JMf26gHmvZOSu7cJrEbHW+c3I+1GPlIoVF+lweAybuygQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxGrUthw;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFEE606A326
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 14:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AFEE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxGrUthw
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso12287797a12.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 06:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795617688; x=1796222488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C8wAVDCriQKpBgX/jVo0IgbeLC43EIblU+w+9MjzIuA=;
        b=sxGrUthw3PgdlHgVxJKxLveTYF94vC4Q25lC6ULnWml2NQRE8JwZDTITECUm+mEMS0
         pyGtkOrQoTMhTaLfpdFxD4qTs9dtr0xHLcMqSbTn0F2y1RGPLYZDLFE7/+Lu67S/6yY8
         6N/XlK75C1Lf6nhuNHGebRezg/uPcUkaDpIIeMVM/xq5yvf6u2x9Jr7MG9akG4MS5hSL
         j/sj3letj6qLOzJfnBJntFE7bQr8GMj1PBRRZLSf+Z66B7mQiQOQFeZjkdP2Qk9DrBnV
         MCUTxoiW++fUYyhq+vo9u/g9J75Y3ZL8CaymGZiIR8TvnkPbt6rPVJcRVU17tA+XkNxp
         t7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617688; x=1796222488;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C8wAVDCriQKpBgX/jVo0IgbeLC43EIblU+w+9MjzIuA=;
        b=L70eXmAGZNpH+palLfL+aAxB4T14nKklu+GeedxJhvuQ6iX0P3oAltJqRdySiGSX72
         dUqHETpSNqmaamZWrQSKNVG+ctO/c4FN7tt676DspFc4JpVE6HuK5vF0SpauDg7oA8y7
         dBtTEh06i66f3CfRBO+ZjbwVnVl8TuWKpGFgvHTalpeadP4Auqd85HUW1ifwRthe6k7z
         DkS6JQ0RMUv6QWOKa0n4RJ4H3VdT0ekwogq9Z7hor5nR+mlWotLiUlbFETPVFeANh921
         q4C3yLt6wKvWVazIQueshPfLmgb3qNk/hkGpI6PHmgweMhr0guoRnLKs9ATo1i0YDXB1
         Iwow==
X-Forwarded-Encrypted: i=1; AL+hErE+zdFvRM1wwai0s1vXEAmOJPLrTUf+zyBQBKhl64og4JP/tc9iHD+dxg0yqjPCo1v+DmhMPOFFDg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+4fAEa8sdqMdzyKC0dxJRxd5L3EENJDQ2nNAbiGqh5TW61GV1u
	lspaphNME6qr4i19E+mYpcDTqFnLfmkYrN5PdNxtUIRoeyViUnm2B6v+
X-Gm-Gg: AZFdTZcMaAYqv6TkfLhtJ14ch/I58/ySYXsU3agnpSFLb6xuw0LVDauLXFxa95QLbtu
	M9kAleqKrq6h4Xozg1fKWOc6U/QV5KRMfP3UXWh0DcM5bG3NRfYhIf2x+YE9nMlG0vmB4Zi39xH
	43r+ZcUnw2wz+qEJxzoSIKljS259WNvIRWN6QMU+7cb13cNojhaB8QbjnlPqUao+uiYlRKbcuj0
	MkiRrQh4FPA2OHntz0XPKpSr1hSUV2shBow798lDHuo1NfuEJLcx2AibYzArlh7DUq7Mns96kXl
	WDtRboRhY3L+ITQB6uLqJjKM6l1b7xAgY/XePW0kVHbCWZ2lIwMSu2VOYZRQhctbfPPtIwm9Wbl
	mII8P+llHGD0ajlvEHgqlmF+vrwglymH4epv98zRSjTs5iC2FXQLBiAzo15ORtrXuVCrgtBYJfq
	xeMYuZ4hr34WUqYTzOPC9H7C9WBDj/4CELGYau7cBcPXWGIiMoj0CwNMFXgikQVSOHAeePEgI6K
	ZJ3OhSr+e7oIm88vaNdgK1L2pmHUCvICCQEUwepHxXinfl+cAIYeaJcE0SLSi2hX2Yw6GeWNL3D
	UcdM8bF6gI/c7fzU4NwPVpp+5RbZ+HcHxCqxlZZ47CDOsD4=
X-Received: by 2002:aa7:c0d8:0:b0:6b5:6b89:e3b0 with SMTP id 4fb4d7f45d1cf-6ba1fc3dcfamr11494812a12.19.1795617688216;
        Wed, 25 Nov 2026 06:41:28 -0800 (PST)
Received: from localhost.localdomain ([195.155.168.135])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb1ca4ff7bsm1437512a12.8.2026.11.25.06.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:41:27 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: add samsung,s2mu106-fuelgauge
Date: Wed, 25 Nov 2026 17:41:25 +0300
Message-ID: <20261125144125.3951425-2-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123-hot-stallion-of-fascination-eaa83c@quoll>
References: <20261117104328.1176951-1-tadilhusrev@gmail.com> <20261117104328.1176951-2-tadilhusrev@gmail.com> <20261123-hot-stallion-of-fascination-eaa83c@quoll>
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

On Mon, Nov 23, 2026 at 01:29:03PM +0100, Krzysztof Kozlowski wrote:
> Exactly the same as s2mu005. I do not understand why do you need a new
> binding file and no one suggested that.

There is no good reason for it. I'll drop this binding and add
samsung,s2mu106-fuel-gauge to the enum in samsung,s2mu005-fuel-gauge.yaml
instead, without a fallback.

I'll also cut the commit message down to what differs between the two
chips.

Adil
