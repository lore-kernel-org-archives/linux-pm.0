Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A95D4749DA
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191717; cv=none; b=Pi5uR6ISyfgM3S2TVNCKQO3cp8ulXQGk596m7UGMxoaGgK8toiMkAT4mOsUTuNFK6Ul6ORrmOkEvKQniNIoPI2a/mmVmiQ6unujRZAMAN1bYyqKTu2tUvNYpvv4e4+eT855gAG2C2AGhxK5HyH0YVPt4aJi7nliRJMn5XBBS7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191717; c=relaxed/simple;
	bh=kyBxHFkuQn3FS5OvT3QiCa4szxRN8wQSZLeSF+Xb4P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIr5p7ercu4w6QVoDvxEpIDgMM3LINkAgfN427Exg1kuSJrLg20UFvmpSBVrNEiOzMegfa87R+8Ek8lsuBSFgGZErF/RTqLcXizdBZfoRqPk9oOuH1VEl7OWMmpnIE91t67rcllT9arTX8i3KxgNfsco7P+mrzdPdho05Or497g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa4Akin7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa4Akin7"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-482e5733a5aso2174095f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788191715; x=1788796515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bh1KXOOmBOjDBOj2ACsh+u/Pu6jBtIO7BgsluZcPxUo=;
        b=Sa4Akin7qk8AsFq1+Me4krvf9BHB4KFnxRAaUwTbc73Y1HhOXoh+3w+47pFZ9ryVBY
         ZqNtP7ien+j/k/3CYR0wUOsbFlLOBpxALqmTBQSGKcxhaUNCIFckjuhcPs2LxbKgV8h/
         9Anaihk6i4FmZbzQn+umraKs+WFXng0yDzRTyPpIqbI4crre99clxymtZ8JXW14KU6Sy
         stYS5ifsV8Jt1axHZN8mIqDCdOZW/UcYBLCLfbpFiI9uXSmhBBvqWL4Olva15rko38n7
         gwPrqrnU1zjXb+b8v4e6ryLchtzMEFyfc4dVq2mkyH1HIk90MxW+NynTz45FVM9VaYc2
         nlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191715; x=1788796515;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bh1KXOOmBOjDBOj2ACsh+u/Pu6jBtIO7BgsluZcPxUo=;
        b=Q8OT92dA+X+NCm8AIEUQqQ/h6M8qYDNeuYcKMtadHTcXuTEb05znw0DOw5vdT1STkn
         S5he+BuHYFH6iao0irXMqSnsriQQ1yD2WFbDJRAHKuFaVre6xE5BAqQeXfM1e+GwihUh
         zgR8stWx6iBED3pOJUNzDpHTIuuZYxx3eLP1gGI5wdR+/lT0rTNjj1mIkHAcgK/s9TZD
         tnKolV7S1qeRqT4/20l0FaOzA1LAXqnG+3YRkRU2JBu+Fq20ewfXYwTT1Qw+Q/brV2dF
         fqAM2Wr+H4eSqhvp55AvKucZrI1GTdtAm/Yxf2znQqiiD9O4YxMoHfOtbiaHuxDQxBog
         6WGw==
X-Gm-Message-State: AFuF++kcSlBs8Xx7bOi52GLWnPUgVLNg2+IorAMGser9taNCssHqWDhM
	KxfzA+FlLeBMZ6lhqOVjAGBnyiQaLPcmQu5FLU5gYXcpH7j/BEVHKNGT
X-Gm-Gg: AYBFou2lxFQn+Bc1sDnh0tmfeJufln0zNfzqUXRCs02zEY+aSBUVfAI1STk/HI1G8bv
	MIoeGuM1u6X5QpUwVrUqp9yVgzupH55Xbl6o7yfdnb0HZhfYwvjiAyQSVrLfwTaA0bXlcND7IFW
	pOXCSBdskfgPaaXsLhQTAobanZyWGS9qggSUaO45+1qJ0IQ2xGXK0tH3s+SsClB2iLOTq92xkrA
	mBrUAgKs61yexzrT0mPp8m9Me439KqQjJ4K+mFYvefrof2Q0uXP+msfki1Nx9mKo86YGbAe6MSd
	hZeARrgZk3bLrmDIcfsuom58uhN40JgQRxkvCPpMT7ywX92++vbxHITZwlEcL+WaTE55Jh3TTPn
	25xLPbo+YV4I4bkjXaiT9aX434lQVSK2GPkqGt/OfhaUsmO5S/hswdjHtr3OBRJf+nW15zj88q+
	p5krUv8v0Y1lWm40eNxwnWZGJHy1oAo64nxaJmoBk0u+NQJVgpn7vTidq2YQpR4s90TqLendFrp
	ddFlzakNa0LDUP2bsHDv4roLRjzyi+9hgY=
X-Received: by 2002:a05:6000:981:b0:484:3604:c7bd with SMTP id ffacd0b85a97d-48440ff8ec9mr3258271f8f.17.1788191714553;
        Mon, 31 Aug 2026 08:55:14 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48436e2af3asm12949099f8f.12.2026.08.31.08.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:55:13 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v1 4/5] docs: ABI: complete power_supply type valid values
Date: Mon, 31 Aug 2026 12:53:38 -0300
Message-ID: <20260831155339.181487-5-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831155339.181487-1-ivanrwcm25@gmail.com>
References: <20260831155339.181487-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sysfs type already exposes USB_DCP/CDP/ACA, USB_C, USB_PD,
USB_PD_DRP, BrickID and Unknown via POWER_SUPPLY_TYPE_TEXT[]. Update
the ABI document so Valid values match the implementation.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-power | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 5641f1fd5fd6..08afb75973d2 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -34,7 +34,9 @@ Description:
 		Describes the main type of the supply.
 
 		Access: Read
-		Valid values: "Battery", "UPS", "Mains", "USB", "Wireless"
+		Valid values: "Unknown", "Battery", "UPS", "Mains", "USB",
+		"USB_DCP", "USB_CDP", "USB_ACA", "USB_C", "USB_PD",
+		"USB_PD_DRP", "BrickID", "Wireless"
 
 **Battery and USB properties**
 
-- 
2.43.0

