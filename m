From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: 2.6.37-rc5, pata_atiixp,
 DVD-ROM: kernel log flooded with "rpm_resume flags 0x4",
 "rpm_resume returns 1"
Date: Fri, 17 Dec 2010 21:30:34 +0100
Message-ID: <20101217213034.7bf6587c__11571.143664378$1292617902$gmane$org@stein>
References: <20101211173234.77617d3a@stein>
	<Pine.LNX.4.44L0.1012111425520.14704-100000@netrider.rowland.org>
	<20101217211556.2789cb80@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101217211556.2789cb80@stein>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Dec 17 Stefan Richter wrote:
> On Dec 11 Alan Stern wrote:
> > This is probably because hal probes the DVD drive every two seconds
> > looking for media changes.  However that's not supposed to cause
> > rpm_resume to be called for the host unless runtime PM is allowed for
> > the DVD drive, which it isn't according to your listings below.  So
> > there's a bug somewhere.
> 
> I had 2.6.36 running since then and have now booted into 2.6.37-rc6.
> 
> Yes, it is hal indeed.  Shutting hal down avoids this logging activity.
[...]
> Actually, this time I see once every two seconds a message about
> logical unit 6:0:0:0 and 6 times every two seconds a message about
> host7:
> 
> Dec 17 20:22:08 stein kernel: sd 6:0:0:0: rpm_resume flags 0x4
> Dec 17 20:22:08 stein kernel: sd 6:0:0:0: rpm_resume returns 1
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume returns 1
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume returns 1
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume returns 1
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume returns 1
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume returns 1
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume returns 1
> Dec 17 20:22:10 stein kernel: sd 6:0:0:0: rpm_resume flags 0x4
> Dec 17 20:22:10 stein kernel: sd 6:0:0:0: rpm_resume returns 1
> Dec 17 20:22:10 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:10 stein kernel: scsi host7: rpm_resume returns 1
> Dec 17 20:22:10 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:10 stein kernel: scsi host7: rpm_resume returns 1
> Dec 17 20:22:10 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:10 stein kernel: scsi host7: rpm_resume returns 1
> Dec 17 20:22:10 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:10 stein kernel: scsi host7: rpm_resume returns 1
> Dec 17 20:22:10 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:10 stein kernel: scsi host7: rpm_resume returns 1
> Dec 17 20:22:10 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:10 stein kernel: scsi host7: rpm_resume returns 1
> 
> sd 6:0:0:0 is a USB card reader built into a monitor:
> Host: scsi6 Channel: 00 Id: 00 Lun: 00
>   Vendor: Generic  Model: Ultra HS-SD/MMC  Rev: 1.88
>   Type:   Direct-Access                    ANSI  SCSI revision: 00

Well right --- hald polls the card reader for media change too.

I now noticed that the two lines
	sd *:0:0:0: rpm_resume flags 0x4
	sd *:0:0:0: rpm_resume returns 1
are logged once for each sd device (i.e. those with fixed media too)
at the startup of hald.  Is this expected?

Note, I have not seen anything of the sort on another PC which runs
2.3.37-rc6 with the same PM debug options.  The differences are that
the other PC is an Intel 945GM based one with x86-32 kernel and 32bit
Gentoo userland, whereas the PC with log spam is an AMD RS780 based one
with x86-64 kernel and 64bit Gentoo userland.  Both got hal 0.5.14-r2.
-- 
Stefan Richter
-=====-==-=- ==-- =---=
http://arcgraph.de/sr/
