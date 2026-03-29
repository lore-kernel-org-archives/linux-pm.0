Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7737474F;
	Sun, 29 Mar 2026 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790276; cv=none; b=g1OUlZB0I7AWKnCx+oN8yBGvlOwhleUbiGTGmfcJ+YT9nboh0YTc4mAQiMziIipVxUGljkoVphOa7+TWejlSwjrhQ4Q0WC5gFoMQcirbS6bCsMszNmHs6nHvflVJt/Wtd9lioXTegPo3ZKVTtw+Mg4Lor1+B2LrvKh+POuLgRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790276; c=relaxed/simple;
	bh=BjgGh2qWeketmWWjg6OivllLXv8cNlqGMfQjqTipPnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtOVMZqBDtI2rIaB2mL3wDcAfLEbK1iQNTDa1lJVAjbt7A7RcA4myrIVUZU8Z1by+Ar9VQOkqNyeIM2yZo+asgoYFPB9BKmE8Zw2aUxgI+N1ogfyN9yOEPAwyAth1SPQxg4Yd9NeEWJk68hm503x851GfPAy1iRxSWVcM534G0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3mfa3GQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3mfa3GQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E92C116C6;
	Sun, 29 Mar 2026 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790275;
	bh=BjgGh2qWeketmWWjg6OivllLXv8cNlqGMfQjqTipPnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3mfa3GQtf1U0ehAcJQGWsP7myHVZ5Pjzs4PHYPBhr8q0mGmkRzOEbvZ3ggUPXOHR
	 Buxv56drE5+GKc0125aBjDPtyMKicrWg0UKV5YAiLT8gY2X6aQZh87BR4QEBysxELN
	 uVLKnPRP+Eidbb4FnfJr1n/l2I8xDWXyGsSyrEp8=
Date: Sun, 29 Mar 2026 14:48:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fix for 7.0-rc
Message-ID: <2026032939-cola-drone-8f25@gregkh>
References: <20260324152553.612127-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324152553.612127-1-djakov@kernel.org>

On Tue, Mar 24, 2026 at 05:25:53PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains one driver fix for v7.0. The details are
> in the signed tag. It have been also in linux-next for a week. Please
> pull into char-misc-linus when you get a chance.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:
> 
>   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-7.0-rc6

PUlled and pushed out, thanks.

greg k-h
