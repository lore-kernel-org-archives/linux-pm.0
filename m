Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9A41DDEA;
	Thu, 10 Sep 2026 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028917; cv=none; b=F8ZEp9W/n/qtln97nIgH1LFJan57THZ1DxWF+w4qlEHzGX+IQZJ0oXIsLyQpEkFL9Y4/i/urdM2O+pDzcnojWTfMVq2Pey41Hz/Xe99Puv6mVcJWyFJjtjcGZHh1ekfYwZjH37Crec+HrHkq1+DKip1LCfOBXebn+LKFZz6AWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028917; c=relaxed/simple;
	bh=3meVQBKw5bq+scBGcadQotIqs8mTlAqN2EfNgH/DC+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8t7Ct0km4ApfoEX1zs9rbqAux3uOVhAOQ4NwDZrHohBRGxjIsxP454OXF0LPWw36jVoqrIpHgeLBd+1hwEsqQKxTcBI6n7sykToP/sGfM5y35fwPa56/4UNcTNbnqZpGZF+QZtrDd13hzmfV+8i8AzuvVdcvPpR8ZbjblM018Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XGpizOx6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XGpizOx6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5F451570;
	Thu, 10 Sep 2026 01:28:25 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B4F3F7B4;
	Thu, 10 Sep 2026 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789028909; bh=3meVQBKw5bq+scBGcadQotIqs8mTlAqN2EfNgH/DC+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGpizOx6IoDqL+wGAhDW9ImK/xbkcpp36Tl57accRVuBqgrx/+c5Ev+08536uewl0
	 kHd0G2CqjFHNzjfqWjdbBboVkOzmGj/I46e74EQLshovhCH16y/PjFbNIkjtD8EJ37
	 Nn9ktAE7ceOsMMqnnoIrsVHQwoBW1i5Gj6JyvUTg=
Date: Thu, 10 Sep 2026 10:28:16 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, daniel.almeida@collabora.com,
	boris.brezillon@collabora.com, work@onurozkan.dev,
	samitolvanen@google.com, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: add runtime PM support
Message-ID: <aqJqICNMitP3JTJw@arm.com>
References: <20260826131213.1820408-1-beata.michalska@arm.com>
 <20260826131213.1820408-2-beata.michalska@arm.com>
 <aqEox8rYYBcfxtrN@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqEox8rYYBcfxtrN@google.com>

On Wed, Sep 09, 2026 at 09:37:11AM +0000, Alice Ryhl wrote:
> On Wed, Aug 26, 2026 at 03:10:55PM +0200, Beata Michalska wrote:
> > +/// Result type returned by runtime PM callbacks.
> > +pub type PMCallbackResult<T> = Result<Option<T>, (Option<T>, Error)>;
> 
> So I think my number one feedback is that it would be really nice to get
> rid of this Option.
Guess this can be done. And I'm assuming that's for both Options here (?)

---
BR
Beata
> 
> > +/// Runtime PM data stored within the `struct device_private' during
> 
> Should be ` ... ` rather than ' to render correctly in html docs.
> 
> Alice
