From: Michal Hocko <mhocko@suse.cz>
Subject: Re: suspend regression in 4.1-rc1
Date: Mon, 18 May 2015 16:41:37 +0200
Message-ID: <20150518144136.GB5726@dhcp22.suse.cz>
References: <20150517185041.GA5897@dhcp22.suse.cz>
 <CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
 <20150518073046.GO17717@twins.programming.kicks-ass.net>
 <20150518090336.GA6393@dhcp22.suse.cz>
 <20150518093150.GC21418@twins.programming.kicks-ass.net>
 <309071648.615900.1431946606778.JavaMail.zimbra@redhat.com>
 <20150518142607.GL184517@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35056 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbbEROlk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 10:41:40 -0400
Content-Disposition: inline
In-Reply-To: <20150518142607.GL184517@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
Cc: Ulrich Obergfell <uobergfe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon 18-05-15 10:26:07, Don Zickus wrote:
> On Mon, May 18, 2015 at 06:56:46AM -0400, Ulrich Obergfell wrote:
> > 
> > > There further appears to be a distinct lack of serialization between
> > > setting and using watchdog_enabled, so perhaps we should wrap the
> > > {en,dis}able_all() things in watchdog_proc_mutex.
> > 
> > As I understand it, the {en,dis}able_all() functions are only called early
> > at kernel startup, so I do not see how they could be racing with watchdog
> > code that is executed in the context of write() system calls to parameters
> > in /proc/sys/kernel. Please see also my earlier reply to Michal for further
> > details: http://marc.info/?l=linux-pm&m=143194387208250&w=2
> > 
> > Do we really need synchronization here?
> 
> As Peter said we have to focus on doing things correctly and not based on
> what is currently.
> 
> During s2ram, I believe all the threads get parked and then unparked during
> resume.  I am wondering if the race happens there, threads get unparked and
> stomp on each other when watchdog_nmi_enable_all() is called.

Wouldn't that cause an issue during freezer mode of pm_test? I can see
it much later in the processors mode.
-- 
Michal Hocko
SUSE Labs
