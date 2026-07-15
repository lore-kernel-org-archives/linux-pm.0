Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F43C5550;
	Wed, 15 Jul 2026 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784156352; cv=none; b=VIW0xow/Gsjlx6F/FMrFHiW9hRkAQv3mP4TThyCsiSJYXH3KZLQ+2dxVEBH9HUUdTqCKmOMfCA7R0ISCSox+58Oc6+CH0frYhGV4UrAgD6ef4l1pQY6m1kk75u8yePD6zjeIlkxlK76GK/J2lz5HWZDVoKuNmlvS0b2llkjANt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784156352; c=relaxed/simple;
	bh=/lzFJhABRUy+KiQy0qiOYHx3t8OFYNnY7gqj2PnHe/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrRHYv0ZPBKU/PeT+pLnRzyIrMnJWY0Hf8675I1bI53/P2pzRBrR7MRCzPtpN/jGiJJny8BiUDSkDfwN3+1ZdmM1oY7uUsl7xjxRCJ2+qGd48Wa0YwdnDz8jBu+6jSm63YRfrqzJr6yR1yADHOAuSNC4jT2U949B0Kh3f3hYdhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Zd/LlOSh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zd/LlOSh"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 74B6B40E019E;
	Wed, 15 Jul 2026 22:59:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XclVYafuI90z; Wed, 15 Jul 2026 22:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784156337; bh=N7AjLxWBxSGpWfLKscRnhuR4xi9Boc26YLbIPUVpTHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zd/LlOSh9PkXIxBc+HKXIIAc7MlFvjreZMhVBJCPM5gRy6sty7F47teWoATdoMbIp
	 2iuHi6xOIUzQ07RyNY+pVaSivy5hT5QnS9iuN497vSR0oXRzt+kHFKTBdQYvBWGunK
	 fGbfEnQemHRtcZ8WPMNqQz81yUDCeTk1i5BYSEXvIXO8PXLFmPzJ++THIxQzZP+chK
	 VjWNGGXtf+evW8XvMfIXiJwq/Swo9+8kR074zjCuhVULlA1OXXKAxV5TyoQKX5HnAM
	 oXMIL8oHEb4qcKXoFg0omkNHFi9C7EW207zxahg+UKLHuYkr7O90oURB3GBhT/i1Bs
	 cy3VGADrVwpYOhoe5sCVdl5KYGwVbJ8I/dNG95AyXn3Yo2VBLI9cmR+1SAmSuq99Jo
	 Ypmh5vLq6JhPwYn92I3q5VM6rbStfMr8qcitmKJspM3EakJ+k47pyeAHLSTWtLwgPy
	 hRHGOOOj20mQrYB3Ucs62dLOtc+m4/mmYPeC8XJH5m/kyEyhfJAQEIfx9D61Wr2Vdg
	 +mUNtVrJd7TnuaMd5/Q0enEqqHlISKHGd/lTWZ1Txdg3fsBhld725qHeHJWMy7LHGQ
	 rODWQW98VQNJl8fysSSlM6ddUR28hP7ykS8hyoUZQ27RIbb8W5/oghcw7N2l/cZUot
	 r+B3iF4UMPXz6mXBoC0lzXxc=
Received: from stx.tnic (unknown [12.110.208.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2C7F40E00E6;
	Wed, 15 Jul 2026 22:58:46 +0000 (UTC)
Date: Wed, 15 Jul 2026 15:58:34 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Rong Zhang <i@rong.moe>, Mario Limonciello <mario.limonciello@amd.com>,
	Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines
 and don't warn
Message-ID: <20260715225834.GAalgQmpfnioYepdbz@fat_crate.local>
References: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
 <0c55d331-bf98-4e6e-9de5-35803ead3c0a@amd.com>
 <20260715180454.GAalfLxn3Wyu-fRjoT@fat_crate.local>
 <ecc292377a145741f47ff2422b72fa95e57a725b.camel@rong.moe>
 <61a141cd-c72a-4ee5-8273-ee721aa13f68@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61a141cd-c72a-4ee5-8273-ee721aa13f68@amd.com>

On Wed, Jul 15, 2026 at 04:32:53PM -0400, Jason Andryuk wrote:
> I think changing amd_cppc_supported() to return false for
> X86_FEATURE_HYPERVISOR makes sense and can remove the message.  The
> heuristic there doesn't seem relevant when virtualized.

I don't maintain that code but if I were, I won't sprinkle if
X86_FEATURE_HYPERVISOR for no good reason. And the guest warning is not good
enough a reason.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
