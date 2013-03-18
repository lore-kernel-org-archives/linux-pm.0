From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH][RFC] PM / Domains: Add on-off notifiers
Date: Mon, 18 Mar 2013 12:14:17 -0700
Message-ID: <878v5kh65y.fsf@linaro.org>
References: <1363351143-28490-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:51362 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab3CRTOU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Mar 2013 15:14:20 -0400
Received: by mail-pb0-f51.google.com with SMTP id un15so6661961pbc.38
        for <linux-pm@vger.kernel.org>; Mon, 18 Mar 2013 12:14:20 -0700 (PDT)
In-Reply-To: <1363351143-28490-1-git-send-email-rickard.andersson@stericsson.com>
	(Rickard Andersson's message of "Fri, 15 Mar 2013 13:39:03 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rickard Andersson <rickard.andersson@stericsson.com>
Cc: linux-pm@vger.kernel.org

Hi Rickard,

Rickard Andersson <rickard.andersson@stericsson.com> writes:

> Some drivers needs to restore their context directly
> when a power domain is activated. For example a driver
> handling system bus settings must be able to restore
> context before the bus is being used for the first time.
> Other examples could be clock settings hardware blocks and
> special debugging hardware blocks which should be restored
> as early as possible in order to be able to debug direcly
> from waking up. Typically these notifers are needed in
> systems with CPU coupled power domains. The notifiers
> are intended to be trigged by cpuidle driver or the
> suspend ops hooks.
>
> The drivers that needs to use these notifiers are
> some special cases. Most drivers should not use this
> method and instead control their context via the
> pm_runtime interface.
>
> Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>

Some general comments.

First, I don't see where the notifiers are actually called in this
patch, so their intended use is not entirely clear.

Second, I'm a bit reluctant to see another layer of callbacks added to
the drivers.  I think using notifiers for this adds another level of
complexity to drivers that already have a pile of PM related callbacks
to manage.

IMO, it would be helpful to see an example driver using this feature,
and how it would interact with the drivers runtime PM callbacks.  For
example, I suspect that the the notifier callback would bascially be the
same as the runtime_resume callback, right?

Stated differently, at first glance, it seems the feature needed is
"runtime resume immidately after genpd power on".  Is that correct?

Also, the changelog implies that ordering may be crucial here (e.g bus
settings restored before bus is accessed), and using notifiers is not
going to give you that kind of ordering guarantee.

Kevin
