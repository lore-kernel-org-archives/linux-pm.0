From: Dave Jones <davej@redhat.com>
Subject: Re: swsusp1 not working
Date: Wed, 4 Jan 2006 01:02:57 -0500
Message-ID: <20060104060257.GA10592@redhat.com>
References: <380D9721A8E2114485644D71E87C6AB20136297A@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============50276648352864184=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB20136297A@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rasmit.ranjan@wipro.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============50276648352864184==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 04, 2006 at 11:23:53AM +0530, rasmit.ranjan@wipro.com wrote:

 > Jan  4 10:51:48 rasmit kernel: Debug: sleeping function called from invalid context at mm/slab.c:2459
 > Jan  4 10:51:49 rasmit kernel: in_atomic():0, irqs_disabled():1
 > Jan  4 10:51:51 rasmit kernel:  [<c011a183>] __might_sleep+0xa3/0xc0
 > Jan  4 10:51:52 rasmit kernel:  [<c014b1d4>] kmem_cache_alloc+0x54/0x70
 > Jan  4 10:51:52 rasmit kernel:  [<c0212264>] acpi_pci_link_set+0x4a/0x1a2
 > Jan  4 10:51:52 rasmit kernel:  [<c02127f8>] irqrouter_resume+0x26/0x38
 > Jan  4 10:51:52 rasmit kernel:  [<c02555c4>] __sysdev_resume+0x44/0x90
 > Jan  4 10:51:52 rasmit kernel:  [<c02558a8>] sysdev_resume+0x38/0x5b
 > Jan  4 10:51:52 rasmit kernel:  [<c025a475>] device_power_up+0x5/0xa
 > Jan  4 10:51:52 rasmit kernel:  [<c013abf5>] swsusp_suspend+0xa5/0xd0
 > Jan  4 10:51:52 rasmit kernel:  [<c011cf97>] printk+0x17/0x20
 > Jan  4 10:51:52 rasmit kernel:  [<c013b7e0>] pm_suspend_disk+0x40/0xd0
 > Jan  4 10:51:52 rasmit kernel:  [<c01391ea>] enter_state+0x9a/0xb0
 > Jan  4 10:51:52 rasmit kernel:  [<c013932b>] state_store+0x9b/0xae
 > Jan  4 10:51:52 rasmit kernel:  [<c0139290>] state_store+0x0/0xae
 > Jan  4 10:51:52 rasmit kernel:  [<c01a2958>] subsys_attr_store+0x38/0x50
 > Jan  4 10:51:52 rasmit kernel:  [<c01a2c0e>] flush_write_buffer+0x2e/0x40
 > Jan  4 10:51:52 rasmit kernel:  [<c01a2c76>] sysfs_write_file+0x56/0x90
 > Jan  4 10:51:52 rasmit kernel:  [<c0161c05>] vfs_write+0x175/0x180
 > Jan  4 10:51:52 rasmit kernel:  [<c0161cc1>] sys_write+0x41/0x70
 > Jan  4 10:51:52 rasmit kernel:  [<c0102fff>] sysenter_past_esp+0x54/0x75

This was definitly fixed in 2.6.15, you should retest with that,
as your other problem may also be already fixed.

		Dave


--===============50276648352864184==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============50276648352864184==--
