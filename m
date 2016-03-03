From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PM / Domains: Propagate start and restore errors during runtime resume
Date: Thu, 03 Mar 2016 12:24:23 -0800
Message-ID: <7h60x3wbrc.fsf@baylibre.com>
References: <1456874438-26330-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34716 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcCCUYZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 15:24:25 -0500
Received: by mail-pf0-f182.google.com with SMTP id 4so20998796pfd.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Mar 2016 12:24:24 -0800 (PST)
In-Reply-To: <1456874438-26330-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	(Laurent Pinchart's message of "Wed, 2 Mar 2016 01:20:38 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com> writes:

> During runtime resume the return values of the start and restore steps
> are ignored. As a result drivers are not notified of runtime resume
> failures and can't propagate them up. Fix it by returning an error if
> either the start or restore step fails, and clean up properly in the
> error path.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/base/power/domain.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> This fixes an issue I've noticed with my driver's .runtime_resume() handler
> returning an error that was never propagated out of pm_runtime_get_sync().

Acked-by: Kevin Hilman <khilman@baylibre.com>

> A second issue then appeared. The device .runtime_error field is set to the
> error code returned by my .runtime_resume() handler, but it never reset. Any
> subsequent try to resume the device fails with -EINVAL. I'm not sure what the
> right way to solve that is, advices are welcome.

Probably setting it (back) to zero after each successful runtime_suspend
or runtime_resume is the right way.  Rafael?

Kevin
