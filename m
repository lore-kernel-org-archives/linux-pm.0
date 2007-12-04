From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Need lockdep help
Date: Tue, 4 Dec 2007 22:00:06 +0100
Message-ID: <20071204210006.GE32018__46652.2599490874$1196803509$gmane$org@elte.hu>
References: <4754907E.9060203@gmail.com>
	<Pine.LNX.4.44L0.0712041000540.4321-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0712041000540.4321-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Jarek Poplawski <jarkao2@o2.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jarek Poplawski <jarkao2@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


* Alan Stern <stern@rowland.harvard.edu> wrote:

> > I'm not sure I can understand your plan, but I doubt there should be 
> > such problems with taking rwsem for sleeping, so maybe it would be 
> > better to figure out what really scares lockdep, to fix the right 
> > place?
> 
> The real problem is that lockdep has to make some generalizations.  It 
> can't be aware of the details of every possible situation, and it 
> doesn't have a global view of the entire kernel, so it doesn't know 
> when special circumstances make deadlock impossible.
> 
> Furthermore, in this case deadlock isn't really impossible -- it could 
> occur if there were a bug somewhere else in the kernel.  So lockdep 
> was correct to warn that deadlock might occur.

ok. Thanks for resolving this by working it around - i _think_ in the 
long run we'd like to make all locking "simpler" - not just for the sake 
of lockdep, but also for the sake of human reviewability. So in that 
sense, even though in this particular case you are fully right that 
lockdep was wrong, we benefit long-term.

	Ingo
