From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] add helper for translation of runtime PM errors
Date: Thu, 11 Sep 2014 16:18:15 +0200
Message-ID: <1410445095.21752.4.camel@linux-fkkt.site>
References: <Pine.LNX.4.44L0.1409111003160.1357-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36553 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbaIKOSS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Sep 2014 10:18:18 -0400
In-Reply-To: <Pine.LNX.4.44L0.1409111003160.1357-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net

On Thu, 2014-09-11 at 10:04 -0400, Alan Stern wrote:
> On Thu, 11 Sep 2014, Oliver Neukum wrote:
> 
> > pm_runtime_get() returns specialised error codes. They are not
> > fit to be returned to user space. This patch adds a helper
> > for translation.
> > 
> > Signed-off-by: Oliver Neukum <oneukum@suse.de>
> > ---
> >  include/linux/pm_runtime.h | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index 367f49b..67d078f 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -128,6 +128,27 @@ static inline void pm_runtime_mark_last_busy(struct device *dev)
> >  	ACCESS_ONCE(dev->power.last_busy) = jiffies;
> >  }
> >  
> > +static inline int pm_runtime_translate_errors(int error)
> > +{
> > +	int rv;
> > +
> > +	switch (error) {
> > +	case 0:
> > +	case -ENOMEM:
> > +	case -EBUSY:
> > +		rv = error;
> > +		break;
> > +	case -EINPROGRESS:
> > +		rv = -EAGAIN;
> > +		break;
> > +	default:
> > +		rv = error > 0 ? error : -EIO;
> > +		break;
> > +	}
> > +
> > +	return rv;
> > +}
> 
> Is this function small enough to be worth inlining?

I did this because many drivers do

if (ret < 0)
	return ret;

So the compiler can optimize a part away. But yes, I'll test.

	Regards
		Oliver



