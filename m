From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
 suspend/resume (was: Re: Memory allocations in .suspend became very
 unreliable)
Date: Sat, 30 Jan 2010 22:37:43 +0200
Message-ID: <1264883863.13861.3.camel__2208.50099945$1264884058$gmane$org@maxim-laptop>
References: <1263549544.3112.10.camel@maxim-laptop>
	<201001170138.37283.rjw@sisk.pl>
	<1264866419.27933.0.camel@maxim-laptop>
	<201001301947.10453.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001301947.10453.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2010-01-30 at 19:47 +0100, Rafael J. Wysocki wrote: 
> On Saturday 30 January 2010, Maxim Levitsky wrote:
> > On Sun, 2010-01-17 at 01:38 +0100, Rafael J. Wysocki wrote: 
> > > Hi,
> > > 
> > > I thing the snippet below is a good summary of what this is about.
> > 
> > Any progress on that?
> 
> Well, I'm waiting for you to report back:
> http://patchwork.kernel.org/patch/74740/
> 
> The patch is appended once again for convenience.

Ah, sorry!

I used the second version (with the locks) and it works for sure (~500
cycles)

However, as I discovered today, it takes the lock also for GFP_ATOMIC,
and thats why I see several backtraces in the kernel log. Anyway this
isn't important.

I forgot all about this patch, and I am compiling the kernel right away.
Will put the kernel through the hibernate loop tonight.

Best regards,
Maxim Levitsky
