From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] power: add an API to log wakeup reasons
Date: Wed, 12 Mar 2014 12:50:50 -0700
Message-ID: <1394653850.3915.26.camel@joe-AO722>
References: <1394653598-17143-1-git-send-email-kandoiruchi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]:60874 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750751AbaCLTu4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Mar 2014 15:50:56 -0400
In-Reply-To: <1394653598-17143-1-git-send-email-kandoiruchi@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ruchi Kandoi <kandoiruchi@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, ghackmann@google.com, john.stultz@linaro.org, toddpoynor@google.com

On Wed, 2014-03-12 at 12:46 -0700, Ruchi Kandoi wrote:
> For power management diagnostic purposes, it is often useful to know
> what interrupts are frequently waking the system from low power
> suspend mode, especially on battery-powered consumer electronics
> devices that are expected to spend much of their time in low-power
> suspend while not in active use.  For example, reduced battery life on
> a mobile phone may be caused in part by frequent wakeups by broadcast
> traffic on a busy wireless LAN even while the screen is off and the
> phone not in active use.

trivial note:

> diff --git a/kernel/power/wakeup_reason.c b/kernel/power/wakeup_reason.c
[]
> +#define pr_fmt(fmt) "wakeup_reason:" fmt

It's almost universal in the kernel to have a space after the :
in the prefix

#define pr_fmt(fmt) "wakeup_reason: " fmt


