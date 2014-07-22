From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/6 v2] PM / Hibernate: Memory bitmap scalability
 improvements
Date: Tue, 22 Jul 2014 12:58:12 +0200
Message-ID: <20140722105812.GB9814@amd.pavel.ucw.cz>
References: <1405938422-21900-1-git-send-email-joro@8bytes.org>
 <20140721160346.GP30979@8bytes.org>
 <20140721230500.GA7019@amd.pavel.ucw.cz>
 <6793803.1FXN0a3O0V@vostro.rjw.lan>
 <20140722103443.GV30979@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140722103443.GV30979@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 2014-07-22 12:34:44, Joerg Roedel wrote:
> On Tue, Jul 22, 2014 at 02:41:29AM +0200, Rafael J. Wysocki wrote:
> > It looks like some specific need motivated the Joerg's work, however,
> > so let's just not dismiss the use case lightly without knowing it.
> 
> The motivation was to optimize the data structures for machines with
> large amounts of RAM without penalizing average machines. On a 12TB
> machine you are close to 100000 pages just for one bitmap. Scanning
> through that linearly to find a given bit just doesnt scale anymore in
> this case.

Can you produce backtrace where 12TB machine spends time during boot
with resume= parameter but no suspend image?

AFAICT swsusp_check() does not play with bitmaps.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
