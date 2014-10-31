From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 4/9] drivercore / platform: Keep PM domain powered
 during ->probe()
Date: Thu, 30 Oct 2014 17:07:49 -0700
Message-ID: <20141031000749.GK36444@dtor-ws>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <1413208930-26019-5-git-send-email-ulf.hansson@linaro.org>
 <7hoast8eu8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38770 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161331AbaJaAHz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Oct 2014 20:07:55 -0400
Content-Disposition: inline
In-Reply-To: <7hoast8eu8.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>

On Thu, Oct 30, 2014 at 01:47:27PM -0700, Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > To sucessfully probe some devices their corresponding PM domains may
> > need to be powered.
> 
> Isn't that what pm_runtime_get*() is supposed to be doing?  Why isn't
> that working?

Also, I do not understand why we placing device into a power domain only
when we probe it. Why if I unbind device from its driver (or do not have
a driver for it) it disappears from its power domain? To me power domain
and having driver bound to a device are 2 orthogonal concepts.

Thanks.

-- 
Dmitry
