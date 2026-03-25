Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18B3E3149;
	Wed, 25 Mar 2026 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451610; cv=none; b=b7kGBXgUbGWg9/0Rxgp2W0xd7Gk4kyKE16NW79+Azoz5EODdU2xfmxe25aZYuEIBSfURtyZOHBObwDB+nl/sTsA4wNehgolT36ggx7jv+pKUW74RqaS2J+//sfZon3xKMY6lehWPfeTh1PR1MKeNM7kIOZ9nX3MBKjmrFDbNulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451610; c=relaxed/simple;
	bh=MAlbuevEvA1SK7q46a0nAEvQ/jKgXgzc/DPCmBiSFTU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SHmOGw+CfvRn5WKQHxA0voztpnICSWj4VTcIVrJhzs3xt98OGuBVnXy1wYpZ0t/CynLNkNrgx12s/UhB+XCfNn8+L0ZiHtE3XgjNAEHRJfIyncJ+nLyRnpbYXYCDJHJxNrYWNkSHtW4o5ACl6PqN4lcQ2TUyVw/6kyR/NMv/vmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=itQtzgP8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="itQtzgP8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=v2hHjF9Ho4eVXVPMDn877QGxvdBxJ/XB9rHI3ZELASs=; b=itQtzgP8dDYkrhzcdl7cCllX6m
	H+fdEONOxDG4015ZF2iuijL/AzpxabQ4Wb08B8A8OiFmGWzvAtcLXjr/TbwXKfEGBnGf3rPfJ72pb
	t37vR2e/mMpkmEV5dRkcQWk3E+KIZgABB6rMOjmamKu76OwVejvRZJAAQgKw6Pq1wvTLVAaCOP/HS
	hUH9+zvqzLd9t1tpMN8h9rsDW+Izy0fzaQvqCA8cBatDglxjAaGfFCatmN5EOe7oWi4QVyT1oFr+2
	Ox/FenGYQbud8+y0qxMu+t7DBjgeju3YFhMRBp16V+YW05dI7b5Fn82YkCNm5W2gSMzdCxTJT7xrD
	KkUNCBnw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w5Pv3-005tBE-RP; Wed, 25 Mar 2026 16:13:17 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1w5Pv1-007cOm-PM; Wed, 25 Mar 2026 16:13:17 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1w5Pv1-00AiQN-0z;
	Wed, 25 Mar 2026 16:13:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Mar 2026 12:13:15 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Subject: Re: [PATCH] thermal: core: fix use-after-free due to init/cancel
 delayed_work race
In-Reply-To: <52d861b9a215150424ae4d49b4e2c90b@igalia.com>
References: <20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com>
 <CAJZ5v0h8Q-Cs-05hwKUF9wPbOzg2gyG8yH6tOfzJgXQCh5Ohbg@mail.gmail.com>
 <CAJZ5v0iBh6BjtwhS7RK_GE8QmYLAwW71P+YpA92SiGu4wy+syw@mail.gmail.com>
 <772a77c80b6ad216dec4cc10d3fbb133@igalia.com>
 <52d861b9a215150424ae4d49b4e2c90b@igalia.com>
Message-ID: <a61c19043dcf579e46f7d4f124013e60@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-4.1, Tests=ALL_TRUSTED=-3,AWL=-1.893,BAYES_50=0.8
X-Spam-Score: -40
X-Spam-Bar: ----

On 2026-03-25 11:28, Mauricio Faria de Oliveira wrote:
> On 2026-03-25 11:17, Mauricio Faria de Oliveira wrote:
>> Thanks for looking into this.
>> 
>> On 2026-03-25 09:47, Rafael J. Wysocki wrote:
>>> I can see the one between thermal_zone_device_unregister() and
>>> thermal_zone_device_resume(), but that can be addressed by adding a
>>> TZ_STATE_FLAG_EXIT check to the latter AFAICS.
>>
> 
> Please disregard this paragraph; I incorrectly read/wrote _resume()
> as thermal_zone_pm_complete() discussed above. The rest should be
> right. I'll review this and get back shortly.
>
>> In the example describe above and detailed below, apparently that
>> is not sufficient, if I'm not missing anything. See, if _resume()
>> is reached with thermal_list_lock held, thermal_zone_device_exit()
>> is waiting for thermal_list_lock before setting TZ_STATE_FLAG_EXIT,
>> thus a check for it in _resume() would find it clear yet.

Ok, similarly: 

Say, thermal_pm_notify() -> thermal_pm_notify_complete() ->
thermal_zone_pm_complete() 
run before thermal_zone_device_unregister() is called;
thermal_zone_device_resume()
starts, and by now thermal_zone_device_unregister() is called.

If thermal_zone_device_resume() wins the race over thermal_zone_exit()
for guard(thermal_zone(tz) (tz->lock), it sees TZ_STATE_FLAG_EXIT clear;
note its callees (eg, thermal_zone_device_init()) run with tz->lock
held,
so they see it clear as well.

So, thermal_zone_device_init() calls INIT_DELAYED_WORK(), everything
returns, tz->lock is released and the thermal_zone_device_unregister()
-> thermal_zone_exit() path can continue to run.

Only now thermal_zone_exit() sets TZ_STATE_FLAG_EXIT (too late),
returns.
cancel_delayed_work_sync() does not wait for
thermal_zone_device_resume()
due to INIT_DELAYED_WORK() in thermal_zone_device_init(); and kfree(tz).

Then, thermal_zone_device_resume() accesses tz and hits use-after-free.

Hope this clarifies. Please let me know your thoughts. Thanks!

-- 
Mauricio
