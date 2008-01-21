From: Manuel Arguelles <manuel.arguelles@gmail.com>
Subject: ACPI Sleep problem
Date: Mon, 21 Jan 2008 09:12:08 -0500
Message-ID: <200801210912.08733.manuel.arguelles@gmail.com>
Reply-To: manuel.arguelles@gmail.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
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
List-Id: linux-pm@vger.kernel.org

Hello list,

I have a laptop, dell latitude d810, running slackware linux 12.0, kernel: 
2.6.21.5 (vanilla as far as i know).

I can put it into sleep mode, but it doesn't came up, and I'm not sure how to 
debug it, I supposed it doesn't come up fully and not only the video, since 
if I wake it up, and type my loggin in and pass and type restart or similar 
nothing happends....

I have read that it's good to update teh dsdt, but from 
http://acpi.sourceforge.net/ there's only one:

Dell Latitude D810
Last Modified  2007-07-15 06:22 by inktvis75  
S4 Bios  no
Original  yes  
SMP  no
Bios Revision  09-30-2005  
APIC Table  no
Board Revision  A04  
Boot Table  no
DSDT Vendor  
C2 Latency  0
DSDT Product  
C3 Latency  0
DSDT Revision  0  
Dutywidth  0
Interpreter Fix
Features
Supersedes  none  Superseded By  none

Not sure if this will help, also the file is a .asl not sure how to handle or 
compile it (if needed?)

my cpu info is:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.73GHz
stepping        : 8
cpu MHz         : 1729.200
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx est tm2
bogomips        : 3461.65
clflush size    : 64


and my hard disk information:

/dev/sda:

ATA device, with non-removable media
        Model Number:       SAMSUNG MP0402H
        Serial Number:      S03WJ20YB44676
        Firmware Revision:  UC200-16
Standards:
        Used: ATA/ATAPI-7 T13 1532D revision 0
        Supported: 7 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:   78140160
        LBA48  user addressable sectors:   78140160
        device size with M = 1024*1024:       38154 MBytes
        device size with M = 1000*1000:       40007 MBytes (40 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 8
        Advanced power management level: unknown setting (0x0080)
        Recommended acoustic management value: 254, current value: 128
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    DOWNLOAD_MICROCODE
                Advanced Power Management feature set
                SET_MAX security extension
           *    Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    IDLE_IMMEDIATE with UNLOAD
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
                supported: enhanced erase
        44min for SECURITY ERASE UNIT. 44min for ENHANCED SECURITY ERASE UNIT.
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

any tips or help will be appreciated, thanks for your time
