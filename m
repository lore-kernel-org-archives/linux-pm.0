From: Mattia Dongili <malattia@linux.it>
Subject: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR
Date: Tue, 19 Jun 2007 19:09:19 +0900
Message-ID: <20070619100919.GA4016__25047.2780819566$1182248262$gmane$org@inferi.kami.home>
References: <20070518071523.GA3195@inferi.kami.home>
	<20070518002240.bc08e811.akpm@linux-foundation.org>
	<20070519064829.GA15518@inferi.kami.home>
	<20070519000413.75badb6f.akpm@linux-foundation.org>
	<20070520061408.GA3325@inferi.kami.home>
	<1182243475.5411.101.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1182243475.5411.101.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 19, 2007 at 04:57:55PM +0800, Zhang Rui wrote:
...
> I tested this patch on several platforms but can not reproduce the bug.
> Could you please help me do a simple test please?
>
> Any kernel release later than 2.6.22-rc1 is ok. You don't need to apply 
> acpi-driver-model-flags-and-platform_enable_wake.patch.

2.6.22-rc5 *without* the patch

> Try to enable the wakeup GPE for all the USB devices first.
> e.g. "#echo USB1 >/proc/acpi/wakeup" will enable GPE for USB1.
> USB1      S3     disabled  pci:0000:00:1d.0
> USB2      S3     disabled  pci:0000:00:1d.1
> USB3      S3     disabled  pci:0000:00:1d.2
> USB4      S3     disabled  pci:0000:00:1d.3
> USB7      S3     disabled  pci:0000:00:1d.7
> 
> Try STR and check if it resumes immediately after suspend.
> I think the same problem will happen without this patch.

only after enabling USB7 the broken behaviour showed.

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02)

Quite consistent with the other findings.

Cheers
-- 
mattia
:wq!
