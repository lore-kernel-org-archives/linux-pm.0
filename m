Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040157;
	b=dRiS1SXhSpffbeffAUTHSnqOdJfq0d/5XKnwxWRkaVNkILa2rUlueEo3U/fINymj9ZqJ
	 70OeaJGkCSmFZ69Aqyf4qbvxkz/tdP1AGd4Xkc7EFa4ibS92oj7whxi/88ZaPt7QvCVgJ
	 jMJBhBGDmc8ZJ2Wug5KLHmshWwnBpOW80/0CIeiCl1LXDC86NAP0ckF729qtTE8tkvaCe
	 tEvyMly/PjDWj3bf4A6YS/V23PEPyiVlman9BeCuNVHCjrO0WGSsO+9SQ5wo0C588X7sn
	 O3Ng+sQ1TR30vljjN5M4VpmxQ2+LHcRQxElYgNIclJikYTwOlWUGLknCLlR7hYxIKAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040157;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jHGQKwi3HPZqZ9VMWi33DPF8ighBiHYISSnr6zwG9Ks=;
	b=aSVqFlv+cFLk+ZmHOMpI60V0D+sTxpNVxiWvsqrjQParX8/qafbqrcwcxdWBNNQAdbrx
	 1nNjHLX5U/KfSZUKhieGNRAN9fmKUHh4UsHzC+WflLzYoOpSQWUXhbd70h/ZGLto2ELfX
	 S95ru00Y3V6B0dFm9+mQfMpiFlmTVUeJy8+UtJLOka0Sz5nVugxnJpMMVfVbsmeg3/D6k
	 aLSfTqaL1mKURt0VurQb0Fdqpt6AtEnwBiRazUMOGg8MDDkKyU+RYTm/sesrCxONL69Pr
	 oZAi7+H3Kx3xXnEDi7lartwTtI5U0/cSdx6JbtSYf/3MumZHkAWFN/ozHD9LSUXLNIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MPDbHy+5;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F75606A31D;
	Mon, 26 Oct 2026 18:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1F75606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MPDbHy+5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793040157; x=1824576157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pxkiu2dpipdFnT+u2/AE1L8SMSKwkt5e3B1Dige/WPs=;
  b=MPDbHy+5cL9da7ZKt8tlTaiCd+WBbkP080itWj89uQg+xizcnYssCrVa
   IV8F+McIyokaotHn3NVDB2H/M/8oMFFu0OHMcdAAQxbqY/T7kaefq8nmB
   ZRHlb5/XZ7YYnoEbOm07BUS3gXvtQYumewxbMgD8RmPgviCX5IboGH5fM
   hnjoBsBWHLyaHgnuSCXOGk+65xeVM2vidIdZr2zMKgB0beDs/okoOtMbL
   fl6TZtmZ9Oh+62WmK50Y6xUqomv5ES2WkLS3UShipwj6If/4Lk5iE61Hf
   yYTcMML+6psiaW57ZC3K/E6TxexeD/GAZTl8pQqnKWWjTzoUlSgItkZrt
   A==;
X-CSE-ConnectionGUID: zepA9MyYQeiCD2XU/U60sA==
X-CSE-MsgGUID: WOLvbHtsT7yzXr/EMl0MvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731416"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731416"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:42:36 -0700
X-CSE-ConnectionGUID: 7nm3nCWrREmdXpwFKMm4aQ==
X-CSE-MsgGUID: yimnzbkvTE6NQb400VmwsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4321598"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:42:33 -0700
Date: Mon, 26 Oct 2026 20:42:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/17] iio: light: tsl2583: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <at-fF6u6Oqq-CHbW@ashevche-desk.local>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <20261021165858.v2.16.Ic3775fd68cac415d959c0456c4d4c36e9e5b95e5@changeid>
 <20261026005504.7482bf26@jic23-hlaptop>
 <at-U7LvkoiNAJ6YM@google.com>
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
In-Reply-To: <at-U7LvkoiNAJ6YM@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 10:59:08AM -0700, Brian Norris wrote:
> On Mon, Oct 26, 2026 at 12:55:04AM +0000, Jonathan Cameron wrote:
> > Note I'm putting these on my testing branch which I'll rebase
> > after rc1 is out and then they should show up in linux-next.
> 
> Thanks. I can't seem to find them on any 'testing' branch [1]. Just FYI,
> in case you were intending to publish the intermediate result. If that's
> intentionally a local branch, that's fine -- I'll check back in later.
> 
> I also see you're trying to partially rework/expand/add to some of them.
> I'll try to review those, based on my local combination of my patches an
> your patches.
> 
> Regards,
> Brian
> 
> [1] In any of these:
> 
> $ git ls-remote -b git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git | grep testing | wc -l
> 9

Yet another "useless use of grep" ;)

$ git ls-remote -b git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git \*testing* | wc -l

-- 
With Best Regards,
Andy Shevchenko


