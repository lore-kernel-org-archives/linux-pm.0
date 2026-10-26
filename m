Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017706;
	b=zuOM9uI/Kps0+0U77q3Pz1hGt5Ww9GFHDHmTVFFj75npCFwzpc42aoThYyCnOjTVV8Y9
	 oINMMM2MfF+zYBb4oo0Elz8jP0WC3KqlllJC0BKL6cNYrSF5vIJbThx8G5e0iALySEz4D
	 FVx+LxGMvWWoWRZSKf0VVDPGzk1Ak5/xJzAaYTPQLtX+Nq22kI8D0Oi3xDSywY5k8EBqw
	 sRV+rUuO1uRi9q53D0+qNztZeIRx4NWh6GWIgjMKMaGIXwkZWPKngnK3ZsPMDWMKWPyey
	 nBe969ZOXmq5omwSydxtPWku92vgLAkRRpeF6hOGlcaI9WMlhOEuv8v+BQ7yjRp8+Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017706;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=CyYy5rHlSrqPvF55GuDtnj/n5m7aEAbLHRyOk9mZP24=;
	b=Lu4fJI9npt+Esf7iidGFapT34HvWIQlrItYhvNVErqhUgXTMgmb5AthRYRxd72lWhsQv
	 wUre7IfEcrqdwg1kVcasjuz0ztIYya+RWOus5PiG5PCotOY+1IXL0WsaIWVl0jh9vghm9
	 15Aq+jtNWnY8TiVVl3B2ctAvzE8TOpUGMg6Nk16QNVAeXKkCgXIs6Vn6LEMadl7F6tB8F
	 pVUfYZR0UTlnPJcX4BxGesw5Zh+nahNIi1j6SAJp1rI5fhu9G3gakg5j6v7j3jmPq/Ik1
	 ZDgL/tijr7WpP53S9ctz/tMlvZoRU8YOsaE4yt3jkJ2nlfc6AJjDF15OKkgOfYv2g5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b8xdyLjn;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C02606A323;
	Mon, 26 Oct 2026 12:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90C02606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b8xdyLjn
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFEFB25DF;
	Mon, 26 Oct 2026 05:28:21 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D093D3F7B4;
	Mon, 26 Oct 2026 05:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793017704; bh=FG/4ImEeMP+5qKPDzvHVRV8OOA4sHPiDH8TZTXN25gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8xdyLjnA1INMUY/43v6eyVrKV47Zq/4FNMbcGuBjXNtvpwL/BXMEVkxYRr6YTHJm
	 trnQmlgfGSXGXv/rIIdlD9EXv/3c5GA7wIuylp9KsPq+1ON8q11Ye7+Bkpgg3T+SZd
	 NKEsMxWoTuUJ1ZeanPRvpHGZBuBxAOJ8LRu6iUo8=
Date: Mon, 26 Oct 2026 13:28:10 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <at9HWpz0WCE6gosQ@arm.com>
References: <20261026120523.526942-1-beata.michalska@arm.com>
 <2026102635-stray-census-1169@gregkh>
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
In-Reply-To: <2026102635-stray-census-1169@gregkh>

On Mon, Oct 26, 2026 at 01:15:46PM +0100, Greg KH wrote:
> On Mon, Oct 26, 2026 at 01:05:05PM +0100, Beata Michalska wrote:
> > Hi All,
> 
> Subject looks a bit wrong, did something break?
It did! Just sent an update as a --in-reply-to.

---
BR
Beata
> 
