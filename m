Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B886332ED6;
	Sun, 23 Aug 2026 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787502733; cv=pass; b=obiQFRjDECQTE/8F1eA/lPVrQNbdcw1AcMn5U5jciP8a16tSG2kYmkJl2p0pR/BpLn7lZ/rgK0clXKsgM8OrovVKeJ5pg5NJlriDeLTUzaouq5H1iZOwoGC6a4S9/sgBPByIeV1twQE9a+abdmFIEZPsZgZikYUykd25r+/csSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787502733; c=relaxed/simple;
	bh=5dN1ImORKqAUgZTovNpT9cUgG37m8afF+78fxaTm3Eo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=TA7JpU3jbg3nTZ4EHGXjGdu3u6wlsfU4SLCLp7TEoPlxgC5TMvCOcMOld4ShZARpWiXsdRIzEkgXvBg88rmHaIdFVJAbTUCdKuRhcp8OzsYlYG+ENmBln1FzGdmHuIPPjH1scbSi9botBrZ397F3Wldy7P8QeyXX9pGomViO9Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=CvTvSS+8; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=rTObEa7l; arc=pass smtp.client-ip=185.56.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="CvTvSS+8";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="rTObEa7l"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-80d2.prod.antispam.mailspamprotection.com; s=arckey; t=1787502729;
	 b=5YE5WMoAL1huYR9erafbDpkj3I37tqEx5vV3oF5DFLQzCitPuYJGbhIkhN/Viws7/+zwXdsqj6
	  ENfzVoG4Kfe0ywypBEjN1lE4DpfjhYgmg4uhwasjRdgi4F6mhGP7I/x7+X/rKsp1IXaaod4cw4
	  oGx18x80DLWmVDMYPUTWzmjDM1caEh//gIdHAF7T0DMQnFkM32LCZi1huPDR5tW7JTjVVb90Aq
	  buzzMrLh6d5Cgt+4tN3fjRUHHQiHjHDDesrJ1vRaT5ba0BRZv+lcKUO6AAMMUgttgXyq1GOKTP
	  HoqUTB+q8y5xcEBf6KGxCaktlIFm1xAy2Fw2BntcI+Okxw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-80d2.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-80d2.prod.antispam.mailspamprotection.com; s=arckey; t=1787502729;
	bh=5dN1ImORKqAUgZTovNpT9cUgG37m8afF+78fxaTm3Eo=;
	h=Message-ID:Date:References:In-Reply-To:Cc:To:From:Subject:
	  Content-Transfer-Encoding:Content-Type:MIME-Version:DKIM-Signature:
	  DKIM-Signature;
	b=Z3xesdG4reZZpGb2ho1SA0dinaxTvfAvC8fnsWdlNyiQytl3Oik81YJbdI3jBNvM++Jry/moTs
	  uHo4S2bIUCME3G+E56d2LNODsJCd6Dc7ISuigsCced/ssAiV2yFJw4s91oFOU+3eM8jpOsnxU1
	  cpyzbdNrv4bM5PwlIYXWA3P34w2nAhVc7sp720DZmK0SkaXlUpm+RWW+vAyC+xpRuE5tDV/7yP
	  Lz3MkiuHgHaVK+ZqWDMrfm7rTuG4VB4dEM6OkQRs2dR1DyLKmeGEP1iBud0VWvNs+tiezR/0YK
	  qFd1oPOwLGMwKUMk4QGqgUXsZE0stcm7rm1p7SUx89BgoA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Message-Id:Date:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:List-Unsubscribe;
	bh=l5zxUfEJrziejSOin0jHlVkLHq8RGIm7aPdntTfjl/I=; b=CvTvSS+82uU1OwRmhjkkwq3M+x
	GwsputQ1zuyAujWmqSyC42czCz3Aeb02kJVpNYAzlakb5rj9ZY4S+vnX3bMCyJYOKVTJKbK7d0ktG
	UlscJHrZyuW8RUubgmhIh15bQ4ubLNvljx41XzeJV3eG+quj8BwBABCJVM7HgZuEXADk=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-80d2.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1wyA7i-0000000Fj1O-1OVl;
	Sun, 23 Aug 2026 15:28:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Cc:To:From:Subject:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=l5zxUfEJrziejSOin0jHlVkLHq8RGIm7aPdntTfjl/I=; b=rTObEa7lGbkYRGKYn0rY87UTd1
	gA2vJE/Hb7gJkVPa2mzJFtFag6KY5Qll+GEGLMkBFyztCon720qj98HlBlmQiZn/BIZC5lthJdElW
	ymlkNPP0h/Rc2WOcbXAXXTJgSl6EginRRKN5N2I+URW8OY7cLvZ9aNPJiI0cFaMTElFI=;
Received: from [87.5.139.196] (port=62816 helo=[192.168.178.158])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1wyA7P-000000002aX-0APe;
	Sun, 23 Aug 2026 15:28:19 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v12 5/6] power: reset: Introduce PSCR Recording
 Framework for Non-Volatile Storage
From: Francesco Valla <francesco@valla.it>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de, 
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 linux-pm@vger.kernel.org, =?utf-8?q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
 Guenter Roeck <groeck@chromium.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 Faruque Ansari <faruque.ansari@oss.qualcomm.com>, 
 Francesco Valla <francesco@valla.it>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 chrome-platform@lists.linux.dev
In-Reply-To: <20260731095959.296056-6-o.rempel@pengutronix.de>
References: <20260731095959.296056-1-o.rempel@pengutronix.de>
 <20260731095959.296056-6-o.rempel@pengutronix.de>
Date: Sun, 23 Aug 2026 17:28:11 +0200
Message-Id: <178749889134.204450.5740187753642158305.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4292; i=francesco@valla.it;
 h=from:subject:message-id; bh=5dN1ImORKqAUgZTovNpT9cUgG37m8afF+78fxaTm3Eo=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFndgpPWLG16UNq2dm/6s0eixbNe7vJcYad79e3Wlqe2T
 PvvP75X3FHKwiDGxSArpsgSsu7GvT1zzb+lbWB8BDOHlQlkCAMXpwBMRDiVkeHo3LXqPJL9Rhn+
 tz0sHs4ok8l8ozE9TC4mttw5+Gj5umBGhoXX5A7PeSa79NzfOX06QpbLj9t3RE+KPmLVFJ0S5Jj
 +hAUA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 9a1066689d24ec207e1d349dfdbcb88c
X-AntiAbuse: ID - 9a1066689d24ec207e1d349dfdbcb88c
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wyA7i-0000000Fj1O-1OVl-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-80d2.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Oleksij,

sorry for the late reply. I was wondering about this series some time
ago and it was a nice surprise to find a new revision in my inbox.

> Introduce the Power State Change Reasons Recording (PSCRR) framework: a
> generic mechanism to record why the last power state change (shutdown or
> reboot) happened - under-voltage, thermal, watchdog, software-triggered,
> etc. - so a postmortem reason survives a reboot or an abrupt power loss.
> 
> PSCRR is built around providers. A provider is either a hardware reason
> source (a PMIC, SoC reset controller or watchdog exposing a reset cause)
> or a recorder that persists the reason across a power cycle (an NVMEM or
> RTC scratch cell). Each provider gets a directory under
> /sys/kernel/pscrr/providerN/ exposing its name, backing device, the set
> of observed reasons (as tokens), its capabilities, the reasons it
> supports and - for recorders - a record policy. The reason set is
> deliberately not collapsed to a single winning cause, since resets are
> often multi-causal.
> 
> Reasons are the numeric enum psc_reason values from reboot.h, shared with
> the POWER_ON_REASON_* vocabulary, so they store compactly in small
> battery-backed cells. The current reason (get/set_psc_reason(), set by
> the thermal/regulator/hw_protection paths) is written to every recorder
> from the reboot notifier.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>

[...]

> +/*----------------------------------------------------------------------*/
> +/* Provider registration */
> +/*----------------------------------------------------------------------*/
> +
> +/**
> + * pscrr_provider_register - register a power state change reason provider
> + * @p: caller-owned provider description
> + *
> + * Creates /sys/kernel/pscrr/providerN/ with "name" and "reason" attributes
> + * and, when @p->dev is set, a "device" symlink. @p->reason is writable when
> + * @p provides write_reason(). The provider must outlive the matching
> + * pscrr_provider_unregister() call.
> + *
> + * Return: 0 on success or a negative errno.
> + */
> +int pscrr_provider_register(struct pscrr_provider *p)
> +{
> +	struct pscrr_provider_dir *dir;
> +	int ret;
> +
> +	if (!p || !p->name || !p->ops || !p->ops->read_reasons)
> +		return -EINVAL;
> +
> +	dir = kzalloc_obj(*dir);
> +	if (!dir)
> +		return -ENOMEM;
> +
> +	dir->provider = p;
> +	dir->policy = PSCRR_RECORD_FIRST;
> +
> +	scoped_guard(mutex, &pscrr_lock) {
> +		if (!pscrr_root) {
> +			kfree(dir);
> +			return -ENODEV;
> +		}

Since the existence of pscrr_root is not protected by the lock, consider
to move this check before the allocation. 

> +
> +		dir->id = ida_alloc(&pscrr_ida, GFP_KERNEL);
> +		if (dir->id < 0) {
> +			ret = dir->id;
> +			kfree(dir);
> +			return ret;
> +		}
> +

Given that ida_alloc() should be safe to call without locking, couldn't
the scoped_guard be limited to the list operation below? Or, if the
goal is to protect against sysfs access during a provider registration,
right before the call to sysfs_create_link()?

> +		ret = kobject_init_and_add(&dir->kobj, &pscrr_dir_ktype,
> +					   pscrr_root, "provider%d", dir->id);
> +		if (ret) {
> +			/*
> +			 * kobject_init_and_add() failed: per its contract only
> +			 * kobject_put() may follow, no kobject_del(). The
> +			 * kobject is not in sysfs, so this is safe under the
> +			 * lock.
> +			 */
> +			ida_free(&pscrr_ida, dir->id);
> +			kobject_put(&dir->kobj);
> +			return ret;
> +		}
> +
> +		if (p->dev) {
> +			ret = sysfs_create_link(&dir->kobj, &p->dev->kobj,
> +						"device");
> +			if (ret)
> +				break;
> +		}
> +
> +		list_add_tail(&dir->node, &pscrr_dirs);
> +		return 0;
> +	}
> +
> +	/*
> +	 * sysfs_create_link() failed after the directory was created: tear it
> +	 * down outside pscrr_lock (kobject_del() drains sysfs stores that take
> +	 * the lock) and release the id only once the directory is gone.
> +	 */
> +	kobject_del(&dir->kobj);
> +	ida_free(&pscrr_ida, dir->id);
> +	kobject_put(&dir->kobj);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pscrr_provider_register);
> +

Regards,

Francesco

-- 
Francesco Valla <francesco@valla.it>
