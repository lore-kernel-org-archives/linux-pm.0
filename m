Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601B40BCDB;
	Wed, 12 Aug 2026 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527026; cv=none; b=s+kv6s/nS4si5oP8mR1qwgIRMZxHu/Uta4Cv0dzH+17w59xgNEi5Let/35QcF2dMcqoF398Vk9hHk9YGuuvTBUo8LXGlbiIhMsDb6FhEuDd8w1DVXssG6CmBUsngyjaKAwzZvPulIQoNPaYmUze3oUIZz1GClUhoAy3/zXMbJcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527026; c=relaxed/simple;
	bh=+4yLLm465CQUUIekz9W1YpdGLDkOgHuG8GlHa768BMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owt7uPgt0qcWIgXI0ZqxBINHSgnP0KI6xYCOPAr4TM/wx7WqfnTF4hxpYdEHLVbSojk/gWLGYaKZBFSQzXKcnw4lZ9BAyNqKEdPfVemh6mMufMAEh/ecKwLOGiobeW2OahdBO6KS0XrGIxbYufkuv5Flz3YUeY0fnztgu/MSmSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/7J9amq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/7J9amq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786527024; x=1818063024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+4yLLm465CQUUIekz9W1YpdGLDkOgHuG8GlHa768BMM=;
  b=K/7J9amqSU5/xcNrF85/EqzAmMuWsbtYQgX81IGj6QGX44xE2YyhLwwc
   wjXQSUJBnfK7W/g+h1bGI+00lQj5WH8JGvp8eVClRN+jT0Lglm+9kJgm0
   KWnc9XR72qbMIbmP4NVhl5mFt0ujW/mnH0kreXG3eqO1oyGyw3iaziZAZ
   Q3jfwv3DJftY0jVq5ldjLeEr9IwXPwqaID1P/KLN2mp567mRl1mMmqCd9
   aKbBg1rMGB14s2kZBOwMs/RpLnNHNVM5taDUfz/xNjkoM/syz9ldMpPti
   hJwS4CeszJBl9JvA3ABjh5j4+HSr0KA0LcbYHPNqT6Hg1NCcGs/UEo7tt
   Q==;
X-CSE-ConnectionGUID: GP7JgHMESkKGYhuT63d2EA==
X-CSE-MsgGUID: +avhVtV6Qo21HR0jNxse3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97663326"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="97663326"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:30:23 -0700
X-CSE-ConnectionGUID: vbCwM3F/SvSsDKBzekBzWg==
X-CSE-MsgGUID: 3KY20DooSOGDQrIojIhinA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="257394107"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:30:20 -0700
Date: Wed, 12 Aug 2026 12:30:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Matti Vaittinen <matti.vaittinen@linux.dev>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>,
	Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
	Markus Laine <markus.laine@fi.rohmeurope.com>
Subject: Re: [PATCH 2/5] power: supply: bd71828: Fix current direction
Message-ID: <anw9KgvL1Yj-XdZc@ashevche-desk.local>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
 <22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
 <20260812101050.575c9bfb@kemnade.info>
 <anwsIK9ITpcDkZos@ashevche-desk.local>
 <20260812102536.63579b89@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812102536.63579b89@kemnade.info>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 10:25:36AM +0200, Andreas Kemnade wrote:
> On Wed, 12 Aug 2026 11:17:36 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Aug 12, 2026 at 10:10:50AM +0200, Andreas Kemnade wrote:
> > > On Mon, 10 Aug 2026 13:09:07 +0300
> > > Matti Vaittinen <matti.vaittinen@linux.dev> wrote:  

...

> > > That code is complicated. What about a generic 16bit non_2complemented sign
> > > to 2-complemented sign function/macro. Such would have prevented the error
> > > in the first places. So &vals[i] = signbit_to_2complement(be16_to_cpu(tmp_curr), 15) * pwr->curr_factor  
> > 
> > Do you mean existing sign_extend32() from bitops.h?
> > 
> 
> I don't think it does what is needed. Here we have
> 
> 0000 0000 0000 0001 -> 1
> Usually we have
> 
> 1111 1111 1111 1111 -> -1
> 
> but here
> 
> 1000 0000 0000 0001 -> -1

I see, wouldn't this be then as simple as

	sign = $REGVAL & BIT(15 /* sign bit */);
	if (sign)
		$REGVAL = sign - $REGVAL;

> If I do understand things correctly. I not find something useful
> in bitops.h.

-- 
With Best Regards,
Andy Shevchenko


