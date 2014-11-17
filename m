From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
Date: Mon, 17 Nov 2014 20:32:54 +0100 (CET)
Message-ID: <1496616289.267768.1416252774816.JavaMail.open-xchange@oxbaltgw08.schlund.de>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51656 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbaKQTdi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 14:33:38 -0500
In-Reply-To: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org

Hi Viresh,

> Viresh Kumar <viresh.kumar@linaro.org> hat am 17. November 2014 um 09:08
> geschrieben:
>
> [...]
>
> Now the question is: Should we destroy these OPPs?
>
> Logically kernel drivers *must* free resources they acquired. But in this
> particular case, the OPPs are created using a static list present in device
> tree. Destroying and then allocating them again isn't of much benefit. The
> only
> benefit of removing OPPs is to save some space if the driver isn't loaded
> again.
>
> This has its own complications. OPPs can be created either from DT (static) or
> platform code (dynamic). Driver should only remove static OPPs and not the
> dynamic ones as they are controlled from platform code. But there is no field
> in
> 'struct dev_pm_opp' which has this information to distinguish between
> different
> kind of OPPs.
>
> Because of all this, I wasn't sure if drivers should remove static OPPs during
> their removal. And so just fixing the reported issue by issuing a dev_dbg()
> instead of dev_warn().

how about adding some kind of FIXME?

beside that

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks

Stefan
