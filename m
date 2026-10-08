Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88CC49E156
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466886; cv=none; b=EtDxLxIQUh9ccI/eRMiEI7QHWLFjoADT/iR6aBianGcAuzJO86UA4XEmE5G3LEDR0wm3W+v/3yrgvnTy/8/bgtm5LZZO+bPFMAzz7d9GQMNHmkb6Bo4GDrSPdRhFRM5eaatK53+plH1gH/u0YdsAs/cOpHD2e4XxxQw6gbDz6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466886; c=relaxed/simple;
	bh=XezWRLY9lxI5ComY59DgZ5KT78+aaYpBiaD6Ktv8gIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsUYvJDqDw05fbUChPAL2ePg8uNkW63GrYOyTM3NM56YjDpJpvhZ0dpijVJ3WK80fgdmdKBL0tFD1mc8Vj+mYHtCjVt+BW2/NX9IZY+M4jbIhKijxpO6ceLHSVhQqIOGDTJAtIUDXW2OZoQztTJQVxudAO8Y43ih/2ziZtd/lJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2dd9cbb661bso24084145ad.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 06:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791466884; x=1792071684;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1j9k5OlTGty7BZhrOeehSiHjb4OZRtbs/bCekRUx6wI=;
        b=b1s0BmstqZW6JTbEynAgg7vbbZ4KivrkqBdAiUsNwRXL5q88g4fKT/pXe6kEeDeIq1
         Slky2565Z80Aa/uthWeVIlINtOKG6goLZSSQhAoVEoHBYlB1TYVjRasMFJFbQYx2YNKW
         i7TVTMHf5Mvw3XvePuquXiLDpN1BI2CVYNyssOXxkbm8jomayUOa8ykDiWDfEND2UNrA
         LgpO2qvTEEU2zLWCmv2FCGCmAf9t87WdIzyLrE2sZhifWxAsPJgg7TWM/srs/1OIz6Ss
         qeMtWmqTreL2MJPIqkPTVRBDpCZLbD3sI/QJOKF8UtA+Q01mR3hmNnSptgWSV6BckXvY
         ncQA==
X-Forwarded-Encrypted: i=1; AKwUvBzv84bzSCtkV7ihvc3816bXXhf99iuIiY72Dl6jELmzIkKSSecOIjyHuEmkKN71dxBDcLxLnYuBnw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIf4t/ITslLUNuWRcwHNEG5hxIxMIjm8rOM5PXAPZbTLLMXZYbX
	8DjNuW6M3wSR0GTlNHiIdqxeJ0O6QeS9xpf5+gjXIuwKy0kcP7u252DMEhMbXUeLwFdc8PgiF+1
	Twv+8rrrYNCUWCpKz8XPJPcPw3zASAnhu0B5SSYUMN2H0yeTfpELq
X-Gm-Gg: AYBFou23nQZQtgdjtgz74Dk6Aq7IBCUSHaa6qJFHpJLo8wI7H/rO8pCfqfrmwKhHe7x
	RQP23cxyK6NT2DYLDSaN6B2jg7AhXFkKBFQeZRGEmcW//CSQNFwD7JHs9QJMKu1UKtdvxvstSJc
	JvjDQnWTkGFGMyGs6dXC0fB7M6qM5rpgDAZAcqhTAnkq0zI0jW40KQvw9Z7QOGmj4fN9lHZIEJD
	pFUL6oxBfjaF2VkS5DBuQUZ6CXv/ejY7Z91JSsQan0GCEDUPCIWPvBt8BciKouBkREJlgjji4qW
	p4zG5duzxgCMcT4FGnUUwismiuZugtb4sfXtqwBWmVi3oRe2Z0jboEfZZk7SOR2jjznOnkbEcRx
	ALrQ=
X-Received: by 2002:a17:902:ce07:b0:2df:7fe1:72b8 with SMTP id d9443c01a7336-2e60038d0e2mr50963895ad.16.1791466884035;
        Thu, 08 Oct 2026 06:41:24 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e6048443f6sm2131865ad.51.2026.10.08.06.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:41:24 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 37B8D1285603; Thu, 08 Oct 2026 06:41:23 -0700 (PDT)
Date: Thu, 8 Oct 2026 06:41:23 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Matthew Garrett <matthewg@nvidia.com>
Cc: keyrings@vger.kernel.org, James.Bottomley@hansenpartnership.com,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <asedg6XdGkOaQJ_E@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008132532.1155166-2-matthewg@nvidia.com>

On Thu, Oct 08, 2026 at 06:20:17AM -0700, Matthew Garrett wrote:

> Reserve NV index 0x014c4853 for use by the kernel, and filter commands

I should emphasise that this value is very much a placeholder - please 
don't deploy this patchset anywhere until we've decided whether this is 
something that should live inside the Linux UAPI group range or whether 
the kernel should own an independent range.
