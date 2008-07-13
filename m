From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Sun, 13 Jul 2008 20:43:03 +0200
Message-ID: <487A4CB7.1080001__14515.461077872$1215974807$gmane$org@firstfloor.org>
References: <200807010148.02135.rjw@sisk.pl> <200807122253.32382.rjw@sisk.pl>
	<48793A0E.3050803@myrealbox.com> <200807130133.12324.rjw@sisk.pl>
	<20080713091524.GA29907@elte.hu>
	<20080713120253.GA27582@srcf.ucam.org>
	<487A2431.2050103@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <487A2431.2050103@myrealbox.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@myrealbox.com>
Cc: hpa@zytor.com, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Andy Lutomirski wrote:
> Matthew Garrett wrote:
>> On Sun, Jul 13, 2008 at 11:15:24AM +0200, Ingo Molnar wrote:
>>
>>> we still need to find the HAL quirk and disable it, right?
>>
>> Not without understanding what the cause is. If the video BIOS calls
>> are generically broken, then we have a problem.
>>
> 
> The HAL quirk is the very first one here:
> 
> http://gitweb.freedesktop.org/?p=hal-info.git;a=blob;f=fdi/information/10freedesktop/20-video-quirk-pm-lenovo.fdi
> 
> 
> I removed it from the HAL config and suspending w/ the hardware button
> works fine now with -rc9-wl and on Ubuntu's stock .24 kernel.

Hmm, but the change was not supposed to break the s3 bios. Something
fishy is going on. It sounds like the s3 bios relies on some earlier
segment register setup.

If true this means the segment register reset would need to be moved
later after S3 bios ran. Saving/restoring is unfortunately not possible
because we cannot save/restore the hidden state loaded from the GDT earlier.

This is unfortunately a little tricky with the new C wakeup code.

> I'll file the obvious bug report against HAL, but it might annoy users
> if new kernel + old HAL = broken system, 

It's the bad side effect of HAL effectively being an out of tree kernel
driver (that just by chance happens to run in user space). Really
all these s3 quirks at least should be in the kernel.

We can't really do much about that now, but longer term it might be useful
to invent some mechanism to tell HAL to disable specific quirks from
the kernel.

-Andi
