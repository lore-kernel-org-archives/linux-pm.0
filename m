Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D145561F
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946639; cv=none; b=MHkJleWWnqKxZD6qG/uSW/W7MxZmwMxPx0sFiyoGFbBPpzsjYpgLwT2Tly82ty3xKw7JGMQle7pQXqnqSL764KiZWDOTNBVktz4eHtYcbHRILhGS9p2+z4Te0h5cVAHN4SXmoRfKBivv3QExBOcoD+FKJ3XxR8BEHZmjhQN84xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946639; c=relaxed/simple;
	bh=CoR+vQjBubRI4wv3EktisroBpu3v3oIwSCS6EuZEAYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bGAH5tvJFXadYS3TwNjNd9Ljp4ymBxcsmq5bDdMgme/J8xeIAwLI5326ksuryko+0GsKW/cfdTA2OQpreEUr/Guc7iBZXAu3D6qd49JWC9+Ce/QBUGmcxNl9gZpau+i4D++UY4HsbL7H/KjvRQd8eZdt1UaAW9J/tteUExN4ch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFt4uUWD; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFt4uUWD"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49d156c917cso18503135e9.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 02:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788946633; x=1789551433; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CoR+vQjBubRI4wv3EktisroBpu3v3oIwSCS6EuZEAYs=;
        b=pFt4uUWD/uFr9iWectDGs9IfshhdzMdo5NtOOMGPKE1aaWS26gjmqizlUGu9XVo38q
         eKm5rMzihT59HVAb+7G175cc074xPO6kLP5rzL+A8rTpcx6JO2V6XbZ1AjRSSf5vxEhg
         iEFdRx+KQ8y9SdyqO5HES+XF6wpBFkU4+CDSuLVtdH0UmilvfQFO+IL/xXhIbCcsBwNX
         /uafc41c+b+Y60bmNsYAJBnFOiRVff7ibK79ZKWF/Q1DzMPYf66z5TroIvwuYjye43A9
         nqiEU1UlM86+9KLZSqcLXnrFUJZFRQ8mk810mIyubG9e2cTEIapi+WFkWRiEUtWOejIc
         OWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946633; x=1789551433;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CoR+vQjBubRI4wv3EktisroBpu3v3oIwSCS6EuZEAYs=;
        b=ZAlek97r51KcpIpp3BDEc+kjguNXLK9A1EEhWPwAKUoKrgtzzemtc094U8xnnj5hsz
         alnpU3RPlb3xWINkST1OLm9ZRFa40irMNq2uWp/FLdeNUpHaqHeXxg4ZAhkVF8TOLiin
         +fRe4EDbReRbj81JtrjUD4y68lG0FCOrpaskcaIV/14bhn7yO3ZT6sLsMRiZYy3wGmDA
         7VLBQqgk8sNi2Nq38u/IVF2awKhGqwJiXiEN2nOvh/mwj40WdhsRKPLFcHfEN1d0/EuO
         tZnGNV+Kc9v23dWs2fXNIdT6DHpei0/7XebROHVcOaByx730VhohnYkcinb7t520SRbK
         I6og==
X-Forwarded-Encrypted: i=1; AKwUvBw+AYMejpv5It94Zq/1LVQWne466AIoAnwAkazHYCQJ57v78qx8K1i4hJ26kOb//EMZ9N2AjrUu5Q==@vger.kernel.org
X-Gm-Message-State: AFuF++k+SoZGlycG15Svre+N0tl0n/N2Q+eTJSTNmZ5GDeI/PFwP7zzX
	TjQYoTTPV9a1x5FWboDgPKrWWo0lhYjgbxSbUUgq/G40moWzXYWREvcGHWvH6vpqXdYWiqP2ToD
	BlTxW9TviatdGCHHyzQ==
X-Received: from wmnu16.prod.google.com ([2002:a05:600c:4410:b0:49c:f5c2:d311])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c21:b0:49d:1e79:35d6 with SMTP id 5b1f17b1804b1-49d1e79368dmr64831015e9.14.1788946632676;
 Wed, 09 Sep 2026 02:37:12 -0700 (PDT)
Date: Wed, 9 Sep 2026 09:37:11 +0000
In-Reply-To: <20260826131213.1820408-2-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826131213.1820408-1-beata.michalska@arm.com> <20260826131213.1820408-2-beata.michalska@arm.com>
Message-ID: <aqEox8rYYBcfxtrN@google.com>
Subject: Re: [PATCH v3 1/3] rust: add runtime PM support
From: Alice Ryhl <aliceryhl@google.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, daniel.almeida@collabora.com, 
	boris.brezillon@collabora.com, work@onurozkan.dev, samitolvanen@google.com, 
	acourbot@nvidia.com, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 26, 2026 at 03:10:55PM +0200, Beata Michalska wrote:
> +/// Result type returned by runtime PM callbacks.
> +pub type PMCallbackResult<T> = Result<Option<T>, (Option<T>, Error)>;

So I think my number one feedback is that it would be really nice to get
rid of this Option.

> +/// Runtime PM data stored within the `struct device_private' during

Should be ` ... ` rather than ' to render correctly in html docs.

Alice
