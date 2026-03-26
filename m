Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC3334C08;
	Thu, 26 Mar 2026 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547128; cv=none; b=qKiJkMtrUEtcLf5vIHEiczlNBNBBixJRVe11RRCMlQU5CL7suEhjSwFux85/5HkF6e8IvLLBKpqI50+NECj9OkAIRQG8QvwvhZ/LCL2303Pdj2qRlaMDOsFgfsf4ghl17NSsGV4t6v6EcyplqSiL283yoTuCCLD3ZHMrozxMMDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547128; c=relaxed/simple;
	bh=oqWLkmV/yGDH5O8I4Bs6KpB4EyHg9yCZjQR5yenFYJc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gT71S5ZfnUpMQHwVSaGHOvfoBKqVp9Sp5jLSfr6KuoakWEUQ03fOjAOCZl3aw1urfxKV7y0yaI02UVGkrBOEtdtK5h91g/fUlk6FJ7ZIPL2COkHqzlz165cARZkvQ6KcCJ7Pn06tVwJE3c1/0DMxN1VNU84WeXLPeBDJAUPehD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=a7AnQ7Yw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="a7AnQ7Yw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=m1rhDkDvWCv/0ftYJtXYXefQESlFNBTLvV0PMJtbKdE=; b=a7AnQ7YwhlCGA8gvtbrt5FFHps
	xVYOdoD7cldOWVyvGCaGS7BTCV+V/2Q8R1Qgo9Jk+rJrzt6Dz8tJ4TaWSqt0S201eBU5tJ8Rj/A5+
	VvGRmWnLXcQiVWVrQarzYhhuvi9gb4m9mV0155J/m6SmMaaHIRsPd9x5iKllvm4ZPGtyvU5XIPSAu
	D3vn29DvzGxFWtGpu//TP8W3TU4x//+e4Kwzu1JqVpPtmZrh2fM7Z0EguFP5KLCN+Vol+1pzBFMJj
	sa6OSxTFMn9vHwxFTXLYqu2f61DzjFbYp2xMeiIUGE0B+eYRLfVlnFQGm/bR0wCx0sfAMte3F/jCi
	YuFDFOxg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w5oli-006Tk9-4Q; Thu, 26 Mar 2026 18:45:18 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1w5olf-009N3C-Vb; Thu, 26 Mar 2026 18:45:17 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1w5olf-00B1Fd-1c;
	Thu, 26 Mar 2026 18:45:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Mar 2026 14:45:15 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Subject: Re: [PATCH] thermal: core: fix use-after-free due to init/cancel
 delayed_work race
In-Reply-To: <CAJZ5v0goUgYXwyR-G_5zu+wTfbCH5B4B0JL1pU9+cdHbKqT-Lw@mail.gmail.com>
References: <20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com>
 <CAJZ5v0h8Q-Cs-05hwKUF9wPbOzg2gyG8yH6tOfzJgXQCh5Ohbg@mail.gmail.com>
 <CAJZ5v0iBh6BjtwhS7RK_GE8QmYLAwW71P+YpA92SiGu4wy+syw@mail.gmail.com>
 <772a77c80b6ad216dec4cc10d3fbb133@igalia.com>
 <52d861b9a215150424ae4d49b4e2c90b@igalia.com>
 <a61c19043dcf579e46f7d4f124013e60@igalia.com>
 <CAJZ5v0goUgYXwyR-G_5zu+wTfbCH5B4B0JL1pU9+cdHbKqT-Lw@mail.gmail.com>
Message-ID: <427a61782249b5f1c0e2c7c186271767@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Report: NO, Score=-4.7, Tests=ALL_TRUSTED=-3,AWL=-2.550,BAYES_50=0.8,URIBL_BLOCKED=0.001
X-Spam-Score: -46
X-Spam-Bar: ----

On 2026-03-25 17:20, Rafael J. Wysocki wrote:
> On Wed, Mar 25, 2026 at 4:13 PM Mauricio Faria de Oliveira
> <mfo@igalia.com> wrote:
>>
>> On 2026-03-25 11:28, Mauricio Faria de Oliveira wrote:
>> > On 2026-03-25 11:17, Mauricio Faria de Oliveira wrote:
>> >> Thanks for looking into this.
>> >>
>> >> On 2026-03-25 09:47, Rafael J. Wysocki wrote:
>> >>> I can see the one between thermal_zone_device_unregister() and
>> >>> thermal_zone_device_resume(), but that can be addressed by adding a
>> >>> TZ_STATE_FLAG_EXIT check to the latter AFAICS.
>> >>
>> >
>> > Please disregard this paragraph; I incorrectly read/wrote _resume()
>> > as thermal_zone_pm_complete() discussed above. The rest should be
>> > right. I'll review this and get back shortly.
>> >
>> >> In the example describe above and detailed below, apparently that
>> >> is not sufficient, if I'm not missing anything. See, if _resume()
>> >> is reached with thermal_list_lock held, thermal_zone_device_exit()
>> >> is waiting for thermal_list_lock before setting TZ_STATE_FLAG_EXIT,
>> >> thus a check for it in _resume() would find it clear yet.
>>
>> Ok, similarly:
>>
>> Say, thermal_pm_notify() -> thermal_pm_notify_complete() ->
>> thermal_zone_pm_complete()
>> run before thermal_zone_device_unregister() is called;
>> thermal_zone_device_resume()
>> starts, and by now thermal_zone_device_unregister() is called.
>>
>> If thermal_zone_device_resume() wins the race over thermal_zone_exit()
>> for guard(thermal_zone(tz) (tz->lock), it sees TZ_STATE_FLAG_EXIT clear;
>> note its callees (eg, thermal_zone_device_init()) run with tz->lock
>> held,
>> so they see it clear as well.
>>
>> So, thermal_zone_device_init() calls INIT_DELAYED_WORK(), everything
>> returns, tz->lock is released and the thermal_zone_device_unregister()
>> -> thermal_zone_exit() path can continue to run.
>>
>> Only now thermal_zone_exit() sets TZ_STATE_FLAG_EXIT (too late),
>> returns.
>> cancel_delayed_work_sync() does not wait for
>> thermal_zone_device_resume()
>> due to INIT_DELAYED_WORK() in thermal_zone_device_init(); and kfree(tz).
> 
> Wait.
> 
> I'm not sure why this matters because the zone lock is dropped at the
> end of thermal_zone_device_resume() at which point it has done
> everything it had to do.  Then, the cancel_delayed_work_sync() in
> thermal_zone_device_unregister() should properly wait for the work
> item queued up by thermal_zone_device_resume().

Oh, indeed, you're right.

>> Then, thermal_zone_device_resume() accesses tz and hits use-after-free.
> 
> Say thermal_zone_device_resume() has lost the race for tz->lock to
> thermal_zone_exit() though.  It runs after the latter and
> reinitializes the delayed work.  Now, thermal_zone_device_unregister()
> continues and cancel_delayed_work_sync() doesn't see the
> thermal_zone_device_resume() running in parallel with it any more, so
> it doesn't wait and if thermal_zone_device_unregister() continues to
> run, it may free tz prematurely.
> 
> I claim that this can be prevented by adding a tz->state check to
> thermal_zone_device_resume() before the reinitialization of the
> delayed work.  Namely, if it loses the race tz->lock to
> thermal_zone_exit(), the new check will trigger and the delayed work
> will not be reinitialized, so the cancel_delayed_work_sync() will wait
> for it to complete.

I see it in this case now, thanks for clarifying.

-- 
Mauricio
