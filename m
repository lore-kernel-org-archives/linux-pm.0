Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4625A2A1BF;
	Wed, 12 Aug 2026 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523144; cv=none; b=sS2Xp4ywc7LhP7x2u3HsNQMWKlWGunT7rqWk4OBYBrP0Y/ngs4WLX5+TeXXpZrrQqYX+yFpJfTiRFHH86IhLxESIFkfptt2U8NW/mqbsvCXQTFUbP9QOrRcdo1HjwsLPCZm4cV+EagrVjI+96JGuaDZHUkCQKbBSCNhYy5zW+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523144; c=relaxed/simple;
	bh=tny5Iu/qkEtm2rO2sjUbDrD83srQ1jsdQcevPEJYjm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGVfDhQwQvkBiaHXV9W6qkUGYO9fwoaV0AJD3TO9jBet9qIi1ZruArid5Q2/qhAOjZqHbbU/c23FBa/i/FXTJ8lJ4vw05MoEPxxN0AGy7MSBq8rkmbqFYNX+7IUHam36snWvJc2xa9iWKjLNdtMHk0x3RBOqXu+ka50FOn3am2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=DZgIzqUT; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="DZgIzqUT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=Ae1cHGIkXknetjxACYrkrvOwVg2spMOHzCRg0uEqS5M=; t=1786523143; x=1787732743; 
	b=DZgIzqUT/JVZKFOymTXLndmQibdyDTETHrZsBMff/gQqaCHge2+ymqNmN7vRYTc5o4i2Qec5+zI
	3wslPOIgHzaxz8FBGIbMfqaT/IFV9Ai/M1QFNBMj7OsJtbWXVrYP7cxs8fh7lACbvkmLxbipQ9WVS
	WRM4WNe2yaWe6N6qPtdlJD0+1hRHberB/dY8ABgsqzX20qJjIx8Mdq5gXJ1s1OyHHkdLZfc2Uj3yK
	MY7P4MzDE2yg6t333TrgLaWD0KbgAUQArKAAGOqkknTHSVCvKMYsD+EY0RjYLiCyAFzKXIX0YkOq1
	wrIHS54V4Vo/pmfGDEKqFUp79o2EMcUkTr+w==;
Date: Wed, 12 Aug 2026 10:25:36 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@linux.dev>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kalle Niemi
 <kaleposti@gmail.com>, Topi =?UTF-8?B?U29ua2Fqw6Rydmk=?=
 <sonkajarvi@hotmail.com>, Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
 Markus Laine <markus.laine@fi.rohmeurope.com>
Subject: Re: [PATCH 2/5] power: supply: bd71828: Fix current direction
Message-ID: <20260812102536.63579b89@kemnade.info>
In-Reply-To: <anwsIK9ITpcDkZos@ashevche-desk.local>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
	<22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
	<20260812101050.575c9bfb@kemnade.info>
	<anwsIK9ITpcDkZos@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 11:17:36 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Aug 12, 2026 at 10:10:50AM +0200, Andreas Kemnade wrote:
> > On Mon, 10 Aug 2026 13:09:07 +0300
> > Matti Vaittinen <matti.vaittinen@linux.dev> wrote:  
> 
> ...
> 
> > That code is complicated. What about a generic 16bit non_2complemented sign
> > to 2-complemented sign function/macro. Such would have prevented the error
> > in the first places. So &vals[i] = signbit_to_2complement(be16_to_cpu(tmp_curr), 15) * pwr->curr_factor  
> 
> Do you mean existing sign_extend32() from bitops.h?
> 

I don't think it does what is needed. Here we have

0000 0000 0000 0001 -> 1
Usually we have

1111 1111 1111 1111 -> -1

but here

1000 0000 0000 0001 -> -1

If I do understand things correctly. I not find something useful
in bitops.h.

Regards,
Andreas
