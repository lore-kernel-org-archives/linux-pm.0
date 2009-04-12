From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [2.6.30-rc1-git2 regressions] Hibernation broken and
 (minor but annoying) audio problem
Date: Sun, 12 Apr 2009 11:27:36 -0700
Message-ID: <49E23298.5050702__1192.02561113543$1239561158$gmane$org@linux.intel.com>
References: <200904100057.43827.rjw@sisk.pl>
	<alpine.LFD.2.00.0904111253520.4583@localhost.localdomain>
	<49E0F805.2090502@linux.intel.com>
	<200904122006.57425.rjw@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904122006.57425.rjw@suse.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> 
> OK, updated patch follows, with a changelog.
> 
> I've added this check to user.c too, because that code can be called
> independently of the one in disk.c .  Also, if resume is user space-driven,
> it's a good idea to wait for all of the device probes to complete before
> continuing.
> 
> Thanks,
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM/Hibernate: Wait for SCSI devices scan to complete during resume
> 
> There is a race between resume from hibernation and the asynchronous
> scanning of SCSI devices and to prevent it from happening we need to
> call scsi_complete_async_scans() during resume from hibernation.
> 
> In addition, if the resume from hibernation is userland-driven, it's
> better to wait for all device probes in the kernel to complete before
> attempting to open the resume device.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

looks like a good fix to me (regardless of the async stuff)

Acked-by: Arjan van de Ven <arjan@linux.intel.com>
