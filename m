From: Bryan Henderson <bryanh@giraffe-data.com>
Subject: Re: battery drains after shutdown
Date: 23 Feb 2015 18:47:43 +0000
Message-ID: <7857.bryanh@giraffe-data.com>
References: <1423899504.11560.128.camel@rzhang1-mobl4>
	<72477.bryanh@giraffe-data.com> <20150223162240.d3b9c917752268fbcf4945c2@maison.homelinux.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from rhino.giraffe-data.com ([174.143.232.82]:41277 "EHLO
	rhino.giraffe-data.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbbBWSy1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Feb 2015 13:54:27 -0500
In-reply-to: <20150223162240.d3b9c917752268fbcf4945c2@maison.homelinux.net>
	(user.anti-spam@maison.homelinux.net)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, user.anti-spam@maison.homelinux.net, linux-pm@vger.kernel.org

So it appears the invoking 'hwclock' does not enable the RTC wakeup function,
at least in this experiment.

I have no idea what could be causing the battery drain.

-- 
Bryan Henderson                                   San Jose, California
