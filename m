From: Alex Levin <Alex.Levin@csr.com>
Subject: Using swsusp on embedded Linux
Date: Wed, 18 Apr 2012 10:48:44 +0000
Message-ID: <E50E3A7B24E4904D9DD8FAAFB97AA8E30DBE5738@HAIEUREXM01.EUROPE.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

I'm trying to use swsusp on an embedded Linux system (kernel - 2.6.32) and I encounter a the next problem:

I'm using our own driver for a block device for a swap partition (a partition on a non-volatile memory device e.g. NAND SD) and while mkswap and swapon acturally creates a swap partition on the device, the command echo disk > /sys/power/state gets stuck (cpu_idle() ).

/dev/cb0 is the swap partition.

I would appreciate if you could help me.

Thank you very much,
Alex.



Here if the log: (with logLevel=9 and CONFIG_PM_DEBUG) 

~ # echo disk > /sys/power/state 
[   72.273000] device: 'vcs63': device_add
[   72.274000] PM: Adding info for No Bus:vcs63
[   72.275000] device: 'vcsa63': device_add
[   72.275000] PM: Adding info for No Bus:vcsa63
[   72.293000] PM: Basic memory bitmaps created
[   72.298000] PM: Syncing filesystems ... done.
[   72.308000] Freezing user space processes ... (elapsed 0.00 seconds) done.
[   72.316000] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[   72.324000] PM: Preallocating image memory... done (allocated 6708 pages)
[   72.386000] PM: Allocated 26832 kbytes in 0.05 seconds (536.64 MB/s)
[   72.392000] platform ci13610-udc.0: preparing freeze
[   72.398000] serial8250 serial8250: preparing freeze
[   72.403000] gmac_drv_eth gmac_drv_eth.0: preparing freeze
[   72.409000] cb cb.0: preparing freeze
[   72.413000] cb cb.1: preparing freeze
[   72.416000] platform rtevent.0: preparing freeze
[   72.421000] platform rtevent.0: freeze
[   72.425000] cb cb.1: freeze
[   72.428000] cb cb.0: freeze
[   72.431000] gmac_drv_eth gmac_drv_eth.0: freeze
[   72.436000] serial8250 serial8250: freeze
[   72.440000] platform ci13610-udc.0: freeze
[   72.445000] platform rtevent.0: LATE freeze
[   72.450000] cb cb.1: LATE freeze
[   72.453000] cb cb.0: LATE freeze
[   72.456000] gmac_drv_eth gmac_drv_eth.0: LATE freeze
[   72.462000] serial8250 serial8250: LATE freeze
[   72.466000] platform ci13610-udc.0: LATE freeze
[   72.471000] Checking wake-up interrupts
[   72.471000] Suspending System Devices
[   72.471000] Suspending type 'clocksource':
[   72.471000]  clocksource0
[   72.471000] Suspending type 'timekeeping':
[   72.471000]  timekeeping0
[   72.471000] Suspending type 'cpu':
[   72.471000]  cpu0
[   72.471000] PM: Creating hibernation image: 
[   72.471000] PM: Need to copy 6696 pages
[   72.471000] PM: Normal pages needed: 6696 + 1024, available pages: 9683
[   72.471000] PM: Hibernation image created (6696 pages copied)
[   72.471000] Resuming System Devices
[   72.471000] Resuming type 'cpu':
[   72.471000]  cpu0
[   72.471000] Resuming type 'timekeeping':
[   72.471000]  timekeeping0
[   72.471000] Resuming type 'clocksource':
[   72.471000]  clocksource0
[   72.499000] platform ci13610-udc.0: EARLY thaw
[   72.504000] serial8250 serial8250: EARLY thaw
[   72.508000] gmac_drv_eth gmac_drv_eth.0: EARLY thaw
[   72.513000] cb cb.0: EARLY thaw
[   72.517000] cb cb.1: EARLY thaw
[   72.520000] platform rtevent.0: EARLY thaw
[   72.524000] platform ci13610-udc.0: thaw
[   72.529000] serial8250 serial8250: thaw
[   72.533000] gmac_drv_eth gmac_drv_eth.0: thaw
[   72.538000] cb cb.0: thaw
[   72.540000] cb cb.1: thaw
[   72.543000] platform rtevent.0: thaw
[   72.547000] platform rtevent.0: completing thaw
[   72.552000] cb cb.1: completing thaw
[   72.556000] cb cb.0: completing thaw
[   72.559000] gmac_drv_eth gmac_drv_eth.0: completing thaw
[   72.565000] serial8250 serial8250: completing thaw
[   72.570000] platform ci13610-udc.0: completing thaw
[   72.575000] PM: writing image.
[   72.579000] PM: Free swap pages: 8190


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
