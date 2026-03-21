Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC8349AEE;
	Sat, 21 Mar 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774081472; cv=none; b=t3KSEZHG5gLVEGU78wSLS/FCdje+5E+H+s3U113fywlbPMMlHzXi0yiSrcf3ZDhyu0f4pIytILEG736cUEx0932E8aWEcRqaBNQcvDEmbOzGJHpkD5oryTVtbpWBEPEzirutcKcDNy2zAv2wytPsVbDjopFgg5ftCqXbeJXRidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774081472; c=relaxed/simple;
	bh=Rybs5XVKBjVm+KSQNmEQOobZO8BwSUFh+LMnbMG3Mj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcjTTDEpty3QAeIOKJxuWFaszKl/q5o4hFTfBqCG01NbAemwotTEoKliET9H1IdaWOSLwMTYAqqaL0LZeETcIAjVYvKFc6mSRF41s4Gv+RDvnpzpLBc5+4RncUKeXI1QrPbXU4MKzZHXnw0+5xMl9+HeoMUlqlNMKxPvkknxGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D0NAW0lG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D0NAW0lG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04304C19421;
	Sat, 21 Mar 2026 08:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774081472;
	bh=Rybs5XVKBjVm+KSQNmEQOobZO8BwSUFh+LMnbMG3Mj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0NAW0lG/L2yWTkeYcBaHSMlfEww1wiln2GyqG/3t4DZbwp3pGutmFSq0+TH/R0/K
	 specBnGIyuQFsC1M+aEzo7YzgqWJ11W5QJR+1uzsT6Kj4oZ/IHm38t9/9904jTSJRA
	 aEoPddFAcMoiVkViGPP82owtWrZHoL7xDGVEfxkI=
Date: Sat, 21 Mar 2026 09:24:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ionut Nechita <ionut.nechita@windriver.com>
Cc: stable@vger.kernel.org, rafael.j.wysocki@intel.com,
	linux-pm@vger.kernel.org, christian.loehle@arm.com,
	artem.bityutskiy@linux.intel.com, quic_zhonhan@quicinc.com,
	aboorvad@linux.ibm.com
Subject: Re: [PATCH 6.12.y 1/6] cpuidle: menu: Drop a redundant local variable
Message-ID: <2026032141-tightness-lukewarm-43df@gregkh>
References: <20260320202908.24377-1-ionut.nechita@windriver.com>
 <20260320202908.24377-2-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320202908.24377-2-ionut.nechita@windriver.com>

On Fri, Mar 20, 2026 at 10:29:03PM +0200, Ionut Nechita wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Local variable min in get_typical_interval() is updated, but never
> accessed later, so drop it.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Link: https://patch.msgid.link/13699686.uLZWGnKmhe@rjwysocki.net
> ---
>  drivers/cpuidle/governors/menu.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Again, you forgot the original git id.  Please redo the series with that
information.

And you all know this, I went through "how to properly backport patches
to stable" a lot with your team, this needs to be reviewed by someone
else at windriver before it can be accepted as you also messed up on
something else here that you should have gotten correct :(

thanks,

greg k-h
