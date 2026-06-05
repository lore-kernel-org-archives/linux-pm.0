Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC34A33EC;
	Fri,  5 Jun 2026 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649728; cv=none; b=sapQ+KmubPmvpb3g4P9Mnyako8wWIr9y5fIqKRouaNtd7+vcC8iHgKdxA5242J3oyRptGWn1Wb2FUEAUdXM+UW2HwrDJr+pJNlZC5VjDT9oYzqQrcP2LOTd2rsEvOqnkFdz3DPE2ggQj10huzx8rPqnC2QR6nAtjgNUTXMaxu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649728; c=relaxed/simple;
	bh=Rpl2Za7dofjcWGzRUUqPYTAcNHnqkkIvfjXwZwi0IMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/9z8JFTgBfSnqTYnFilH6kzrNJTB9HmUVJ6ORF8k+Weqzxd4A2Gox9l1g3+eoc3cK6rBBQndWXpeXdAy/aBZw0+xERT5AXSPLdGUg/pANyuf+qm7JH7Pp1YQ2OIs3E5NHEppv/E8cr/K9VImd4ffSTbvarcXGQzLQuCn5Om01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcbFt4dL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcbFt4dL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58CE1F00893;
	Fri,  5 Jun 2026 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780649726;
	bh=KayeETGnQJsWcIfVh4r9XzwjlxK0G+EeHaWt/yDRsv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TcbFt4dLf5aKET6Xbu7fYmRzQMW0flh99MVQXZ1PY3HW7Pw7U1bDjY4V2srg2diNs
	 uFGRErphe/HfsFxgeQuC1N5D/wQbY0hmyv8MmAkp6LcQGkUv1PHWbV8TQrj93SDJyD
	 RjX9vkbL9A6mOzRH80WGklpOocNW3FfzUawjmLpSZnz5L0Dm7LqCjeMF/nwVBbk9/7
	 nedvHJDc2JIg8Wy90V59/xoYa+8s+RxSFWcXE69RBHGHS50xg3G4pMdsG60kDv2SMw
	 7EPe/x1yxGBJxa2mL87O/UAJJBMWVOQmk4hSDtnAwKK6O9p/SGhg9JIiccq8fZm08N
	 2fgyTOKMUv2OQ==
Date: Fri, 5 Jun 2026 10:55:20 +0200
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
Message-ID: <aiKO-FJcXhLhebyU@gmail.com>
References: <20260605070826.2995913-1-jgross@suse.com>
 <20260605070826.2995913-6-jgross@suse.com>
 <aiKMytZNGHj0epSn@gmail.com>
 <aiKOEDblINFcKZzu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiKOEDblINFcKZzu@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Juergen Gross <jgross@suse.com> wrote:
> > 
> > > In order to prepare retiring rdmsrq_safe_on_cpu() switch
> > > rdmsr_safe_on_cpu() to have the same interface as rdmsrq_safe_on_cpu().
> > 
> > Patch #1.
> 
> Note that to do this, a new name should be introduced,
> such as rdmsrq_safe_on_cpu() or so. This principle applies
> to the other patches as well.
> 
> Ie. since we are changing the function signature anyway,
> do not keep 32-bit API names, and introduce the new ones
> cleanly in 3 patches:
> 
>   - introduce rdmsrq_safe_on_cpu()
>   - change users from rdmsr_safe_on_cpu() => rdmsrq_safe_on_cpu()
>   - remove obsolete rdmsr_safe_on_cpu()
> 
> This will make it easier to bisect any breakages, and will
> make it easier to transition the APIs.

Addendum #2:

So instead of doing:

  x86/msr: Switch rdmsr_safe_on_cpu() to return a 64-bit quantity
  x86/msr: Switch all callers of rdmsrq_safe_on_cpu() to use rdmsr_safe_on_cpu()

We want something like:

  x86/msr: Switch all callers of rdmsr_safe_on_cpu() to use rdmsrq_safe_on_cpu()
  x86/msr: Remove unused rdmsr_safe_on_cpu() API

Ie. instead of having this confusing mixture of 32-bit and 64-bit
API names and transition, just transition to the 64-bit API cleanly,
and remove the 32-bit API in a separate patch once it's unused.

Thanks,

	Ingo
