From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH v3 0/2] Exynos IOMMU: proper runtime PM support (use
 device dependencies)
Date: Mon, 19 Sep 2016 23:45:12 +0200
Message-ID: <57E05C68.80804@math.uni-bielefeld.de>
References: <CGME20160913124917eucas1p23425d2cb1c24e73ae3c2927ec141fd30@eucas1p2.samsung.com>
 <1473770941-8337-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1473770941-8337-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Marek,

I did some tests with the new version today. Sadly the reboot/shutdown
issues are still present.

Here's what appears on the UART last:
> [  399.538147] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [  404.970649] smsc95xx 1-2.1.1:1.0 eth0: Failed to read reg index 0x00000114: -110
> [  404.972426] smsc95xx 1-2.1.1:1.0 eth0: Error reading MII_ACCESS
> [  404.978336] smsc95xx 1-2.1.1:1.0 eth0: MII is busy in smsc95xx_mdio_read
> [  404.985020] smsc95xx 1-2.1.1:1.0 eth0: Failed to read MII_BMSR
> [  434.170626] usb 1-2-port2: cannot reset (err = -110)
> [  435.210242] usb 1-2-port2: cannot reset (err = -110)
> [  436.250261] usb 1-2-port2: cannot reset (err = -110)
> [  437.290241] usb 1-2-port2: cannot reset (err = -110)
> [  438.330241] usb 1-2-port2: cannot reset (err = -110)
> [  438.330346] usb 1-2-port2: Cannot enable. Maybe the USB cable is bad?
> [  439.370608] usb 1-2-port2: cannot disable (err = -110)
> [  440.410225] usb 1-2-port2: cannot reset (err = -110)
> [  441.450236] usb 1-2-port2: cannot reset (err = -110)
> [  442.490222] usb 1-2-port2: cannot reset (err = -110)
> [  443.530224] usb 1-2-port2: cannot reset (err = -110)
> [  444.570228] usb 1-2-port2: cannot reset (err = -110)
> [  444.570331] usb 1-2-port2: Cannot enable. Maybe the USB cable is bad?
> [  445.610227] usb 1-2-port2: cannot disable (err = -110)
> [  446.650230] usb 1-2-port2: cannot reset (err = -110)
> [  447.690231] usb 1-2-port2: cannot reset (err = -110)
> [  448.730235] usb 1-2-port2: cannot reset (err = -110)
> [  449.770235] usb 1-2-port2: cannot reset (err = -110)
> [  450.810239] usb 1-2-port2: cannot reset (err = -110)
> [  450.810342] usb 1-2-port2: Cannot enable. Maybe the USB cable is bad?
> [  451.850240] usb 1-2-port2: cannot disable (err = -110)
> [  452.890243] usb 1-2-port2: cannot reset (err = -110)
> [  453.930271] usb 1-2-port2: cannot reset (err = -110)
> [  454.970247] usb 1-2-port2: cannot reset (err = -110)
> [  456.010250] usb 1-2-port2: cannot reset (err = -110)
> [  457.050251] usb 1-2-port2: cannot reset (err = -110)
> [  457.050353] usb 1-2-port2: Cannot enable. Maybe the USB cable is bad?
> [  458.090250] usb 1-2-port2: cannot disable (err = -110)
> [  459.130603] usb 1-2-port2: cannot disable (err = -110)
> [  464.330286] hub 1-2:1.0: hub_ext_port_status failed (err = -110)


If I trigger a stack trace via SysRq at this point, I get this here:
> [  672.679321] sysrq: SysRq : Show backtrace of all active CPUs
> [  672.679448] Sending NMI to all CPUs:
> [  672.682901] NMI backtrace for cpu 0
> [  672.686377] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.0-rc7-debug+ #6
> [  672.693149] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [  672.699223] Backtrace: 
> [  672.701657] [<c010c9bc>] (dump_backtrace) from [<c010cb68>] (show_stack+0x18/0x1c)
> [  672.709212]  r6:c0c25e40 r5:600401d3 r4:00000000 r3:00040800
> [  672.714845] [<c010cb50>] (show_stack) from [<c039bef8>] (dump_stack+0xb0/0xdc)
> [  672.722062] [<c039be48>] (dump_stack) from [<c03a089c>] (nmi_cpu_backtrace+0x88/0x8c)
> [  672.729870]  r8:c0c27f88 r7:c010e87c r6:00000000 r5:00000000 r4:00000000 r3:00000000
> [  672.737590] [<c03a0814>] (nmi_cpu_backtrace) from [<c010e8d8>] (raise_nmi+0x5c/0x60)
> [  672.745320]  r5:c0c0281c r4:c0c0281c
> [  672.748868] [<c010e87c>] (raise_nmi) from [<c03a0800>] (nmi_trigger_all_cpu_backtrace+0x120/0x134)
> [  672.757821]  r4:00000001 r3:00000000
> [  672.761367] [<c03a06e0>] (nmi_trigger_all_cpu_backtrace) from [<c010f5c0>] (arch_trigger_all_cpu_backtrace+0x18/0x1c)
> [  672.771972]  r7:00000001 r6:00000008 r5:0000006c r4:c0c0cf0c
> [  672.777601] [<c010f5a8>] (arch_trigger_all_cpu_backtrace) from [<c03fc7c0>] (sysrq_handle_showallcpus+0x14/0x18)
> [  672.787774] [<c03fc7ac>] (sysrq_handle_showallcpus) from [<c03fcfc8>] (__handle_sysrq+0x104/0x268)
> [  672.796711] [<c03fcec4>] (__handle_sysrq) from [<c03fd5d4>] (handle_sysrq+0x34/0x38)
> [  672.804431]  r8:c0c02100 r7:c0c2b994 r6:00000040 r5:00000000 r4:c0c2b964
> [  672.811106] [<c03fd5a0>] (handle_sysrq) from [<c0412564>] (s3c24xx_serial_rx_drain_fifo+0x1fc/0x22c)
> [  672.820236] [<c0412368>] (s3c24xx_serial_rx_drain_fifo) from [<c04133f8>] (s3c24xx_serial_rx_chars+0x74/0x1a8)
> [  672.830214]  r10:0001000f r9:ee1f2200 r8:200401d3 r7:ed01cc00 r6:c0c2b994 r5:ee2a5550
> [  672.838013]  r4:c0c2b964
> [  672.840529] [<c0413384>] (s3c24xx_serial_rx_chars) from [<c041357c>] (s3c64xx_serial_handle_irq+0x50/0x68)
> [  672.850178]  r10:c0c01e24 r9:00000000 r8:00000047 r7:c0c00000 r6:00000047 r5:00000001
> [  672.857977]  r4:c0c2b964
> [  672.860496] [<c041352c>] (s3c64xx_serial_handle_irq) from [<c01843b8>] (__handle_irq_event_percpu+0x7c/0x4c4)
> [  672.870403]  r6:c0c02848 r5:eeb0a100 r4:ed76b8c0 r3:c041352c
> [  672.876030] [<c018433c>] (__handle_irq_event_percpu) from [<c0184824>] (handle_irq_event_percpu+0x24/0x60)
> [  672.885679]  r10:c0c01ee8 r9:ee808000 r8:00000001 r7:00000000 r6:c0c02848 r5:eeb0a100
> [  672.893478]  r4:eeb0a100
> [  672.895994] [<c0184800>] (handle_irq_event_percpu) from [<c01848a0>] (handle_irq_event+0x40/0x64)
> [  672.904860]  r5:eeb0a160 r4:eeb0a100
> [  672.908406] [<c0184860>] (handle_irq_event) from [<c01881d0>] (handle_fasteoi_irq+0xd8/0x1a8)
> [  672.916925]  r6:c0c02848 r5:eeb0a160 r4:eeb0a100 r3:00000000
> [  672.922554] [<c01880f8>] (handle_fasteoi_irq) from [<c0183ae8>] (generic_handle_irq+0x2c/0x3c)
> [  672.931160]  r7:00000000 r6:00000047 r5:00000000 r4:c0b42270
> [  672.936790] [<c0183abc>] (generic_handle_irq) from [<c0183b7c>] (__handle_domain_irq+0x84/0xf4)
> [  672.945486] [<c0183af8>] (__handle_domain_irq) from [<c0101510>] (gic_handle_irq+0x5c/0xa0)
> [  672.953815]  r10:c0c02524 r9:f0821000 r8:f0820000 r7:c0c01ee8 r6:f082000c r5:c0c26380
> [  672.961616]  r4:c0c02848 r3:c0c01ee8
> [  672.965172] [<c01014b4>] (gic_handle_irq) from [<c010d7b0>] (__irq_svc+0x70/0xb0)
> [  672.972651] Exception stack(0xc0c01ee8 to 0xc0c01f30)
> [  672.977679] 1ee0:                   00000001 00000001 00000000 c011b660 c0c00000 c0c448cc
> [  672.985846] 1f00: c0c024d4 00000001 00000000 00000000 c0c02524 c0c01f44 c0c01f08 c0c01f38
> [  672.994005] 1f20: c01743d4 c01089d4 20040053 ffffffff
> [  672.999029]  r9:c0c00000 r8:00000000 r7:c0c01f1c r6:ffffffff r5:20040053 r4:c01089d4
> [  673.006758] [<c01089a8>] (arch_cpu_idle) from [<c016cdd8>] (default_idle_call+0x28/0x38)
> [  673.014838] [<c016cdb0>] (default_idle_call) from [<c016d190>] (cpu_startup_entry+0x3a8/0x484)
> [  673.023436] [<c016cde8>] (cpu_startup_entry) from [<c0807b00>] (rest_init+0x168/0x178)
> [  673.031327]  r7:ffffffff
> [  673.033834] [<c0807998>] (rest_init) from [<c0b00cf8>] (start_kernel+0x384/0x390)
> [  673.041308]  r5:c0c49000 r4:00000001
> [  673.044855] [<c0b00974>] (start_kernel) from [<40008078>] (0x40008078)
> [  673.051486] NMI backtrace for cpu 3
> [  673.054844] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.8.0-rc7-debug+ #6
> [  673.061615] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [  673.067692] task: ee8b3200 task.stack: ee8be000
> [  673.072201] PC is at arch_cpu_idle+0x2c/0x44
> [  673.076455] LR is at trace_hardirqs_on_caller+0x158/0x200
> [  673.081840] pc : [<c01089d4>]    lr : [<c01743d4>]    psr: 20010053
> [  673.088089] sp : ee8bff90  ip : ee8bff60  fp : ee8bff9c
> [  673.093294] r10: c0c02524  r9 : 00000000  r8 : 00000000
> [  673.098503] r7 : 00000008  r6 : c0c024d4  r5 : c0c448cc  r4 : ee8be000
> [  673.105014] r3 : c011b660  r2 : 00000000  r1 : 00000001  r0 : 00000001
> [  673.111525] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
> [  673.118736] Control: 10c5387d  Table: 6dc5804a  DAC: 00000051
> [  673.124459] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.8.0-rc7-debug+ #6
> [  673.131229] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [  673.137306] Backtrace: 
> [  673.139730] [<c010c9bc>] (dump_backtrace) from [<c010cb68>] (show_stack+0x18/0x1c)
> [  673.147292]  r6:c0c25e40 r5:600101d3 r4:00000000 r3:00040800
> [  673.152929] [<c010cb50>] (show_stack) from [<c039bef8>] (dump_stack+0xb0/0xdc)
> [  673.160138] [<c039be48>] (dump_stack) from [<c0108c5c>] (show_regs+0x14/0x18)
> [  673.167251]  r8:f082c000 r7:ee8bff40 r6:c0b42270 r5:00000003 r4:ee8bff40 r3:00040800
> [  673.174982] [<c0108c48>] (show_regs) from [<c03a0880>] (nmi_cpu_backtrace+0x6c/0x8c)
> [  673.182707] [<c03a0814>] (nmi_cpu_backtrace) from [<c010f1c0>] (handle_IPI+0x14c/0x434)
> [  673.190692]  r5:c0b42270 r4:00000007
> [  673.194241] [<c010f074>] (handle_IPI) from [<c0101550>] (gic_handle_irq+0x9c/0xa0)
> [  673.201803]  r10:c0c02524 r9:f082d000 r8:f082c000 r7:ee8bff40 r6:f082c00c r5:c0c26380
> [  673.209615]  r4:c0c02848
> [  673.212121] [<c01014b4>] (gic_handle_irq) from [<c010d7b0>] (__irq_svc+0x70/0xb0)
> [  673.219596] Exception stack(0xee8bff40 to 0xee8bff88)
> [  673.224624] ff40: 00000001 00000001 00000000 c011b660 ee8be000 c0c448cc c0c024d4 00000008
> [  673.232790] ff60: 00000000 00000000 c0c02524 ee8bff9c ee8bff60 ee8bff90 c01743d4 c01089d4
> [  673.240952] ff80: 20010053 ffffffff
> [  673.244411]  r9:ee8be000 r8:00000000 r7:ee8bff74 r6:ffffffff r5:20010053 r4:c01089d4
> [  673.252147] [<c01089a8>] (arch_cpu_idle) from [<c016cdd8>] (default_idle_call+0x28/0x38)
> [  673.260221] [<c016cdb0>] (default_idle_call) from [<c016d190>] (cpu_startup_entry+0x3a8/0x484)
> [  673.268816] [<c016cde8>] (cpu_startup_entry) from [<c010ee88>] (secondary_start_kernel+0xf8/0x100)
> [  673.277755]  r7:c0c49328
> [  673.280259] [<c010ed90>] (secondary_start_kernel) from [<401015ec>] (0x401015ec)
> [  673.287648]  r5:00000051 r4:6e89406a
> [  673.291197] NMI backtrace for cpu 2
> [  673.294670] CPU: 2 PID: 3729 Comm: reboot Not tainted 4.8.0-rc7-debug+ #6
> [  673.301443] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [  673.307518] task: ee030c80 task.stack: edec8000
> [  673.312029] PC is at _raw_spin_unlock_irq+0x30/0x64
> [  673.316891] LR is at mark_held_locks+0x74/0x9c
> [  673.321317] pc : [<c080ee84>]    lr : [<c0174254>]    psr: 200a0053
> [  673.327569] sp : edec9df0  ip : c0d9a4d4  fp : edec9e04
> [  673.332775] r10: 00000000  r9 : ee029c44  r8 : c0c49020
> [  673.337984] r7 : ee029cb0  r6 : 00000000  r5 : ee029d84  r4 : ee029cb0
> [  673.344495] r3 : 600a00d3  r2 : 00000000  r1 : ee031158  r0 : 00000001
> [  673.351005] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
> [  673.358215] Control: 10c5387d  Table: 6d7ec04a  DAC: 00000051
> [  673.363937] CPU: 2 PID: 3729 Comm: reboot Not tainted 4.8.0-rc7-debug+ #6
> [  673.370709] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [  673.376784] Backtrace: 
> [  673.379209] [<c010c9bc>] (dump_backtrace) from [<c010cb68>] (show_stack+0x18/0x1c)
> [  673.386773]  r6:c0c25e40 r5:600a01d3 r4:00000000 r3:00040800
> [  673.392408] [<c010cb50>] (show_stack) from [<c039bef8>] (dump_stack+0xb0/0xdc)
> [  673.399618] [<c039be48>] (dump_stack) from [<c0108c5c>] (show_regs+0x14/0x18)
> [  673.406732]  r8:f0828000 r7:edec9da0 r6:c0b42270 r5:00000002 r4:edec9da0 r3:00040800
> [  673.414462] [<c0108c48>] (show_regs) from [<c03a0880>] (nmi_cpu_backtrace+0x6c/0x8c)
> [  673.422187] [<c03a0814>] (nmi_cpu_backtrace) from [<c010f1c0>] (handle_IPI+0x14c/0x434)
> [  673.430173]  r5:c0b42270 r4:00000007
> [  673.433722] [<c010f074>] (handle_IPI) from [<c0101550>] (gic_handle_irq+0x9c/0xa0)
> [  673.441283]  r10:00000000 r9:f0829000 r8:f0828000 r7:edec9da0 r6:f082800c r5:c0c26380
> [  673.449095]  r4:c0c02848
> [  673.451601] [<c01014b4>] (gic_handle_irq) from [<c010d7b0>] (__irq_svc+0x70/0xb0)
> [  673.459076] Exception stack(0xedec9da0 to 0xedec9de8)
> [  673.464103] 9da0: 00000001 ee031158 00000000 600a00d3 ee029cb0 ee029d84 00000000 ee029cb0
> [  673.472272] 9dc0: c0c49020 ee029c44 00000000 edec9e04 c0d9a4d4 edec9df0 c0174254 c080ee84
> [  673.480430] 9de0: 200a0053 ffffffff
> [  673.483892]  r9:edec8000 r8:c0c49020 r7:edec9dd4 r6:ffffffff r5:200a0053 r4:c080ee84
> [  673.491627] [<c080ee54>] (_raw_spin_unlock_irq) from [<c047ab90>] (pm_runtime_barrier+0x68/0xbc)
> [  673.500395]  r4:ee029c10 r3:00000080
> [  673.503942] [<c047ab28>] (pm_runtime_barrier) from [<c046c6d4>] (device_shutdown+0x110/0x1c8)
> [  673.512460]  r7:c140755c r6:ee029c10 r5:c0c2e210 r4:ee029c1c
> [  673.518094] [<c046c5c4>] (device_shutdown) from [<c014ad10>] (kernel_restart_prepare+0x3c/0x40)
> [  673.526782]  r9:c0c0ae1c r8:00000010 r7:c0c0b244 r6:01234567 r5:00000000 r4:00000000
> [  673.534506] [<c014acd4>] (kernel_restart_prepare) from [<c014ae68>] (kernel_restart+0x14/0x58)
> [  673.543100] [<c014ae54>] (kernel_restart) from [<c014b13c>] (SyS_reboot+0x114/0x200)
> [  673.550824]  r4:c0c02448 r3:01234567
> [  673.554374] [<c014b028>] (SyS_reboot) from [<c0107ee0>] (ret_fast_syscall+0x0/0x1c)
> [  673.562021]  r9:edec8000 r8:c0108084 r7:00000058 r6:010a0008 r5:be9f6ce0 r4:00000001
> [  673.569748] NMI backtrace for cpu 1
> [  673.573211] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.8.0-rc7-debug+ #6
> [  673.579984] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [  673.586059] task: ee8b1900 task.stack: ee8ba000
> [  673.590570] PC is at arch_cpu_idle+0x2c/0x44
> [  673.594823] LR is at trace_hardirqs_on_caller+0x158/0x200
> [  673.600206] pc : [<c01089d4>]    lr : [<c01743d4>]    psr: 200b0053
> [  673.606457] sp : ee8bbf90  ip : ee8bbf60  fp : ee8bbf9c
> [  673.611664] r10: c0c02524  r9 : 00000000  r8 : 00000000
> [  673.616872] r7 : 00000002  r6 : c0c024d4  r5 : c0c448cc  r4 : ee8ba000
> [  673.623383] r3 : c011b660  r2 : 00000000  r1 : 00000001  r0 : 00000001
> [  673.629894] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
> [  673.637103] Control: 10c5387d  Table: 6df9804a  DAC: 00000051
> [  673.642827] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.8.0-rc7-debug+ #6
> [  673.649598] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [  673.655672] Backtrace: 
> [  673.658098] [<c010c9bc>] (dump_backtrace) from [<c010cb68>] (show_stack+0x18/0x1c)
> [  673.665660]  r6:c0c25e40 r5:600b01d3 r4:00000000 r3:00040800
> [  673.671296] [<c010cb50>] (show_stack) from [<c039bef8>] (dump_stack+0xb0/0xdc)
> [  673.678506] [<c039be48>] (dump_stack) from [<c0108c5c>] (show_regs+0x14/0x18)
> [  673.685620]  r8:f0824000 r7:ee8bbf40 r6:c0b42270 r5:00000001 r4:ee8bbf40 r3:00040800
> [  673.693350] [<c0108c48>] (show_regs) from [<c03a0880>] (nmi_cpu_backtrace+0x6c/0x8c)
> [  673.701075] [<c03a0814>] (nmi_cpu_backtrace) from [<c010f1c0>] (handle_IPI+0x14c/0x434)
> [  673.709061]  r5:c0b42270 r4:00000007
> [  673.712610] [<c010f074>] (handle_IPI) from [<c0101550>] (gic_handle_irq+0x9c/0xa0)
> [  673.720171]  r10:c0c02524 r9:f0825000 r8:f0824000 r7:ee8bbf40 r6:f082400c r5:c0c26380
> [  673.727983]  r4:c0c02848
> [  673.730489] [<c01014b4>] (gic_handle_irq) from [<c010d7b0>] (__irq_svc+0x70/0xb0)
> [  673.737964] Exception stack(0xee8bbf40 to 0xee8bbf88)
> [  673.742992] bf40: 00000001 00000001 00000000 c011b660 ee8ba000 c0c448cc c0c024d4 00000002
> [  673.751160] bf60: 00000000 00000000 c0c02524 ee8bbf9c ee8bbf60 ee8bbf90 c01743d4 c01089d4
> [  673.759319] bf80: 200b0053 ffffffff
> [  673.762780]  r9:ee8ba000 r8:00000000 r7:ee8bbf74 r6:ffffffff r5:200b0053 r4:c01089d4
> [  673.770515] [<c01089a8>] (arch_cpu_idle) from [<c016cdd8>] (default_idle_call+0x28/0x38)
> [  673.778588] [<c016cdb0>] (default_idle_call) from [<c016d190>] (cpu_startup_entry+0x3a8/0x484)
> [  673.787182] [<c016cde8>] (cpu_startup_entry) from [<c010ee88>] (secondary_start_kernel+0xf8/0x100)
> [  673.796123]  r7:c0c49328
> [  673.798627] [<c010ed90>] (secondary_start_kernel) from [<401015ec>] (0x401015ec)
> [  673.806016]  r5:00000051 r4:6e89406a

So this seems to be PM related, since it hangs in pm_runtime_barrier()
in device_shutdown().

Anyway, I noticed something else on boot:
> [    7.567702] usb-storage 1-2.2:1.0: USB Mass Storage device detected
> [    7.569762] scsi host0: usb-storage 1-2.2:1.0
> [    7.579054] scsi host0: runtime PM trying to activate child device host0 but parent (1-2.2:1.0) is not active


Maybe some details about my storage setup. While boot and rootfs are on
a SD card, /var and some other things are on a USB thumb drive (/dev/sda
is that drive).

My guess is that with the runpm changes the failure to sync the thumb
drive now blocks the rest of the shutdown/reboot procedure.


With best wishes,
Tobias



Marek Szyprowski wrote:
> Hello,
> 
> This patch series finally implements proper runtime PM support in Exynos
> IOMMU driver. This has been achieved by using recently introduce device
> links, which lets SYSMMU controller's runtime PM to follow master's device
> runtime PM state (the device which actually performs DMA transaction).
> The main idea behind this solution is an observation that any DMA activity
> from master device can be done only when master device is active, thus when
> master device is suspended SYSMMU controller device can also be suspended.
> 
> This patchset solves the situation that power domains are always enabled,
> because all SYSMMU controllers (which belongs to those domains) are
> permanently active (because existing driver was simplified and kept
> SYSMMU device active all the time after initialization).
> 
> Patch requires second version of Rafeal's "Functional dependencies
> between devices" patchset, which is available here:
> https://lkml.org/lkml/2016/9/8/798
> 
> If one wants to test this patchset, I've provided a branch with all needed
> patches (some fixes for Exynos4 FIMC-IS driver are needed):
> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.8-iommu-pm-v3
> 
> Patches are based on vanilla v4.8-rc6 kernel with Rafael's patches applied.
> 
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
> 
> 
> Changelog:
> v3:
> - rebased on top of latest device dependencies/links patchset
> - added proper locking between runtime pm, iommu_attach/detach and sysmmu
>   enable/disable(added per iommu owner device's rpm lock)
> 
> v2:
> - replaced PM notifiers with generic device dependencies/links developped
>   by Rafael J. Wysocki
> 
> v1: http://www.spinics.net/lists/arm-kernel/msg509600.html
> - initial version
> 
> 
> Patch summary:
> 
> Marek Szyprowski (2):
>   iommu/exynos: Remove excessive, useless debug
>   iommu/exynos: Add proper runtime pm support
> 
>  drivers/iommu/exynos-iommu.c | 228 ++++++++++++++++++-------------------------
>  1 file changed, 94 insertions(+), 134 deletions(-)
> 
