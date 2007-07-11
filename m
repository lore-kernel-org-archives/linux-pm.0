From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: Hibernate after alarm wakes from STR
Date: Wed, 11 Jul 2007 09:04:33 -0700
Message-ID: <200707110904.33696.david-b__4723.84229437939$1184170167$gmane$org@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707100951.04193.david-b@pacbell.net>
	<200707110816.42114.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707110816.42114.nigel@nigel.suspend2.net>
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
To: nigel@suspend2.net
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Richard Hughes <hughsient@gmail.com>, rtc-linux@googlegroups.com
List-Id: linux-pm@vger.kernel.org

On Tuesday 10 July 2007, Nigel Cunningham wrote:
> Yeah, the bit I consider to be ugly is opening the files from within the 
> kernel, but it seemed to be necessary in order to provide the functionality 
> without having to rely on userspace or do some sort of messy work to figure 
> out how to access the lid button and so on.

Perhaps there should be a formal API to such buttons.


> Re proc files, are the button files already exposed under sysfs and I just 
> don't know? If so, I'll happily shift to using them.

ascent:/sys/devices/acpi_system:00/device:00/PNP0C0D:00$ ls -l 
total 0
lrwxrwxrwx 1 root root    0 2007-07-11 08:58 bus -> ../../../../bus/acpi/
lrwxrwxrwx 1 root root    0 2007-07-11 08:58 driver -> ../../../../bus/acpi/drivers/button/
-r--r--r-- 1 root root 4096 2007-07-11 08:58 hid
lrwxrwxrwx 1 root root    0 2007-07-11 08:58 input:event2 -> ../../../../class/input/input2/event2/
lrwxrwxrwx 1 root root    0 2007-07-11 08:58 input:input2 -> ../../../../class/input/input2/
-r--r--r-- 1 root root 4096 2007-07-11 08:58 path
drwxr-xr-x 2 root root    0 2007-07-11 08:58 power/
lrwxrwxrwx 1 root root    0 2007-07-11 08:58 subsystem -> ../../../../bus/acpi/
-rw-r--r-- 1 root root 4096 2007-07-11 08:58 uevent
db@ascent:/sys/devices/acpi_system:00/device:00/PNP0C0D:00$ cat path
\_SB_.LID_
ascent:/sys/devices/acpi_system:00/device:00/PNP0C0D:00$ 

If the generic kernel doesn't show that, then it's likely
a consequence of a submitted-but-not-yet-merged patch.

- Dave
