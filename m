From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH] PM: disable nonboot cpus before
	suspending devices
Date: Mon, 1 Feb 2010 07:57:06 -0800
Message-ID: <20100201075706.69b1d2c0.akpm__19428.0315343805$1265039982$gmane$org@linux-foundation.org>
References: <alpine.LFD.2.00.1001221841490.2266@localhost>
	<201001252237.42545.rjw@sisk.pl>
	<alpine.LFD.2.00.1002011527580.5334@localhost>
	<201002011630.04281.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002011630.04281.rjw@sisk.pl>
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
Cc: Benjamin@smtp1.linux-foundation.org, linux-kernel@vger.kernel.org, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 1 Feb 2010 16:30:04 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Monday 01 February 2010, Sebastian Ott wrote:
> > Hi Rafael,
> > 
> > since you didn't like the idea of calling the driver callbacks with just
> > one cpu enabled, we gave your patch: "MM / PM: Force GFP_NOIO during
> > suspend/hibernation and resume" a try and i can confirm that this
> > fixes the issue on s390.
> 
> Great, thanks for testing!
> 
> > Will this go in 2.6.33/stable?
> 
> That depends on Andrew, actually.
> 
> Andrew, what do you think of the patch at:
> http://patchwork.kernel.org/patch/74740/mbox/ ?
> 
> It helps people and I don't see any major drawbacks of it.
> 

Seems sane.  A couple of minor things:

- the names mm_force_noio_allocations() and mm_allow_io_allocations()
  are a bit sucky.  Asymmetrical.

- the functions don't nest: if someone calls
  mm_force_noio_allocations() twice in succession then the kernel is
  all mucked up.  Why not:

gfp_t mm_set_gfp_mask(gfp_t mask)
{
	gfp_t ret = gfp_allowed_mask;

	gfp_allowed_mask = mask;
	return ret;
}

which is of course racy :)  Could add a local spinlock if really worried.

All your current callers can easily save the old value in a local.
