From: "Kay Sievers" <kay.sievers@vrfy.org>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while
	suspended (rev. 2)
Date: Wed, 2 Jan 2008 15:55:00 +0100
Message-ID: <3ae72650801020655h6ec31ce8n5cd9014c00c9f6ad__31915.9904764549$1199289230$gmane$org@mail.gmail.com>
References: <200801020032.45529.rjw@sisk.pl> <20080102105217.GA14731@elte.hu>
	<200801021356.59865.rjw@sisk.pl> <20080102131529.GA32160@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080102131529.GA32160@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Jan 2, 2008 2:15 PM, Ingo Molnar <mingo@elte.hu> wrote:
> A stupid question. The old RTC driver is in
> drivers/char/rtc.c, and maps to:
>
>   crw-r--r-- 1 root root  10, 135 Oct 25 18:02 /dev/rtc
>
> the new driver is in drivers/rtc/*, and maps to:
>
>   crw-r--r-- 1 root root 254,   0 Dec 12 02:30 /dev/rtc0
>
> but all the x86 distro boxes i have access to make use of /dev/rtc.
> There's no symlink set up from /dev/rtc to /dev/rtc0 either. So it
> appears to me that the new RTC driver isnt actually utilized on most
> distributions.
>
> shouldnt we provide a Kconfig way of replacing dev 10:135 with the new
> driver's 254:0 device? (while keeping all the current modes of operation
> as well, of course.) It's all supposed to be 100% ioctl ABI compatible
> with the old driver, right?

It's not compatible enough to "fake" only the old major/minor. Userspace
must be fixed not to depend on stuff like:  /proc/sys/dev/rtc/max-user-freq:
  http://lkml.org/lkml/2007/8/4/183

> That way distros could start migrating to it
> as well, without depending on any udev hackery.

It's in the default udev setup:
  KERNEL=="rtc|rtc0",             MODE="0644"
  KERNEL=="rtc0",                 SYMLINK+="rtc"

Kay
