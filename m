From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 4/6] swsusp: move swap check out of swsusp_suspend
Date: Sun, 30 Oct 2005 12:46:58 +0100
Message-ID: <20051030114658.GG16684@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <200510292236.47960.rjw@sisk.pl> <20051029232134.GG14209@elf.ucw.cz> <200510301340.20959.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932097AbVJ3LrN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200510301340.20959.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > This is a non-essential step making the next patch possible.  No functionality
> > > changes.
> > 
> > If you can push this before 3/6, that would be nice.
> 
> Sure.  I think I'll send the two patches you have already acked and this one
> to Andrew as a separate series.  Then I'll get back to the 3/6 etc.

Splitting swsusp.c into swsusp.c and swap.c looked nice, too, btw. We
may finally get rid of "swsusp" name :-). But, in the long term, I'd
like to see swap reading/writing support removed from kernel. That
2.8.0 or something, through...
								Pavel
-- 
Thanks, Sharp!
