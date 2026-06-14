Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C92F12C5
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424474; cv=none; b=SfwhLTjBcLhYfwPsBi/dk5LE5XUu6rT/WYvQ31PO8nqixmXFwQquvGoD/M+xch1p3MaCGdKaCnltNEvIE4kW2TCHuBaUXhCkgpXq1WLCFdaj5kgCSavzXLO807urv9LOy9NDFgFEFcOwFxeMRgoC2AuiaOxGiI5uedl7RTazc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424474; c=relaxed/simple;
	bh=ZIwfbuN/aakw7XAOet5JzTo3BYyb7KCvw0pGU30XBrI=;
	h=Content-Type:MIME-Version:Subject:From:To:Date:Message-ID:
	 In-Reply-To:References; b=fNDcHAkjOBLgjH8t2vQIObHyJOkUebdGti5QbvFt8yXPV0770aHrwLeCAdmAPrFtwuqNt2UGpbv5T5Yg2FCDXy7I7EaVrji0L+qbfVfrQhB7poB6+fH86KyigH8Z0cxDmZWyKuhFWNu162EhgGn5RBDkfpPaU5+Xr5cgKbJaifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ph2VfNXP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ph2VfNXP"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf125989f2so17213525ad.3
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 01:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781424473; x=1782029273; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBlR1Hi3/PZGqm51Bgf8sjl36GMGb6oFaJ9EFXjhcdg=;
        b=ph2VfNXPxm9mFBnSEhN9NYnwVYfR+2dd7eumJPQF3EEYSZgsrlj2fcNUSeG0yNGZMK
         xLlCeb7EEGrmhkAl0deMaN2SUcPgmwKbe3XQ/sCTk+z+laodUdfTZzAnF9/RjsPZwydV
         Ibf2RMAR1fbMhYXTgRB87gbkttNu3b5ZC7fSEvJsLpG5Pu4RpZvfyKsUZdCgb0CCOPOv
         bZqJnQkOzvw/GH9GGM9mg1nVsSaMonZ7W+m2InjFw6Hrr+q/FRINW1AGlxht5tqAKmUM
         aC1HTrPWTybknGd6XrxSM8H+AZqIY2CA+BG7PMx7gYUt9J31OBXePMmtg9nHp2Xgq30h
         0Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781424473; x=1782029273;
        h=references:in-reply-to:message-id:date:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBlR1Hi3/PZGqm51Bgf8sjl36GMGb6oFaJ9EFXjhcdg=;
        b=nVHErmSF3obYd9DhKMpnlLDRzYIg3FnoHzp1e9mHntnJaJzMRyPfmcAkI773frpLJZ
         PefT8THWSPFydejrTvgYuQFD88wu8LlGT/3PkVAOsTyuCaxKmgeHnGVQl5y/2l5JEwbv
         rNlX9CYHp7I7yerGxiKfmZ0Tasb7GWpkj1MAoSvWcD1zw6TRwV7CmHX2jcUwJWMMnZm8
         05OyGTg/bH8xB7+2GtM5sDGNFaGE40zM21FmX952FBwmS3gKKKjN8PE+l6c1PKPwFujs
         kcv3VEOvZTxn13E0DAOd4IDkpxKARPkcNM8+ZltnF8Q55p3twrMkTq+GGBgZEMJ4XdwT
         HZWw==
X-Gm-Message-State: AOJu0Yw5saab4SOq8BNs3/IWPDk1IvpvUbuef4ycBFEW31PLkl8CjGmX
	J6JGRSwh7C/ylAYuqyzQWu7MIZZV/Qd8Oir15HjCL/iDtKy0AatIgBri/hl+uJOMJoo=
X-Gm-Gg: Acq92OHHv8A5vEnttwxJAcWcb+hUgicqMvqRAS4SsXhkCLMJaQchVxpflF84ixRqNt6
	Dq4NbW1A3F1E+CUvrPvchMmKdwRDmj8mot4W9jYycds6Yy0Xxgfbhm6J7v/knig59rizFhOfio4
	gKmfWvpExwNPXcWLHYke+kPF4ryGoEnZecrYl6UG//HBb6FPN+TooqXGWl4WkVnjLA2Au7o6isV
	TDXzIXGmWUFJv/CxCaLUOpLGpvgQgnG8zARd9dCMNpY+VAcLHhaF20hCtPMcFpSwH1xq8p7DhbL
	+BvzwiauHWZS32xPdsCvfchMPZwVAeylE8fDiRGv108g9CRQX51JMEormirILh19hK9QHhcFZq2
	Fi5LhNd4FgVwO+BoniGe6i3Pj2OAoaSC7tMY7cInXEiVcrQQDH1smm68QlnxfS/CixDndxOUicQ
	vsWMvstDvwJEskw9Rq4blmei7+Dhs=
X-Received: by 2002:a17:902:c404:b0:2c1:566b:f907 with SMTP id d9443c01a7336-2c4134ec360mr109239245ad.20.1781424473284;
        Sun, 14 Jun 2026 01:07:53 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c75c3sm65137235ad.27.2026.06.14.01.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:07:52 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v5,1/7] thermal/drivers: airoha: fix copy paste error on clamp_t low temp
From: win847@gmail.com
To: linux-pm@vger.kernel.org, ansuelsmth@gmail.com
Date: Sun, 14 Jun 2026 16:07:49 +0800
Message-ID: <178142446919.1922841.1587467455095684359@gmail.com>
In-Reply-To: <20260612000000.1@example.com>
References: <20260612000000.1@example.com>

On [v5,1/7] thermal/drivers: airoha: fix copy paste error on clamp_t low temp, Christian Marangi wrote:
> fix copy paste error on clamp_t low temp
> 
> [patch content]

Reviewed-by: Wayen Yan <win847@gmail.com>

The fix is correct and matches the expected behavior. The clamp_t should
use 'low' not 'high' for the low trip temperature validation.

This is the same bug I independently identified and submitted as a
separate patch. Happy to review and support this series to get the
fix merged upstream.
