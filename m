Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F221339861;
	Fri, 30 Jan 2026 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788083; cv=none; b=OugUY1yYdVbqBea6jDSQSvWeZtSibPlT3VA3gdlaqvk/Adigq6VYXVqmdZpxnA77pxrspqgfIJ49y0VioxEbamZYW6d6PAVqlR8xxtbJXPlGYvl0sZtOxhhn7oeqYfSjAoK7uTgo6+Q/+9yYB3rDQ4QqNPDjU6J3nG4yTS11p7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788083; c=relaxed/simple;
	bh=HWr7UzYErxoguWHUXdQTNgJ54b8ZIoan0pgg+sfSsBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf31yabOnPklsvc4go+Iwm13JUG2wxpACe6PDLe1AlAcgeklyhr/N+WGk5obPUw5qA3IJUuy3ZG6LoeCdIgzuY/S9cgt93OdXz2wUHBFCpsd31URS2yiTzUK2V6SFO6hBcu+51bz8DwqHYzQOz95toWj9QuDZasAfv7zoqTDPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WpBwugE2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WpBwugE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6D0C4CEF7;
	Fri, 30 Jan 2026 15:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769788083;
	bh=HWr7UzYErxoguWHUXdQTNgJ54b8ZIoan0pgg+sfSsBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WpBwugE20oP9vjvzqYx84M0SAyuhXZfJDQXgwtg7oVElTI2EXKld+2/Wu1QxqBw3V
	 TSPTyxZFv3HEeej+csXDLkYJ4JeGkGFvyDzRHvGAia/rM8Bk2vLOjzAL7P3IS1DlOJ
	 ZxOd/Q5RJkY/+vZM5LiNB5PMy1O9U1amDkbvb2dQ=
Date: Fri, 30 Jan 2026 16:47:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.20
Message-ID: <2026013023-thievish-viscosity-c9f6@gregkh>
References: <20260130124630.1279635-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130124630.1279635-1-djakov@kernel.org>

On Fri, Jan 30, 2026 at 02:46:30PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.20-rc1 merge
> window. As always, the summary is in the signed tag.
> 
> All patches have been in linux-next for over a week. There are currently
> no reported issues. Please pull into char-misc-next when possible.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:
> 
>   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.20-rc1

Pulled and pushed out, thanks.

greg k-h
