Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359649EC4E;
	Thu,  1 Oct 2026 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859075; cv=none; b=MC0nj079E9NcwEeM18ADry4Gp7Ho+t5UgGt3q7yJ6D6nQrAAiDmAO2JjoAzcwPxnk/5MatoMnAPZEqbduPDXCzPyo8mYO4q+q+ewgl2Hg3gU+prGEjSNC21J0dI4GLJAQT1qP9fgwakhjHuCyfyZoPy8xSq7NuqeJqAbZaVJWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859075; c=relaxed/simple;
	bh=9zwE3it0X/SnR7JPTJCFFCGzWsvCI3Ts+3EP1gH61IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u38JkURPXQhz647dtdASHYkd7TgX9ixK946TPBgVc2vzNY//HelYWi+3VyBeMNlYiDzOUU/zXXfzo7mPoooz+nT478R2mmoyflMUihdVP+rOhJSRQVbX9zYV+wmvasQJNWHq+l1gE2eGdA/UStK74eaYV8nfsHRUaadkSX/GhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2K+v1eTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2K+v1eTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17561F000FF;
	Thu,  1 Oct 2026 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790859073;
	bh=+djwyJDzMgBoU15oSzdHcTZ6n15+RfZnhqPlr0XbuLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2K+v1eTw3+jJXNdnbRTVEIEwnsQtV0YZLkQagVar9LZgouJm6tHqx3t59WxT/UdzE
	 pd4uZ2cahRDtuiXKBHrOH393TVPbkayC30in1ttx0d4BqxZ0Z4tBvNT/f3vyrLSYTZ
	 HBzOGiAx3+XsdNtWlZXzkOwNsNqdHOoEyGUJnI1o=
Date: Thu, 1 Oct 2026 14:51:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: rafael@kernel.org, dakr@kernel.org, djakov@kernel.org,
	quic_mdtipton@quicinc.com, vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 0/3] debugfs: make debugfs_create_str() read-only
Message-ID: <2026100153-unmanaged-impart-3adf@gregkh>
References: <20260807100053.1089834-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807100053.1089834-1-chenyichong@uniontech.com>

On Fri, Aug 07, 2026 at 06:00:50PM +0800, Yichong Chen wrote:
> debugfs_create_str() has a generic write implementation that replaces the
> backing string.  Concurrent writers can race and free the same old string
> twice.
> 
> Instead of adding more locking to the generic helper, convert the existing
> writable in-tree users to local file operations and make
> debugfs_create_str() read-only.
> 
> Changes since v2:
> - Use scoped mutex guards in the interconnect and SoundWire conversions.
> - Clarify why GFP_KERNEL is safe in the interconnect conversion after the
>   RCU read-side critical section is removed.
> - Drop the unnecessary firmware_file = NULL assignment in the SoundWire
>   exit path.
> - Use WARN() instead of WARN_ONCE() so each writable debugfs_create_str()
>   caller can be reported.

Sorry for the delay, now applied.

greg k-h
