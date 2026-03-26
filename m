Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5382DF707;
	Thu, 26 Mar 2026 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565106; cv=none; b=B2Dtvj0Ex8V5nNkywLHkXGnamHeH9rgcB6a635I2TgwEBV/up7zmpuT9mNUkbEzLYuB9hpe2j6P0Md8oLz8jK176FLI5y21sIu1UutI83Dgb2WTs0f4K7fw6/mNCMV6iLaRTvg5WlULnK0sZ7RU3dNkISWJmipDkWo6jS6gQXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565106; c=relaxed/simple;
	bh=VoRNhyD9naTtB3TuugQkll0lgJBrUNM1tIyMLQNofBY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kkgoJtEi3GrnUxePwAIDOHFFGq9F15p5X0r1kBXQxlAuss89KLJnLmttnRRS/pnk621XLWwYZLJHHPHk30MRMWRmMOUwxpcKllDJQuk7qikf5ObOuxXmA7Yt0PncxzVu+OAmeVS6a/D//SFtC/MFn3QdBug9uwYea0YpiqL0D9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZBZ08oqN; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZBZ08oqN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8Ypkmi4vlellxMlLT0KviA15se13i3AI70w4vi7qa1E=; b=ZBZ08oqNMhoKggflYLnoyHnj4+
	Q6SpHSbocMgWTz25pvQSN//F8rDmyhn6lu/+MYaZ/fFW22V628odmE5JoelLiV49hlCb+cWmvP640
	/qG6y1c63I4Ey3xqh/BTlgFpAIhaA7cbyQRwUrW/TPcMK4u9VQe0EceVBTD3V0X0Y79lPxB2rJIM/
	Q+icH+bxKN5j8aRO7JG1Ln+D1dmU6mtuU7IIbNWRxUrNqzn94P/k1Dvaen5O5FOMEMnLd/9p++72T
	44iE2G0c/c9dB5AFIIjmAFCjfIshpa/LncxwZAgBh388+rPFQuYyWe/ocrEenT9GB6jR5Y4348oT5
	8LhAxbbw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w5tRj-006uEk-NM; Thu, 26 Mar 2026 23:44:59 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1w5tRh-009jCw-Iz; Thu, 26 Mar 2026 23:44:59 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1w5tRh-00B4TH-0N;
	Thu, 26 Mar 2026 23:44:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Mar 2026 19:44:57 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v1] thermal: core: Address thermal zone removal races with
 resume
In-Reply-To: <CAJZ5v0hmkRsz2A0sh4PdEY9V=gLJejWH=kMJH6hR_bh=Q9ZdfA@mail.gmail.com>
References: <12876512.O9o76ZdvQC@rafael.j.wysocki>
 <4f1186a042ed78f06d8f2ce1eb6f3ce3@igalia.com>
 <CAJZ5v0hmkRsz2A0sh4PdEY9V=gLJejWH=kMJH6hR_bh=Q9ZdfA@mail.gmail.com>
Message-ID: <dba615418ad4e1a2944f06860e22d150@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Report: NO, Score=-4.0, Tests=ALL_TRUSTED=-3,AWL=-2.486,BAYES_60=1.5,URIBL_BLOCKED=0.001
X-Spam-Score: -39
X-Spam-Bar: ----

On 2026-03-26 16:03, Rafael J. Wysocki wrote:
> On Thu, Mar 26, 2026 at 7:35 PM Mauricio Faria de Oliveira
> <mfo@igalia.com> wrote:
>>
>> On 2026-03-26 08:45, Rafael J. Wysocki wrote:
>> > Address the first failing scenario by ensuring that no thermal work
>> > items will be running when thermal_pm_notify_complete() is called.
>> > For this purpose, first move the cancel_delayed_work() call from
>> > thermal_zone_pm_complete() to thermal_zone_pm_prepare() to prevent
>> > new work from entering the workqueue going forward.  Next, switch
>> > over to using a dedicated workqueue for thermal events and update
>> > the code in thermal_pm_notify() to flush that workqueue after
>> > thermal_pm_notify_prepare() has returned which will take care of
>> > all leftover thermal work already on the workqueue (that leftover
>> > work would do nothing useful anyway because all of the thermal zones
>> > have been flagged as suspended).
>>
>> Thanks for coming up with this alternative. I spent some time earlier
>> today thinking of corner cases in that it might fail, and it held OK.
>>
>> However, slightly unrelated: apparently, flushing the workqueue in
>> thermal_pm_notify() reintroduces the issue addressed by the Fixes:
>> commit, but moving it from PM_POST_* to PM_*_PREPARE?
> 
> Note that the work in question will be thermal_zone_device_check(),
> which simply calls thermal_zone_device_update() that essentially
> invokes __thermal_zone_device_update() under tz->lock.
> 
> Thus thermal_zone_device_update() can only run as a whole before or
> after thermal_zone_pm_complete() for the given zone because the latter

      ^ thermal_zone_pm_prepare(), you mean? 
        (in PM_*_PREPARE path; sets TZ_STATE_FLAG_SUSPENDED mentioned
below.)

> also acquires tz->lock and releases it at the end.  If it runs before
> the latter, it will be waited for because the latter will block on the
> lock, but that happens without the changes in the $subject patch.  If

Ok, right; that already happens.

> it runs after the latter, __thermal_zone_device_update() will see that
> tz->state is not TZ_STATE_READY (because TZ_STATE_FLAG_SUSPENDED is
> set) and it will bail out immediately.
> 
> So I don't see the problem here.

Well, __thermal_zone_device_update() taking long might indeed impact
the PM_*_PREPARE path too (the former case, "it will be waited for"),
however, as you said, it happens without this patch, and it is not
fixed with the patch I proposed either. :)

> PM_POST_* is different because thermal_zone_device_resume() calls
> __thermal_zone_device_update() when tz->state is TZ_STATE_READY and
> that may take time.
> 
>> IIIUC, that issue is __thermal_zone_device_update() might take long
>> thus block other thermal zones and other PM notifiers after thermal.
>>
>> Apparently, at least the latter also applies to PM_*_PREPARE?
> 
> Not at the point when the flush_workqueue() is called.

Thanks for clarifying.

>> Say, a currently running work item (i.e., that cancel_delayed_work()
>> cannot cancel) wins the race for tz->lock and doesn't see tz->state
>> TZ_STATE_FLAG_SUSPENDED set, so it runs, and say it might take long.
>>
>> Now, the workqueue flush blocks on it, also taking long, which thus
>> blocks other PM notifiers.
>>
>> > The second failing scenario is addressed by adding a tz->state check
>> > to thermal_zone_device_resume() to prevent it from reinitializing
>> > the poll_queue delayed work if the thermal zone is going away.
>>
>> This also held OK in the thinking of corner cases.
> 
> Thanks for the feedback!

Glad to help!

-- 
Mauricio
