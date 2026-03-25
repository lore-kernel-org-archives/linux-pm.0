Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F76387357;
	Wed, 25 Mar 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448909; cv=none; b=R9QIjwb54Luq9eMBLnJPIWX7YaJaiYdJ0Arp2hZVTvR5Bk+tBbKJWLyWb3nSnoqfuGay4Po5AldkOGzOEncQmi2Tg34NTaAgT6iyc+l8EAa4aQRuWO9vpGwdaL8c/9d4czT9eLyuhUpcmT4eAXG1+UZPWi7xrcoVYNj9SOxKWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448909; c=relaxed/simple;
	bh=IV4cGe7yUxgRfw9GD7kDrHxIAHKFDg6b/FMNTVx3n34=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ldcgdzdhA9LGrkwG3AKYmXs3E2w08Uf9DOVg7bWn1vXasCOCGBhM30p7A7Z/rZKCnJnSK7ELp/7zMyIMR8eP+dJcMKu5Ilvudscq3EyQuxABC1m8JYKv4O0FPvklPMUlKZMx+o85DEncSdB11XRadlEijtF9C6bf1ARAYUpwRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CSnRaQ/q; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CSnRaQ/q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AxZF3U/NGexp0uWwK4TROTQ4PifQKEbXzcKR5S5LnZg=; b=CSnRaQ/q8WrYKmiArHFEfxgdzg
	GwcR8vKCGvoA0PPasHBtMuOvU3ub+njU9168WxpVLGFFFZv+tyhvKwBF6P36kUOo7X96/5D/9FUee
	75dBckXNvKHdRafkCQ4Z0okxPrG1rOA+s0Wajta1LYgkOX4xJ8/+xb45WK02+AndXMRzC9gllnZaU
	s7vGOeDDVOL0w/cWOkprr3l5EdOdoCkrNwW+Vq8TEh62LLQjQz1THbFdlq1QnIyS4DRw66cY4c4dd
	ghSxtqCaTuG1ilE+hRTKNmTgYXKbyZnp6Jv7eiGaSkzdrWS1jvId2cHHRGtfe5LgFY5gnPHcvsJK7
	j1HEHYfQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w5PDW-005s8e-HD; Wed, 25 Mar 2026 15:28:18 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1w5PDU-007ZBK-G2; Wed, 25 Mar 2026 15:28:18 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1w5PDU-00Ahfz-03;
	Wed, 25 Mar 2026 15:28:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Mar 2026 11:28:16 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Subject: Re: [PATCH] thermal: core: fix use-after-free due to init/cancel
 delayed_work race
In-Reply-To: <772a77c80b6ad216dec4cc10d3fbb133@igalia.com>
References: <20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com>
 <CAJZ5v0h8Q-Cs-05hwKUF9wPbOzg2gyG8yH6tOfzJgXQCh5Ohbg@mail.gmail.com>
 <CAJZ5v0iBh6BjtwhS7RK_GE8QmYLAwW71P+YpA92SiGu4wy+syw@mail.gmail.com>
 <772a77c80b6ad216dec4cc10d3fbb133@igalia.com>
Message-ID: <52d861b9a215150424ae4d49b4e2c90b@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-4.1, Tests=ALL_TRUSTED=-3,AWL=-1.874,BAYES_50=0.8
X-Spam-Score: -40
X-Spam-Bar: ----

On 2026-03-25 11:17, Mauricio Faria de Oliveira wrote:
> Thanks for looking into this.
> 
> On 2026-03-25 09:47, Rafael J. Wysocki wrote:
>> I can see the one between thermal_zone_device_unregister() and
>> thermal_zone_device_resume(), but that can be addressed by adding a
>> TZ_STATE_FLAG_EXIT check to the latter AFAICS.
>

Please disregard this paragraph; I incorrectly read/wrote _resume()
as thermal_zone_pm_complete() discussed above. The rest should be
right. I'll review this and get back shortly.

> In the example describe above and detailed below, apparently that
> is not sufficient, if I'm not missing anything. See, if _resume()
> is reached with thermal_list_lock held, thermal_zone_device_exit()
> is waiting for thermal_list_lock before setting TZ_STATE_FLAG_EXIT,
> thus a check for it in _resume() would find it clear yet.


-- 
Mauricio
