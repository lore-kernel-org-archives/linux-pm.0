From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / Hibernate: no kernel_power_off when pm_power_off NULL
Date: Thu, 01 May 2014 01:21:41 +0200
Message-ID: <1465868.JN1PNL3ufB@vostro.rjw.lan>
References: <1398126646-29518-1-git-send-email-sebastian.capella@linaro.org> <20140422070955.GA14108@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56780 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759830AbaD3XFL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Apr 2014 19:05:11 -0400
In-Reply-To: <20140422070955.GA14108@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Capella <sebastian.capella@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

On Tuesday, April 22, 2014 09:09:55 AM Pavel Machek wrote:
> On Mon 2014-04-21 17:30:46, Sebastian Capella wrote:
> > Reboot logic in kernel/reboot will avoid calling kernel_power_off
> > when pm_power_off is null, and instead uses kernel_halt.  Change
> > hibernate's power_down to follow the behavior in the reboot call.
> > 
> > Calling the notifier twice (once for SYS_POWER_OFF and again for
> > SYS_HALT) causes a panic during hibernation on Kirkwood
> > Openblocks A6 board.
> > 
> > Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> > Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > Cc: Len Brown <len.brown@intel.com>
> 
> Reviewed-by: Pavel Machek <pavel@ucw.cz>

Queued up for 3.16, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
