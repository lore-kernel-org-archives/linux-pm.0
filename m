Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64753B71DE;
	Mon, 29 Jun 2026 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732355; cv=none; b=u4F3x3hO0sAZ285R0yJRhn8huYw4KUApw86+tqf9QGd7/8AGnmSfWsMyiDuAmX/D8jVv4iffB/ILixWSdKX0medrgqV6yd1Qclj4A5k6ArPEnU4K7zyVUf1lqvpGpwAOHyPAATCZnoDbUOqNklF4obDj67Xy4ftxwpFniERUjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732355; c=relaxed/simple;
	bh=FKQ0X0pB394T4VxzKajvOev+QqSf7EFp8dqHrrAawjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spXcHJhzoeQLS8hw6L/TcuT0ozq82l3B9PAZ82AtxAjQpM8ONd/4dh6tKBvLLThDMVGpDvbZPPpYWevu1yG+QvJB68nzv2UTL1x9j4lLSGlPeMKBAsZk/5Ij8V+OLUMxFjtI06sJgbpditz8VigFLRwPC/7NMIUIn3RuNcKRz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkq9hu8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkq9hu8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647171F000E9;
	Mon, 29 Jun 2026 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782732354;
	bh=sv3fauJ3nxeelUZKkLaugCRmFLCcDbkMk039jnGT6jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xkq9hu8pLsRNsRh747P9//NLTAfyR/mzDNNkNDUFDVUNqYZsc95jMFTot37HFUBiX
	 d8D+K43BuNOIggIwbkbD4Uh+6FkPead6Ld5jZowfeJSXCf3gaVr4fnI6RHdpcbM9vK
	 TJOy4KvkBWIOsxDYotPZQ5HhZHOjjarkD1kqYdduldjGZ3huYQZ2Tr7opgtNqp2u4q
	 dcIg9nPMnxijvEMjT886TTogk9xXc+TCubPz1JqKuUaD/HSvhrF1Ow4R9qJej9xoZL
	 DgMviEA46+i9rccDVktu9l3xBUzUP13Nmhxu7Hr6TtexV4GCkloRPzGaf3DDeIfFJh
	 6QIPpOoWlDPmg==
Date: Mon, 29 Jun 2026 13:25:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 02/32] powercap: Stop using 32-bit MSR interfaces
Message-ID: <akJWPnqcbL6RCfYN@gmail.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-3-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629060526.3638272-3-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> The 32-bit MSR interfaces rdmsr_safe() and wrmsr_safe() are planned to
> be removed. Use the related 64-bit variants instead.
>
> Drop a pointless initializer.

Was the initializer really 'pointless'? IIRC it suppressed a build warning
on 32-bit builds, at least in some past iterations of these APIs.

So maybe this should say: 'Drop initializer that became pointless'?

Thanks,

	Ingo
