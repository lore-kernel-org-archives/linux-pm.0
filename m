Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B73515EC;
	Tue,  4 Aug 2026 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846484; cv=none; b=QSTYj3GBfn5E7MAaboSI0jtG1UEL/P19cvl+lvy84VG3BeWziIrrQksTEZ/XDR0nLAqsv3VrI6pWaaetZk9H/W7b/2i8hjN+2E57+PL5R3l97FEvk9bkW6SNZaeqSn/ujhea7JjiQbozU550bUFEwog6DBdS28AMcCBiq5gttxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846484; c=relaxed/simple;
	bh=cx2LKkgNpsUUJk7LYJTUvB3PbWBDkYUjGpXQWftZhmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBHyTB8xXTGitFdhl8ByknAhsKdFwuL69OXToMTKv6BgS4ibbSdUcX3c5uLP259gHaftNyLbe7nwJVtu9jSRiN1hvYtMnVEys7xm4MvE4BwpR9Uqd/eofWIhgWmCWqRBL/1U97s8jyhjsRj7MCo32kgpGrCLQo1CoKYmLL0wjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tbuZnDKh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tbuZnDKh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 986A61476;
	Tue,  4 Aug 2026 05:27:58 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EA0E3F66F;
	Tue,  4 Aug 2026 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785846482; bh=cx2LKkgNpsUUJk7LYJTUvB3PbWBDkYUjGpXQWftZhmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tbuZnDKhdqqslTlAhNoAr8TBQj54OQ87sEk/TE8WzEfEhB9bGakiu7CTfc5N4rqzE
	 UfzIC1J+lYfkOcAj5+hLFTC9fq339MVLMDmPDrVb7K3wTZba7f4wgFg215jcc4FM/C
	 A8s6nCaCZDMNfHgcmmQzaaE14EpodzSpIv6uia+c=
Date: Tue, 4 Aug 2026 14:27:55 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, daniel.almeida@collabora.com,
	boris.brezillon@collabora.com, work@onurozkan.dev,
	samitolvanen@google.com, rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: add runtime PM support
Message-ID: <anHay9VZ7Mx7DrKb@arm.com>
References: <20260721153617.869933-1-beata.michalska@arm.com>
 <20260721153617.869933-2-beata.michalska@arm.com>
 <anGdb0C_j-OUsDVJ@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anGdb0C_j-OUsDVJ@google.com>

On Tue, Aug 04, 2026 at 08:06:07AM +0000, Alice Ryhl wrote:
> On Tue, Jul 21, 2026 at 05:34:02PM +0200, Beata Michalska wrote:
> > diff --git a/rust/helpers/pm_runtime.c b/rust/helpers/pm_runtime.c
> > new file mode 100644
> > index 000000000000..d0d71fcb0097
> > --- /dev/null
> > +++ b/rust/helpers/pm_runtime.c
> > @@ -0,0 +1,44 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/pm_runtime.h>
> > +
> > +__rust_helper void rust_helper_pm_runtime_get_noresume(struct device *dev)
> > +{
> > +	pm_runtime_get_noresume(dev);
> > +}
> > +
> > +__rust_helper void rust_helper_pm_runtime_put_noidle(struct device *dev)
> > +{
> > +	pm_runtime_put_noidle(dev);
> > +}
> 
> Should this file be wrapped in `#ifdef !CONFIG_PM` or similar?
It kinda is (should be) on the C side of things.
Though I can wrap it in another layer of ifdef.
> 
> > +/// Runtime Power Management modes that determine how a particular PM
> > +/// transition is to be carried out.
> > +/// Corresponds to C Runtime PM flag argument bits:
> > +/// - `RPM_ASYNC`
> > +/// - `RPM_NOWAIT`
> > +/// - `RPM_GET_PUT`
> > +/// - `RPM_AUTO`
> > +#[derive(Clone, Copy, PartialEq, Eq, Debug)]
> > +struct Mode(u32);
> 
> Nit: we have a macro for bit flags.
> 
> See for example:
> https://lore.kernel.org/rust-for-linux/20260719-b4-rust_binder_impl_flags-v3-0-f8d0b3ea1b87@google.com/
Will migrate it to that macro then.
> 
> > +#[cfg(CONFIG_PM)]
> > +impl Request {
> > +    ...
> > +}
> > +
> > +#[cfg(not(CONFIG_PM))]
> > +impl Request {
> > +    ...
> > +}
> 
> Doesn't your rust/helpers file already handle these for you? The methods
> exist as stubs in the C header on not(CONFIG_PM), I think?
Some, yes, but not all.

---
BR
Beata
> 
> Alice
