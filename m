From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 03/10] freezer: add new freezable helpers using
 freezer_do_not_count()
Date: Fri, 3 May 2013 16:00:43 +0200
Message-ID: <20130503140043.GA21647@amd.pavel.ucw.cz>
References: <1367271946-7239-1-git-send-email-ccross@android.com>
 <1367271946-7239-4-git-send-email-ccross@android.com>
 <20130502124826.GE22618@amd.pavel.ucw.cz>
 <CAMbhsRRhcM=59xVgitYPyY-rzJTjV1mgwwusOzqFUqT2=__JDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41143 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762240Ab3ECOAp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 10:00:45 -0400
Content-Disposition: inline
In-Reply-To: <CAMbhsRRhcM=59xVgitYPyY-rzJTjV1mgwwusOzqFUqT2=__JDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Len Brown <len.brown@intel.com>

Hi!

> > Also, why not static inline?
> 
> I copied the style of the existing helpers.  I can change them all to
> static inlines if you prefer.

That would be better, yes.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
