From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH][1/8] PM: Rework handling of interrupts
 during suspend-resume (rev. 5)
Date: Mon, 9 Mar 2009 08:40:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903090837340.19207__49741.8664665476$1236615832$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0903091106010.3778-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0903091106010.3778-100000@iolanthe.rowland.org>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Mon, 9 Mar 2009, Alan Stern wrote:
> 
> I see.  The unstated key point is this:
> 
> 	Unsophisticated drivers [...]

Another key point is:

 - _un_sophisticated is the norm, and anybody who expects otherwise is 
   living in some odd la-la-land together with his or her pink unicorn and 
   endless supplies of quaaludes.

The thing is, we have about a metric sh*tload of drivers, and many of them 
are effectively written by people who don't really do kernel work, and are
basically unmaintained in the long run (ie they may be maintained while 
written, but two years down the line they have a couple of hundred users 
and nobody who really cares about it, because the original author long 
since moved on to fancier hardware).

			Linus
