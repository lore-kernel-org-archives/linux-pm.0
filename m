From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] PM / Domains: Turn latency warning into debug message
Date: Fri, 28 Feb 2014 15:18:28 +0100
Message-ID: <1393597108.3802.42.camel@paszta.hi.pengutronix.de>
References: <1393525604-21471-1-git-send-email-p.zabel@pengutronix.de>
	 <CAPDyKFoSQQqiL7=H12z9Ag2_DZNig_DGu_u9qrpQ53YtJhwUSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57862 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbaB1OSe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2014 09:18:34 -0500
In-Reply-To: <CAPDyKFoSQQqiL7=H12z9Ag2_DZNig_DGu_u9qrpQ53YtJhwUSQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Ulf,

Am Donnerstag, den 27.02.2014, 23:43 +0100 schrieb Ulf Hansson:
> On 27 February 2014 19:26, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > If devices don't provide latency data, this warning can be quite noisy until
> > the pm domain was enabled and disabled a few times. Turn this warning into
> > a debug message.
> 
> Just curious, why is the latency not interesting for you?

at least it is not always interesting.

root@BDSL:~ v4l2-ctl -D -d /dev/video5
coda 2040000.vpu: start latency exceeded, new value 743 ns
coda 2040000.vpu: state restore latency exceeded, new value 4828363 ns
Driver Info (not using libv4l2):coda 2040000.vpu: stop latency exceeded,
new value 1561 ns

	Driver name   : coda
	Card type     : CODA960
	[...]

That's a bit too verbose for my taste if I'm not currently working on
either latency or the pm domain handling itself.

regards
Philipp

