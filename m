Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991155;
	b=ibkhvCLEASHQ7uMiNSl3b5ULtZ57/naKrInS5WcPOmmnIEq8Vks8wAY6WV88llDkLV8h
	 zkQzh8p45zBNdfeD8CvRe3u8Cd8aYKBnLhq/gnvpOISpBU85TmEaqn7Dc+X7R3xgjWecc
	 daWY8Z4amtyViaOWLIJ37pJggkxfdY6xvLdlx/+hfbe6hA4weqVcg54BA7boAeND/Q0c3
	 nY3eMs8HSOs0qXzcxc86EcNEMrIJK8MrUqyp1JpWZChVRlIx6o0JamPZoMW4uydpW0FyU
	 XKrB1g1QgcOE2G/Ik6W8ESEF/KhMxuMPPIRflarvAn0kT6l6Z0TCFm1o+1HFVQMi5tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991155;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=93JD4oOl8RigguqAzYS0DanPg4ZmNzSu7c7ItgKEQWw=;
	b=fkggn4cE/qtqsAW7cS7Q7N/dGkkIG44O2Wv/wxeSShLPcQx5GjbjYiGAafuaSu6Hulii
	 DMaL3PhRULLAipWx+89UlTVu4yzkP73A4zCJ8XmS/G3hn0T3HS8jDxV66bXJCA76WbtaQ
	 /gsqPddg2Ao6FNSQbPfTo0SVTjn41eOtVs8sx64fb9fe11b9qLyWsV8KHQ4y7uHjVtVll
	 V7QSLtZAZ95cxjs5L+LGFc2UhO6VpEb+dN5hAIIXpBZmxA8Pf3kIJKDdgoBiS2WTJZmPr
	 YBuwXNTbsx8Zpw6x+qa8IcikwpaJGMc/aWhwLK8o8QV2Q39BlzpFLyOGtk00yPUoK3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IeUyPOXA;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E455606A31C;
	Wed, 18 Nov 2026 08:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E455606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IeUyPOXA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794991156; x=1826527156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GVuehxEYhnaikefPNV5ljoAX+GlBmLt5R6g/hv9W6+o=;
  b=IeUyPOXAR6u0FTTYruGF0h1qMgH6lzTO3iwr5ortIjMUL6T1sRhAsD5+
   jnIZMZ9o8pN3VRH/Rq47W/MW7IwwcOOOlqYKubxkjFxzHFnsJhYCADVhz
   evtPXtCM0ZbY/6v3JPqb5eKStjao2H0ws76NRNNwB856FeaeA3plALzzI
   BiX0ZAuefdkrkvWsrPjkp33Njx0DFEoxK7vhD9Ql6/E+aYMBD6w63iww3
   grlBo/O2kotzu8/jZGxFzhyOrmK6Nb0SJI73YalXB7onwn0stndGjuIDZ
   f87T1lLSFxCQyWN7b0upeuKeh+Ekuf9HakZTDz9hh/g7x1ZdUt4EJi+Hv
   A==;
X-CSE-ConnectionGUID: wI3PixhmR1W6YDqfRxoYmw==
X-CSE-MsgGUID: 9XRF66UYRHG7VJsUEXoCmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3815944"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3815944"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:39:13 -0800
X-CSE-ConnectionGUID: SqGI4Z6rRNalVSS/yeo4pg==
X-CSE-MsgGUID: ISFbWIJcTEKqKk3Lni9sZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10094903"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.183])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:39:11 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5A7A4121B6F;
	Wed, 18 Nov 2026 10:39:08 +0200 (EET)
Date: Wed, 18 Nov 2026 10:39:08 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: Re: [PATCH v1] PM: runtime: Update last_busy before calling
 rpm_suspend() in rpm_idle()
Message-ID: <av1kLCLk9dIzKxQD@kekkonen.localdomain>
References: <4789427.LvFx2qVVIh@rafael.j.wysocki>
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
In-Reply-To: <4789427.LvFx2qVVIh@rafael.j.wysocki>

On Fri, Nov 13, 2026 at 02:27:23PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> When rpm_idle() is about to call rpm_suspend(), there are no reasons
> preventing the device from being suspended, but if the device uses an
> autosuspend delay, it needs to be taken into account.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
