From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 01/27] PM: Add helper
 pm_runtime_last_busy_and_autosuspend()
Date: Thu, 25 Sep 2014 13:30:38 +0530
Message-ID: <20140925080038.GX24663@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <1411575342-31048-2-git-send-email-vinod.koul@intel.com>
 <20140924175410.GC1231@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140924175410.GC1231@amd>
Sender: linux-doc-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, subhransu.s.prusty@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Randy Dunlap <rdunlap@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 24, 2014 at 07:54:10PM +0200, Pavel Machek wrote:
> On Wed 2014-09-24 21:44:51, Vinod Koul wrote:
> > From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > 
> > pm_runtime_mark_last_busy and pm_runtime_put_autosuspend are used together
> > in quite a lot of places. Add a helper for these.
> > Also updated Documentation for this
> 
> With function name as long as the implementation... I'm not sure if
> this is good helper :-).
am all ears if that is a general consensus to cut down on length and
suggestions welcome :)

-- 
~Vinod

> 									Pavel
> 
> > +static inline int pm_runtime_last_busy_and_autosuspend(struct device *dev)
> > +{
> > +	pm_runtime_mark_last_busy(dev);
> > +	return pm_runtime_put_autosuspend(dev);
> > +}
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
