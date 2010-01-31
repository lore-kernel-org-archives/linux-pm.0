From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [RFC][RFT][PATCH] ACPI: Protection from suspending
 in the middle of EC transaction
Date: Sun, 31 Jan 2010 19:09:20 +0200
Message-ID: <1264957760.7264.3.camel__33450.571637559$1264957875$gmane$org@maxim-laptop>
References: <201001310029.48717.rjw@sisk.pl>
	<9b2b86521001310611m339862afw73410dc7eb5692c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9b2b86521001310611m339862afw73410dc7eb5692c8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Sun, 2010-01-31 at 14:11 +0000, Alan Jenkins wrote: 
> On 1/30/10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Hi,
> >
> > While Maxim is testing if the patch below helps with
> > http://bugzilla.kernel.org/show_bug.cgi?id=14668
> > I think it's necessary anyway.
> >
> > The problem is that currently there's nothing to prevent us from suspending
> > in
> > the middle of an EC transaction in progress, at least as far as I can see.
> > As a result, we can suspend with the ACPI global lock held or something like
> > this, which leads to problems especially for hibernation (if the resume
> > kernel
> > passes control to the image kernel in the middle of an EC transaction,
> > things
> > aren't nice).  For this reason I think we should wait until there are no EC
> > transactions in progress before we suspend and we should prevent any new
> > EC transactions from starting after that point.  The patch below does that.

Unfortunately, this patch even causes regressions on my notebook (it
survive 63 hibernate cycles), but now I battery driver reports 'battery
absent', backlight driver reports 0 brightness, but reload helped.

I think that not only _PTS ans _WAK are problematic. What about other
ACPI drivers that start accessing the EC before it is resumed?
I think that these cause the problems I observe.

Still, at least it does resume.

Best regards,
Maxim Levitsky
