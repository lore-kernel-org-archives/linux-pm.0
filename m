From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [2/2] 2.6.21-rc7: known regressions
Date: Thu, 19 Apr 2007 22:15:48 -0700
Message-ID: <46284C84.6060301@goop.org>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org> <20070416003723.GM3691@stusta.de> <4628482B.6040804@goop.org> <20070420050344.GG20566@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754432AbXDTFP5@vger.kernel.org>
In-Reply-To: <20070420050344.GG20566@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz, linux-pm@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

Dave Jones wrote:
> Do you have the backlight code enabled ?
> I'm guessing not.
>   

Hm, think so.  backlight controls work, via both
/proc/acpi/ibm/backlight and /sys/class/backlight/*/brightness.

$ ls -l /sys/class/backlight/
total 0
drwxr-xr-x 2 root root 0 Apr 19 22:13 acpi_video0
drwxr-xr-x 2 root root 0 Apr 19 22:13 acpi_video1
drwxr-xr-x 2 root root 0 Apr 19 22:13 ibm


    J
