Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A7330B0E
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440639; cv=none; b=i5PAJcKKSwqo8pR2+3CAb3Sz6+ao4Ws0Bqmu3/jGHyF2ZSwTbDHxXaqooh9UIF/A1DSZneHM99ch0lyXV0+s8jKZ+mK/46cxNWCChnP7dO4rTkMAmiLv7y24SWM74zAm0R7TtYBSdpi+uQVTxdtUtGzBpf+3UHoeDB981yAIOrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440639; c=relaxed/simple;
	bh=Zl2OeNtAZVoRJcEGuXTCluOp5i40UTaGuvKLZ0WWD1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILxGKkgINWIqEWqKDVEt/4CRN38ggvMIo636ty4fPNbu9JclmnLX6ReE9CXfYHX9UOU1Fneolil51Btk/Ic++JK71AyXGagKOWaUYs5wAi5V3AHcnFkdiMCOZa1SGn/nmHnYx7kfVLySE7xYSEsNSoPRqfLV6gDraoNY8eI2vMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H55ZDUAo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H55ZDUAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7F9C2BCB9
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774440639;
	bh=Zl2OeNtAZVoRJcEGuXTCluOp5i40UTaGuvKLZ0WWD1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H55ZDUAoQZ+ERen6u/ZeBl4ZVMQlaFvWbn1dOdnMNVEpvY2jbxqg3Gg0JUyY4m+4j
	 ruUPZbQZqhzTe0ojKUF9wrqjwWlwCE3to8CXoSP7MOPexLmPg4krJL5Q0s1BUIqcrg
	 iletiiHM80BCujv8G3vIhFXYbu+7tcxW994ppf00p8aR95AgpmiJtq5ZSoWGRmH7hg
	 ayPyKhOT2AMoFRT/QnLXs/iIKZrH5xVmsKrFOgmxj7BEfkPatGl2WV5wm1RssSOPHX
	 ryWiYQOy83f7sZdpUz5Hrv3yPTM0mRwn+oKNmJ+TGFaXvVwLRFaiiTKzYIXvC6lY+p
	 q1sQ0Bfm7rEPw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4094b31a037so4568683fac.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 05:10:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYbnNrCvi9EW6tw321V921l6Dn+mXQINSKlZYshvvQq4SmF/lfy9qsHuENyMZn30rUku4n9z49AA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxehfwNQskPeiRD/Rryn+xV6ha1ZaVz2z2LyUH8AcqD2B+ggf3
	DkuSrODcR1mJrOuLBPpiJtpcYCHICkzwV8c7DDKOQGvKyGx4j++MpnbyyWVSTTx4JSpNt6rugdX
	ZBVkJQFAZRmtDyu+3HPJysrPC5fHx3ZA=
X-Received: by 2002:a05:6870:a2cd:b0:41c:6bf0:677c with SMTP id
 586e51a60fabf-41ca6d72df9mr1772249fac.2.1774440638279; Wed, 25 Mar 2026
 05:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com>
In-Reply-To: <20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Mar 2026 13:10:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h8Q-Cs-05hwKUF9wPbOzg2gyG8yH6tOfzJgXQCh5Ohbg@mail.gmail.com>
X-Gm-Features: AaiRm51puq75WcqBTp0h9vcB8fnHNi4PnUpgGt6yNcjT3ebroiB8Vfs0S7ZPp0Y
Message-ID: <CAJZ5v0h8Q-Cs-05hwKUF9wPbOzg2gyG8yH6tOfzJgXQCh5Ohbg@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: fix use-after-free due to init/cancel
 delayed_work race
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 12:51=E2=80=AFAM Mauricio Faria de Oliveira
<mfo@igalia.com> wrote:
>
> If INIT_DELAYED_WORK() is called for a currently running work item,
> cancel_delayed_work_sync() is unable to cancel/wait for it anymore,
> as the work item's data bits required for that are cleared.
>
> In the resume path, INIT_DELAYED_WORK() is called twice:
> 1) to replace the work function: thermal_zone_device_check/resume()
> 2) to restore it.
>
> Both cases might race with the unregister path and bypass the call to
> cancel_delayed_work_sync(),

So this is the problem, isn't it?

> after which struct thermal_zone_device *tz
> is freed, and the non-canceled/non-waited for work hits use-after-free.

Which basically means that a TZ_STATE_FLAG_EXIT check is missing in
both thermal_zone_pm_complete() and thermal_zone_device_resume().

> Fix the first case with a dedicated work item for the resume function,
> and the second case by initializing the work item(s) only during init.

So why not add those missing checks instead of complicating the code even m=
ore?
