From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH RESEND v2 03/10] power: charger-manager: Remove
 deprecated function, cm_notify_event().
Date: Sat, 20 Dec 2014 01:16:22 +0100
Message-ID: <20141220001622.GA1694@amd>
References: <1255984171.39711418975524329.JavaMail.weblogic@epmlwas08d>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45305 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbaLTAQ0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Dec 2014 19:16:26 -0500
Content-Disposition: inline
In-Reply-To: <1255984171.39711418975524329.JavaMail.weblogic@epmlwas08d>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: =?utf-8?B?7J207KKF7ZmU?= <jonghwa3.lee@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "anton@enomsg.org" <anton@enomsg.org>, =?utf-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>

On Fri 2014-12-19 07:52:07, MyungJoo Ham wrote:
> >   
> >  cm_notify_event() is introduced to get event associated with battery status
> > externally, but no one had been used. Moreover it makes charger manager
> > driver more complicated. This patch tries to drop the function and all data
> > related to simplify the driver.
> > 
> > Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> 
> You are not just removing cm_notify_event() and its related.
> 
> You are hereby removing the much of software charger control
> and suspend-related operations. Could you please be more specific
> on why? (many of such features are to comply with operators' requirements)
> 
> (Or we may meet next Monday for some discussions :) )

So... you'll meet in person and we will not see fireworks on the
mailing list? :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
