Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C374A2E2A;
	Fri,  5 Jun 2026 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649495; cv=none; b=bjGA06lMEM4hRxD0Sq/H4nxYPSB97XVAnsvSXktMOPzZD8xG8r1ZcedbzkwIHNIA7gp3DGc0w9n9wDhSv5qLb/gN0a+2cWookd3DLUjctRYa9LU59JY76mE0TbrGVb8NRICKms3Gf8OwaUh0ecx79nA0HGlsOMnEOpcLLW+/MhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649495; c=relaxed/simple;
	bh=CjmjJ3FqfPMaCf9NjEWXWFUKJnBCFzrkQtKV41GU7vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzBS4kN5F63l8743PHFjCHSvDGYq15es0ZLIXm/TrTGYqe6i+EZqDIWNf8qCFQIc80fsyl/puvFWeA+YlEB3gocFMj0puKwMlqU4i2kh4oeTBcj4gKM4prv1W10wtagAPppNB3vd3dko8W4SRBPR7zy21xuwWEXECuctWNI1Nss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuPY4R2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuPY4R2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34801F00893;
	Fri,  5 Jun 2026 08:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780649494;
	bh=PoLYMeKru7/QcgZB6I78dgnMNXR0n4Pp9fLqbueGZOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IuPY4R2koWqMYmXBlmZW1cbN4wFbHQPFk9jICO3rkwwQZDoD+iDjSjWGtz73NVCQV
	 /MOj/sqJnakhfcWs5un55unuk0nunAoVp8R44G5ia+51L7YDlVZcKsDEY9psoJY1UN
	 kH3QXxt8rNoz9zuzyor7EuaQae0uj8fWX2PnRUP2uIto8mebX/zntRMWMBqEouJ6DB
	 RGEPR+7j0yhNykspShqIFYz0rbq5Pu5I1jpFSal2LEaI8Wy3q7By2S+3sUrmKHTkXl
	 vtrpQZuDgQ8D38SgINhss608hIt2fHpP0Wf4snC1kHTYDaLmpbeFfoh1rtYnO/DwS8
	 7b2079bctKFPw==
Date: Fri, 5 Jun 2026 10:51:28 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 5/8] x86/msr: Switch rdmsr_safe_on_cpu() to return a
 64-bit quantity
Message-ID: <aiKOEDblINFcKZzu@gmail.com>
References: <20260605070826.2995913-1-jgross@suse.com>
 <20260605070826.2995913-6-jgross@suse.com>
 <aiKMytZNGHj0epSn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiKMytZNGHj0epSn@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Juergen Gross <jgross@suse.com> wrote:
> 
> > In order to prepare retiring rdmsrq_safe_on_cpu() switch
> > rdmsr_safe_on_cpu() to have the same interface as rdmsrq_safe_on_cpu().
> 
> Patch #1.

Note that to do this, a new name should be introduced,
such as rdmsrq_safe_on_cpu() or so. This principle applies
to the other patches as well.

Ie. since we are changing the function signature anyway,
do not keep 32-bit API names, and introduce the new ones
cleanly in 3 patches:

  - introduce rdmsrq_safe_on_cpu()
  - change users from rdmsr_safe_on_cpu() => rdmsrq_safe_on_cpu()
  - remove obsolete rdmsr_safe_on_cpu()

This will make it easier to bisect any breakages, and will
make it easier to transition the APIs.

Thanks,

	Ingo
