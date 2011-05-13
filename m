From: "Michael Leun" <lkml20100708@newton.leun.net>
Subject: AHCI driver problem on ICH (Re: AHCI driver problem on
 SB700/SB800 w/ Acer Ferrari One)
Date: Fri, 13 May 2011 14:37:58 +0200
Message-ID: <20110513143758.33f68a77__9907.72210429913$1305564254$gmane$org@xenia.leun.net>
References: <201105120025.34531.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105120025.34531.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 May 2011 00:25:34 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> There seems to be a problem on my Acer box which is related to DIPM
> and switching the power source.  Namely, when I detach the AC adapter
> from the machine, the disk (which is an Intel SSD) freezes for a
> while and something like this appears in dmesg:
[...]

Since updating to 2.6.39-rc7 (from 2.6.38.x) I have similar problems
with two notebooks using Intel ICH:

Acer PTZ1825
00:1f.2 SATA controller: Intel Corporation ICH9M/M-E SATA AHCI
Controller (rev 03) (prog-if 01 [AHCI 1.0]) Subsystem: Acer
Incorporated [ALI] Device 0300 Flags: bus master, 66MHz, medium devsel,
latency 0, IRQ 42 I/O ports at 30e8 [size=8]
        I/O ports at 30fc [size=4]
        I/O ports at 30e0 [size=8]
        I/O ports at 30f8 [size=4]
        I/O ports at 3020 [size=32]
        Memory at d4504000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [80] MSI: Enable+ Count=1/16 Maskable- 64bit-
        Capabilities: [70] Power Management version 3
        Capabilities: [a8] SATA HBA v1.0
        Capabilities: [b0] PCI Advanced Features
        Kernel driver in use: ahci


Dell Latitude E6510
00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset
6 port SATA AHCI Cont roller (rev 05) (prog-if 01 [AHCI 1.0])
        Subsystem: Dell Device 040b
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 41
        I/O ports at 8090 [size=8]
        I/O ports at 8080 [size=4]
        I/O ports at 8070 [size=8]
        I/O ports at 8060 [size=4]
        I/O ports at 8020 [size=32]
        Memory at e9640000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [70] Power Management version 3
        Capabilities: [a8] SATA HBA v1.0
        Capabilities: [b0] PCI Advanced Features
        Kernel driver in use: ahci

Patch not tried yet (do not know / not looked into yet where to change
for this chipset).

Seems to be a 2.6.39-rcX regression?


-- 
MfG,

Michael Leun
