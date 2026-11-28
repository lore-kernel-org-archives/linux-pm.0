Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795828743;
	b=HaGgXAQbSquStFHuGtRGnFj+QHPcUctXauREYJ6uHpM6Vz2yCt8D8R2+BtF+5SKqd0Rv
	 sq3FsIArvDqJg07b2Xtqx+QFiQYImAcpgSsf9LyjiBrTDAbXumQbV5m1b3XlNZ4kj5W1Q
	 0dHpXOJsHffaDLBzQdI/WziYgyMZi20BSJ6ip1Dl9XxXEf8COe+XHlRqoXdJMagSvaX5o
	 cgEVq7cuKSmion7hhWtS8xqLyv3l34w0l00/+YRppS3evnZX7UyVPCpjlyGNOT9taApZH
	 9GUhJ112NW5gSC6eDa1Yu7ijeRZAhQR2zN+BbqRvm4eJkgdyfPPM9uAEOcg5/EBA1vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795828743;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RwcVg3+rV7Sl5vgXGmdhNKL0T6Nnr1F7uikU1pgMnzo=;
	b=Idt2aEvbyDdQsSoS69BfSdfpIfBknbDA0NWiZNpJ0U0ygKB9f6z/keUIIY4+kWsZE9zf
	 ytg14pdE0VOHw/azr6l3vtgYRDUvuggXEFvhkRypCGlK/qERMrk8fZ3C6+l4ALNy1/egs
	 WFlY3S04mTBYK/d286fNwwlvge5n6+Bzkr/5osjMc6HWAo1Z/24m4uEvR1WAYYxuJ49hE
	 jVQv+xlfEwHcPwp2Tf0tt5xPpOMfqM8QS59ptNx4EDCx9ascEMvj5e1BexuXAsZJUpKYH
	 06yfygeqUIuYv+xgJs/sVUEVzjVidhUr9VMPPowPnQBy0HQoK5YfQXOf0Hz6WtwxtqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=P6TosyJH;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E54606A31C;
	Sat, 28 Nov 2026 01:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E54606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=P6TosyJH
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8697640E015B;
	Sat, 28 Nov 2026 01:19:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id U279ELJDDiNH; Sat, 28 Nov 2026 01:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795828737; bh=RwcVg3+rV7Sl5vgXGmdhNKL0T6Nnr1F7uikU1pgMnzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6TosyJHo0QNL1RuhiDynv6VRUsaX4qiWq5q4ZzaALCHnELu86O0uilO/Rt1kdq62
	 UO69pXxQLj9epskIxnlYaXCbR372z3YWJqFEXBNQaCMIBJvK6DpAq5Lg3e7NKKXfUf
	 nWu3yzBJoINmpRYOL70SfFNePyqhGI8yOHZrXGIhSo/2E2T4oOkDTrtMY8wT5fO7iZ
	 QBPH3EHU3vOaMVOMjmMstP+aPRNeqSntEjfFSSndBzr25JHsQJDuOsenARGG9l9Z3w
	 KRp0PAZf9Bxegdzy8Dz+1Vb1chUsGDYUjXqk1LIBlrik/0fRr5HTTdESzAJ2+H4Gor
	 X0ts20HFCK3/qGmGerwoM13GgJ1gKOQfSyaifrjAjTU57J4u/wJnDFJ7q4Yt62fENN
	 y/99hbdN/VUn+O7biVUtAaaoU/tA8UQHd/Sj6IItMROibGQjWAoBO8bqDWFKOkn8mI
	 Toa3huhnQRi2aLAj1OHgwvPkfn1uveh85YLENMjUFZwRLm7n+sK7mfHtJ069foAHrg
	 n28/VcMv1X1WckXWXXS9jZ2eQveuvVPZcXhE9L12a9WMf7Bsjn3Rt2yX6tBRYgIwlZ
	 gqX9PPAx5/nEAL4orio+YYsgSsBD8KCsrQBWT1qA2tFyJ9H836CeTvA981qu/W96AF
	 YEGzkQzNqk9+ErAiPKSY13VM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA71C40E00C2;
	Sat, 28 Nov 2026 01:18:45 +0000 (UTC)
Date: Fri, 27 Nov 2026 17:18:42 -0800
From: Borislav Petkov <bp@alien8.de>
To: Andre Eikmeyer <dev@deq.rocks>
Cc: tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
	rafael@kernel.org, linux-pm@vger.kernel.org, lukas@wunner.de,
	yu.c.chen@intel.com
Subject: Re: [PATCH] x86/cache: Restore AP cache state while bringing CPUs
 online on resume
Message-ID: <20261128011842.GBawor8g-JODmLyVCY@fat_crate.local>
References: <20261111123747.49446-1-dev@deq.rocks>
 <20261127150014.285304-1-dev@deq.rocks>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261127150014.285304-1-dev@deq.rocks>

On Fri, Nov 27, 2026 at 04:00:14PM +0100, Andre Eikmeyer wrote:
> gentle ping on this patch. Is there anything you would like me to
> change?

Yes, why is your change correct for all x86 out there?

Yu Chen in his original patch at least tried to do some git archeology, you're
simply axing them off because works-for-me.

Sorry.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
