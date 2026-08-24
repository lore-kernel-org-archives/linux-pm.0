Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752B7377AB6;
	Mon, 24 Aug 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590570; cv=none; b=ZAhAaFyZp/dipZZRrHQfglqiqxTwRJ8LWgDMrswpLA4cVsIUxmjRlJYwuCHqymYW7c6bMh6KANGmy/W49hJBnn2oGKyHS6uRmo29XFX981YwZJipahXPo4PEggHAaLgXmnI/YgXYtaIUGVENRiTmTC95lZ5PiSpM5V6Ef89QMic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590570; c=relaxed/simple;
	bh=qUQjtkrXT9OQJ/hOuCnqlUXvjpEJ2WOuntgsmgU4EL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS3vzVfr07UHf5pQwUr6jxbIQrWU9shNdzaI+dz8Sf188QWixaxTtriEGMf/8akArm3WJGv65rPIny6MHrzYIh/1dvY4gYho0VgmukITvyWCCl0LIc+A6tEYlxNS1eONP+icy56aQLHtQX1NKS1aCRHSmgcwlfgHJ5tk3Ps6kSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cOSMwhct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cOSMwhct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0471F0155E;
	Mon, 24 Aug 2026 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787590569;
	bh=aVUNsYdJy/FbMJlOHEA8f+/GfBmyFwvR6FbrpO6Y4vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cOSMwhctCisiK+lAvh2P+xbtZh9l5VAThToxJjeE6QyS3Q3X4ZDtJe+x3UpW33WVW
	 lO58BqQVMy37tQyzpJ5QdJxM84PtTkF1oWiS+2wZy6wkF+anYPLZWCRC2o1VeFDtZ5
	 wsAzpwN/EqCKIF+OJ7CWQ9hlT/0YeNtgmadRO7TY=
Date: Mon, 24 Aug 2026 18:56:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH] thermal: change thermal_class to a const struct
Message-ID: <2026082411-flask-rewire-434f@gregkh>
References: <20260811061530.21789-1-jkoolstra@xs4all.nl>
 <CAJZ5v0i0PQEMTOT6UqWO87jCdV539ns-KcP69n++eQsz_NG0zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i0PQEMTOT6UqWO87jCdV539ns-KcP69n++eQsz_NG0zA@mail.gmail.com>

On Mon, Aug 24, 2026 at 06:09:33PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Tue, Aug 11, 2026 at 8:17 AM Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> >
> > The class_create() call has been deprecated in favor of class_register()
> > as the driver core now allows for a struct class to be in read-only
> > memory. Change thermal_class to be a const struct class and drop the
> > class_create() call.
> 
> This has been deliberately changed the other way around not too long
> ago, in commit
> 
> 34f54003643e thermal/core: Allocate the thermal class dynamically
> 
> and it was then argued that it would be better to allocate the class
> dynamically.
> 
> You seem to have a differing opinion.
> 
> Is there any plan to remove class_create() from the kernel?  If there
> isn't, I'd rather stop this back-and-forth dance and leave the code
> as-is.

Yes, class_create() is going away.  I didn't notice commit 34f54003643e,
but that's the wrong thing to do here.  We should just revert that
instead.

thanks,

greg k-h
