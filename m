Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984F2BEC55;
	Wed, 13 May 2026 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653980; cv=none; b=bB/SwhWNzU+sYkeyfH/EpqUwWRuUwlxPQqmkqFSEUTcuFZ+QYfM4elniL3affB3iNIquciwWKy1hlL6ICuIy+mw3EYfNSVLQZ3IUzPnEjbI+eFi7XtrfU2PYym1q41JdXrx2el6Amkrem544cPsmKHBUQ2OcKrg1YmZeACEQh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653980; c=relaxed/simple;
	bh=07Qgn89ErG2GzIr75mP7BvjV3SrEQGTuF7ev2g8smFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8cF+sfJ8YTdVJ+ox3R4mEut79pUNno7oQ/2ZR7Nri7pKOIpY32mKYj5D9B1Lbv5SI0Vc+qOEEEOTjcKeO+RseQco5sW6dbQej2vzixmdr4dze+QhqZfZQk9aNQWvp/KVw34Yc0IRStzyS/IPKJDzWUsQorv5/pne77T2TupWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn8terCI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn8terCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786B5C2BCC6;
	Wed, 13 May 2026 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778653980;
	bh=07Qgn89ErG2GzIr75mP7BvjV3SrEQGTuF7ev2g8smFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pn8terCIqY55wZVBpkXI91LQF27aL7N/uwWBlTyz/NokVHO3JT56UjBqVZ3PUbVAC
	 ijUW4wCD2LIgFiYk7+4fJxX+KU7RyiRT5BcTAnGDxbCs9Xp7j1Ko67a6qDqlPpGrEB
	 Hg2CsWqy9iBC0F1LGkHJl/Z+PdzZOsy9jchaMzhmQ4pqGlh32RsZIWM7o/NA+V9nhX
	 TvBEUdGS+qBFSzpelDPhuvUj+EPSLTfs9P2q7U6cbLuL2MWWSCv9KZI/Kwr8tlYNC3
	 3yuSjWcGxk9odveEQk1mHvA2qyxetzJhmtdTZl78TzyEmBbsCEp8q6iUJZGLVRRYfH
	 2Xd+kHZnu94BQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wN39N-00000004H1o-355Z;
	Wed, 13 May 2026 08:32:57 +0200
Date: Wed, 13 May 2026 08:32:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: Re: [PATCH v2] power: supply: max17042: fix OF node reference
 imbalance
Message-ID: <agQbGQTlkIFz0GbM@hovoldconsulting.com>
References: <20260407123338.2677375-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407123338.2677375-1-johan@kernel.org>

Hi Sebastian,

On Tue, Apr 07, 2026 at 02:33:38PM +0200, Johan Hovold wrote:
> The driver reuses the OF node of the parent multi-function device but
> fails to take another reference to balance the one dropped by the
> platform bus code when unbinding the MFD and deregistering the child
> devices.
> 
> Fix this by using the intended helper for reusing OF nodes.
> 
> Fixes: 0cd4f1f77ad4 ("power: supply: max17042: add platform driver variant")
> Cc: stable@vger.kernel.org	# 6.14
> Cc: Dzmitry Sankouski <dsankouski@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> 
> Changes in v2:
>  - add missing driver name to patch summary prefix

Can this one be picked up now?

Johan
