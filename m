From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] timer: move enum definition out of ifdef section
Date: Tue, 02 Apr 2013 15:27:04 +0200
Message-ID: <2657498.rI4k3ezvLQ@vostro.rjw.lan>
References: <1364379733-23725-1-git-send-email-daniel.lezcano@linaro.org> <5116925.ZeoNyu5C6N@vostro.rjw.lan> <515A61FA.6000302@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:50108 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760079Ab3DBNT3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Apr 2013 09:19:29 -0400
In-Reply-To: <515A61FA.6000302@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linus.walleij@linaro.org, kernel@pengutronix.de, santosh.shilimkar@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org

On Tuesday, April 02, 2013 06:43:38 AM Daniel Lezcano wrote:
> On 04/02/2013 01:24 AM, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > All 5 in this series applied to linux-pm.git/linux-next.
> > 
> > What am I supposed to do with patches [6-15/15] in your previous series?
> > 
> > Are you going to resend the ones that have been ACKed?
> 
> No, please ignore them. After discussing, people want to see the init
> function in the cpuidle framework not in a generic ARM driver. So I am
> rewriting the patchset for that.
> 
> There are the cleanups before to apply [1], except [4/9] which was
> already fixed in the OMAP tree.

OK, I'll ignore the rest of that patchset, then.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
