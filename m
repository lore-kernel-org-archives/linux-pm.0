From: Chris Newport <crn@netunix.com>
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Date: Fri, 25 May 2007 12:53:29 +0100
Message-ID: <4656CE39.8050800@netunix.com>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
	<Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
	<alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
	<20070524193740.GA6787@elte.hu>
	<alpine.LFD.0.98.0705241247540.26602@woody.linux-foundation.org>
	<20070525101105.GA9268@elte.hu>
Reply-To: crn@netunix.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070525101105.GA9268@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Kristian H?gsberg <krh@bitplanet.net>, Mikael Pettersson <mikpe@it.uu.se>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>, linux-pm@lists.linux-foundation.org, Christoph Lameter <clameter@sgi.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pcmcia@lists.infradead.org, Marcus Better <marcus@better.se>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>Linus Torvalds <to>
List-Id: linux-pm@vger.kernel.org

Ingo Molnar wrote:

>A BUG_ON() has a (much) lower likelyhood of being reported back - for 
>most users it is a "X just hung hard, there was nothing in the syslog, i 
>had to switch back to the older kernel" experience, and they do not have 
>a serial console to hook up (newer hardware often doesnt even have a 
>serial port). With the WARN_ON()s we have a _chance_ that despite the 
>seriousness of the bug, the message makes it to the syslog, until the 
>system comes to a screeching halt due to side-effects of the bug.
>
>in that sense i am part of the problem: i was adding WARN_ON()s that 
>werent true 'warnings' but 'bugs'. So i'd very much like to fix that 
>problem, but i'd also like to solve the (very serious and existing) 
>problem of BUG_ON()s making it less likely to get bugs reported back. 
>
>  
>
There is a fundamental problem in getting  a decent log to debug  a 
crashed kernel.  Maybe we should take a hint from Solaris.
If the kernel crashes Solaris dumps core to swap and sets a flag.
At the next boot this image is copied to /var/adm/crashdump where
it is preserved for future debugging. Obviously swap needs to be
larger than core, but this is usually the case.

On Sun machines this is fairly easy because the dump can be
performed by the OBP, on other architectures it may be more
difficult to still have enough working kernel to achieve the dump
after a kernel panic.

Just a thought .......
