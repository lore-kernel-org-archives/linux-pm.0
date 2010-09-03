From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [Bisected Regression in 2.6.35] A full tmpfs
	filesystem causeshibernation to hang
Date: Fri,  3 Sep 2010 09:13:37 +0900 (JST)
Message-ID: <20100903085756.B657.A69D9226__37300.3047345721$1283472888$gmane$org@jp.fujitsu.com>
References: <201009022157.18561.rjw@sisk.pl> <201009022224.59313.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009022224.59313.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, "M. Vefa Bicakci" <bicave@superonline.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kosaki.motohiro@jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

Hello,

> > > > Like in the patch below, perhaps?
> > > 
> > > Looks like fine. but I have one question. hibernate_preallocate_memory() call
> > > preallocate_image_memory() two times. Why do you only care latter one?
> > > former one seems similar risk.
> > 
> > The first one is mandatory, ie. if we can't allocate the requested number of
> > pages at this point, we fail the entire hibernation.  In that case the
> > performance hit doesn't matter.
> 
> IOW, your patch at http://lkml.org/lkml/2010/9/2/262 is still necessary to
> protect against the infinite loop in that case.

As far as I understand, we need distinguish two allocation failure.
  1) failure because no enough memory
	-> yes, hibernation should fail
 2) failure because already allocated enough lower zone memory
	-> why should we fail?

If the system has a lot of memory, scenario (2) is happen frequently than (1).
I think we need check alloc_highmem and alloc_normal variable and call
preallocate_image_highmem() again instead preallocate_image_memory()
if we've alread allocated enough lots normal memory.

nit?
