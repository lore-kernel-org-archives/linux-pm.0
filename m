Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984544;
	b=S4u1dCc6WS//MWeXFExagcrkhClzDDmOjIM1dzXBC/DrVhq29YNakDvmDXEz94pvBnnC
	 txVKb8bi6eTAaTFhtpKz+q0jeJGyv0Gr/mcCvHEpUHj/RCqeszdSZx8GSBxQ+7RQR2VAM
	 yNQsqTaoUABQhCmNddRs71L11WVlXZjWq62KNTakEKGnos411QbdIaKmCdWLXz8/4U9ig
	 t0jmSOj0zhLj9JyH/meYLhA4BKO7VMknDN89rmYKjDfJj4C4mMOBxfeDsvscYnzfnlHFC
	 LaoXC6O2puoFiD9coTgfXit0y20ZA3OICi7w8WevcHGoY55x+XVpSITEFo9AsJzZ9mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984544;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=SBwPD+7yUoBJrcRIsaXVc/j48GadrJcUMRQdNzAX8Z4=;
	b=Vuhr7T75HX3emC43de9MYMY0qG6yuiVysA4f2iUdEhUoRaqFr/jX/PWSQPvd/MzY9N5i
	 TJyKNvXM40fcsdY/PCrXKAnRQFqGBGFeQjGjn3bcRwcLJTHOsglRu7viupbjsL63A2I5/
	 ExmQUiGWDWWPtrHYvsQG2I/WzdfY0vSEfIw65/enXePjdhk4exkB5JXHYzCZ14/RtrstE
	 BhcCJAhWXUZvOH/b4ZyvLYDuQ2t2Y7Joqr2Qj52UaS0BOkC9euP3LuUaYHjwt5CK+XTif
	 FSeVTFGlBHAUTbv+T0+69ZPfSYECeQHPhDAYBXHp7V1ZwM5NL9RN2pCro4iq7LTrquA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PvX8YdIO;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FBA606A336;
	Fri,  6 Nov 2026 17:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33FBA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PvX8YdIO
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6586B15A1;
	Fri,  6 Nov 2026 09:02:19 -0800 (PST)
Received: from [10.57.68.162] (unknown [10.57.68.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA28A3F673;
	Fri,  6 Nov 2026 09:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793984542; bh=57Fdpgw2gt5HD38VZ7LEbtA/6ymscQgr5sSFQplAwwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PvX8YdIO6iZLf0LEGEH0s6nXvrXckaz4Qip3Hv9nCkT7YS3lmK778FthDgPIauewF
	 WbEiFMPpBynPwNeEYTbTTfe4Hn6li3lvQomvAabB5nOYpNp4qB9BByOIpID3tNp4u5
	 69xH6YF4obfxL2tTimECHfM77wYdyF6TFV/XD5wY=
Message-ID: <811812a3-1148-4a06-b660-715aea25376a@arm.com>
Date: Fri, 6 Nov 2026 17:02:18 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] cpufreq: Fix issues related to cached resolved
 frequency and index
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Vincent Donnefort <vincent.donnefort@arm.com>
References: <5176274.31r3eYUQgx@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <5176274.31r3eYUQgx@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 14:59, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series addresses two issues related to the caching of the
> resolved frequency and index in __resolve_freq().
> 
> The first one is that the cached resolved frequency value should be
> the post-resolution one, not the pre-resolution one (which is the
> case now).  Patch [1/2] fixes this.
> 
> The other issue is that __resolve_freq() is now called in multiple
> places, some of which may race with the cached frequency and index
> updates in the schedutil governor path and that may cause the cached
> values to become invalid.  This is fixed by patch [2/2].
> 
> Please see the individual patch changelogs for details.
> 
> Thanks!
> 
> 
> 

Tested-by: Christian Loehle <christian.loehle@arm.com>
