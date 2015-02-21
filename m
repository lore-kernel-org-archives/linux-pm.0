From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / sleep: add configurable delay for pm_test
Date: Sat, 21 Feb 2015 21:32:56 +0100
Message-ID: <20150221203256.GA15228@amd>
References: <1409788535-28264-1-git-send-email-computersforpeace@gmail.com>
 <20141213025530.GO21347@ld-irv-0074>
 <20141213083123.GA26129@amd>
 <20141216235813.GI9759@ld-irv-0074>
 <20141217080947.GB2027@amd>
 <20141217091057.GH7112@brian-ubuntu>
 <20141217092255.GA4588@amd>
 <CAGVrzcZgwQqfBkupWkChYg8NmpKsFzWNa0jB18wN6YUuOzgvsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58775 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbBUUc7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Feb 2015 15:32:59 -0500
Content-Disposition: inline
In-Reply-To: <CAGVrzcZgwQqfBkupWkChYg8NmpKsFzWNa0jB18wN6YUuOzgvsw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Chirantan Ekbote <chirantan@chromium.org>




> Considering that Brian's change are enclosed within a CONFIG_PM_DEBUG
> ifdef, can we really use the code bloat as a technical argument here?

Yes.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
