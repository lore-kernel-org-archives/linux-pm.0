Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D163CC323;
	Thu,  2 Jul 2026 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983832; cv=none; b=s7ziHAS/bFzbsibO8DoT9/mveHoYBNdY067bTt/UNISjMd2bfvCOVXgicmU9div+tdhjBye+4Z3TEP7Uj00+ZzjANVMs6j8Zn8U1IcFVeQL5rOgLxVMcSAdM2R7gVAMwEO9MLC5oRqvC5GOOeohSxdeU5UPgCxaw/mDFUifDjRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983832; c=relaxed/simple;
	bh=ZELQq4Ew5zUkysZbdMMAI0aZmr+u0qTWsEDCMajsglM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3T3TRBicwuhIC7SxDQzZPs5ZSGP1EXyDU/MfYfDxWw308irDWxgZeKyBBfsF57djmIy8JHeyQBPsPAftkekqaKMr9sdqycnlH39lzcSmHs76jE6uKQ8WRtnyxQ4pPU9InfNX/NwgqVt7W2dqg6rh7e4B8jHdraVTXTX77gPap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpXhRbwV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpXhRbwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6681F000E9;
	Thu,  2 Jul 2026 09:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782983829;
	bh=Z2FZVglLJ/kT9Hsn+vNEqj9oU4+pKVESNFEBfGAH4qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DpXhRbwVe+Q7bjr62Bes2dr9AV1tduypHHzRlIvm3uminq9RwkwWUE0P3SaFcYihp
	 GLQqdaQik8W5dK2X7LGd5jAyNPu/zhC8asnod4KFl4fd4qk+rFhnxoJc1gdRX/J6Yy
	 G2hqjTu/M/XnE03D5bU6uMDovYOu6yUhPNZ9KZP0GdBeyWCDne2kxfQcjSlWYI6anr
	 +Z17tfhMiBHezfMKMyWZ4OS32Ve88/6YI2d89GT9GR9bITrJShtncsn9sGcdO/OxxI
	 Sax4ISUPmr/8DHoehTLIVyommwiNQO9wiq9jJv7zABWjr5HbCW6bgYgGleS4RMDvgG
	 MHM1LW6wTrJQw==
Date: Thu, 2 Jul 2026 11:17:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 04/32] acpi: Stop using 32-bit MSR interfaces
Message-ID: <akYskLix-iNOAbCM@gmail.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-5-jgross@suse.com>
 <CAJZ5v0itUVZ6=GCbRomkMiesy5uhZVWWjsUbqFqsZTyNeCBAbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0itUVZ6=GCbRomkMiesy5uhZVWWjsUbqFqsZTyNeCBAbQ@mail.gmail.com>


* Rafael J. Wysocki (Intel) <rafael@kernel.org> wrote:

> On Mon, Jun 29, 2026 at 8:05 AM Juergen Gross <jgross@suse.com> wrote:
> >
> > The 32-bit MSR interfaces rdmsr(), wrmsr(), rdmsr_safe() and
> > wrmsr_safe() are planned to be removed. Use the related 64-bit variants
> > instead.
> >
> > In processor_throttling.c drop needless initializers.
> >
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> LGTM overall.
> 
> Do you want me to pick it up or do you prefer to route it along with
> the rest of the series?

I'd like to keep this series together if you don't mind, so that
followup changes can be done more easily.

Thanks,

	Ingo
