From: Jarek Poplawski <jarkao2@gmail.com>
Subject: Re: Need lockdep help
Date: Tue, 04 Dec 2007 20:02:47 +0100
Message-ID: <4755A457.5080405__41609.8676775166$1196794964$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.0712041000540.4321-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Peter Zijlstra <peterz@infradead.org>, Kernel development list <linux-kernel@vger.kernel.org>, Jarek Poplawski <jarkao2@o2.pl>, Ingo Molnar <mingo@elte.hu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern wrote, On 12/04/2007 04:17 PM:
...

> Furthermore, in this case deadlock isn't really impossible -- it could 
> occur if there were a bug somewhere else in the kernel.  So lockdep was 
> correct to warn that deadlock might occur.


Alan, if the scenario was like you described at the beginning, there was
no deadlock possible, unless some errors in the notifier. These #1-#3
threads were only helpful to guess what lockdep could 'think', but I
guess notifier doesn't use 2 rivaling threads for a wake, so, lockdep
probably needed additional information. And you really can't consider
any hypothetical kernel bugs here because then each lock is vulnerable.

Regards,
Jarek P.
