Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE731F9B9
	for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851215; cv=pass; b=EkP5VpG6XtXVj9Pf4p0CP5tBbJxXtW0Thb+bSRlOFURrveOc2C3saT0WhoNhFjgX1x29JDrTFgeroBIgnojE9APVuqenlLytKWha6QJlUEhaDL0PuDEPIDj2iD4rwBTKthj92lJOpczkDDkXqq2COscdUCXaXk/RhgCf+Sid6Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851215; c=relaxed/simple;
	bh=1yDDpGk7UlB1XRm2igJPt/Nd5az01ELMWZVQ62sfJZk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=noDlHb04GQmKbXAmYsZqlLHzzHCTmrHo90YwzkGXO6afvTrfd/G+wyfHRy8JnfyvvQtzYJ3mNIVvr07OYFiQaADUqqUpSadBog95Q7wD2Lbe3/eki1qkFgHno8nO+9geA2mIay+e6Rx64Ak9NCj6PRUVk7lWSURr2s4Ovz+fWcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCYdMdaE; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCYdMdaE"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8692a8568e9so1554301b3a.3
        for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 13:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789851214; cv=none;
        d=google.com; s=arc-20260327;
        b=M2vwSDJAD4dPp4K3lv2BEJEAetGhcnPdYxojUrLFwZAP0NSxSB2D4JqRK7mdDe9rqg
         4GFMP/9VECxbHrP/bRMZE0zRrMh+S0eUpsQPssRQAzmfs/yaKEjIr+BZ7RBO/3dClmi8
         ccDn5cNFfJt+z499L8lDQ0eR7NpFEeAnpOi35L+YgPnTDcP3TNB6rxNHPQtE/cxlzhuX
         1fUYA3GIkqTx/EcyEZyX1EAUmrQww/SguaapBNhe+NvhrG9wViM50DpcwojZ9fmSmmFn
         GB9EUAF6InFa3G05XAhwLWZlD5oaPVxOSNJtW5G5b5Wag9p6VO+twzCrvt+jQF2vU5RV
         oLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1yDDpGk7UlB1XRm2igJPt/Nd5az01ELMWZVQ62sfJZk=;
        fh=SvysSHKCtIzGvNEmWInZFFj4+5spoWhVsg+Z35xqQLk=;
        b=pCTLuFdbTiRp5UhRmYDO0izEwIWsmyOzhyVPlu9gR9CT2Pqnetsuk/l2DrwZnK6zs+
         Gjx9/3BFIdruneqiLnjPAjT+0tNteJ9Yw63X4GA1fEMjw/LVTtPRqlu3TzdISjX+Ca0d
         2RtkijfpTfy2AOFzjreuhsuhzP+rvXAmpHj7rwKcdBPvZLLQwg+SVZAeGZMVaG4S/erL
         fi8Y5mPr7qPXcYZUylOtnu+D8WQyU1CnZBHSLmQG/nZVIZhp0ZdCRFeWIEuSPLjOgCOO
         V1ydbrZGy6Y9b3BZiSDxqTeL2G9EcyCHMZAM4RvGOeMkUuxiqPVGjdWldt75Yz6l9OeM
         eYWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851214; x=1790456014; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yDDpGk7UlB1XRm2igJPt/Nd5az01ELMWZVQ62sfJZk=;
        b=GCYdMdaElAFUrge1m5HEc8Lsu8lsI7i/hXDOVxq0k79HW/RA1H1dCkUTqX/7LSZ6qg
         bC965UsWeFUaAlFRZoe7MhFiNEykjJsrFzhnceCz5bN5tDCiye4IrA1cw0/A+FWRBdgA
         +zOx6CfPhnXATZq/EyxutbO+gt2q7RA6rNBifo+LlCYnyMvDKLiSTGMXud9DfNSDxuKN
         S32uRQ+HtMUQgclb3FPmJsc7L2J83JRX6KU4qJaJLbMreU/A4koMYHIZ/oy0EN6tQum4
         Vf1IHvkOqFQyDRKoAXk8kXd5tD49zouDa+yfUmtNhscW4Wa1sC/goQJjLasKiLgOu3Cv
         xsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851214; x=1790456014;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1yDDpGk7UlB1XRm2igJPt/Nd5az01ELMWZVQ62sfJZk=;
        b=fHd2e1hxB4lzh4/HtxoC1fUaWMcmckRu1IP2osI91dY2Zf04HdM6ThZ09Sadqyua8c
         LPQUaDoVkfjK0qNVbK3KlU3FKNj3ZwCfAuDTsYt8mB/K+nN4pXFVSGmM9FS1Jz7PYwmQ
         UqAuiD0/alGMDff2djyt4zQkAYJKLlbb9JnVyl+6q6hKI0KTjPi79KPY40R1fTuZBqBw
         ka4bWqlBnOhyI1oZd3WVs7YzaGcbn9NYOngQbpYroeCt/eDJEcszcktTJ9RNUdo43599
         fDzi53mv9OQwFb7jBNvRwfhZEkHDr6ZiLzq/EqQUxbCXvq/PYp6qA+k8SfATtdkRR2Dy
         kYFg==
X-Gm-Message-State: AFuF++nEQvpfnwDr9ZMudoOl+4PAzMd6/cefXkcnPPILTIJCBYOyeOdB
	lMG4DCoirHNWt7AZtxNjxgpI2Pi7t2KKSHcovJI7w49QTnm5jomXq4I8HF4FQRCMrHnOW2nV5DR
	+XwmnJklafBC04qQp+eN9KaWocPfLImM=
X-Gm-Gg: AYBFou0nL+Wm8DmHPfV9vY/5WbGe1mHaAzJ8PBi1N2Jry//tHCr7YYxGcfYfrkouIrt
	kKajaxubPJfnftkCRVAWEopxDIJwqpZ/ahSyBK/uI3LCwPMZPMJHbMQFvF2pQhQngxlStGcMbKR
	ALR9OQVRVS0lJTCMCkZUHnthSZFCWEBExvCQUQTquc+JXoH8i/1QYrgrC5YIVV/Z1x7NCFjUrZJ
	HvoIwK5ppjtaRXjWg5KbvDD8D0m+R2EYmQDd9PQ8+VHG1YIwLnAJh87AlzObSOJ9nyxXhIWDpUG
	eGAC+A7A+wteesaRdNHN4Nv7UJDTK1McRgfvXLsy3qdxSIRrdvs4yaV/GNf41eGEGdMMP0OQaQe
	aCPPxKN+uNui8UJkI699wYgEZPmI9SV2sJb3QlBiA7cy1z4IH37quy7UNDgnQF1U1XxtAQ0c8
X-Received: by 2002:a05:6a21:6b01:b0:3da:b089:dba4 with SMTP id
 adf61e73a8af0-3dd8c3fc826mr11732141637.2.1789851214024; Sat, 19 Sep 2026
 13:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Lomas <david.s.lomas@gmail.com>
Date: Sat, 19 Sep 2026 21:52:57 +0100
X-Gm-Features: AcwNN1VByzJrKqU7LMzWxWek7XyZ9CB60Q9hWtTQdOYL4Vi6JhYXo8yhZonG_r8
Message-ID: <CALjEBWT9wyBYtWPgtg8Xd_FxRU_XnatzQMcwMB9_P2Fdj83+cQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 0167/1250] PM: hibernate: call preallocate_image()
 after freeze prepare
To: h.haechoc+kernel@gmail.com
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, 
	matthew.leach@collabora.com, gregkh@linuxfoundation.org, 
	stable@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Same commit, same symptom: my report with the blocked-task backtrace
is at https://lore.kernel.org/all/CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com/
(XPS 13 9360, 8 GB, zswap). The hibernating task sits in
throttle_direct_reclaim() waiting for kswapd, which
freeze_kernel_threads() froze just before
hibernate_preallocate_memory() ran.

#regzbot introduced: 783c8109844503bd1c35dab41b6d5fd074a9f131

David
