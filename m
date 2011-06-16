From: Brad Campbell <brad@wasp.net.au>
Subject: 32 bit s2disk on 64 bit kernel
Date: Thu, 16 Jun 2011 23:13:41 +0800
Message-ID: <4DFA1DA5.1010502@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

<oops, sent this to the wrong list..>

I run an entirely 32 bit userspace on a 64bit kernel. I've compiled suspend-utils from todays git 
tree. trying to use s2disk results in the following :

Is this a supported configuration?

brad@bklaptop:~$ sudo s2disk
s2disk: Could not use the resume device (try swapon -a). Reason: Invalid argument
brad@bklaptop:~$ dmesg | tail -n3
[  823.530812] video LNXVIDEO:00: Restoring backlight state
[  834.100071] iwlagn 0000:02:00.0: iwlagn_tx_agg_start on ra = 00:26:f2:94:ba:59 tid = 0
[  842.392066] iwlagn 0000:02:00.0: iwlagn_tx_agg_start on ra = 00:26:f2:94:ba:59 tid = 0

snip of strace
open("resume", O_RDWR|O_LARGEFILE)      = 3
stat64("/dev/snapshot", {st_mode=S_IFCHR|0660, st_rdev=makedev(10, 231), ...}) = 0
open("/dev/snapshot", O_RDONLY|O_LARGEFILE) = 4
ioctl(4, 0x400c330d, 0xffe07a3c)        = -1 EINVAL (Invalid argument)
ioctl(4, 0x4004330a, 0x805)             = -1 EINVAL (Invalid argument)
write(2, "s2disk: Could not use the resume"..., 82s2disk: Could not use the resume device (try 
swapon -a). Reason: Invalid argument

echo mem > /sys/power/state
.. works fine, but no compression, status or encryption.

Regards,
Brad
-- 
Dolphins are so intelligent that within a few weeks they can
train Americans to stand at the edge of the pool and throw them
fish.
