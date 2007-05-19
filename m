From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: (fwd) empty /sys/power/state?
Date: Sat, 19 May 2007 22:15:50 +0200
Message-ID: <464F5AF6.3090507@s5r6.in-berlin.de>
References: <464F53C2.8070802@s5r6.in-berlin.de>
	<464F5625.9020905@s5r6.in-berlin.de>
	<464F58FD.5010101@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <464F58FD.5010101@s5r6.in-berlin.de>
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

>>> What's wrong here?
>>>
>>> # cat /sys/power/state
>>> # echo mem > /sys/power/state
>>> -su: echo: write error: No such device
>>> # uname -a
>>> Linux mini 2.6.22-rc2 #3 SMP PREEMPT Sat May 19 20:56:46 CEST 2007
>>> x86_64 Intel(R) Core(TM)2 CPU         T7600  @ 2.33GHz GenuineIntel
>>> GNU/Linux
> 
> PS:  It's an Apple Mac mini with Bootcamp.  I'd like to get suspend (to
> RAM) working for driver testing, but I won't switch to an i386 kernel.

PPS:  The i386 kernel won't help anyway.

On another machine with 32bit kernel:

# cat /sys/power/state
# echo mem > /sys/power/state
-su: echo: write error: No such device
# uname -a
Linux stein 2.6.22-rc1 #1 SMP PREEMPT Sun May 13 19:50:17 CEST 2007 i686
Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz GenuineIntel GNU/Linux

That's a PC with 945GM based MSI microATX motherboard.
-- 
Stefan Richter
-=====-=-=== -=-= =--==
http://arcgraph.de/sr/
