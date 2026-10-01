Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7941E4A688D;
	Thu,  1 Oct 2026 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860758; cv=none; b=ocU/v3Syp1UM8oLfeplSU5Wa9jL4JRXBindLfZrAO8QlhW0/RRP/rompwy5ieAecBMXrQeQDnRgd5rCWDcG3UaVB/k+WcH+VJLkBLTxSeixnT+mrMikcl6Hm6wu9fwO5YlY6I+ymz+bentPBJu7i1hn6yKq+zr7cryjMk1kvAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860758; c=relaxed/simple;
	bh=n3ht7i9wvEQCRO5Tfn/BQFxtlXYVkDMnrVBK7Jm/1Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqqIU3tPRBiiGp0+3NqIE9nMoHCdOH/Gc+NqEHf+LAcNjxov62wFCTiFXxsC1MfTe4Lw427bXnBgRlTHdDf+CAfm+AMM+y1z4HG38cu/eggkD+DNw6IPTN8EsGZ80/LfIUrdITLWOs7ktRgCQIRD8nCvDe1E03RA4E+n3WPCYPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z8nExqUY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z8nExqUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788921F000FF;
	Thu,  1 Oct 2026 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790860756;
	bh=CE1NOSSLrczNGc3jgPGiT/nO5QTS2f9fCjw4RbC3cmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z8nExqUY8Ta8l8uUEfESP9Y+FiEG2B1Jrr7K2DNeSGYOu+o1/J4XjlrjtIs6MiwYe
	 k7NHmI3x+Ua41WzqhaP2HS+7JVRR1Bil2PEQKYMoOciAbfkLaXGf30kszF+gWihGxe
	 WIbroZ2g4sdv3QbnYZ/frd8+c9JBEM6rwzmorl5A=
Date: Thu, 1 Oct 2026 15:19:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Yichong Chen <chenyichong@uniontech.com>, rafael@kernel.org,
	djakov@kernel.org, quic_mdtipton@quicinc.com, vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 0/3] debugfs: make debugfs_create_str() read-only
Message-ID: <2026100139-deviancy-direction-edea@gregkh>
References: <20260807100053.1089834-1-chenyichong@uniontech.com>
 <2026100153-unmanaged-impart-3adf@gregkh>
 <DLTIZ3CNCQDS.24NN9OMJG7AXA@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLTIZ3CNCQDS.24NN9OMJG7AXA@kernel.org>

On Thu, Oct 01, 2026 at 03:10:45PM +0200, Danilo Krummrich wrote:
> On Thu Oct 1, 2026 at 2:51 PM CEST, Greg KH wrote:
> > On Fri, Aug 07, 2026 at 06:00:50PM +0800, Yichong Chen wrote:
> >> debugfs_create_str() has a generic write implementation that replaces the
> >> backing string.  Concurrent writers can race and free the same old string
> >> twice.
> >> 
> >> Instead of adding more locking to the generic helper, convert the existing
> >> writable in-tree users to local file operations and make
> >> debugfs_create_str() read-only.
> >> 
> >> Changes since v2:
> >> - Use scoped mutex guards in the interconnect and SoundWire conversions.
> >> - Clarify why GFP_KERNEL is safe in the interconnect conversion after the
> >>   RCU read-side critical section is removed.
> >> - Drop the unnecessary firmware_file = NULL assignment in the SoundWire
> >>   exit path.
> >> - Use WARN() instead of WARN_ONCE() so each writable debugfs_create_str()
> >>   caller can be reported.
> >
> > Sorry for the delay, now applied.
> 
> This series fell through the cracks on my end. I also reported this issue in [1]
> and I agree making debugfs_create_str() read-only is the best fix for now.
> 
> However, it duplicates code and I think having a proper helper as suggested in
> [1] would be nice follow-up.
> 
> [1] https://lore.kernel.org/driver-core/DLPDB44JJRGJ.3K6JNS746M7QC@kernel.org/

Yes, that would be nice, but for read-only debugfs strings, let's keep
writable ones away if at all possible :)

thanks,

greg k-h
