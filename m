From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v1] refining the rpm_suspend function
Date: Tue, 19 Jan 2016 14:49:15 +0100
Message-ID: <9438969.iYZ3h3fHzb@vostro.rjw.lan>
References: <1453194858-17416-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48165 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754015AbcASNsd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 08:48:33 -0500
In-Reply-To: <1453194858-17416-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: zhaoyang.huang@spreadtrum.com, pavel@ucw.cz, linux-kernel@vger.kernel.org, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org

On Tuesday, January 19, 2016 05:14:18 PM Zhaoyang Huang wrote:
> There are too many branch path within he original rpm_suspend funciton,which make
> the code a little bit hard for understanding and debugging.Just try to split the
> function into some small one to eliminate the goto and make one optimization for
> avoiding transfering from wait to auto when irq_safe flag set
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>

First off, please don't mix cleanups with optimizations.

Second, I don't really think that the changes you're making improve things
from the readability/debugging viewpoint.

Thanks,
Rafael

