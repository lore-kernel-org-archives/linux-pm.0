From: Uli Luckas <u.luckas@road.de>
Subject: Why schedule in thaw_processes
Date: Thu, 28 Jun 2007 15:53:48 +0200
Message-ID: <200706281553.48897.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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

Dear PM Team,
i am working my way through the Linux power managemen subsystem, trying to 
understand, benchmark and improve our ARM based device's suspend/resume 
cycles.
I measure the time from a wakeup event until suspend_finish() returns.
I was very confused, why this interval varies between 150ms and 300ms. Walking 
the code I found the difference between 150ms wakeups and 300ms wakeups to 
come from a call to schedule() in thaw_processes().
I do realise, that these extra 150ms are not wasted, as they are spent in 
other threads, doing what these threads need to do any way. Still an unneeded 
schedule() is overhead in itself and probably would not have been introduced 
without reason.

So, can anyone explain, why this schedule() is of any benefit?

regards,
Uli

-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 64 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing directors: Hans-Peter Constien, Hubertus von Streit
