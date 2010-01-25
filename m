From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][PATCH] MM / PM: Force GFP_NOIO during
	suspend/hibernation and resume
Date: Mon, 25 Jan 2010 22:49:18 +0100
Message-ID: <201001252249.18690.rjw__28830.1629167565$1264456345$gmane$org@sisk.pl>
References: <201001212121.50272.rjw@sisk.pl> <201001222219.15958.rjw@sisk.pl>
	<1264238962.16031.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1264238962.16031.4.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Andrew Morton <akpm@linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 23 January 2010, Maxim Levitsky wrote:
> On Fri, 2010-01-22 at 22:19 +0100, Rafael J. Wysocki wrote: 
> > On Friday 22 January 2010, Maxim Levitsky wrote:
> > > On Fri, 2010-01-22 at 10:42 +0900, KOSAKI Motohiro wrote: 
> > > > > > > Probably we have multiple option. but I don't think GFP_NOIO is good
> > > > > > > option. It assume the system have lots non-dirty cache memory and it isn't
> > > > > > > guranteed.
> > > > > > 
> > > > > > Basically nothing is guaranteed in this case.  However, does it actually make
> > > > > > things _worse_?  
> > > > > 
> > > > > Hmm..
> > > > > Do you mean we don't need to prevent accidental suspend failure?
> > > > > Perhaps, I did misunderstand your intention. If you think your patch solve
> > > > > this this issue, I still disagree. but If you think your patch mitigate
> > > > > the pain of this issue, I agree it. I don't have any reason to oppose your
> > > > > first patch.
> > > > 
> > > > One question. Have anyone tested Rafael's $subject patch? 
> > > > Please post test result. if the issue disapper by the patch, we can
> > > > suppose the slowness is caused by i/o layer.
> > > 
> > > I did.
> > > 
> > > As far as I could see, patch does solve the problem I described.
> > > 
> > > Does it affect speed of suspend? I can't say for sure. It seems to be
> > > the same.
> > 
> > Thanks for testing.
> 
> I'll test that too, soon.
> Just to note that I left my hibernate loop run overnight, and now I am
> posting from my notebook after it did 590 hibernate cycles.

Did you have a chance to test it?

> Offtopic, but Note that to achieve that I had to stop using global acpi
> hardware lock. I tried all kinds of things, but for now it just hands
> from time to time.
> See http://bugzilla.kernel.org/show_bug.cgi?id=14668

I'm going to look at that later this week, although I'm not sure I can do more
than Alex about that.

Rafael
