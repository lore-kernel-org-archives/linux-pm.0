From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] Hibernate: check unsafe page should not in e820
 reserved region
Date: Fri, 8 Aug 2014 09:05:56 +0200
Message-ID: <20140808070556.GA27434@amd.pavel.ucw.cz>
References: <1407165801-24648-1-git-send-email-jlee@suse.com>
 <20140807040543.GE26210@linux-rxt1.site>
 <20140807080025.GA24700@amd.pavel.ucw.cz>
 <20140807085203.GF26210@linux-rxt1.site>
 <20140807093957.GB28649@Nokia-N900>
 <20140807101734.GG26210@linux-rxt1.site>
 <20140807210532.GA7816@Nokia-N900>
 <20140808042428.GI26210@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53660 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbaHHHF7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Aug 2014 03:05:59 -0400
Content-Disposition: inline
In-Reply-To: <20140808042428.GI26210@linux-rxt1.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> > When I wrote that num_physpages check, I should have checked
> > whole e820  table, instead. (If anything at all changed there,
> > "new" kernel is running with wrong e820 info).
> > 
> > You seem to be in great position to fix that mistake now...
> 
> Hashing e820 is fine, but it can not provide detail information to user/developer when issue
> happened. We only know the e820 table changed but not more information for bug tracking, not
> too many shipping machine have serial console.

I don't see what it has to do with serial console, during relevant
stages of hibernation, normal console should be available.

Anyway, either hash or full comparison is file, whatever is simpler.

Thanks,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
