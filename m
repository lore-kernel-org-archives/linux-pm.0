From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: pm_runtime_barrier breaks autosuspend
Date: Thu, 08 May 2014 01:58:29 +0200
Message-ID: <6921768.5dEhd41WuE@vostro.rjw.lan>
References: <CAPcyv4h9prfrxmEvVamzCaT9Hc91WR90VO6k2PQa9RkSinAvuA@mail.gmail.com> <Pine.LNX.4.44L0.1405071112080.1325-100000@iolanthe.rowland.org> <CAPcyv4hf2hQGEsZXtFJiVa0GC-7A6RpKUDOTY6C7xkpDEaezRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59745 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751914AbaEGXlu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 May 2014 19:41:50 -0400
In-Reply-To: <CAPcyv4hf2hQGEsZXtFJiVa0GC-7A6RpKUDOTY6C7xkpDEaezRA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Wednesday, May 07, 2014 08:50:28 AM Dan Williams wrote:
> On Wed, May 7, 2014 at 8:21 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Tue, 6 May 2014, Dan Williams wrote:
> >
> >> > Why didn't pm_request_resume() result in an autosuspend?
> >>
> >> Found it.
> >>
> >> The last thing pm_runtime_barrier() does is pm_runtime_put_noidle()
> >> which may cause the autosuspend timer to never be reset.
> >
> > Rafael, this seems like a bug.  Should pm_runtime_barrier() be changed
> > so that just before the spinlock is released, we queue an autosuspend
> > request if dev->power.use_autosuspend is set and all the other
> > conditions are met?
> 
> ...or at least rename it to pm_runtime_barrier_noidle()?  I.e. make it
> clear that it needs to be wrapped by get / put, or an explicit suspend
> request queued afterwards.

Can you please point me to the piece of code where the problem happens?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
