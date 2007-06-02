From: "Mitch Davis" <mjd-kernel@afork.com>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Sat, 2 Jun 2007 21:08:18 +1000
Message-ID: <8956d4ca0706020408y4ddcea6ap35c8b7dee3fcbe32__46444.22931965$1180782544$gmane$org@mail.gmail.com>
References: <878xb35sje.fsf@goat.bogus.local> <200706012340.54394.rjw@sisk.pl>
	<87hcpr2ubl.fsf@goat.bogus.local> <200706020037.16615.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706020037.16615.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Olaf,

I'm also having troubles with the resume part of STR, although since
your hardware is significantly different to mine, the cause is likely
to be different.

On 6/2/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > >>
> > >> > On Friday, 1 June 2007 22:27, Olaf Dietsche wrote:
> > >> >> When I resume, everything seems to come up (fan becomes busy, disk and
> > >> >> dvd spin up for a short time),
>
> First, you can check if the patch
>
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc3/patches/20-ACPI-preserve-the-ebx-value-in-acpi_copy_wakeup_routine.patch
>
> helps, by chance.

(Rafael's suggestion may help you but it didn't help me)

> Second, you can use PM_TRACE (Documentation/power/s2ram.txt) to find the
> place where it really fails.

I modified my kernel source so it uses PM_TRACE to trace both the
suspend, and whether the BIOS ever jumps back into the kernel on
resume.  (In my case, I don't think the BIOS is doing the jump).

I also compiled with only the bare minimum of options turned on, and
use an initramfs to rule out device interactions.

If what I did is useful to you, you can find it here:

  http://bugzilla.kernel.org/show_bug.cgi?id=7988

And if you haven't already (and your problem occurs with a stock
kernel), you might want to log this as a bug like I did.

Hope this helps.

Mitch.
