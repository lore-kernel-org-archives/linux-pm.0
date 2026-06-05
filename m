Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38573CD8CA;
	Fri,  5 Jun 2026 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649169; cv=none; b=jCnWpLxge1D658PnFEPk4CIw514Mvlxx5VKIhdGU/YKIzQuIcXH3cXckWlnsmLEc5DWhPrxQo1sihsVSK/sRgmy4gNJlTzECCepXxWq7iPV69zabEZLWmHxVGzcUHomZ3rYWi3gfyw9YCi2jsm395Jtj8/vvgyTYCzYgkbvlArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649169; c=relaxed/simple;
	bh=Y/Yn5a+st7jcNKLOamu7hkvlg/hwC0dcEladNw/0TeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sciaKSg5vieONOcBcbGz+/KN8rd+zehVSZZlGbVwuCdFXnmxJfMWDuUOVvZ82Ix8mhf4E7RqlE7x5NGpkgFupR89fYBP/hUfGE+hF7L4nMsiWi5RWjBeJHglij7YeQIocquKjRUmKDXWoMiX5Jz7qdHHY5AhvM/WgKPp3pI2fEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNwgOdSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNwgOdSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488A01F00898;
	Fri,  5 Jun 2026 08:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780649167;
	bh=cfYjhL+ONZtAyMzZiKF/rHsqkuzOareTCLYQL96UjO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hNwgOdSdPkbbMmFUGIMDQ9okUGHjSGLtIF+NCJXnaOG/rkeJW2og+h0EZEzVV+sQJ
	 a6yJmSMspbgJxRMlhynFDhezZD6dQTaaQChT9//1N/GwfTgy9kWn4q7pumMJ2OgDcJ
	 Bfa1Ye+PWX0zpyf0sa+3pqfSM0BD2VzqVBhz9Cf9Pk+9sh7ZLpNfQZwl91Grl15i6k
	 94lZ1bg3AlvwrFG5NMG+qGlXzX0WrxJ0/VWfWy75iixadH09qNC31eszWtrfJMbDEW
	 UI8EoLfLz7hr1eS78bCH+GOtS6H8w5BcPL4au9QtK0XQWBVm/oj08IGJ4EqxsmHj+p
	 cksUom8VtuDCA==
Date: Fri, 5 Jun 2026 10:46:02 +0200
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
Message-ID: <aiKMytZNGHj0epSn@gmail.com>
References: <20260605070826.2995913-1-jgross@suse.com>
 <20260605070826.2995913-6-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605070826.2995913-6-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> In order to prepare retiring rdmsrq_safe_on_cpu() switch
> rdmsr_safe_on_cpu() to have the same interface as rdmsrq_safe_on_cpu().

Patch #1.

> Switch all rdmsr_safe_on_cpu() callers to use the new interface.

Patch #2.

Thanks,

	Ingo
