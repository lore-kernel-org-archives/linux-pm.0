From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V3 01/11] power: charger-manager: Use alarmtimer for
 battery monitoring in suspend.
Date: Sat, 20 Dec 2014 01:21:30 +0100
Message-ID: <20141220002129.GB1694@amd>
References: <1418979323-7188-1-git-send-email-jonghwa3.lee@samsung.com>
 <1418979323-7188-2-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45805 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbaLTAVd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Dec 2014 19:21:33 -0500
Content-Disposition: inline
In-Reply-To: <1418979323-7188-2-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com

On Fri 2014-12-19 17:55:13, Jonghwa Lee wrote:
> To guerantee proper charing and managing batteries even in suspend,
> charger-manager has used rtc device with rtc framework interface.
> However, it is better to use alarmtimer for cleaner and more appropriate
> operation.
> This patch makes driver to use alamtimer for polling work in suspend and

alarmtimer.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
