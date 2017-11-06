From: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH] freezer: Fix typo in commnent to function
 freezable_schedule_timeout()
Date: Mon, 6 Nov 2017 16:57:09 +0530
Message-ID: <20171106112709.GA4822@himanshu-Vostro-3559>
References: <1509832652-1552-1-git-send-email-himanshujha199640@gmail.com>
 <20171104220256.GA7012@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:55703 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbdKFL1U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2017 06:27:20 -0500
Content-Disposition: inline
In-Reply-To: <20171104220256.GA7012@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org

On Sat, Nov 04, 2017 at 11:02:56PM +0100, Pavel Machek wrote:
> On Sun 2017-11-05 03:27:32, Himanshu Jha wrote:
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> 
> ACK.
> 
> But note you have typo in the subject ;-).

Oops!
Do I need to send v2 with correct subject ?

> Plus this kind of bug is usually called thinko.
> 								Pavel
> 
> 
> > diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> > index 3995df1..21f5aa0 100644
> > --- a/include/linux/freezer.h
> > +++ b/include/linux/freezer.h
> > @@ -182,7 +182,7 @@ static inline void freezable_schedule_unsafe(void)
> >  }
> >  
> >  /*
> > - * Like freezable_schedule_timeout(), but should not block the freezer.  Do not
> > + * Like schedule_timeout(), but should not block the freezer.  Do not
> >   * call this with locks held.
> >   */
> >  static inline long freezable_schedule_timeout(long timeout)
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Thanks
Himanshu Jha
