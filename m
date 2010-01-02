From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Update] Re: [RFC] Asynchronous suspend/resume - test
	results
Date: Sat, 2 Jan 2010 22:28:31 +0100
Message-ID: <201001022228.31436.rjw__35245.6970992081$1262467739$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912211200200.2979-100000@iolanthe.rowland.org>
	<200912212136.12665.rjw@sisk.pl> <200912232135.25041.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912232135.25041.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 23 December 2009, Rafael J. Wysocki wrote:
> On Monday 21 December 2009, Rafael J. Wysocki wrote:
> > On Monday 21 December 2009, Alan Stern wrote:
> > > On Mon, 21 Dec 2009, Rafael J. Wysocki wrote:
> ...
> > > You should also make SCSI targets and hosts async.  Hosts are added in
> > > drivers/scsi/hosts.c:scsi_add_host_with_dma() (in 2.6.32 this was
> > > named scsi_add_host()).  Targets are added in
> > > drivers/scsi/scsi_sysfs.c:scsi_target_add().  And for thoroughness,
> > > SCSI devices are added in scsi_sysfs_add_sdev() in the same file.
> > 
> > Thanks a lot for the pointers.
> 
> I put device_enable_async_suspend() in all of these places and that resulted in
> major reduction of suspend time without starting the async threads upfront.
> Now, however, starting them upfront helps only a little, within the standard
> deviation from the "non-upfront" case.
> 
> In turn, resume _without_ starting the async threads upfront makes a little
> sense on my test boxes.  In fact, it only helped on the nx6325 and made things
> worse on the other two (I added the results from Toshiba Portege R500, but it
> has the same chipset as the Wind U100, ie. ICH7).
> 
> The results are as follows:
> 
> 			HP nx6325	MSI Wind U100	Toshiba Portege R500
> 
> sync suspend		1357 (+/- 35)	 656 (+/- 50)	 889 (+/- 29)
> sync resume		3027 (+/- 6)	3372 (+/- 30)	4552 (+/- 35)
> 
> async suspend		1053 (+/- 50)	 490 (+/- 42)	 620 (+/- 52)
> async resume		2291 (+/- 7)	3406 (+/- 52)	4557 (+/- 26)
> 
> async "upfront" suspend	1040 (+/- 35)	 476 (+/- 9)	 585 (+/- 29)
> async "upfront" resume	1787 (+/- 7)	1724 (+/- 48)	1990 (+/- 25)
> 
> The raw data are at
> http://www.sisk.pl/kernel/data/async-suspend-updated.pdf
> http://www.sisk.pl/kernel/data/r500/
> http://www.sisk.pl/kernel/data/nx6325/
> http://www.sisk.pl/kernel/data/wind/
> 
> and the previous results were moved into
> http://www.sisk.pl/kernel/data/091220/
> 
> The patches used in the testing are in my async branch at
> http://git.kernel.org/?p=linux/kernel/git/rafael/suspend-2.6.git;a=shortlog;h=refs/heads/async
> The patches in this branch are not for upstream, but it's on top of the 
> linux-next branch containing patches for the 2.6.34 merge window.

Here's a small update to this I thought might be interesting to someone.

Namely, I replaced the rotational disk in the Toshiba Portege R500 with an SSD
and ran a few suspend/resume speed tests with the KMS on (the previous results
for the R500 are with the userspace modesetting).  The results are here:

http://www.sisk.pl/kernel/data/r500-ssd/

As you can see here:

http://www.sisk.pl/kernel/data/r500/times-r500-async-resume.txt
http://www.sisk.pl/kernel/data/r500-ssd/times-r500-async-resume.txt

the resume times changed quite a bit.  First, the device 0:0:0:0+ (the SSD) now
takes about 0.33 s to resume (the rotational disk took about 1.7 s), pretty
much as expected.  Second, the slowest resuming device is now the graphics
(1.1 s), while without the KMS it resumed in no time.

The device suspend times also changed:

http://www.sisk.pl/kernel/data/r500/times-r500-async-suspend.txt
http://www.sisk.pl/kernel/data/r500-ssd/times-r500-async-suspend.txt

but 0:0:0:0+ is still the slowest suspending device, although it takes 200 ms
less to suspend than the rotational disk.

Overall, synchronous suspend of devices takes about 600 - 700 ms and
synchronous resume takes about 4 s.  At the same time, asynchronous suspend of
devices takes about 300 - 350 ms and asynchronous resume takes about
1.1 - 1.2 s (that is with the async resume threads started upfront).  So, with
the asynchronous suspend/resume the total times are roughly equal to the
suspend/resume time of the slowest device and the resume speedup is
more than 70%..

Rafael
