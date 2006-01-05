From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 0/5] swsusp: userland interface (rev. 2)
Date: Fri, 6 Jan 2006 00:30:26 +0100
Message-ID: <20060105233026.GA3339@elf.ucw.cz>
References: <200601042340.42118.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751852AbWAEXam@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200601042340.42118.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> This is the second "preview release" of the swsusp userland interface patches.
> They have changed quite a bit since the previous post, as I tried to make the
> interface more robust against some potential user space bugs (or outright
> attempts to abuse it).

Works for me, thanks.

Perhaps it is time to get 1/4 and 3/4 into -mm? You get my signed-off
on them...

2/4 needs to allocate official major/minor. 1/13 would be nice :-).

4/4... I'm not sure. It would be nice to make swsusp.c disappear. It
is really wrong name. That means we need to only delete from it for a
while...
									Pavel

-- 
Thanks, Sharp!
