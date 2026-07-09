Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B53ACA7C
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624996; cv=pass; b=Vm4Uy70hepEygX+j3WHjVTlaKDA0y826eBothbQBvtPN/FTovXCVL3eXZcomXVLnzdcDWj/pWMO7xnQumnnSniJGIaMGRTgg+v0P3OtCzeZ4sZDuA0Cl8kFH4vu0fFUvIFXlP+QCRKXs/GF6M5LaZtsdEt1rybrtBNkd+KrPHLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624996; c=relaxed/simple;
	bh=P3KfzPSkqzrrDnn9/YRCi/E2VWJhiGCYGZ9lMjKrEmo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ioo7DRLaEa/bzkzh0DdBp0rEFSLIDPZuzt5sDKbT4NecyJ7sIpKMAHIvDqji0sr+NBGmnI4+Ga7QNs+BkNy4+fJq3nAGFMbhGn5m1cA1FYue+YBnz7z5dJfUFsAt3luWH/DY2dRGUJEungdL0VJMHhFMPJnE/s9QR3EUEmkvHdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=ljEtguaU; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="ljEtguaU"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664c535f1a0so274168d50.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 12:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783624993; cv=none;
        d=google.com; s=arc-20260327;
        b=WR0dtc/WS6AyC0ttoVj7/Djyzw+t9PAL/MEhklXVOkgh8YFWEtxBV0GHn5b8sUVeRU
         rP0bkY35EEwQfir0wvDYX37bT1RLpZcPvzyCcWLdLqMQfV6X67J2bsuYo+noCwWbEjFz
         T9rJ9d+vAG5PJ35kVxfky8ylxjYOGMU1FooaL+U8zBzufddK8CX6dnnNhjC4B2XZmkKC
         6h4lqa78nEjgH09CDQONljXInZt3wLowTIJLGWyv5L4wBoh/fH0kA8iQZ1FD/y1xp18K
         Y9AAlU7I+G3kZfsbGo4VDpFCwvsK0HhlfLzta8BrajZw4rW3ZfGJa1i44qCBHvNjOVWT
         +BhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rLKUCgOPdJB6WTWmQJRFGnXb1O7aYuVdA+Enw8Jcsyc=;
        fh=f+bu3qqEDhnU1FRivKm6MazcSZN3nzUker4BlKspHSk=;
        b=g+bSfamisBzGmEDSIog8ob4ogtt7qgze9foKGdtScuptwJIiJNOHzBuq+JJjyXw4Rg
         zMOeu43HzUW9D9rlGPzs3T03AsHXIAxhe12Hv3Odo1t3HeL/BhvaCiRhDYToNly+Qo8A
         hLxET4Xam+MvWPrKNfNJSkGC0vE4Od2+jhwrjToZpuwPJ43bl3w0YrKolcuXKM6++WFo
         UJKxxt9oswafbBKLTctfEFHALo4GNna2bUOKerZR5G9+EWL2RG0oQeBu6FDdP93Im2J1
         wOUSlZaxa5zn5KfCZKaNRTHgYJrtBXKdKKegZ38nG9YEypVehN6ApQRV9ADcJl2bJM9K
         /Mrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1783624993; x=1784229793; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rLKUCgOPdJB6WTWmQJRFGnXb1O7aYuVdA+Enw8Jcsyc=;
        b=ljEtguaUrlOSM4IV2SAU7NG/Xt3zC3n3DBjx0i6yZ2ajqin+G58jhYLXbAnGDIWMa8
         BZ9PpW5dKDglG6fyO8OH39Hy6bbGiA9y8i6Xs/3RveHZ58YG16waIZOMhzsBAevg1k2h
         xhCNo5pd3NKeud9FQ7AuADR/Qxt7PvlaJ3tVeBVNBNlUwYE6SPzZrlxwbAyV2BzMgoz/
         Qx9X3jP4MDHbux73mAC5KfL+R2YsT5/LqszTOsBeUemwyP2w6SFjzOa1yxYm8dsGRSoD
         fp5Knr+JURHaZ22uuuxBUC88zLk0C4G0P7TKWxr6iWD7foxqdKzwjNaPVLva1qgUqiVI
         WF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783624993; x=1784229793;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rLKUCgOPdJB6WTWmQJRFGnXb1O7aYuVdA+Enw8Jcsyc=;
        b=a5CkgBqT9sazp1DqmSXHSOpxV1U/xi2xLyJT+3qCc2uIIgOZQ4b1ZF185vujSiAUCl
         xPUIIwqhY93GWeNSElOIm2DGKAW3LjzIMalC2m8/niw8wWrlnmZn9LDkymqOFjVgG/m9
         GGqnMDs1j1Ls0M5KeHNgzQc6l+bnK3bY4PsCJ3lNDL4YqIExSm+YKnqYXld1IoZb40C1
         0+kSvCaw7zBi+97bXSCzz3e7L7yY/ZWiT9IlIz34jcH/WECyEnUtp3VqhwsTwxYwgqK7
         N/HFxl7dORdbvcE0RrLLcIAbmI0Z0A1f0OU/7QXWGuwddp/pubekVE55IIz8NH3CdrAn
         mO/A==
X-Forwarded-Encrypted: i=1; AHgh+RodKjFnSWf5Y2vAgZ/mcVmOJg2tlGtB/c++3Ng6Ib/inRbI3br+DHPHtfyVCrnQw63+hJOuJHxoLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YykZZ1sLpvrMosojLxMuKcdHTVzft1rskqA3+2ZkujgdvOmrchw
	8rAzQ2ldZS91ynrZWg75NT8Nk7vH6FPXpIMG4I3Hwdm4noe0MTzwFYzbsJfpZIdzar+DC548dfu
	rI60ZSlAVIbFD1ug0fXDiyuHel06r4gDAYpV2yIb+
X-Gm-Gg: AfdE7cmOkWOsuAnAhqFcKgocFxJj9opngDja3TCH3IVKp3dDpZlg63RLkbOXWm1h3lh
	Pmbt4jUCX5Z9dSs9cD5+yvIXJaV0lVkmJNp5oiqcHQs2mC87/7UVQ1D5FwU2lOlk4SalSBKTWo0
	17Sya09WPdqtJh2nxYaMhjHgEtJImXTH7KGhrSDGUYr4VV2XKxess60YBgFcztxDXLlt4d3eUOE
	53+RlDBoaM7dBAf8H3hPu38PBqRfFAFF4Doji0UrAl15D730Cobim6uJNQy0PLWbV+LaqPF9EZy
	v3YVWIEgVjBC7lRby56aOYfG5Eg=
X-Received: by 2002:a05:690c:6d0c:b0:81e:6f0d:8e05 with SMTP id
 00721157ae682-81e6f0d8e5bmr31386797b3.43.1783624992516; Thu, 09 Jul 2026
 12:23:12 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 9 Jul 2026 12:23:11 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 9 Jul 2026 12:23:11 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 9 Jul 2026 12:23:11 -0700
X-Gm-Features: AUfX_mzVZtqRRkl9fVhuBIBaSxwAAmVa-vH3CHlHUp7UY50ccQrXa49krBcAszw
Message-ID: <CABtds-0AUr1jD2Sri6ViiFiqyBbjc3-6xeAOr12YLJA9ux-2BA@mail.gmail.com>
Subject: [PATCH] PM: hibernate: Allow hibernation opt-in when locked down
To: rafael@kernel.org
Cc: lenb@kernel.org, pavel@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
	keescook@chromium.org, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Kernel lockdown disables hibernation because the resume image cannot be
verified before it is restored. On systems where external platform or
storage policy protects the hibernation image from offline modification,
users may still need hibernation while lockdown is active.

Add a hibernate=allow_locked_down command line option to make that opt-in
explicit. This only bypasses the LOCKDOWN_HIBERNATION gate; nohibernate,
secretmem and CXL memory restrictions still apply.

The kernel does not validate the external policy or authenticate the image
with this option.

Build-tested with Fedora config:
  make O=../linux-lockdown-hibernate-build kernel/power/hibernate.o

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 kernel/power/hibernate.c                        | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt
b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..0d20ad9c7d78 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1967,6 +1967,11 @@ Kernel parameters
 		protect_image	Turn on image protection during restoration
 				(that will set all pages holding image data
 				during restoration read-only).
+		allow_locked_down
+				Allow hibernation even when kernel lockdown would
+				otherwise disable it. The kernel does not verify
+				the hibernation image; only use this when external
+				policy protects the image from offline modification.

 	hibernate.compressor= 	[HIBERNATION] Compression algorithm to be
 				used with hibernation.
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d2479c69d71a..71232eece9a3 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -41,6 +41,7 @@
 static int nocompress;
 static int noresume;
 static int nohibernate;
+static bool allow_locked_down_hibernation;
 static int resume_wait;
 static unsigned int resume_delay;
 static char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -109,7 +110,8 @@ bool hibernation_in_progress(void)
 bool hibernation_available(void)
 {
 	return nohibernate == 0 &&
-		!security_locked_down(LOCKDOWN_HIBERNATION) &&
+		(allow_locked_down_hibernation ||
+		 !security_locked_down(LOCKDOWN_HIBERNATION)) &&
 		!secretmem_active() && !cxl_mem_active();
 }

@@ -1433,6 +1435,8 @@ static int __init hibernate_setup(char *str)
 	} else if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)
 		   && !strncmp(str, "protect_image", 13)) {
 		enable_restore_image_protection();
+	} else if (!strncmp(str, "allow_locked_down", 17)) {
+		allow_locked_down_hibernation = true;
 	}
 	return 1;
 }
-- 
2.53.0
