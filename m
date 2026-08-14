Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0D42C51A
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786701483; cv=none; b=WgSAXZdcATpI0JQskTPyInWskBcke31xR0rX66gsU8DdYgmMhY5wcJHgDUXKCPrri1atuaO2H8vqYrdkITUgKX7cqsTZjyic3qp2mXkFt2dCc9ip1PxrtWaTwKKmruEBcvDq0GSVquEu+horKFRo2jrVEBeIfr7UnMiugkKsEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786701483; c=relaxed/simple;
	bh=EWws4Sm9+B4D3Vwe3Lc2f+99NK9aInhso5r7IaIXQ5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/HlQQbdUO4X/nCVNYvCLROJDcWREfnk5LXVD2lHZ6PdY/VGhuJUdDKFXHYDe8MyWI8ZWVWIeJnBDOd69bKy5se0VY4D6xnGd/h5GCp/fpKfOXuD7MmjwG7lKf7xSj8tJO4OdPf2MOSIQAbjRZBzaSkFVV09U0gNemLUZkel6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft1hZyKM; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft1hZyKM"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-836c91bd782so12633017b3.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 02:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786701468; x=1787306268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EWws4Sm9+B4D3Vwe3Lc2f+99NK9aInhso5r7IaIXQ5I=;
        b=ft1hZyKMIuTW6RGhsS77S8azknsZDlXuw9ewbM8zZH285PcrXgPwCMzSQroyUECl9f
         oxaPGXpKDFt1vEvar20rNZ7chOKnXLWi3FV3QQHkwq/4T/tPAwn+icGrVINVRp6GYuVC
         o4MDamanLLKodH9PB/kdOg6fjmLat6jT0uavWd86qHfdMaKrgSxGj8LeBVUcMXLaBxTo
         N8pCAonFx+K8ux1COu3f1oE+7W93dbv13hgBofZ9UZism0EbK9xLanKzvDoXXYP+2Lvw
         PDtp4Wn8GdlLh6HGYs6zg2FLzRR5riHluU1OakR+nOiyth+5hW5WbjKsnZWhzyG9f7FI
         4mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786701468; x=1787306268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWws4Sm9+B4D3Vwe3Lc2f+99NK9aInhso5r7IaIXQ5I=;
        b=Gp8w3LkrvtJV1WCc1tFjXZBL4tx9QSkuh2jfc9BnW21GeIehvAwSFWFIT6xTrMF0Ju
         iiDOfXSiWLc3L3Q9d8xHSAxUhlNOAV91/xpqyuUDFVNOTBxn16IbtczQpY2dsSYF2Rcp
         88EsmxxckpAMpvOvDipPSYYAr1aLzjutXyd9NB0ECLPRTazumzMWJii5A5KD05ljJIFd
         ZljDxaRbLnFfJ4x1HuHpKYlVF1odi1KxBVtnU4N+tFoFGtuF7lZvO62cBgnhNSVfZMl3
         53/yQ7Lwd2dT7+sgadd3eUH7Lou+HO7kEo66AqmlBAVJk3yE/lww0ajzJGmMASIydk++
         LCoQ==
X-Forwarded-Encrypted: i=1; AHgh+RoXr4tJOpSTUUy26fNLPubnSK+qP4sKc6T/pw0Bok6vxRnCYWpgTjeMeQWQtwdKo8Xo/QmSDPpiuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMjqiZRDcOsNJ9Pm7VTfKOeb6s2FUTByjjoc/wykOnTYBTioU9
	MEAmm7ZyMogePbl+TVuQbYv31Cl7WG6yspSe0vDqbSc23QqMB1V/TfX2
X-Gm-Gg: AR+sD11ROWcEJgdVFUgVu6OrstJ/8aJh7LB67JcVcqXW2Nc4XntTUA8gavbXBauiPAr
	wPU8HWF/Fycju/3kTqWXbkCb5nJ9xq1nyB8YEh6M8UtUqDlqO+Wpx3qGFHBBbmO0Vfm09Iu8nce
	DXD2LFtsxzmv6hGaFjoVbiwV7l/s67Qz6QipuDzDjUw5ri6ol6/5+kH+r7zKniqoJz6CMXsZXUa
	XuGkfSn98T8lVF40wGLDHWM3zl2ca1G8pAmpNlCQic77vC7u0hdPu8tJyGdl2tfydTKyHbFi/FM
	vouDnJSnwm1wkSQxaCUT/VVghBHgnjD1BRi3R0nPtKBKJeGrMQdWOcAn4TayEAhDWnq/76iQbWD
	U3wp+2edZJFNtMeBU9jixVxfY1oLihLXHM3naV0vHpu1r/tSZFcNu+IKT8ALy+m/z6iyYkjbfLd
	5+C3f7s3Mul0x6FlFaMFBFrsV4QJEPtzilIm5eKNtUTib79IxTi7yYeFtnyWOFKDo3AA==
X-Received: by 2002:a05:690c:e292:b0:820:b24:27a4 with SMTP id 00721157ae682-83714dd07ffmr13828027b3.32.1786701468147;
        Fri, 14 Aug 2026 02:57:48 -0700 (PDT)
Received: from Gentoo ([191.96.150.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c1f43e82sm11099667b3.30.2026.08.14.02.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:57:46 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: ray.huang@amd.com,
	mario.limonciello@amd.com,
	perry.yuan@amd.com,
	kprateek.nayak@amd.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] Doc: admin-guide: pm: Remove unnecessary backticks and fix a spell
Date: Fri, 14 Aug 2026 15:21:37 +0530
Message-ID: <20260814095716.2905589-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One,
Removed the superfluous backticks in the sentence.

And second,

s/peferred/preferred/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 V2 changes from V1:
 Randy caught a spelling mistake in the same sentence,so fixed
 Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index c7bf7cc2db87..6fd72ba52df2 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -471,7 +471,7 @@ update the core ranking and set the cpu's priority.
 Kernel Parameters
 -----------------

-``amd-pstate`` peferred core`` has two states: enable and disable.
+``amd-pstate`` preferred core has two states: enable and disable.
 Enable/disable states can be chosen by different kernel parameters.
 Default enable ``amd-pstate`` preferred core.

--
2.54.0

