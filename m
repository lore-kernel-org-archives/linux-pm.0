From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.34-rc3 doesn't suspend to disk (-rc2 did)
Date: Fri, 2 Apr 2010 18:56:42 +0200
Message-ID: <201004021856.42092.rjw__46820.1216696345$1270227296$gmane$org@sisk.pl>
References: <alpine.LNX.2.00.1004020215100.8345@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LNX.2.00.1004020215100.8345@pobox.suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 02 April 2010, Jiri Kosina wrote:
> Hi,

Hi,

> I have just hit this problem. Haven't bisected it yet, and going through 
> shortlog doesn't ring any bell immediately, so I am sending this out in 
> case it rings a bell for someone right away.

No, and it works for me on a couple of systems.

> Calling 
> 
> 	s2disk -r /dev/sdb4
> 
> suspends without any issues on 2.6.34-rc2, and resume is also fine. With 
> 2.6.34-rc3 I get
> 
> 	s2disk: Could not use the resume device (try swapon -a). Reason: No such device
> 
> Relevant part of s2disk strace:
> 
> mount("none", "/proc/2449", "tmpfs", 0, NULL) = 0
> stat64("/dev/sdb4", {st_mode=S_IFBLK|0660, st_rdev=makedev(259, 65536), ...}) = 0
> chdir("/proc/2449")                     = 0
> mknod("resume", S_IFBLK|0600, makedev(259, 65536)) = 0
> open("resume", O_RDWR|O_LARGEFILE)      = 3
> stat64("/dev/snapshot", {st_mode=S_IFCHR|0660, st_rdev=makedev(10, 231), ...}) = 0
> open("/dev/snapshot", O_RDONLY|O_LARGEFILE) = 4
> ioctl(4, 0x400c330d, 0xbfdbcb04)        = -1 ENODEV (No such device)
> ioctl(4, 0x4004330a, 0x10010300)        = -1 ENODEV (No such device)
> write(2, "s2disk: Could not use the resume"..., 80s2disk: Could not use the resume device (try swapon -a). Reason: No such device

It seems that swap_type_of() returns error code for your swap device.

I'd put a couple of debug printks in there to see what happens.

Rafael
