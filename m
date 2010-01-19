From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Tue, 19 Jan 2010 10:19:29 +0900 (JST)
Message-ID: <20100119101101.5F2E.A69D9226__12692.3686163083$1263864062$gmane$org@jp.fujitsu.com>
References: <20100118110324.AE30.A69D9226@jp.fujitsu.com>
	<201001182155.09727.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001182155.09727.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, kosaki.motohiro@jp.fujitsu.com, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi 

> > If suspend need lots memory, we need to make free memory before starting IO
> > suspending, I think.
> 
> Suspend as such doesn't need a lot of memory, except for some drivers doing
> things they shouldn't do.
> 
> However, there are a few problems that need to be addressed in general.
> 
> First, we can't really guarantee that there's a lot of free memory available
> during suspend and some memory allocations are done indirectly, using
> GFP_KERNEL (for example, when new kernel threads are started).  If one of
> these is done during suspend and it happens to cause the mm subsystem to
> start I/O on a suspended devices, the kernel will lock up.
> 
> Second, there may be a memory allocation in progress when suspend is started
> that causes I/O to happen and races with the suspend process.  If the latter
> wins the race, the I/O may be attempted on a suspended device and the kernel
> will lock up.

I think the race happen itself is bad. memory and I/O subsystem can't solve such race
elegantly. These doesn't know enough suspend state knowlege. I think the practical 
solution is that higher level design prevent the race happen.


> My patch attempts to avoid these two problems as well as the problem with
> drivers using GFP_KERNEL allocations during suspend which I admit might be
> solved by reworking the drivers.

Agreed. In this case, only drivers change can solve the issue.
