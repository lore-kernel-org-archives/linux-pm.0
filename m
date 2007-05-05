From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] suspend/resume debugging: device filter
Date: Sat, 5 May 2007 11:39:32 +0200
Message-ID: <200705051139.33008.rjw@sisk.pl>
References: <20070125110501.GA25151@elte.hu> <20070126015536.GA14917@suse.de> <20070505092425.GA23125@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423239AbXEEJfJ@vger.kernel.org>
In-Reply-To: <20070505092425.GA23125@elte.hu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Saturday, 5 May 2007 11:24, Ingo Molnar wrote:
> 
> * Greg KH <gregkh@suse.de> wrote:
> 
> > Here's a (compile tested only) patch that does this on a per-device 
> > basis, which is smaller, and should work just as well as your patch.
> > 
> > It creates a new file in the power/ directory for every device called 
> > "can_suspend".  Write a '0' to it to prevent that device from being 
> > suspended.
> > 
> > Does this work for you?
> 
> yeah, i was able to use this too to debug suspend/resume problems. But 
> i've added the check to the resume path too - for example sw-suspend 
> does a resume of devices during its suspend cycle, cutting off much of 
> the netconsole output.
> 
> which makes the can_suspend flag mis-named - perhaps rename it to 
> exclude_pm ?
> 
> updated patch below, against v2.6.21. Could we get this into v2.6.22 
> please? It's a real time-saver.

ACK

Greetings,
Rafael
