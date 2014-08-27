From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 1/4] QoS: Modify data structures and function arguments for scalability.
Date: Wed, 27 Aug 2014 10:44:24 -0700
Message-ID: <7hr401esjr.fsf@paris.lan>
References: <1407945689-18494-1-git-send-email-lina.iyer@linaro.org>
	<1407945689-18494-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:50730 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511AbaH0Roc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Aug 2014 13:44:32 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so732120pad.25
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 10:44:29 -0700 (PDT)
In-Reply-To: <1407945689-18494-2-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Wed, 13 Aug 2014 10:01:26 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, tglx@linutronix.de, rjw@rjwysocki.net, Praveen Chidambaram <pchidamb@codeaurora.org>

Lina Iyer <lina.iyer@linaro.org> writes:

> QoS add requests uses a handle to the priority list that is used
> internally to save the request, but this does not extend well. Also,
> dev_pm_qos structure definition seems to use a list object directly.
> The 'derivative' relationship seems to be broken.
>
> Use pm_qos_request objects instead of passing around the protected
> priority list object.
>
> Signed-off-by: Praveen Chidambaram <pchidamb@codeaurora.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>
