Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71985325485;
	Thu, 26 Mar 2026 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550142; cv=none; b=LcWwBI1H7SefGX678yqyCSUtMKjj4/0oMzAH4AMV1UqkBEJntRddNodAbfndH8Fw/zKmDk/7Z450nTPQOpNRmr0LOEHBFn540O4U6EDSHGuP7/YK0FoBSC9RcYbRWZgQTgkIDiY6IVzO3opTTymv7nvhmDjMtkTHHoeONDwKYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550142; c=relaxed/simple;
	bh=vHha5uSPppJRH9Cr5SjpZFkwBe67YHMFD0UZ/nXKkrg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=W9lM6dG/r8rT/2cgakrJSodiQ1+zUqxwhNn7J9MGwxuWVf29nIDdBzgMz61xDC+PTI9W9rsOB1QvgktQt3I+Iho4b6liVxPLsZ+rVWBtd8XdXPAUzYxYaJuK2NGqgr8olUUJJ+HeYsumRdtN8BZQMwbx0hwXiiBQNZC9YheLla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BoIzKYjp; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BoIzKYjp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kozB2guDU85YZS51UheWIQ7xwVQInVRSv73o8iTZSqw=; b=BoIzKYjpHU7flZXUAWdty26Dmo
	fpYGiOJQh/YevXkpshqCeBnpfYuAA8cXghcJAP0WWMVijVWC5p5LJIfnT7s4DXymmFysHMYPNz/Lg
	pcfdZSjxCjawzed6tdOSnTiCtAsgTv50K04ujSJrzP8Nr0aHSmvvQG22PtElkP6At4qIAGgKwnq9e
	IWLUquVgdSHgHG4ynqa3cGgqfu/DjAG+MzD0EptEAzWhbiEhtgCWVmoVTyPlFQlFW2U3a+/BBze3v
	GJGwW0YKMAPv0nFgEqEU7iNMVE9cWejGvv3RJ37JHGaaDyWmx1utctFuK96a750Y00k+HRWSvDkkX
	OHKdvu4Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w5pYM-006Yz5-1h; Thu, 26 Mar 2026 19:35:34 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1w5pYJ-009RZ4-Uq; Thu, 26 Mar 2026 19:35:33 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1w5pYJ-00B1we-1Y;
	Thu, 26 Mar 2026 19:35:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Mar 2026 15:35:31 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v1] thermal: core: Address thermal zone removal races with
 resume
In-Reply-To: <12876512.O9o76ZdvQC@rafael.j.wysocki>
References: <12876512.O9o76ZdvQC@rafael.j.wysocki>
Message-ID: <4f1186a042ed78f06d8f2ce1eb6f3ce3@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-4.4, Tests=ALL_TRUSTED=-3,AWL=-2.900,BAYES_60=1.5
X-Spam-Score: -43
X-Spam-Bar: ----

On 2026-03-26 08:45, Rafael J. Wysocki wrote:
> Address the first failing scenario by ensuring that no thermal work
> items will be running when thermal_pm_notify_complete() is called.
> For this purpose, first move the cancel_delayed_work() call from
> thermal_zone_pm_complete() to thermal_zone_pm_prepare() to prevent
> new work from entering the workqueue going forward.  Next, switch
> over to using a dedicated workqueue for thermal events and update
> the code in thermal_pm_notify() to flush that workqueue after
> thermal_pm_notify_prepare() has returned which will take care of
> all leftover thermal work already on the workqueue (that leftover
> work would do nothing useful anyway because all of the thermal zones
> have been flagged as suspended).

Thanks for coming up with this alternative. I spent some time earlier
today thinking of corner cases in that it might fail, and it held OK.

However, slightly unrelated: apparently, flushing the workqueue in
thermal_pm_notify() reintroduces the issue addressed by the Fixes:
commit, but moving it from PM_POST_* to PM_*_PREPARE?

IIIUC, that issue is __thermal_zone_device_update() might take long
thus block other thermal zones and other PM notifiers after thermal.

Apparently, at least the latter also applies to PM_*_PREPARE?

Say, a currently running work item (i.e., that cancel_delayed_work() 
cannot cancel) wins the race for tz->lock and doesn't see tz->state
TZ_STATE_FLAG_SUSPENDED set, so it runs, and say it might take long.

Now, the workqueue flush blocks on it, also taking long, which thus
blocks other PM notifiers.
 
> The second failing scenario is addressed by adding a tz->state check
> to thermal_zone_device_resume() to prevent it from reinitializing
> the poll_queue delayed work if the thermal zone is going away.

This also held OK in the thinking of corner cases.

Thanks,

-- 
Mauricio
