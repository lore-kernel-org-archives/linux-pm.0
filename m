Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026818;
	b=3N4huFue3Lz6nUwn57pRwYydTJnLQ5i/Bfl5xl90DVgb6vht0urIiQlLpvT7weILsBEL
	 djAAYUk3/R/ToTgdnjGDvuu3L7ycT4i7k4zDXLVVCA3j70qGbFRfErIxhdmy3Bj1XqbLD
	 Bj1aAyvjhJbocQUibHIzxZvgdnJxop38XOFqM/z4bGd2EmI5B9i0aw3tZkjYlrUqC2p16
	 HHxqIVDJKhR32yvHkdjkEtsW4Kga2svZNLga+Eb/1HAN/ZucHMYdoqtRderPHKzF+YyLm
	 cK+2BDipDHDAnixm6kqoAcvHSeHreOnng2/cr1z6Y9HvIHM+uKc7V1Wv6c6wyAZJgNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026818;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QXGQAan1vXB8Fh8B+GZljg8cnXQfywe3VvHaZl4o6AU=;
	b=149qtZaJziVAJ3TthMDL53mBSdC5ZpSHc/eJCd6TDWP+98ZajIHKFbkVxDG0ebW0MTzc
	 g+ewC26Dr9QdVLWvvbGz6UiQ6/XDOCVzlQeBI7eQDR9SG+L6wVdIpFke6fBWr44+Q96Jt
	 cK2E9KxQAN9lxS/tuVfE1AbssC1DY6vEQfpTbEaoePKnI3QncW8kDFSWAVB9YD68XMyYZ
	 wAGJccu9p/mXXUu6gmJwlD1Y5AFlrKiT9w0/RXVVPPcEU07qekxHGV5NAPF+WVkcTqMIk
	 nm1i1dxwcErOaz+DI2S37EjxvFfUvjHXFeum3aABsHn4BFVanORyin7IOegsB3uOgcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MKJv5w91;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF8A606A339;
	Wed, 18 Nov 2026 18:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF8A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MKJv5w91
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 171181477;
	Wed, 18 Nov 2026 10:33:34 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 194873F673;
	Wed, 18 Nov 2026 10:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795026817; bh=WR2rfmU+q6aN9Sc0uR33u2REPze10bCVVyPGykSpRuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKJv5w91roEUBwvnm+nqtg4/Uu1cpaWyicW1JKpCPkMIIsqtBXgzcMGlaE/rYz5im
	 7tzt0239acWp0fzK/LkAFOX/K4cY+ognAqh4dUGLPi5T9qPfmpPOd0xzDeJoqoCjm+
	 g5JC9RJghc9HtSlxkncDtm/e1/luGkQNRiO5mx5c=
Date: Wed, 18 Nov 2026 18:33:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ben Cressey <ben@cressey.dev>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>, kexec@lists.infradead.org,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Jeson Gao <jeson.gao@unisoc.com>
Subject: Re: [PATCH v2 2/2] arm64: hibernate: use a typed entry to drop
 __nocfi
Message-ID: <av3vfAK-XHNzRnFI@arm.com>
References: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>
 <20261111-arm64-kexec-nocfi-v2-2-ddf0c4aa326f@cressey.dev>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-arm64-kexec-nocfi-v2-2-ddf0c4aa326f@cressey.dev>

On Wed, Nov 11, 2026 at 03:26:05PM -0800, Ben Cressey wrote:
> swsusp_arch_resume() calls the safe page's copy of
> swsusp_arch_suspend_exit() indirectly, without a kCFI check. The MMU is
> on at the call and TTBR0 maps only that page. The copy starts at the
> page's first byte, so the check's load of the type hash in front of it
> would fault. SYM_CODE_START() also gives the routine no hash.
> Commit e2f8216ca2d8 ("arm64: Set __nocfi on swsusp_arch_resume()")
> disabled the check "for now", since the entry had to be first
> in .hibernate_exit.text.
> 
> SYM_TYPED_FUNC_START() emits the hash inside that section, and
> create_safe_exec_page() already copies the whole section, at most 4 KiB,
> to the page's start, so the page holds both hash and entry. Relax the
> linker script's ASSERT, so the entry need only be in the section.
> 
> Fix by typing the routine, with a C prototype, entering the copy at the
> symbol's offset in the section, and dropping __nocfi.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Link: https://lore.kernel.org/linux-arm-kernel/arZSe8hNnRPM5FqY@J2N7QTR9R3.cambridge.arm.com/
> Signed-off-by: Ben Cressey <ben@cressey.dev>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
