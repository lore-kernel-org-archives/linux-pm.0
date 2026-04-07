Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD13A3830;
	Tue,  7 Apr 2026 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549390; cv=none; b=RVm7RzC/UoOBS2h02+lnLkKgZYENAS3sxQzL+Yos9xfLMxGgpzY5lHNsyezEyN8rVxAULMfEJ9CSVmGd++A3cCun51nNWVWClWg8b3BSl4U9ZM9m1oVC49Y+Uzmti9naO+tWIYwZpxYWuWcQOybkwtHLPpexH6t84g9MbyCMzwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549390; c=relaxed/simple;
	bh=69pbhVJSpuHmeuB6LE47GF9WV7VZpEjFuiuFUbGxbNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpyKUU69PDrQZoOfT6LIKLUTp+L5NkDW/jOUnkiUKJhRH7uN15VDOYQdxKpaoMBktGx6CVMVnkQWwMUuy+xHUo/ddIhRS1NXlrog43mBm+UTjJ4F3eFnBTTY0sShPFGfJS106tyCXvh+NAKiHh/9UremGMic49qanTi7ioTYNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CIO/2Tdp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CIO/2Tdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FDEC116C6;
	Tue,  7 Apr 2026 08:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775549390;
	bh=69pbhVJSpuHmeuB6LE47GF9WV7VZpEjFuiuFUbGxbNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIO/2TdppUFlFhDNEt6QybsKo1nIOuGuKGUxtNbfNLF16T/YJCCrvlDyOn1pAKAhQ
	 HUNLeKhCGvBsWQfyUhtpwDet2G96AfC44nXmpPS2lQYP7+fmYwl4kTKUIfbY+Tb7fQ
	 +aKfG2Vo75zi0Q8udQ3ygCQkwou4VhIu5xuFGhuM=
Date: Tue, 7 Apr 2026 10:08:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 7.1
Message-ID: <2026040737-prancing-papaya-344b@gregkh>
References: <20260406120652.1219527-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406120652.1219527-1-djakov@kernel.org>

On Mon, Apr 06, 2026 at 03:06:52PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v7.1-rc1 merge
> window. As always, the summary is in the signed tag.
> 
> All patches have been tested in the last few linux-next releases. There
> are currently no reported issues. Please pull into char-misc-next when
> possible.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:
> 
>   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-7.1-rc1

Pulled and pushed out, thanks.

greg k-h
