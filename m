From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpuidle: remove cpu_pm calls when entering a idle state
Date: Fri, 21 Oct 2016 10:59:49 +0100
Message-ID: <CAPKp9ubMekLZ_GsMjtVg04BqDuDtQ5cW1WH=jkQEsgyMvb2fCw@mail.gmail.com>
References: <1477042377-13485-1-git-send-email-chenhui.zhao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33363 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbcJUJ7v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 05:59:51 -0400
In-Reply-To: <1477042377-13485-1-git-send-email-chenhui.zhao@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chenhui Zhao <chenhui.zhao@nxp.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, open list <linux-kernel@vger.kernel.org>, z.chenhui@gmail.com, Sudeep Holla <sudeep.holla@arm.com>

Hi Chenhui,

On Fri, Oct 21, 2016 at 10:32 AM, Chenhui Zhao <chenhui.zhao@nxp.com> wrote:
> The functions, cpu_pm_enter and cpu_pm_exit, assume that CPU would
> be reset when entering and exiting a idle state. If that is not the
> case, they would cause issue.
>

So are you OK to break all the states that would be reset ?
This is not a proper solution. Can you provide more details on the issue
you are facing ? What platform ? which idle states ? and so on..

Regards,
Sudeep
