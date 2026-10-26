Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016947;
	b=x4onTL8/HKa5ud02hjXWXL7ifFdS4zqQimO9tjT3A13zK8FgkFVCiKDy4y/H3cVCwBfH
	 4strk6wXlutHaxakABQ6sjb2SvXgsPjqdItCukz/wOK+005miW4bKKT4T9pBTWbOeiCIK
	 E4VFIGDoqFcGnXUwDDoeNaxnxST4ph3FCDC9UAr5vJ3hv5hp4nwRVlISFPY2Hg4yBuG6j
	 UnUxV0WeYrXSXgG/8qH1mneY7cz75RhMG0DnWgaZLghJTGUnYkoAkuRQ/odC56gsKL+pv
	 HQdQfAC95oXPu1msD5yo1UTkmybJCKQW5XMszuyXkVUjPxt+oO/nrfP7RH8p7S7YhSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016947;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hm24c+cQsdbwAkbm9KBkSNZyBbC+x5iHoOkTvzmaaWk=;
	b=YTfJ5pmIyHQVvnQR+95pUTeDKuQRNVMC17PJ55yAfAb+USDkkgLiUFfzMo+kWgUwNV50
	 mc49AHcMmdRAVEZVsw4GRtukZ/cjA+uWLC9ECLQnbdirpaE4puR0q10BIuwu097VXvbYS
	 OvAVC59FtGEwl1w3xB3DZglvIv+2P5kcqq07zxWfwAxjPXOIEW0yrVAgg4dSpuSpeAiQi
	 OHc4KavCM+hCavYyT13JGgWyLyafj1qwKOA1DupMSLA8jd5WNyhQtd3ZWWdOp0+hcbTKM
	 btTK7Pyw6uByB6sGgFM79x8JfBqkE0lbynRGxlWoJzlgvex3z/HXKysWtl083Sk8kUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IIGk4zAB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A3606A330;
	Mon, 26 Oct 2026 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IIGk4zAB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99381F031E5;
	Mon, 26 Oct 2026 12:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793016946;
	bh=hm24c+cQsdbwAkbm9KBkSNZyBbC+x5iHoOkTvzmaaWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IIGk4zABS5Ytjop60WP6cY/Ii/G+oA5dWDtAMN/PXC6oT2iTIbf2BuAd7kpY6oe8A
	 A2u8IKR4aCLxi+8/nB3NvPS9tQ9DK+4Mvjy9FK/iPFWsqNVM2EfIt+y4Fsgd5k65gc
	 bDvCCBYpMtSi7gQVdRCQxc01yvyCKaf+mmFBoIXs=
Date: Mon, 26 Oct 2026 13:15:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: ojeda@kernel.org, dakr@kernel.org, rafael@kernel.org,
	aliceryhl@google.com, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, daniel.almeida@collabora.com,
	boris.brezillon@collabora.com, work@onurozkan.dev,
	samitolvanen@google.com, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: Request::put_noidleFrom 43bd77ceaa3d6a9f61ae8074be13824a94fa76c1
 Mon Sep 17 00:00:00 2001
Message-ID: <2026102635-stray-census-1169@gregkh>
References: <20261026120523.526942-1-beata.michalska@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026120523.526942-1-beata.michalska@arm.com>

On Mon, Oct 26, 2026 at 01:05:05PM +0100, Beata Michalska wrote:
> Hi All,

Subject looks a bit wrong, did something break?

