From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC 0/5] PM / clock_ops: provide default runtime ops and cleanup users
Date: Mon, 20 Apr 2015 16:21:23 -0700
Message-ID: <7hfv7ue68c.fsf@deeprootsystems.com>
References: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35320 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbbDTXV1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2015 19:21:27 -0400
Received: by pabtp1 with SMTP id tp1so221537789pab.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2015 16:21:27 -0700 (PDT)
In-Reply-To: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
	(Rajendra Nayak's message of "Tue, 14 Apr 2015 19:04:28 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: rjw@rjwysocki.net, ssantosh@kernel.org, tony@atomide.com, nsekhar@ti.com, magnus.damm@gmail.com, linux-arm-msm@vger.kernel.org, inux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org

Rajendra Nayak <rnayak@codeaurora.org> writes:

> Most users of PM clocks do the exact same thing in runtime callbacks.

Probably because they were all copied from mach-davinci. ;)

> Provide default callbacks and cleanup the existing users (keystone/davinci/omap1/sh)

Very nice cleanup, Thanks!

For the series:

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Kevin
