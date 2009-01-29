From: Eric Sesterhenn <snakebyte@gmx.de>
Subject: Suspend regression, hang after matroxfb
Date: Thu, 29 Jan 2009 13:58:55 +0100
Message-ID: <20090129125855.GA4597@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: vandrove@vc.cvut.cz
List-Id: linux-pm@vger.kernel.org

hi,

on this box standby worked with 2.6.28, but is broken with 2.6.29-rc3.

Dmesg of startup
http://www.cccmz.de/~snakebyte/200.log
.config
http://www.cccmz.de/~snakebyte/config_200

When testing the devices 

root@computer-desktop:/sys/power# echo devices > pm_test 
root@computer-desktop:/sys/power# echo standby > state

I get this message: 

[  174.177445] PM: Preparing system for standby sleep
[  174.182706] Freezing user space processes ... (elapsed 0.00 seconds) done.
[  174.186096] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[  174.186903] PM: Entering standby sleep
[  174.620476] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[  174.621453] sd 2:0:0:0: [sda] Stopping disk
[  174.743784] serial 00:08: disabled
[  174.744389] matroxfb 0000:01:00.0: PCI INT A disabled

and the system does not seem to properly suspend / neither wakeup

root@computer-desktop:~# lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0a.0 Ethernet controller: Intel Corporation 82556 EtherExpress PRO/100 Smart (rev 03)
00:0c.0 SCSI storage controller: Adaptec AIC-7861 (rev 03)
00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:12.0 Multimedia audio controller: Rockwell International Device 4310
00:12.1 Communication controller: Rockwell International Riptide HSF 56k PCI Modem
00:12.2 Input device controller: Rockwell International Device 4312
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 03)

root@computer-desktop:~# lsmod
Module                  Size  Used by
nfsd                  217580  13 
exportfs                4608  1 nfsd
nfs                   253896  1 
lockd                  66984  2 nfsd,nfs
nfs_acl                 3328  2 nfsd,nfs
auth_rpcgss            36160  2 nfsd,nfs
sunrpc                185716  16 nfsd,nfs,lockd,nfs_acl,auth_rpcgss
ipv6                  252276  10 
fuse                   54188  1 
unix                   25404  96

root@computer-desktop:/usr/src/linux# cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 697.840
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1395.68
clflush size	: 32
power management:


After PM_VERBOSE enabled the log changes to this:

[ 1968.407273] PM: Syncing filesystems ... done.
[ 1968.424490] PM: Preparing system for standby sleep
[ 1968.431142] Freezing user space processes ... (elapsed 0.00 seconds) done.
[ 1968.434866] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[ 1968.435887] PM: Entering standby sleep
[ 1968.436580] agpgart-intel 0000:00:00.0: preparing suspend
[ 1968.436683] pci 0000:00:01.0: preparing suspend
[ 1968.436788] pci 0000:00:07.0: preparing suspend
[ 1968.436877] ata_piix 0000:00:07.1: preparing suspend
[ 1968.436998] uhci_hcd 0000:00:07.2: preparing suspend
[ 1968.437091] piix4_smbus 0000:00:07.3: preparing suspend
[ 1968.437213] pci 0000:00:0a.0: preparing suspend
[ 1968.437301] aic7xxx 0000:00:0c.0: preparing suspend
[ 1968.437420] 8139too 0000:00:0e.0: preparing suspend
[ 1968.437511] RIPTIDE 0000:00:12.0: preparing suspend
[ 1968.437617] pci 0000:00:12.1: preparing suspend
[ 1968.437705] pci 0000:00:12.2: preparing suspend
[ 1968.437807] matroxfb 0000:01:00.0: preparing suspend
[ 1968.438056] platform pcspkr: preparing suspend
[ 1968.438166] platform microcode: preparing suspend
[ 1968.438321] vga16fb vga16fb.0: preparing suspend
[ 1968.442065] serial8250 serial8250: preparing suspend
[ 1968.442857] usb usb1: preparing type suspend, may wakeup
[ 1968.442995] i8042 i8042: preparing suspend
[ 1968.443144] rtc-test rtc-test.0: preparing suspend
[ 1968.443256] rtc-test rtc-test.1: preparing suspend
[ 1968.443785] ac97 0-0:unknown codec: legacy suspend
[ 1968.443960] fschmd 3-0073: legacy suspend
[ 1968.444151] rtc rtc2: legacy class suspend
[ 1968.444252] rtc-test rtc-test.1: suspend
[ 1968.444351] rtc rtc1: legacy class suspend
[ 1968.444501] rtc-test rtc-test.0: suspend
[ 1968.444638] rtc rtc0: legacy class suspend
[ 1968.444883] atkbd serio0: legacy suspend
[ 1968.872096] i8042 i8042: suspend
[ 1968.872384] usb usb1: type suspend, may wakeup
[ 1968.872581] sd 2:0:0:0: legacy suspend
[ 1968.872881] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[ 1968.873883] sd 2:0:0:0: [sda] Stopping disk
[ 1968.992131] scsi 1:0:0:0: legacy suspend
[ 1968.992852] serial8250 serial8250: suspend
[ 1968.992997] drm card0: legacy class suspend
[ 1968.996728] vga16fb vga16fb.0: suspend
[ 1968.996920] platform microcode: suspend
[ 1968.997059] platform pcspkr: suspend
[ 1968.997256] serial 00:08: legacy suspend
[ 1968.998043] serial 00:08: disabled
[ 1968.998213] pnp 00:07: legacy suspend
[ 1968.998343] i8042 kbd 00:06: legacy suspend
[ 1968.998498] pnp 00:05: legacy suspend
[ 1968.998626] pnp 00:04: legacy suspend
[ 1968.998754] rtc_cmos 00:03: legacy suspend, may wakeup
[ 1968.998980] pnp 00:02: legacy suspend
[ 1968.999109] system 00:01: legacy suspend
[ 1968.999262] pnp 00:00: legacy suspend
[ 1968.999410] matroxfb 0000:01:00.0: suspend
[ 1968.999737] matroxfb 0000:01:00.0: PCI INT A disabled

I am not sure if a bisection makes sense
with all those suspend bugs.


Greetings Eric
