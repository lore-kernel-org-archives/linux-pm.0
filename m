From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RESEND PATCH] PM / Runtime: Idle devices asynchronously after probe|release
Date: Thu, 11 Apr 2013 07:20:59 -0700
Message-ID: <87txndxi5w.fsf@linaro.org>
References: <1365606048-27603-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:43335 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab3DKOVE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2013 10:21:04 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so874445pdi.21
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2013 07:21:03 -0700 (PDT)
In-Reply-To: <1365606048-27603-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Wed, 10 Apr 2013 17:00:48 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rickard Andersson <rickard.andersson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Ulf Hansson <ulf.hansson@stericsson.com> writes:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Putting devices into idle|suspend in a synchronous manner means we are
> waiting for each device to become idle|suspended before the probe|release
> is fully done.
>
> This patch switch to use the asynchronous runtime PM API:s instead and
> thus improves the parallelism since we can move on and handle the next
> device in queue in an earlier phase.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Kevin Hilman <khilman@linaro.org>
