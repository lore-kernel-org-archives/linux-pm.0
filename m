From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 2/5] [pm] Add state field to pm_message_t (to
 hold actual state device is in)
Date: Sat, 18 Feb 2006 15:15:28 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0602181510510.4115-100000@netrider.rowland.org>
References: <20060218155104.GD5658@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932141AbWBRUPc@vger.kernel.org>
In-Reply-To: <20060218155104.GD5658@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@suse.cz>, akpm@osdl.org, torvalds@osdl.org, Kernel development list <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
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

Hear, hear!  Exactly what I was going to say.  Now that you want to add a 
field describing an actual device state, make it meaningful.

BTW, you might want to look here:

http://lists.osdl.org/pipermail/linux-pm/2005-September/001422.html

for an example of an early implementation of just this idea.  (I still 
have the original patch file if you'd prefer to see it in plain text, 
non-html format.)

Alan Stern
