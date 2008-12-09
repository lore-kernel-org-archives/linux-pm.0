From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] Firewire node manager causes up to ~3.25s
 delay in freezing tasks.
Date: Tue, 09 Dec 2008 18:16:33 +0100
Message-ID: <493EA7F1.3060501__15518.4970856228$1228843286$gmane$org@s5r6.in-berlin.de>
References: <1228822820.6681.22.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1228822820.6681.22.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: krh@redhat.com, linux-pm <linux-pm@lists.linux-foundation.org>, linux1394-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Nigel Cunningham wrote:
> Hi all.
> 
> (Okay, having learnt that ieee1394 != bluetooth, I'll try again :>)
> 
> The firewire nodemanager function "nodemgr_host_thread" contains a loop
> that calls try_to_freeze near the top of the loop, but then delays for
> up to 3.25 seconds (plus time to do work) before getting back to the top
> of the loop. When starting a cycle post-boot, this doesn't seem to bite,
> but it is causing a noticeable delay at boot time, when freezing
> processes prior to starting to read the image.

In 2.6.27 and less, these were only 0.25 seconds.  The 3 additional
seconds in 2.6.28-rc are my doing and sort of a regression.  It occurs
to me that I should send this patch to mainline before release.

> The following patch adds invocation of try_to_freeze to the subloops
> that are used in the body of this function. With these additions, the
> time to freeze when starting to resume at boot time is virtually zero.
> I'm no expert on bluetooth, and so don't know that we shouldn't check
> the return value and jump back to the top of the loop or such like after
> being frozen, but I submit it for your consideration.
> 
> Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>

As far as I can tell, try_to_freeze() without any jump is correct.

>  nodemgr.c |    2 ++
>  1 file changed, 2 insertions(+)
> diff -ruNp 710-nodemanager-freezing.patch-old/drivers/ieee1394/nodemgr.c 710-nodemanager-freezing.patch-new/drivers/ieee1394/nodemgr.c
> --- 710-nodemanager-freezing.patch-old/drivers/ieee1394/nodemgr.c	2008-12-06 08:42:08.000000000 +1100
> +++ 710-nodemanager-freezing.patch-new/drivers/ieee1394/nodemgr.c	2008-12-09 18:49:26.000000000 +1100
> @@ -1685,6 +1685,7 @@ static int nodemgr_host_thread(void *dat
>  		g = get_hpsb_generation(host);
>  		for (i = 0; i < 4 ; i++) {
>  			msleep_interruptible(63);
> +			try_to_freeze();
>  			if (kthread_should_stop())
>  				goto exit;
>  

Here we have the goal to proceed only >= 0.25s after the last bus reset
happened.  While the new try_to_freeze() held up nodemgr, another bus
reset may happen.  But we check for this later in the loop and handle
it, so this is OK.

> @@ -1725,6 +1726,7 @@ static int nodemgr_host_thread(void *dat
>  		/* Sleep 3 seconds */
>  		for (i = 3000/200; i; i--) {
>  			msleep_interruptible(200);
> +			try_to_freeze();
>  			if (kthread_should_stop())
>  				goto exit;
>  

Ditto, the rest of the loop catches the case that another bus reset
occurred during the sleep or freeze.

Thanks for what appears to be a regression fix,
-- 
Stefan Richter
-=====-==--- ==-- -=--=
http://arcgraph.de/sr/
