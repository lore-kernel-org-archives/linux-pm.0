From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Why schedule in thaw_processes
Date: Fri, 29 Jun 2007 15:00:31 +0200
Message-ID: <200706291500.31884.rjw@sisk.pl>
References: <200706281553.48897.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706281553.48897.u.luckas@road.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Uli,

Sorry for the delay, I've been a bit busy recently.

On Thursday, 28 June 2007 15:53, Uli Luckas wrote:
> Dear PM Team,
> i am working my way through the Linux power managemen subsystem, trying to 
> understand, benchmark and improve our ARM based device's suspend/resume 
> cycles.
> I measure the time from a wakeup event until suspend_finish() returns.
> I was very confused, why this interval varies between 150ms and 300ms. Walking 
> the code I found the difference between 150ms wakeups and 300ms wakeups to 
> come from a call to schedule() in thaw_processes().
> I do realise, that these extra 150ms are not wasted, as they are spent in 
> other threads, doing what these threads need to do any way. Still an unneeded 
> schedule() is overhead in itself and probably would not have been introduced 
> without reason.
> 
> So, can anyone explain, why this schedule() is of any benefit?

The reason, AFAICS, is that if there are threads of higher priority than us, in
particular with real time priority, we want them to be able to run as soon as
the're thawed.

Still, I don't think that's really essential, so we can remove this schedule().

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
