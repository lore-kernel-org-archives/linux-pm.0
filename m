Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197C946A
	for <linux-pm@vger.kernel.org>; Sat, 23 May 2026 04:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779509975; cv=none; b=EN2YzZV6TMS6jcS4hGYRpiUs6HsuAkLwD5zMHA7rYvO0PHL1c6eY//152i9970UJsf4oZrxFY+IlqXhsScgLsniCt7p0pHsrs++QeBhu9CZYnzZvD9/ziEZZXfoKn8BMToEuvK0Od2/qvkb6T7lbZidCv8h+uGbLrjJc8Hsyi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779509975; c=relaxed/simple;
	bh=HuJNRlohSYfFqPVbVdepSuV77IoagsyaFUsYQtoe/H0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u1pXcfKscu4B5Ap9OG+u4Kty8bV9V5jKDA7JEfzxwqVVywSciF99Zdmk7HtkM0RZJPateHCJCchiuQPcAZouSTsNaKmSBmATiL2KgEMmvYzcAfiYnVRIk8wlOSstrfJ7HtjnEUyk19FthLBCu2Oov+sfVkk9Y8I7BdHfQEZTW90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apfjjO2K; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apfjjO2K"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4160916f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 21:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779509972; x=1780114772; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHy0tmLMxIFcVodFcAwCiAkweZscezRmdA1qXKYa7dM=;
        b=apfjjO2KXOVokq2wgKQo18U5TzYRXroHYvKMV663UKMFsNttHZJiF/P5ZZfdoNEJy7
         N3JYrRWMtGyFWfeXWlbaI5WCNslQCxC0XvRtDrFrRh9V3JiUgjCqV9a0zD/8rinQcWRN
         bLO9rG/9kZGHW0uG5XIUoqchGHIgv4ck/ZnPPXcrcDEU+EsChL31TJQlKcTl9ywLfYJ/
         XDfMxekv/qsQQDQBlpCTkSvWvO0MDnusrKzWUJyAmvT5XMws0LklVvVdp4UsFWmvsaY0
         3MZVu9iElVxdIER0FxmMUt8y6M77jFzbjGtMPUOWCNTUuERjvRimji6ZY61pkefXf9ZM
         Xbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779509972; x=1780114772;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHy0tmLMxIFcVodFcAwCiAkweZscezRmdA1qXKYa7dM=;
        b=kvSIX1mZHCv2UQKvF2hhP30OicLv8gxug5xrJVUIKNX7ugvb4sOHuIT6VYBzUpwEm6
         oTlyi0Ugfa3gE7JhNy/cp/EQEEc1W25Yo4iNXVfrJCFZQHVN5wg6dC4ImKw8q5IekQEB
         eAiC4Py0R6kqiSewaMnZbbPoKQmlTRq6Y4h+MQY6jr4cAe4dPqe5yN9b0Xj6NWUVAHq+
         uxByZDxY3/vUcmHhADFykD0FNlgNWtmimtKqULFguMnp4nRDzNrcRCSSYQpzl603Bzau
         p0ZAaLVH72M49dlVNum3O/NLrT5hjEee795B4GnCf+IUaPhrFU3Lr4xnfdknzgmq77p4
         he8w==
X-Gm-Message-State: AOJu0YzhCFcOs4K3HXVkdxgvj351zZBzGzu6a4VfmthVmm8jOYV5Jb+q
	lUikLYx1igerNYrJpNtKJQZpDdrIjilodUexCN3eUXOogRAS4u3a2/SDElNaSA==
X-Gm-Gg: Acq92OECAnaolOibbQt6O50Wa8H1gZBJ0nxuatqQ7Ry4u0maodL4dugSz8PSPdFfRT2
	6ZB/IDZPMAwoWbtHdYRJE/ET5RMTurGpdWHGSCC6zM+MHJZSwHJ+gFrYWEtDUY+moB4HAI9tXrk
	1x/ZUeik+mNwg0aPFd/aWQQgY6CGXFBPPsqr6mZf1tLE1Pi/HKQBkPxRpjCabVUwNTaspqW+vS7
	ixlPNQYsCVEFeCxrkIYcUaAH+uLXsMaQyjMfVEkE52WEgSb4eIuoY0ovCh7UyqrSAfYkRQyCBsv
	mjW4AnGEe0vtXYZ/hIIvUapxmbc8HbaStwA9o7pS3sJgt5RXvzo+JI16T5U6nMvqoL27/N22+Id
	m7LRXCzHY1dcaqCGQNhLppde9CZX+rSXONnAi9bi3FYFy562YROg1VOKa3ZzcJ08Ni9HV0NzmAj
	ySmKLMCiCywUIDZ4yDFottzwM=
X-Received: by 2002:a05:6000:290b:b0:43d:7e6f:3816 with SMTP id ffacd0b85a97d-45eb38c359fmr10584714f8f.40.1779509972434;
        Fri, 22 May 2026 21:19:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6cd151asm8372838f8f.13.2026.05.22.21.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 21:19:31 -0700 (PDT)
Date: Sat, 23 May 2026 07:19:28 +0300
From: Dan Carpenter <error27@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [bug report] cpufreq/amd-pstate-ut: Drop policy reference before
 driver switch
Message-ID: <ahEq0CvdBX0T7_cO@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello K Prateek Nayak,

Commit f9f16835d4dc ("cpufreq/amd-pstate-ut: Drop policy reference
before driver switch") from May 8, 2026 (linux-next), leads to the
following Smatch static checker warning:

	drivers/cpufreq/amd-pstate-ut.c:308 amd_pstate_ut_epp()
	warn: pointer dereferenced without being set 'policy'

drivers/cpufreq/amd-pstate-ut.c
    275 static int amd_pstate_ut_epp(u32 index)
    276 {
    277         static const char * const epp_strings[] = {
    278                 "power",
    279                 "balance_power",
    280                 "balance_performance",
    281                 "performance",
    282         };
    283         char *buf __free(cleanup_page) = NULL;
    284         struct cpufreq_policy *policy = NULL;
    285         enum amd_pstate_mode orig_mode;
    286         struct amd_cpudata *cpudata;
    287         unsigned long orig_policy;
    288         bool orig_dynamic_epp;
    289         int ret, cpu = 0;
    290         u16 epp;
    291         int i;
    292 
    293         policy = cpufreq_cpu_get(cpu);
    294         if (!policy)
    295                 return -ENODEV;
    296 
    297         cpudata = policy->driver_data;
    298         orig_mode = amd_pstate_get_status();
    299         orig_dynamic_epp = cpudata->dynamic_epp;
    300 
    301         /* Drop reference before potential driver change. */
    302         cpufreq_cpu_put(policy);
    303         policy = NULL;
                ^^^^^^^^^^^^^^
policy set to NULL.

    304 
    305         /* disable dynamic EPP before running test */
    306         if (cpudata->dynamic_epp) {
    307                 pr_debug("Dynamic EPP is enabled, disabling it\n");
--> 308                 amd_pstate_clear_dynamic_epp(policy);
                                                     ^^^^^^
So this will crash.

    309         }
    310 
    311         buf = (char *)__get_free_page(GFP_KERNEL);
    312         if (!buf)
    313                 return -ENOMEM;
    314 
    315         ret = amd_pstate_set_mode(AMD_PSTATE_ACTIVE);
    316         if (ret)
    317                 goto out;
    318 

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
