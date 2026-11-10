Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794277973;
	b=0TelphQXdKjYRqEFFt4ABscFj57qW4LCJ1wUtwMt4QLNA8OM23Qwj7RgC5Evvzi1/6tZ
	 oLBoL0SQP5y9eMwi63VgXaCdynn3UwHa/+lCDvNm9Gb+jNtYJ2VntVEeOpEAnRnYeNbeY
	 Jq9clhstqe/DN3wD3Y4/v6bRMmVWkMXRhIeuXvDdNVnuFgY/HaeI6aCqNxkYJexHh+ry3
	 7m0ngwQeDXLkE4iX8pyrWitHSQcbf/3URrqAQf8ZOp+b3JAP6bzG0oNIhXJXBkB13pCMj
	 vCr5w5/1Y2czgEXUgsdCsp0GEl9GTS+fzpRefedzd9oKDL4ReYmloE+Wq+KAaI0CELw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=+UEXnv8sO59biXTVUGJWsxHSY+X/qyvekpO21DXG97s=;
	b=sWe61J6uEBfYCQDmNDI/2n7EUk90llGf6+0NcwsgT3k8de+ZZ3Z16wEx9+FWgTtIQE2r
	 bMvhXKfMey5jCSxnXha6iGrRdwuSFdEYD6iXQmssaoy1y3S1qBSmdWybE99MeGze8Q1qd
	 8RCyXIZmOhAnbCY6eVCfEpsjpcVdpzvJFUIHlsOsgYIks351Dlqd97jTdMj2vky3OU/63
	 MsWNPtholmJahep/H7nCKZtvHTbYwQeGsQtGnU418e4wEG+wt65Yvi/ODnCMgIPru80a7
	 g5UMi43AutmvOUel8ovOZOLwkxzRC0/urH4gz3GzAMzijbpWnyiLy+aaNY2oarnYMcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kN8usH9I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E6F606A325
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 02:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59E6F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kN8usH9I
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b6e7a05225so2080179a12.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 18:32:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794277972; cv=none;
        d=google.com; s=arc-20260327;
        b=hSVw6tUxaNNFdWpAFmMnw2JM4AqqBiaCvQgv+ZH3EFNyRAGRfCYsgnJBbrpaTvndrE
         C7Uh8r4VG/84SluA7GvIazTvs9F4SOKV3ck+iZHs6r/+4mjVsfo3iwMhg/5jRKM8FyPP
         3PtQNFzRdGOelp9mHJvtqYmU2J5P8kess0xFpeDVDJ6hT4CU46jkajMXARKD/olQI2T9
         Dz98eifXqkwXT8YPPYD2pjFXhZSn+BtHaYzXQNFrobbz+RDOTUMNTynTUBL+E5a20Qxu
         lbHSENWs38wTGMjdXuh7xyy3DKDWyITQeX6MygqySJbQwMOpOCXr20dp4ztodMIqrm1x
         /rpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+UEXnv8sO59biXTVUGJWsxHSY+X/qyvekpO21DXG97s=;
        fh=7yNPu1h28754wk6P/M5PXPaFRqoGHnaE2xt+F/UGOrk=;
        b=NLt3VVKR5xAKRnMS4iYTDpcaht+7RDv/cVrh6bxMbah1+pb5v1kBvK/f2Lme2iT7BH
         SR9KpT5jq9EMHNCmBAL4TDi0q+Bu5WiMoKhNtpSzDDMClGs0nDjOyOX/YfcjSXCBx+iz
         bBLsG5rQAaXNaib/1EPm7GdO0yeocxB8h7LjmetIrJ9m9y2/kM54OaVckkhDwiOE2XFs
         dYQ4/EoH2tnxhtRyPgQ1i3W5csyRYHN3yBlxDSbikXuhFitFNTHQuprgpvHW027Aevi0
         qsff0VU0kjE5FiU3AH+zAUgH4pN9Yyb7erkAkJJyJcyD67kR78Uij11derpBqIcnj/AU
         UsNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794277972; x=1794882772; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+UEXnv8sO59biXTVUGJWsxHSY+X/qyvekpO21DXG97s=;
        b=kN8usH9IU49ojTSFWxPbJVZ+ZPL9HfmyxBuwCulgrTZp/vIkQ2G69w6Y2yovNv946E
         bJzgBQHvSOFygF+KiU2KfzjtI0OAeGZi9VL3lKD+AvhAVGOQmot95xbnAbg2A4CaqsCf
         eTZ8KFJ96l3FwkAU/lwTHaXnrTtHfa2PYj99p6cQOQJSjiD4KSRMNhMDCcuyLBKNz9Os
         tSQbuty+GYOY4ZQ2vek1GcljQVgKSwQkRuubGXyLCTQolhUdTNTRmgmjxNwLUn2vfeXd
         12WP15h/MMthSPTaba6ldVBkatiFdKp89KUiyAAfiQLjEErfYKq0VKNkyG5HIpvzN859
         aeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794277972; x=1794882772;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+UEXnv8sO59biXTVUGJWsxHSY+X/qyvekpO21DXG97s=;
        b=Vll55Km37caMCwTWQFwWbxuaWKiIzv6XNwnv+BIQH6otfxd2nZBSWzJfCxAGV9PhcG
         DNetJtsqCbjA61XzT0M6IR/ofqPWEEFg3DEUMjfu2LAH689b7Xj4192Osm8Lny4kXRVv
         VLoxlbpqUk2QLdEz7TnQbrkXZGMec34aNLM3iURhaegjInHXbJjiGNG54IGM1SXL39yE
         55/rCElgAWeEchn+b0I+7pUkZmsACzO3SNplpUUz97Al/jxFBQW/LJ/agM8b595ASYKZ
         MB2Im7kWcmzwf7Xxmub/GzyGwfJ1D9dm5XJkH//5dY9MPH5uxgsDXwwW2+byKzH+GEWM
         9saQ==
X-Forwarded-Encrypted: i=1; AL+hErExFFqI5iOv7G3Xg8eLxR+slA15DHuaBsjrwMrU3rBAk45VGmXhJwgqeWC6W2yHSITYnVNG+F486A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/fVhGwYv10gHCFpQ7ZJteS25x/bM4MQYtuPLCRLAqnWyAQfENz
	K3Wc+1CRATq2W2LtDDmW57YQ5lO/dHUiqCWDYRg8DYST2WLZT+7ey9baftZs6zpiAqCMID8lSpF
	wufBY4rvSKBQMro+hxj95GNWjbNY0FQ==
X-Gm-Gg: AYBFou2PacTpYP14r2QnydwQYPFlm1o7hi+1m767gUp+Itb6RyF42g27InitEubkr7h
	mm6GEgMvR2OansKY+WNAhEOG+DFzfbZTwonre1VahNBAJaF4IJNlkUNiB+hBm+WpgW5iObldb9+
	Y1IMI//bmrRFko6IAVwoB31XUgBhobYOLJpYC15CNht0+d8uOrbeqz6VahtbKlcfADHQlfDJjYT
	LMd4T/xCAFN55qgMAeT3v2J1JX2a8VoDA/a+g1r+Kw8zGgrWcLmTPAqJHaKJWXjyYo9yexVPbUu
	ZCcelbvADo9cFLgorWfh4aiBpsah8asOQtmdl3TNbLMXGHtXmv4/C3K1U1ZSJw4e+0V+g8kcgl5
	0NLOVOXfFsLyqFMM7VsIsyEJfkFwEBk426vs7OaLTwIjqRQ/WKgishMLGxBujQ0r9PW3MULEGcW
	IoUPZnMRV6qwBLGmlGEACRZatbMFddGx9I93vpKVIWC4p7
X-Received: by 2002:a05:6402:a507:10b0:6b1:8818:1090 with SMTP id
 4fb4d7f45d1cf-6b7568dc1e7mr684976a12.22.1794277971764; Mon, 09 Nov 2026
 18:32:51 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 10 Nov 2026 02:32:49 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
Date: Tue, 10 Nov 2026 02:32:49 +0000
X-Gm-Features: AclHuK8AIkgNRXamUPSojUGsIPAwgEr26dHrd-qWTZA7kFbE804fLktH5iFVef4
Message-ID: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
Subject: [PATCH v2 0/2] mfd: wm831x: Fix IRQ mapping and cleanup
To: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Ijae Kim <ae878000@gmail.com>, 
	patches@opensource.cirrus.com, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lee and Dmitry,

This series fixes WM831x IRQ resource mismatches and follows Dmitry's
request for managed onkey IRQ/work cleanup and MFD-provided mapped IRQs.
The provider and consumers are converted together to keep their IRQ
resources consistent.

Changes since v1:
- Use managed IRQ/work cleanup instead of storing the onkey IRQ.
- Move IRQ mapping into MFD and update all platform consumers.
- Reject failed mappings and unwind consumers before removing the domain.
- Retain polling for release detection; the chip only interrupts on assertion.
- Drop the previous Reviewed-by tag because the implementation changed
  substantially.

Compile-tested with LLVM, W=1 (arm64), for all 11 changed C objects.
No hardware testing.

Previous discussion:
https://lore.kernel.org/r/atJycIEnUZKVdTjW@google.com

Thanks,
Myeonghun
