From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [linux-pm] [PATCH 2/5] [pm] Add state field to pm_message_t (to
 hold actual state device is in)
Date: Sun, 19 Feb 2006 15:57:43 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602191554560.8676-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171757360.30811-100000@monsoon.he.net>
 <20060218155104.GD5658@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932464AbWBSX55@vger.kernel.org>
In-Reply-To: <20060218155104.GD5658@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org, linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On Sat, 18 Feb 2006, Pavel Machek wrote:

> Hi!
>
>
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index 5be87ba..a7324ea 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -140,6 +140,7 @@ struct device;
> >
> >  typedef struct pm_message {
> >  	int event;
> > +	u32 state;
> >  } pm_message_t;
>
> We have had enough problems with u32s before... What about
> char *, and pass real state names?

I certainly agree that is better in an ideal implementation. But, the
intent of the patches was not to fix the infrastructure; it was to fix the
interface to be compatible with previous behavior (while accounting for
changes made in the area that happened in the process of breaking it).

Thanks,


	Pat
