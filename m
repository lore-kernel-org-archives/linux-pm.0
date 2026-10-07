Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70152AE78;
	Wed,  7 Oct 2026 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383518; cv=none; b=IoPLHX2aei4ubjiyGrHOUcJOSnLstzugMPqFRiRj+muiyoA1hSQvspPvO3HIgf/3/NjvMIDtDdEiZrIry0yiZ6JS9wLz6n6VdD3xGDlH9RXGdB75G95EJ0u0aTvEPmTX9RSdJGFpFOtsofEJhJpKMnvhJHulq/dU/cdOx+duD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383518; c=relaxed/simple;
	bh=1enczDP2Vii+9J2hvQ972QNPLmjHOLw2quo0KO6oXQ0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhwMni5SailA0/nH8JixBTNtX1/EuweuqWPX4PrJZct7ijF7o94SShF18oLo5cBeamr2WXSVBjZj5bXkYs+6qyh/wQurb+TmAXG4K/cHbk11F/NBO8z5qVE1tYtaaueUvaRFE2DrvwuxWOLecpa1JSXIh7xbaA+658iyKKa5tvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wg0K2/9J; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wg0K2/9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:Message-ID:From:To:Subject:MIME-Version:
	Content-Type; bh=1enczDP2Vii+9J2hvQ972QNPLmjHOLw2quo0KO6oXQ0=;
	b=Wg0K2/9JJwwQ/AbbtyZy1jxBVZDhtmWR4BxwGIYFKngQhgegAdov8tIyIXn7Pu
	pYFMjV2IR3DLtjlBoMRrNLg0cBmIhXQrTfasXl2wcdOAOwkzPkSreVnhdoam8230
	uMOOJfheS6uh9xRRxvnLRB5oUeX/H7lMzgljarRY6mpYw=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHjEOBV8ZqVg84DQ--.4531S2;
	Wed, 07 Oct 2026 22:30:26 +0800 (CST)
Date: Wed, 07 Oct 2026 23:30:13 +0900
Message-ID: <179138341312.2968831.4961276880957777576.schedutil-helper-reply@163.com>
From: Hui Su <sh_def@163.com>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: Serialize start against rate limit updates
In-Reply-To: <c2d93d95-e623-4910-8d92-b3e16738703c@oss.qualcomm.com>
References: <20260929103635.3780346-1-sh_def@163.com>
	<c2d93d95-e623-4910-8d92-b3e16738703c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCHjEOBV8ZqVg84DQ--.4531S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOsjjDUUUU
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6QJCoWrGV4JNoQAA3d

> Nit: Better to wrap this in a helper, e.g.gov_attr_set_lock().

Agreed, I'll wrap the governor attribute set locking in helpers and
send v2 shortly. Thanks for the review!

Hui

