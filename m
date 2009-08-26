From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.31-rc7-git2: Reported regressions 2.6.29 ->
	2.6.30
Date: Wed, 26 Aug 2009 07:53:37 -0700
Message-ID: <20090826075337.4230d82c.akpm__10535.5251617313$1251298534$gmane$org@linux-foundation.org>
References: <JuOd1ZASH0B.A.YGB.0zGlKB@chimera>
	<b170af450908260147o60427997ne6b9872198893c41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <b170af450908260147o60427997ne6b9872198893c41@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Kernel Testers List <kernel-testers@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, DRI <dri-devel@lists.sourceforge.net>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Aug 2009 10:47:13 +0200 Rafa__ Mi__ecki <zajec5@gmail.com> wrote:

> 2009/8/25 Rafael J. Wysocki <rjw@sisk.pl>:
> > Bug-Entry __ __ __ : http://bugzilla.kernel.org/show_bug.cgi?id=13514
> > Subject __ __ __ __ : acer_wmi causes stack corruption
> > Submitter __ __ __ : Rus <harbour@sfinx.od.ua>
> > Date __ __ __ __ __ __: 2009-06-12 08:13 (75 days old)
> 
> It has patch, just Len doesn't seem to... don't know, read the topic?
> http://patchwork.kernel.org/patch/29082/
> 
> Can we ping Len somehow to push this patch directly to Linus's tree?
> 

I'm not seeing any linux-acpi emails from Len since August 14.

So I merged this patch and shall send it along with

thermal_sys-check-get_temp-return-value.patch
acpi-dont-call-acpi_processor_init-if-acpi-is-disabled.patch

in to Linus today.
