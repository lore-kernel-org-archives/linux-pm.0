From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Sky2 driver dies some time after resume
Date: Mon, 21 May 2007 18:29:17 -0300
Message-ID: <1179782957.32496.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
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
To: shemminger@linux-foundation.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Stephen,

I've noticing a weird behavior on sky2 driver after returning from
suspend. 

After returning, the driver works as expected. However, after some usage
at the interface, it behaves like if the network were down.

The workaround I'm currently using is manually removing sky2 driver and
reinserting.

This bug is present on all kernel versions I tested on this machine,
since when I bought it, on Feb, 2007. I'm currently running 2.6.20.7 on
this notebook.

The SKY2 hardware is:

02:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8038 PCI-E Fast Ethernet Controller [11ab:4352] (rev 14)
        Subsystem: Gateway 2000 Unknown device [107b:0367]
        Flags: bus master, fast devsel, latency 0, IRQ 318
        Memory at c0200000 (64-bit, non-prefetchable) [size=16K]
        I/O ports at a000 [size=256]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
        Capabilities: [e0] Express Legacy Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting

-- 
Cheers,
Mauro
