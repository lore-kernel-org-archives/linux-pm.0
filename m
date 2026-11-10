Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794278014;
	b=T4riIrfPsL41qFMZhI+eqlAJgfvv54f0C/7rtLnEwQ8F2sC68Yv6vI8zAqsjfRq59AHm
	 i9XHNE0GqoM4Jo/vEV74BFjHYTIVW6WVjK/ptbkWZI2DYUMySgvXahdOxcGAuBCwhh8qf
	 fVUwAwpT5i3gH3YwL2HW7k78In3Soz8n1kASS9Du9Ylk4GiAW+EnhZhbvi6yRigzupHqy
	 4dN+0e11PjREtg7rQoXMFTjKEbgY/vIUDVqFxTVd5XWJxs6Kjx0g8pDdmF4PvlwXCOY9M
	 oc1iBD50e3taIyFhxrYy918se7CGIi1rdEDO9tyQROkeHqIoF7JUGBi60Knv6/b3vIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Ir6+0LktXyNV5hGF4yG0Zsi8r3P+hNjzS2NcO8JzLHM=;
	b=V80MI+eFV5Wux9EXnd4W8iWkCTdrQLOn5XoCt4/WqV8kfJsLex+ruonSkfWhiR/BDfGe
	 BIQhCOEQoVhhjlQKsazFDgDEM2B1/AcZwq07EZFPz27+R49kRe6WTgi22+R3MTddxIKKS
	 PbO6267wjw7tiwTtgr5M+2moVxMJBFNChFW5e2pj5/ki5SaKzuZYNKcJ9GiPbJK62P30K
	 23BCfeFj4gJ5j8gPP76AMLVOXGFZLIUTNmuUx9vTv8gvTkNzz4QwSfXAPQ8yl3YE2yXtv
	 RLXTe2bZWrKSdJ/ep0a2b/Gq4obUCvvHyMdBopkLR0f/aKIf+FDwuqgJmFvVSaye50Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPwTGqod;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC77606A321
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 02:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECC77606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPwTGqod
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso227339166b.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 18:33:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794278012; cv=none;
        d=google.com; s=arc-20260327;
        b=HRtV534aFawJkxfhwNz2HimrcwJgIGa7bFLU57W+anvRBIKf2rITYhVpSNmfy3sCho
         mWRB8fhjnW65Of7pJ1whUZS5YOX0MFphEP1pSYF5ABLo7S5Jy7J9+g+GNOSgIzX2BYUH
         +VNZVFVzA6bHx6CrSoPaEXRbdLnkZ43NvHy/K0z2n7eE2OeDCNMfgAwMV0+Jbxk/XwgD
         aTe/jKbl5Xv6Ad2RnH5Iy0MOhPbejyJUkKFi/Pc075lg7RBFSkCChq6w4qaj2PnGos/S
         mCuCi5XGHSVe4hpO44heTOtgtTFliGgszxHXWLa0M/H46i114riWxfjZkko3G6YEdSs+
         tZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=Ir6+0LktXyNV5hGF4yG0Zsi8r3P+hNjzS2NcO8JzLHM=;
        fh=JhZUaEC3PJ/Bvn/a0RvJlw/+rsN+UbZUEMmARldM9Fo=;
        b=NFLEAeJ/7ewW5rrAUEGySUyVxXNjibQkTZ2i6EcMPiARjgba6iCNlRJCxLr+XlqIWv
         T86v2aAzbCjULNZs6+ThrGF2zof87oTCRhbbKfHo25bDS3BSlw+N+mierO6iiN+Dj+07
         jOEDm12rW9vrqqw9F3Ijr42l4ogjJSPtx5VSzxwDxQg9EF/ArnmmKOlPiSFob0boaQTM
         bg/ldZKNLEsImfML0my7F4PFqqttwUq4gsf6eJwBgWIw9JroiKJeTmGDJxAiprRhX62e
         4OVDbOLYYWMPalfxskNIUjrwR4j6xbXNx3AteT+evuheoDGpTBjA964g4wwX3ygWCVfX
         VKIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278012; x=1794882812; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ir6+0LktXyNV5hGF4yG0Zsi8r3P+hNjzS2NcO8JzLHM=;
        b=yPwTGqodd7n8H1mxcfS43lExUvi0jzQJU+ntBIlR4pprDZdl1TVrV7IbOibnNXcuNF
         DfuCSXoUIjxEK/WuoROirOzkOtDBCuOYUf8FTQuhGN/3OSpvmWL9upVt+5OSUY+BA1Md
         EP51Wv7G3gWQ/TjLOxX/nlHk+lT/lByA+C9Y2XOloW3P50RtVZOHu1p6THXe4zxqIZWc
         HtA5gxGAzy6tlbJp2T5twXh+f6WvRnTzeFgFCgRnDBNd8qMU9WETLMADtfnjGT3rP6aR
         8umd9BDxeT55xe3RiTcauiFKWvpIAeV9D8cmRfLcw/X/L8yNYtl1ln9HMc2idk8YD0Yp
         R4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278012; x=1794882812;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ir6+0LktXyNV5hGF4yG0Zsi8r3P+hNjzS2NcO8JzLHM=;
        b=uDffOtNF3C+xgs1urbGR7/d+HQoraozEc+AFFBUb7Kq/wYBZ4wpkqzV+09vo0n7uvP
         omQiOCRli/DgSSZp7zCPSMWzOEuaEqCPafTHo9EZ4M/aWUkMFf0yAN55FjW+dgs1tdI4
         9WbJc9+t8Tpw5k48jaa7BYrJVRid7OS8KVcWegpDrj5aZus2Rn3eUYtv1BjBEaMW4JTJ
         hxbUP+Qi5jn74aVfcoICCqFUTik1DF+X+WXc4hpznwd0XXTFLi6BVCZvaBoxo+uAi70P
         RSDuTRjqxkjs2KgYoK1D09CFKRZd5pSiZNqWVG+gbCgWwNLTNhdXaK3ipRjWPtof2TaI
         jCPw==
X-Forwarded-Encrypted: i=1; AL+hErG6VhNiIXnyqWiABUoAzEwSk75o0A+E5+sKIj7vLyRFhB3ihoC7SLTSLAVLOSr6hIAhBVO3+RQhdw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/1dMjuFE+pTgqOPsLyDmbHP2y+OpK+29aThnZp78MDG15LgM0K
	UANHO7vqMc4mdCNX+RssWeqaO7WDdg4cTedPFSfsQGXdtXq5bYcwldau7ShuJ5y8UC3/lr66JXi
	ut+ilf+pR+qt4xI8z09Crp5hjeFP5Qw==
X-Gm-Gg: AYBFou1wXyqlMvRtXeCcYu/1aVY5yoLW6KE2KLFdZ78tGqsB55pP1jNl5FbIGd4hRIF
	6pB1NRBUsYZW8DFhlorf35+of5wgxSQxGk1a8sdHNyZM3ylO+77jR4lMCcGiiztVlj/HaOlWgy5
	oXYfc5SZMrOYZm5jCZVfivuy85e3HGnRqRPQpWYoaS1ae3eq2cbDW9vDwTppEPsP1iHY1q1yRXm
	Z46AWvPo5alxv3Z021WcC4YjlxfCeu4Yem2l0OOO36YZYImkZPQg95mpp4ZH8hgqgrdIEvny0Oa
	tlOAWxn60M7CjnllWqIBjr++IdvdVB1Yis3pfvHG7pOYNLn1RP4tYY1OnF5c5fh+zouJlsy8bfg
	YbCLUUBUvpBXF4QIGUfu1HWHV6MK2TRlf2yG8cGGp3Mq+LZUV63sx4YAak7OK1kV5PztEcZDR/d
	j+dZVTys2a3ZuMwlgj86iw6eUe5+oaIsUb71JI5+VdbHVucVburM5r7D1Y3A0CckfQ
X-Received: by 2002:a17:906:c150:b0:c2c:d06f:cf89 with SMTP id
 a640c23a62f3a-c50491bd3b6mr89682666b.2.1794278012315; Mon, 09 Nov 2026
 18:33:32 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 10 Nov 2026 02:33:30 +0000
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
In-Reply-To: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
References: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
Date: Tue, 10 Nov 2026 02:33:30 +0000
X-Gm-Features: AclHuK8--TocW2ifUYfCFyXaag8s9F_8MyrCNuCPPkZVo7e4LGqYlTsfOEWdPSA
Message-ID: <CAGEsz8HEtP7c-JSV=LvhTH9k5uRxq4z+4GgypbE-gmCurghong@mail.gmail.com>
Subject: [PATCH v2 1/2] mfd: core: Reject failed IRQ domain mappings
To: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Ijae Kim <ae878000@gmail.com>, 
	patches@opensource.cirrus.com, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

irq_create_mapping() returns zero on failure. Storing that value in a
child IRQ resource lets registration succeed with an invalid IRQ. The
child then fails to probe, and retrying its probe cannot repair the
resource after a transient allocation failure.

Return -ENOMEM through the existing resource cleanup path when mapping
fails, before registering the child. Leave successful mappings owned by
the IRQ domain provider, since other consumers may share them.

Fixes: c94bb233a9fe ("mfd: Make MFD core code Device Tree and IRQ domain aware")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
No hardware testing.

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 16ad4fd26..e00f31402 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -255,6 +255,10 @@ static int mfd_add_device(struct device *parent, int id,
 					cell->resources[r].end);
 				res[r].start = res[r].end = irq_create_mapping(
 					domain, cell->resources[r].start);
+				if (!res[r].start) {
+					ret = -ENOMEM;
+					goto fail_res_conflict;
+				}
 			} else {
 				res[r].start = irq_base +
 					cell->resources[r].start;


On Tue, 10 Nov 2026 02:32:49 +0000, Myeonghun Pak <mhun512@gmail.com> wrote:
> Hi Lee and Dmitry,
>
> This series fixes WM831x IRQ resource mismatches and follows Dmitry's
> request for managed onkey IRQ/work cleanup and MFD-provided mapped IRQs.
> The provider and consumers are converted together to keep their IRQ
> resources consistent.
>
> Changes since v1:
> - Use managed IRQ/work cleanup instead of storing the onkey IRQ.
> - Move IRQ mapping into MFD and update all platform consumers.
> - Reject failed mappings and unwind consumers before removing the domain.
> - Retain polling for release detection; the chip only interrupts on assertion.
> - Drop the previous Reviewed-by tag because the implementation changed
>   substantially.
>
> Compile-tested with LLVM, W=1 (arm64), for all 11 changed C objects.
> No hardware testing.
>
> Previous discussion:
> https://lore.kernel.org/r/atJycIEnUZKVdTjW@google.com
>
> Thanks,
> Myeonghun
