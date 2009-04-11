From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [REGRESSION] commit 66c1ca0: {fbmem: fix
 fb_info->lock and mm->mmap_sem ...} causes Xfbdev not working
Date: Sat, 11 Apr 2009 11:00:38 +0200
Message-ID: <49E05C36.9040204__13315.3745708571$1239440763$gmane$org@s5r6.in-berlin.de>
References: <f17812d70904090436kd03744brca4a4bc4b85bba8@mail.gmail.com>	<20090409125850.GA2727@linux>	<20090410222122.87be60f6.krzysztof.h1@poczta.fm>	<20090410220521.GB21294@linux>
	<20090411080415.7fe924a2.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090411080415.7fe924a2.krzysztof.h1@poczta.fm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Andrey Borzenkov <arvidjaar@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Harvey Harrison <harvey.harrison@gmail.com>, linux-pm@lists.linux-foundation.org, Andrea Righi <righi.andrea@gmail.com>
List-Id: linux-pm@vger.kernel.org

Krzysztof Helt wrote:
> On Sat, 11 Apr 2009 00:05:22 +0200
> Andrea Righi <righi.andrea@gmail.com> wrote:
> 
>> mmmh... I may have missed something, but the common fb_mmap() should
>> acquire mm->mmap_sem and then info->lock, while fb_ioctl() can do that
>> in reverse order (info->lock first and then mm->mmap_sem) causing the
>> circular locking dependency. Are you sure that pushing info->lock down
>> each driver's fb_mmap will fix the problem?
> 
> Right. The fb_mmap is called with the mmap_sem already held.
> I will try other possibilities like breaking info->lock() into two
> mutexex.

I had to deal with interaction of mmap_sem with a driver lock twice yet.
I solved it cheaply by replacing mutex_lock(driver_mutex) by
mutex_trylock(driver_mutex).

The obvious drawback is that thic changes kernel behaviour visibly to
userspace:  Under contention, the ioctl/read/write fails with -EAGAIN
instead of being blocked until the other thread finished its
ioctl/read/write/mmap on the same fd (if the driver mutex is
instantiated per fd, like in my case).

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=8449fc3ae58bf8ee5acbd2280754cde67b5db128
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=638570b54346f140bc09b986d93e76025d35180f

(In these two drivers, the change of behaviour is irrelevant to real
userspace clients.)
-- 
Stefan Richter
-=====-=-=== -=-= -==-=
http://arcgraph.de/sr/
