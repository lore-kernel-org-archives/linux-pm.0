From: Jiri Slaby <jirislaby@gmail.com>
Subject: 2.6.21-rc5: swsusp: Not enough free memory
Date: Thu, 29 Mar 2007 09:44:11 +0200
Message-ID: <460B6E4B.3060004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

I'm getting this while trying to swsups the machine in -rc5, -rc4 is fine:

Disabling non-boot CPUs
CPU 1 is now offline
SMP alternatives: switching to UP code
CPU1 is down
swsusp: critical section:
swsusp: Need to copy 131380 pages
swsusp: Not enough free memory
Error -12 suspending
Enabling non-boot CPUs ...

# cat /sys/power/resume
8:6
# cat /proc/swaps
Filename                                Type            Size    Used    Pri=
ority
/dev/sda6                               partition       1004020 0       -1

Any other info needed?

BTW. is this OK on resume?
PM: Writing back config space on device 0000:02:00.0 at offset 1 (was 10000=
6, w
iting 100002)
pnp: Failed to activate device 00:04.
pnp: Failed to activate device 00:05.
 usbdev5.3_ep00: PM: resume from 0, parent 5-4 still 2

# ll /sys/bus/pnp/devices/00\:0{4,5}/driver
lrwxrwxrwx 1 root root 0 2007-03-29 09:16 /sys/bus/pnp/devices/00:04/driver
-> ../../../bus/pnp/drivers/i8042 kbd
lrwxrwxrwx 1 root root 0 2007-03-29 09:16 /sys/bus/pnp/devices/00:05/driver
-> ../../../bus/pnp/drivers/i8042 aux

regards,
-- =

http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

Hnus <hnus@fi.muni.cz> is an alias for /dev/null
