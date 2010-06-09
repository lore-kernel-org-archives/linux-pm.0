From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.35-rc2-git2: Reported regressions from 2.6.34
Date: Wed, 9 Jun 2010 07:24:12 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1006090719440.4506__46599.9611690224$1276093600$gmane$org@i5.linux-foundation.org>
References: <Rlf_Qjov7bG.A.a8F.I8rDMB@chimera>
	<alpine.LFD.2.00.1006081814240.4506@i5.linux-foundation.org>
	<201006091106.11232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006091106.11232.rjw@sisk.pl>
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
Cc: Venkatesh Pallipadi <venki@google.com>, DRI <dri-devel@lists.sourceforge.net>, Mauro Carvalho Chehab <mchehab@redhat.com>, Eric Dumazet <eric.dumazet@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jens Axboe <jaxboe@fusionio.com>, Linux PM List <linux-pm@lists.linux-foundation.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Eric Anholt <eric@anholt.net>, Carl Worth <cworth@cworth.org>, =?ISO-8859-15?Q?David__H=E4rdeman?= <david@hardeman.nu>, Network Development <netdev@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Kernel Testers List <kernel-testers@vger.kernel.org>, Dave Airlie <airlied@gmail.com>
List-Id: linux-pm@vger.kernel.org



On Wed, 9 Jun 2010, Rafael J. Wysocki wrote:
> > 
> > That has a "reverting the commit fixes it", and a confirmation from Nick 
> > Bowler.
> > 
> > Eric, Carl: should I just revert that commit? Or do you have a fix?
> 
> This one is reported to have been fixed already.  Closed now.

Heh. That "fixed already" is actually the revert. Carl acked it.

> This should be fixed by commit f8ed8b4c5d30b5214f185997131b06e35f6f7113, so
> closing now.

Good, that was in yesterday's drm pull.

		Linus
