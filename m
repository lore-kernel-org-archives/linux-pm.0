From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v2 01/10] CPU hotplug: Provide APIs for "light"
 atomic readers to prevent CPU offline
Date: Mon, 10 Dec 2012 14:07:33 -0500
Message-ID: <1355166453.17101.236.camel@gandalf.local.home>
References: <50BF96DF.3000500@linux.vnet.ibm.com>
	 <50BF979A.50304@linux.vnet.ibm.com> <50BF982D.7090704@linux.vnet.ibm.com>
	 <50BF98F7.3030600@linux.vnet.ibm.com> <50BF999C.6030707@linux.vnet.ibm.com>
	 <50BFAB17.3090603@linux.vnet.ibm.com> <20121206161850.GA6710@redhat.com>
	 <50C0E88E.9050909@linux.vnet.ibm.com>
	 <1354822103.17101.24.camel@gandalf.local.home>
	 <20121207200014.GB13238@redhat.com> <20121210182115.GA30892@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:22031 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab2LJTHf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Dec 2012 14:07:35 -0500
In-Reply-To: <20121210182115.GA30892@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, sbw@mit.edu, amit.kucheria@linaro.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2012-12-10 at 19:21 +0100, Oleg Nesterov wrote:
> On 12/07, Oleg Nesterov wrote:
> >
> > On 12/06, Steven Rostedt wrote:
> > >
> > > You know reader locks can deadlock with each other, right? And this
> > > isn't caught be lockdep yet. This is because rwlocks have been made to
> > > be fair with writers. Before writers could be starved if a CPU always
> > > let a reader in. Now if a writer is waiting, a reader will block behind
> > > the writer. But this has introduced new issues with the kernel as
> > > follows:
> > >
> > >
> > >    CPU0			   CPU1	 	   CPU2		   CPU3
> > >    ----			   ----		   ----		   ----
> > > read_lock(A);
> > > 			read_lock(B)
> > > 					write_lock(A) <- block
> > > 							write_lock(B) <- block
> > > read_lock(B) <-block
> > >
> > > 			read_lock(A) <- block
> > >
> > > DEADLOCK!
> >
> > Really??? Oh I didn't know...
> >
> > Yes this was always true for rwsem, but rwlock_t?
> 
> Sorry, please ignore my email. I misread your email.
> 

No prob, looking at what I wrote, I should have explicitly stated two
different rwlocks. The only hint that I gave about two locks was (A) and
(B). Even what I started with: "reader locks can deadlock with each
other" is a bit ambiguous. So I can easily see the confusion.

-- Steve


