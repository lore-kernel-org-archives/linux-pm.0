Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F53B443F
	for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791718116; cv=none; b=NSTYXa2le98E58d4VFTLFqkDqV7Q/H6qBYdQ4pUAlaeuliYW5zWhml8lffjoUfAXQdv15w/BqQscyMmfM0YRoQDOqYfLmsnyWxZD+q5xLAOG+YdQaZg2xkMN7cjNrBwif9ywuJXnNs12qMB8MJuZq2tufyogY6yIRvfLtFBMC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791718116; c=relaxed/simple;
	bh=9FzCwcYPrekTsa0r1L9b19cAAS0RIbiRexDegUF0QXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdQ5wbqTtofBMDd8ozc/GDGM7KHlAAYVGRD9GLfxvFRRGz4PXdvBzFixDtywG4bSYNgTrSn9zipB+eFZmq9bk7vJ1mNdcgbp72jR/2uzztoUlbSDSMcTBhcEMkkuLneO6NE3LoLeweejCXLkHcIASDmMVnjlzUpIeLTdBAnE5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-881269371acso1591174b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 04:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791718114; x=1792322914;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I+CJmtB1KpJvhzp1M+nBD7BDZNjs1heGmH4XU3JRK2Q=;
        b=IGYD2psGo2+HeRAS+DhsSlQydm5boWkR/pCcyORxkBkW7NnYkWJiC67Fa+4IT63sOL
         aSiXN4wTQnTA7yZHoRcK7GRnJoWFdptib8Sc/Yi84OnyKNAUhufj6D9Q7AIsHskjS4pL
         keyoSmGSBtJRQPVdiMU9m5C2zG4DcDXraPkl5D6Izoahllys27RpoishOsgCqHGLpRu6
         tw+391qs+heW5cNdEvABzsNvTLVkwE6FlOYI/hILzYPAAk82qcKl98eJOGoiUwInkH5L
         hIgQS+xu0elIg9d+h8dwInEw6kAWpNu0o0yDTiySA3gXh/8q46/vySsrtwtHbW4GhgHp
         83lQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5XPQvVUBzsdnjjQ541Sz+QKfL34JAB0ei9xXW3CKdXB+6pfBaXeODq4K/Hqy8p5OGfVL7KHA4OQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJzWzpMuvfU5VB+JWxjlqwTRNh+H5Kv371d9pEMAo5GWscI/JMO
	Bmhs9zQNeLT+129VhZHVk9JtQvKwhKuFYlUtMprvIxi6TNAC1/dpGknYulIbACsN0uWoQ2r2lCH
	aTIOf9S1R7JHMe+G1cbOcvcRBhhm6yhQWyI0IvYl0jOKEjmhnMMLB
X-Gm-Gg: AYBFou2ul9o2XYOSQ2Ta/dYGsm3BmdcAjOoUi7qU+4/978Z1APu19zm7eb8REtNMewx
	+Ahs/D/AScIweF1xVz+yP4LehZHs6gkkO6RWF7/ui7QGpN+oCzsBBluU0+iWOYXGqlMDKNickbf
	n7wRuthwHvWuX4AovSic2YUwFDOF4aBGccto7lcaNZPjG4A5LM2vWpaUl/ZFc9tHNxTst6nHNHX
	B8gO1XpVHXoPgWNMFYnHYWY1xSVZ/uba5By0o5EnPpwXY+TRFIEofJb5oIOiue2OOVECpDxWEFp
	7NmCKj24ohDIXcCQ+VL8FnKiRXdQ32DPqr60Y8lWWRAMibxpFLD7P0jX5yyqqltw+nGl7MN60hw
	Ccdc=
X-Received: by 2002:a05:6a21:e355:b0:3de:a136:6850 with SMTP id adf61e73a8af0-3e164eb339emr4709275637.17.1791718114268;
        Sun, 11 Oct 2026 04:28:34 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cd3d9e37988sm284927a12.8.2026.10.11.04.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 04:28:34 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 7CB4118A512C; Sun, 11 Oct 2026 04:28:33 -0700 (PDT)
Date: Sun, 11 Oct 2026 04:28:33 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <asty4acE2B94t5q6@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
 <435907614242e82ecde1767a967a3110fca6fb37.camel@HansenPartnership.com>
 <asqthz69ohnMVCye@srcf.ucam.org>
 <059384e86fd256618498b9a7214b6421d38fdf1f.camel@HansenPartnership.com>
 <astjpI65VOyU8xvI@srcf.ucam.org>
 <f002fc613bf0bdcf895e5be02dfd2524b7608787.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f002fc613bf0bdcf895e5be02dfd2524b7608787.camel@HansenPartnership.com>

On Sun, Oct 11, 2026 at 12:27:58PM +0200, James Bottomley wrote:
> On Sun, 2026-10-11 at 03:23 -0700, Matthew Garrett wrote:
> > Hmm. Well, that's irritating. Which year's XPS is this?
> 
> It's an XPS-13 9380 Core i7 ... circa 2019 I think.

Yes, that's definitely later than I hoped. Bother. I think this patchset 
is probably still worthwhile because it does unblock us on at least some 
machines, and the implementation is intended to be opaque (other than 
the change in PCR 5 measurements, but we should still get log replay) 
and can be replaced with something else if we want. The other approach 
that springs to mind is tying this to having distros switch to a new 
kernel signing key before enabling this and so having PCR 7 be 
associated with the feature, but that sounds like an incredibly tedious 
thing to get right in a reliable way.
