From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Tue, 21 Jul 2015 22:05:53 +0200
Message-ID: <20150721200553.GA1861@amd>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org>
 <55A668FE.80409@gmail.com>
 <1A7043D5F58CCB44A599DFD55ED4C948468A7978@fmsmsx115.amr.corp.intel.com>
 <1684935.fYtBRJbzgO@vostro.rjw.lan>
 <20150721093806.GA23841@amd>
 <CAJZ5v0gNKRRaXvfqvj4YEjb+7X1aEobfvWuWyAnAcKArcxtZPA@mail.gmail.com>
 <20150721151941.GA19581@amd>
 <1A7043D5F58CCB44A599DFD55ED4C948468A923D@fmsmsx115.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C948468A923D@fmsmsx115.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Austin S Hemmelgarn <ahferroin7@gmail.com>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue 2015-07-21 20:01:15, Brown, Len wrote:
> > Who does enter suspend to ram multiple times a second? Only android
> 
> One significant customer for fast suspend/resume
> is sufficient to justify Linux supporting fast suspend/resume.

So which customer is that? And does that customer really need config
option, as opposed to writing to sysfs file?

> > Can you run android on mainline kernel? No
> 
> This is something we need to work together to help fix.

Yes, that would be nice, but I'm pretty sure it will require changes
in android userland, as they did not get all the interfaces right.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
