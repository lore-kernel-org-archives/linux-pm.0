From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / Hibernate: Make default image size
	depend on totalRAM size
Date: Mon, 13 Sep 2010 19:52:57 +0200
Message-ID: <201009131952.57862.rjw__8085.64079129628$1284402033$gmane$org@sisk.pl>
References: <201009062043.37819.rjw@sisk.pl> <201009120027.06470.rjw@sisk.pl>
	<4C8E45EB.8030408@superonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C8E45EB.8030408@superonline.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "M. Vefa Bicakci" <bicave@superonline.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, September 13, 2010, M. Vefa Bicakci wrote:
> On 11/09/10 06:27 PM, Rafael J. Wysocki wrote:
> > On Saturday, September 11, 2010, Rafael J. Wysocki wrote:
> >> On Saturday, September 11, 2010, M. Vefa Bicakci wrote:
> > ...
> >>>
> >>> I would be glad to test that patch as well, to see if it brings speed-ups.
> >>> Actually, I might test hibernation with a larger value written to
> >>> /sys/power/image_size when I have time.
> >>
> >> I think that would improve things, as it probably is impossible to reduce the
> >> image size to 500 MB on your system.
> >>
> >> Anyway, I'll let you know when the patch is ready.
> > 
> > OK, please try the patch below on top of the previous one and see if it makes
> > hibernation run faster on your system.
> 
> Dear Rafael Wysocki,
> 
> I think I have good news. I took a clean 2.6.35.4 tree, and first applied
> the latest version of your larger snapshot.c patch, and then the patch you
> appended to your final e-mail in this thread.
> 
> Here is a comparison of the timings from a kernel without your patch, and
> one with it.
> 
> === 8< ===
> Sep 11 10:22:24 debian kernel: [  499.968989] PM: Allocated 2531300 kbytes in 52.66 seconds (48.06 MB/s)
> Sep 11 10:44:08 debian kernel: [  764.379131] PM: Allocated 2531308 kbytes in 143.41 seconds (17.65 MB/s)
> Sep 11 10:48:41 debian kernel: [  920.626386] PM: Allocated 2531300 kbytes in 66.44 seconds (38.09 MB/s)
> Sep 11 10:53:37 debian kernel: [ 1092.919140] PM: Allocated 2531316 kbytes in 81.28 seconds (31.14 MB/s)
> ...
> Sep 13 01:26:09 debian kernel: [   94.948054] PM: Allocated 1804008 kbytes in 28.72 seconds (62.81 MB/s)
> Sep 13 01:29:58 debian kernel: [  176.678880] PM: Allocated 1803992 kbytes in 34.44 seconds (52.38 MB/s)
> Sep 13 01:33:48 debian kernel: [  253.336405] PM: Allocated 1804000 kbytes in 27.35 seconds (65.95 MB/s)
> === >8 ===
> 
> I didn't have your latest patch applied on September 11, and it was applied
> last night.
> 
> It looks like there is a good improvement. I think the data rates look
> faster on Sept. 13 because the kernel spent less time "thinking" less
> while compacting the memory image. (I don't think I have changed anything
> in my configuration that could affect the data rates that much.)

OK, thanks for testing and information.

> Is it possible to have these patches applied to the 2.6.35 tree so that
> the regression I reported is fixed?

The "snapshot.c" patch has just been included into the Linus' tree as

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6715045ddc7472a22be5e49d4047d2d89b391f45

> Should I e-mail Greg Kroah-Hartman about this?

and I've already told Greg that it should go into 2.6.35.y.

The second patch, however, only changes the default value of image_size, so it
is not -stable material.

As a workaround, you can change the init scripts on your system to set
/sys/power/image_size to the same value that's in it when the second patch is
applied.

Thanks,
Rafael
