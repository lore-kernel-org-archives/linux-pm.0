From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Why rpm_idle called in rpm_resume ?
Date: Mon, 13 May 2013 13:55:31 +0200
Message-ID: <4976623.KzG9Mg72uv@vostro.rjw.lan>
References: <cover.1365079581.git.viresh.kumar@linaro.org> <CAKohpomV9-JEbuHWdmp6N+bKYt+83hXXcqg4aKXSY1a5zwpW9Q@mail.gmail.com> <E62404B31D39064FBDD0B843ADF05A7D2DF42CF662@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44455 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617Ab3EMLq6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 May 2013 07:46:58 -0400
In-Reply-To: <E62404B31D39064FBDD0B843ADF05A7D2DF42CF662@SC-VEXCH4.marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Feng Hong <hongfeng@marvell.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Monday, May 13, 2013 12:18:31 AM Feng Hong wrote:
> Hi, All,
> 
> Recently, I'm reviewing the runtime implementation, there is one logical puzzle me
> a lot, can you help to explain ?

That's because the resume may be spurious and in fact it may be possible to suspend
the device again, which we want to happen if so.

Thanks,
Rafael


> See below, if rpm_callback called with successful return in rpm_resume, rpm_idle will be called, what's the purpose on it ? The device just comeback to active, why call rpm_idle to try to suspend it ?  
> static int rpm_resume(struct device *dev, int rpmflags)
> {
>     ...
>     retval = rpm_callback(callback, dev);
>     if (retval) {
>         ...
>     } else {
>         __update_runtime_status(dev, RPM_ACTIVE)
>         ...
>     }
>     if (!retval)
>         rpm_idle(dev, RPM_ASYNC);
>     ....
> }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
