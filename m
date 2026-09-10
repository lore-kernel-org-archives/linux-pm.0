Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32330DEDC
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022152; cv=none; b=Z/1XZnOFPGJcs6hcPJvd+H3+CUFsnMw21pT6tQRsTDahmCusQ+T855/cp62g2c+PLoE9s3lc1+LF78WpVpxkuczEeWbZ74WCXyueLVNf+iZtH5K2xN9jtVF+M/QEQ2vQRW9Gk6sRIbqUMDP5u8Fg/t49tpY10j3p9CQ7vfROUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022152; c=relaxed/simple;
	bh=EV9CYgvynfqPPxDLEZ5SYU734gHfgS64XMZag01l2eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVkTyjxHYFn35kzfLGuAo8xmwmqat9ymEwnBS4Wgd/FxHuXK5aBlARGgSt6h7QEaMLbu/QifVnd0E86f4hyG4sCleXvirJIknBLkobcRSTk6uCjQUdAXBx0IKY0gV4VFae9d4PQGOtQ41H/LNXUfJpV3ASPPjkvE/ZK11qcVOXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbImkt6l; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbImkt6l"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4957eefd361so52510475e9.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 23:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789022141; x=1789626941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=47UBI/niL6S9mV0mk4dleceEw56xBW1KNX8OcFOEg40=;
        b=fbImkt6lAxS4ugKTgJnYeffqnlC/tKUlYreBwIaoxBf+56sOZrFAf3ryvDO/fzTI2L
         /f1PTqzXN57NWwMpqygqUaPi4Za0RI/IPnSpfVq7RtxYDAbVc2KRZw8QQr+4i9f4MmUy
         XdUzkraD1GQ8O9MPQ0ENTon5wN0b9NEzUBmpmc8lXk93e0ws2+FVg6+UJrjBLuR5dTp1
         AbnQXzJHNlhiQ1DVZGOv7jBIddPbSCzk5flsyrmBLMZSPOLp2AHehpXlc3pvoGEl7wNk
         rgQzGu73XsY0Slp0BsfWF0ftSvPzcYWq86j5bpMO+AYy6UcOkbi9Dae2WjVY2Vv/V1+x
         w4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022141; x=1789626941;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=47UBI/niL6S9mV0mk4dleceEw56xBW1KNX8OcFOEg40=;
        b=Oqztepy7N/K4OZ1+EDU2rO4417Ui6LWU+p0vkSGOehCUNdV7vKpxjr8lES8VswmLm0
         JD/HZHak4YaApBVEyeUMdHnKlvA1N1ZDvantYz9/APFcOqZIQtFwiukEscioHc//pGs5
         4rI5Z6y4OEavf+7k+DdJ8JQCEYhYpjzrgx27cwEmq0WanAv167unh0OwYhbBBxv6cCCv
         Y0JRJIMZK0MJ/RCIBEB8ouuDnGpjh5A406vFMrP8Fg1z2mXGbnC/eYLo0/e/38q4D7Xg
         8LuYBWf6eD2Twwrs4Yh4bxjJB8XpzUA2ms/4uKxrt2Ev6J/HWewMbIMF45kljJJOgCzP
         R1KA==
X-Forwarded-Encrypted: i=1; AKwUvByCfgcu51ZtlPq68q0l77AdgqTpWhayZAmfnE56uu1XRfRCsJ7pUGr+ONjDovhGTBElDCpXaaJBxw==@vger.kernel.org
X-Gm-Message-State: AFuF++kwUbEw9pfWXT1psmN/lMvsMdcrW6MhGz7OdVf+BOMG03VkCVuL
	zbFcI6rwfp8hBveWA93kDbH9XoW14QOHN+u3tXn6wN+a8z1dBaIMLGyp
X-Gm-Gg: AYBFou0RCuPCEChjn8CN6NqH/19D+ADfZFzpvN3G7SeP+lwzcjO5YU53bpAQwnxiNfs
	IvGGNtdltk+WL3XipzIw8ed+OJrOYkUcFu++0bkpAvGj+RtWwuxcRhNCb9ksXPebmxr6OWy4pvL
	AB8x/u/0k4NYM/wu+U5Iq0cX3wZh3NKYz5W9EAZ9UCzxN/DXy5zOQd4HKagCaASCYYkYpKZsi65
	ixg0n0OWqgNWY7OhALM/nIq4zZDgjvWeRFhy1E9PvP0O0lcVOZixw5UBYcSQRvpWItqcW6hGhy2
	sMDI5UPrk8G9P//Mec+QjgkP33SZ8a3jVhsUXDDHIkBStHr9VgrCNo9z3UBX8C+P5ZxeDt5JGvl
	FPIj4dO0gjtpeIOUhy5bbfYVIy90e4on1nDIjYAXsHSf6QxCd5tlHx9HeDYDMML1cIY4mAbGceq
	eYK1TDsGLaaPRtiGst8XtEsA1PTo3dMIMl7Khg0p5BIyNCefYnO2Un2NG3460Di7k+XragSsp27
	uDifhrMNWIh7blAGDsS+AWzRY2xolmAXpJ3+bkYRwA9LA2Sg7PM4yk=
X-Received: by 2002:a05:600c:81c8:b0:49d:1f10:8b9f with SMTP id 5b1f17b1804b1-49d1f109802mr89066405e9.7.1789022141345;
        Wed, 09 Sep 2026 23:35:41 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm241531985e9.4.2026.09.09.23.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:35:40 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: jonathan.cameron@oss.qualcomm.com
Cc: sibi.sankar@oss.qualcomm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
Date: Thu, 10 Sep 2026 08:35:30 +0200
Message-ID: <178902213027.4725.14870667006708702053@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909152014.000055d8@oss.qualcomm.com>
References: <20260909152014.000055d8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 9 Sep 2026 15:20:14 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> > Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>  
> You don't add that for a review comment unless it results in a whole new patch.

Understood, and sorry for the misattribution - dropped in v3, which is
otherwise identical to v2:

  https://lore.kernel.org/all/20260910063440.4677-1-okerixx@gmail.com/

> +CC Sibi who is a whole lot more familiar with Glymur than I am!

Thanks. For the record, the numbers in the cover letter were measured on
a Lenovo Yoga Slim 7x Gen 11 (Glymur, 4032000 kHz sustained / 4723200 kHz
boost); I am happy to rerun anything Sibi would like to see.

Thanks,
Oleg
