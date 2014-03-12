From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2] power: add an API to log wakeup reasons
Date: Tue, 11 Mar 2014 20:24:52 -0700
Message-ID: <531FD384.1020700@linaro.org>
References: <1394589767-16829-1-git-send-email-kandoiruchi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:43854 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbaCLDY4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Mar 2014 23:24:56 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so463832pab.34
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2014 20:24:56 -0700 (PDT)
In-Reply-To: <1394589767-16829-1-git-send-email-kandoiruchi@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ruchi Kandoi <kandoiruchi@google.com>, inux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, ghackmann@google.com, toddpoynor@google.com

On 03/11/2014 07:02 PM, Ruchi Kandoi wrote:
> Add API log_wakeup_reason() and expose it to userspace via sysfs path
> /sys/kernel/wakeup_reasons/last_resume_reason
> This is useful for power management diagnostic purposes.

Thanks for re-submitting!

This commit message is still really too brief, focusing only on what
you're doing and not *why*. You should include some of the rational you
provided in in your earlier reply.

The following template is usually good to follow:

1) The Why: Explanation of a problem (and how it came to be) or
problematic use case to be overcome.

2) The What: Your approach or design to solving the problem, with
details on any tradeoffs, or particular benefits of your solution that
should be noted.

I know it can seem terribly verbose for small patches, but it helps
maintainers and other reviewers get into the right context in order to
understand what your patch does before they look at the code.

thanks
-john





