Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7E41BA9D;
	Sat, 15 Aug 2026 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786808608; cv=none; b=klZLmL9OAtxliXW3VWbETrMw3/44RpMX95ytj7apUjZT38NEtvkoCzqyh6afdI/NGYPRRGVX+qgwkWV6LGUEuA/8LshZSO5cVHFOM2svsRC2E5RuRpR658Eq3iTclrt4mHefuCcSt2ldhGLNgDj5IYPmyPcACmHy3/C2045sF2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786808608; c=relaxed/simple;
	bh=S1OYDoEQGB0Zpl6o1DKqXLT/9Cosg1HMfo+jXESlQ7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnm+jHLArOu4XdXXctYjK50DK2wI1O7ZOoXzOwGf7TplWgIU0vvS9f3F3Py4IxIe+0lLc41ITrkfP94OCQxDLWAJcX7nvai0ubFtdAqdaS1SDWck7Ln0GpTMRE15DDyvFpGyza3e82TdFooFd0tXYCrvXIIz1r1/s5xEJV/JxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 90D85C28;
	Sat, 15 Aug 2026 17:43:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5E9B161AD955; Sat, 15 Aug 2026 17:43:22 +0200 (CEST)
Date: Sat, 15 Aug 2026 17:43:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Andre Eikmeyer <dev@deq.rocks>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH] ACPI: x86: Apple T2 systems need early CPU offlining
Message-ID: <aoCJGj8HixmJ9oaZ@wunner.de>
References: <20260812120326.155226-1-dev@deq.rocks>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812120326.155226-1-dev@deq.rocks>

[cc += Chen Yu, start of thread is here:
https://lore.kernel.org/all/20260812120326.155226-1-dev@deq.rocks/
]

On Wed, Aug 12, 2026 at 02:03:26PM +0200, Andre Eikmeyer wrote:
> Linux reports _OSI("Darwin") on x86 Apple systems. On T2 Macs, the
> selected firmware suspend path makes secondary CPU startup during early
> resume take several seconds per CPU.

That's not a T2-specific issue.  It occurs on older Intel Macs as well.

Back in 2018, Chen Yu root-caused it to an invalid MTRR upon resume
from system sleep:

https://lore.kernel.org/all/20180319041843.28218-1-yu.c.chen@intel.com/

I've been using his patch for 8 years to reduce resume time on my
MacBookPro9,1.  Unfortunately it was never applied upstream for
reasons unknown.  It probably just slipped through the cracks.

You may want to test if his patch helps on T2 models as well.
I think it's a more generic solution to the problem than the one
you're proposing.

Thanks,

Lukas
