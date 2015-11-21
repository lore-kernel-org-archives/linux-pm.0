From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: 4.4.0-rc1 cpufreq warning
Date: Fri, 20 Nov 2015 18:50:12 -0800
Message-ID: <1448074212.3450.4.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46379 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbbKUCuN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Nov 2015 21:50:13 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

Hi,

Anybody else has this issue? On rmmod the cpufreq folder in cpuX is not
removed.

[root@spandruv-mobl3 testuser]# uname -a
Linux xxxx-xxx 4.4.0-rc1 #84 SMP Fri Nov 20 18:04:37 PST 2015 x86_64
x86_64 x86_64 GNU/Linux
[root@spandruv-mobl3 testuser]# rmmod acpi_cpufreq
[root@spandruv-mobl3 testuser]# sudo modprobe acpi_cpufreq




[  128.154319] ------------[ cut here ]------------
[  128.154333] WARNING: CPU: 0 PID: 3201 at fs/sysfs/dir.c:31
sysfs_warn_dup+0x62/0x80()
[  128.154337] sysfs: cannot create duplicate filename
'/devices/system/cpu/cpu0/cpufreq'
[  128.154340] Modules linked in: acpi_cpufreq(+) rfcomm ccm cmac
xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun
nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack vboxpci(OE) vboxnetadp(OE) vboxnetflt(OE)
ebtable_nat ebtable_broute bridge ebtable_filter ebtables ip6table_nat
nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle vboxdrv(OE)
ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack fuse
iptable_mangle iptable_security vmw_vsock_vmci_transport iptable_raw
vsock vmw_vmci bnep dm_crypt snd_soc_sst_broadwell arc4
hid_sensor_incl_3d hid_sensor_magn_3d hid_sensor_rotation hid_sensor_als
hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_trigger
hid_sensor_iio_common
[  128.154408]  industrialio_triggered_buffer iwlmvm joydev
hid_sensor_hub hid_multitouch snd_hda_codec_hdmi snd_soc_rt286 elan_i2c
snd_soc_rl6347a mac80211 snd_soc_sst_haswell_pcm snd_soc_sst_ipc
snd_soc_sst_dsp snd_soc_core iTCO_wdt iTCO_vendor_support snd_compress
ppdev snd_pcm_dmaengine ac97_bus intel_rapl x86_pkg_temp_thermal
coretemp kvm_intel kvm snd_hda_intel irqbypass crct10dif_pclmul vfat
snd_hda_codec crc32_pclmul fat iwlwifi uvcvideo crc32c_intel btusb
snd_hda_core btrtl videobuf2_vmalloc btbcm videobuf2_v4l2 videobuf2_core
btintel snd_hwdep snd_seq bluetooth videobuf2_memops v4l2_common
cfg80211 videodev snd_seq_device snd_pcm pcspkr cdc_acm media i2c_i801
snd_timer snd mei_me mei processor_thermal_device shpchp
intel_soc_dts_iosf iosf_mbi lpc_ich soundcore acpi_als winbond_cir
kfifo_buf
[  128.154548]  soc_button_array industrialio rc_core int3403_thermal
parport_pc parport rfkill_gpio dw_dmac int3400_thermal snd_soc_sst_acpi
dw_dmac_core i2c_designware_platform acpi_thermal_rel rfkill
i2c_designware_core tpm_crb tpm_tis tpm int3402_thermal acpi_pad
int340x_thermal_zone nfsd nfs_acl lockd auth_rpcgss grace sunrpc
binfmt_misc cdc_mbim cdc_wdm cdc_ncm usbnet mii i915 8021q garp stp llc
mrp i2c_algo_bit drm_kms_helper drm e1000e sdhci_pci serio_raw
sdhci_acpi ptp sdhci pps_core mmc_core video i2c_hid [last unloaded:
acpi_cpufreq]
[  128.154611] CPU: 0 PID: 3201 Comm: modprobe Tainted: G           OE
4.4.0-rc1 #84
[  128.154615] Hardware name: Intel Corporation Broadwell Client
platform/Wilson Beach SDS, BIOS BDW-E2R1.86C.0121.R04.1505080303
05/08/2015
[  128.154620]  0000000000000000 000000005dac0241 ffff88026000fa70
ffffffff813a3fff
[  128.154627]  ffff88026000fab8 ffff88026000faa8 ffffffff810a0852
ffff8802194f3000
[  128.154632]  ffffffff81ab37c2 ffff880263f97870 ffff880263f97870
ffffffffffffffef
[  128.154638] Call Trace:
[  128.154648]  [<ffffffff813a3fff>] dump_stack+0x44/0x55
[  128.154656]  [<ffffffff810a0852>] warn_slowpath_common+0x82/0xc0
[  128.154662]  [<ffffffff810a08ec>] warn_slowpath_fmt+0x5c/0x80
[  128.154669]  [<ffffffff8129c4d8>] ? kernfs_path+0x48/0x60
[  128.154674]  [<ffffffff8129fae2>] sysfs_warn_dup+0x62/0x80
[  128.154680]  [<ffffffff8129fe67>] sysfs_do_create_link_sd.isra.2
+0x97/0xb0
[  128.154688]  [<ffffffff8129fea5>] sysfs_create_link+0x25/0x40
[  128.154696]  [<ffffffff81619709>] add_cpu_dev_symlink+0x49/0x90
[  128.154701]  [<ffffffff8161b415>] cpufreq_online+0x215/0x790
[  128.154706]  [<ffffffffa03c1000>] ? 0xffffffffa03c1000
[  128.154710]  [<ffffffff8161ba52>] cpufreq_add_dev+0x62/0x90
[  128.154718]  [<ffffffff814d7ea1>] subsys_interface_register
+0xb1/0x100
[  128.154723]  [<ffffffff8161af4f>] cpufreq_register_driver+0x10f/0x220
[  128.154730]  [<ffffffffa03c1231>] acpi_cpufreq_init+0x231/0x1000
[acpi_cpufreq]
[  128.154737]  [<ffffffff81002123>] do_one_initcall+0xb3/0x200
[  128.154743]  [<ffffffff81204002>] ? kmem_cache_alloc_trace
+0x182/0x1f0
[  128.154750]  [<ffffffff811a45dd>] ? do_init_module+0x27/0x1e5
[  128.154755]  [<ffffffff811a4615>] do_init_module+0x5f/0x1e5
[  128.154760]  [<ffffffff8112479c>] load_module+0x201c/0x2630
[  128.154768]  [<ffffffff81120cc0>] ? __symbol_put+0x60/0x60
[  128.154781]  [<ffffffff81228fc0>] ? kernel_read+0x50/0x80
[  128.154787]  [<ffffffff81124ff9>] SyS_finit_module+0xb9/0xf0
[  128.154796]  [<ffffffff817818ee>] entry_SYSCALL_64_fastpath+0x12/0x71
[  128.154800] ---[ end trace 7d344a24810d0a60 ]---
[  128.155075] ------------[ cut here ]------------
[  128.155083] WARNING: CPU: 0 PID: 3201 at fs/sysfs/dir.c:31
sysfs_warn_dup+0x62/0x80()
[  128.155086] sysfs: cannot create duplicate filename
'/devices/system/cpu/cpu1/cpufreq'
[  128.155088] Modules linked in: acpi_cpufreq(+) rfcomm ccm cmac
xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun
nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack vboxpci(OE) vboxnetadp(OE) vboxnetflt(OE)
ebtable_nat ebtable_broute bridge ebtable_filter ebtables ip6table_nat
nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle vboxdrv(OE)
ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack fuse
iptable_mangle iptable_security vmw_vsock_vmci_transport iptable_raw
vsock vmw_vmci bnep dm_crypt snd_soc_sst_broadwell arc4
hid_sensor_incl_3d hid_sensor_magn_3d hid_sensor_rotation hid_sensor_als
hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_trigger
hid_sensor_iio_common
[  128.155148]  industrialio_triggered_buffer iwlmvm joydev
hid_sensor_hub hid_multitouch snd_hda_codec_hdmi snd_soc_rt286 elan_i2c
snd_soc_rl6347a mac80211 snd_soc_sst_haswell_pcm snd_soc_sst_ipc
snd_soc_sst_dsp snd_soc_core iTCO_wdt iTCO_vendor_support snd_compress
ppdev snd_pcm_dmaengine ac97_bus intel_rapl x86_pkg_temp_thermal
coretemp kvm_intel kvm snd_hda_intel irqbypass crct10dif_pclmul vfat
snd_hda_codec crc32_pclmul fat iwlwifi uvcvideo crc32c_intel btusb
snd_hda_core btrtl videobuf2_vmalloc btbcm videobuf2_v4l2 videobuf2_core
btintel snd_hwdep snd_seq bluetooth videobuf2_memops v4l2_common
cfg80211 videodev snd_seq_device snd_pcm pcspkr cdc_acm media i2c_i801
snd_timer snd mei_me mei processor_thermal_device shpchp
intel_soc_dts_iosf iosf_mbi lpc_ich soundcore acpi_als winbond_cir
kfifo_buf
[  128.155215]  soc_button_array industrialio rc_core int3403_thermal
parport_pc parport rfkill_gpio dw_dmac int3400_thermal snd_soc_sst_acpi
dw_dmac_core i2c_designware_platform acpi_thermal_rel rfkill
i2c_designware_core tpm_crb tpm_tis tpm int3402_thermal acpi_pad
int340x_thermal_zone nfsd nfs_acl lockd auth_rpcgss grace sunrpc
binfmt_misc cdc_mbim cdc_wdm cdc_ncm usbnet mii i915 8021q garp stp llc
mrp i2c_algo_bit drm_kms_helper drm e1000e sdhci_pci serio_raw
sdhci_acpi ptp sdhci pps_core mmc_core video i2c_hid [last unloaded:
acpi_cpufreq]
[  128.155270] CPU: 0 PID: 3201 Comm: modprobe Tainted: G        W  OE
4.4.0-rc1 #84
[  128.155273] Hardware name: Intel Corporation Broadwell Client
platform/Wilson Beach SDS, BIOS BDW-E2R1.86C.0121.R04.1505080303
05/08/2015
[  128.155276]  0000000000000000 000000005dac0241 ffff88026000fa70
ffffffff813a3fff
[  128.155281]  ffff88026000fab8 ffff88026000faa8 ffffffff810a0852
ffff8802194f3000
[  128.155287]  ffffffff81ab37c2 ffff880263f980f0 ffff880263f980f0
ffffffffffffffef
[  128.155292] Call Trace:
[  128.155298]  [<ffffffff813a3fff>] dump_stack+0x44/0x55
[  128.155303]  [<ffffffff810a0852>] warn_slowpath_common+0x82/0xc0
[  128.155309]  [<ffffffff810a08ec>] warn_slowpath_fmt+0x5c/0x80
[  128.155315]  [<ffffffff8129c4d8>] ? kernfs_path+0x48/0x60
[  128.155319]  [<ffffffff8129fae2>] sysfs_warn_dup+0x62/0x80
[  128.155324]  [<ffffffff8129fe67>] sysfs_do_create_link_sd.isra.2
+0x97/0xb0
[  128.155329]  [<ffffffff8129fea5>] sysfs_create_link+0x25/0x40
[  128.155336]  [<ffffffff81619709>] add_cpu_dev_symlink+0x49/0x90
[  128.155340]  [<ffffffff8161b415>] cpufreq_online+0x215/0x790
[  128.155345]  [<ffffffffa03c1000>] ? 0xffffffffa03c1000
[  128.155349]  [<ffffffff8161ba52>] cpufreq_add_dev+0x62/0x90
[  128.155355]  [<ffffffff814d7ea1>] subsys_interface_register
+0xb1/0x100
[  128.155359]  [<ffffffff8161af4f>] cpufreq_register_driver+0x10f/0x220
[  128.155367]  [<ffffffffa03c1231>] acpi_cpufreq_init+0x231/0x1000
[acpi_cpufreq]
[  128.155372]  [<ffffffff81002123>] do_one_initcall+0xb3/0x200
[  128.155377]  [<ffffffff81204002>] ? kmem_cache_alloc_trace
+0x182/0x1f0
[  128.155382]  [<ffffffff811a45dd>] ? do_init_module+0x27/0x1e5
[  128.155387]  [<ffffffff811a4615>] do_init_module+0x5f/0x1e5
[  128.155392]  [<ffffffff8112479c>] load_module+0x201c/0x2630
[  128.155399]  [<ffffffff81120cc0>] ? __symbol_put+0x60/0x60
[  128.155406]  [<ffffffff81228fc0>] ? kernel_read+0x50/0x80
[  128.155411]  [<ffffffff81124ff9>] SyS_finit_module+0xb9/0xf0
[  128.155419]  [<ffffffff817818ee>] entry_SYSCALL_64_fastpath+0x12/0x71
[  128.155423] ---[ end trace 7d344a24810d0a61 ]---
[  128.155719] ------------[ cut here ]------------
[  128.155727] WARNING: CPU: 0 PID: 3201 at fs/sysfs/dir.c:31
sysfs_warn_dup+0x62/0x80()
[  128.155730] sysfs: cannot create duplicate filename
'/devices/system/cpu/cpu2/cpufreq'
[  128.155732] Modules linked in: acpi_cpufreq(+) rfcomm ccm cmac
xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun
nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack vboxpci(OE) vboxnetadp(OE) vboxnetflt(OE)
ebtable_nat ebtable_broute bridge ebtable_filter ebtables ip6table_nat
nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle vboxdrv(OE)
ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack fuse
iptable_mangle iptable_security vmw_vsock_vmci_transport iptable_raw
vsock vmw_vmci bnep dm_crypt snd_soc_sst_broadwell arc4
hid_sensor_incl_3d hid_sensor_magn_3d hid_sensor_rotation hid_sensor_als
hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_trigger
hid_sensor_iio_common
[  128.155790]  industrialio_triggered_buffer iwlmvm joydev
hid_sensor_hub hid_multitouch snd_hda_codec_hdmi snd_soc_rt286 elan_i2c
snd_soc_rl6347a mac80211 snd_soc_sst_haswell_pcm snd_soc_sst_ipc
snd_soc_sst_dsp snd_soc_core iTCO_wdt iTCO_vendor_support snd_compress
ppdev snd_pcm_dmaengine ac97_bus intel_rapl x86_pkg_temp_thermal
coretemp kvm_intel kvm snd_hda_intel irqbypass crct10dif_pclmul vfat
snd_hda_codec crc32_pclmul fat iwlwifi uvcvideo crc32c_intel btusb
snd_hda_core btrtl videobuf2_vmalloc btbcm videobuf2_v4l2 videobuf2_core
btintel snd_hwdep snd_seq bluetooth videobuf2_memops v4l2_common
cfg80211 videodev snd_seq_device snd_pcm pcspkr cdc_acm media i2c_i801
snd_timer snd mei_me mei processor_thermal_device shpchp
intel_soc_dts_iosf iosf_mbi lpc_ich soundcore acpi_als winbond_cir
kfifo_buf
[  128.155856]  soc_button_array industrialio rc_core int3403_thermal
parport_pc parport rfkill_gpio dw_dmac int3400_thermal snd_soc_sst_acpi
dw_dmac_core i2c_designware_platform acpi_thermal_rel rfkill
i2c_designware_core tpm_crb tpm_tis tpm int3402_thermal acpi_pad
int340x_thermal_zone nfsd nfs_acl lockd auth_rpcgss grace sunrpc
binfmt_misc cdc_mbim cdc_wdm cdc_ncm usbnet mii i915 8021q garp stp llc
mrp i2c_algo_bit drm_kms_helper drm e1000e sdhci_pci serio_raw
sdhci_acpi ptp sdhci pps_core mmc_core video i2c_hid [last unloaded:
acpi_cpufreq]
[  128.155909] CPU: 0 PID: 3201 Comm: modprobe Tainted: G        W  OE
4.4.0-rc1 #84
[  128.155912] Hardware name: Intel Corporation Broadwell Client
platform/Wilson Beach SDS, BIOS BDW-E2R1.86C.0121.R04.1505080303
05/08/2015
[  128.155915]  0000000000000000 000000005dac0241 ffff88026000fa70
ffffffff813a3fff
[  128.155920]  ffff88026000fab8 ffff88026000faa8 ffffffff810a0852
ffff8802194f3000
[  128.155925]  ffffffff81ab37c2 ffff880263f989d8 ffff880263f989d8
ffffffffffffffef
[  128.155931] Call Trace:
[  128.155937]  [<ffffffff813a3fff>] dump_stack+0x44/0x55
[  128.155942]  [<ffffffff810a0852>] warn_slowpath_common+0x82/0xc0
[  128.155947]  [<ffffffff810a08ec>] warn_slowpath_fmt+0x5c/0x80
[  128.155954]  [<ffffffff8129c4d8>] ? kernfs_path+0x48/0x60
[  128.155958]  [<ffffffff8129fae2>] sysfs_warn_dup+0x62/0x80
[  128.155963]  [<ffffffff8129fe67>] sysfs_do_create_link_sd.isra.2
+0x97/0xb0
[  128.155967]  [<ffffffff8129fea5>] sysfs_create_link+0x25/0x40
[  128.155974]  [<ffffffff81619709>] add_cpu_dev_symlink+0x49/0x90
[  128.155978]  [<ffffffff8161b415>] cpufreq_online+0x215/0x790
[  128.155982]  [<ffffffffa03c1000>] ? 0xffffffffa03c1000
[  128.155986]  [<ffffffff8161ba52>] cpufreq_add_dev+0x62/0x90
[  128.155992]  [<ffffffff814d7ea1>] subsys_interface_register
+0xb1/0x100
[  128.155996]  [<ffffffff8161af4f>] cpufreq_register_driver+0x10f/0x220
[  128.156003]  [<ffffffffa03c1231>] acpi_cpufreq_init+0x231/0x1000
[acpi_cpufreq]
[  128.156009]  [<ffffffff81002123>] do_one_initcall+0xb3/0x200
[  128.156014]  [<ffffffff81204002>] ? kmem_cache_alloc_trace
+0x182/0x1f0
[  128.156019]  [<ffffffff811a45dd>] ? do_init_module+0x27/0x1e5
[  128.156024]  [<ffffffff811a4615>] do_init_module+0x5f/0x1e5
[  128.156029]  [<ffffffff8112479c>] load_module+0x201c/0x2630
[  128.156036]  [<ffffffff81120cc0>] ? __symbol_put+0x60/0x60
[  128.156043]  [<ffffffff81228fc0>] ? kernel_read+0x50/0x80
[  128.156048]  [<ffffffff81124ff9>] SyS_finit_module+0xb9/0xf0
[  128.156056]  [<ffffffff817818ee>] entry_SYSCALL_64_fastpath+0x12/0x71
[  128.156059] ---[ end trace 7d344a24810d0a62 ]---
[  128.156304] ------------[ cut here ]------------
[  128.156310] WARNING: CPU: 0 PID: 3201 at fs/sysfs/dir.c:31
sysfs_warn_dup+0x62/0x80()
[  128.156313] sysfs: cannot create duplicate filename
'/devices/system/cpu/cpu3/cpufreq'
[  128.156315] Modules linked in: acpi_cpufreq(+) rfcomm ccm cmac
xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun
nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack vboxpci(OE) vboxnetadp(OE) vboxnetflt(OE)
ebtable_nat ebtable_broute bridge ebtable_filter ebtables ip6table_nat
nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle vboxdrv(OE)
ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack fuse
iptable_mangle iptable_security vmw_vsock_vmci_transport iptable_raw
vsock vmw_vmci bnep dm_crypt snd_soc_sst_broadwell arc4
hid_sensor_incl_3d hid_sensor_magn_3d hid_sensor_rotation hid_sensor_als
hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_trigger
hid_sensor_iio_common
[  128.156373]  industrialio_triggered_buffer iwlmvm joydev
hid_sensor_hub hid_multitouch snd_hda_codec_hdmi snd_soc_rt286 elan_i2c
snd_soc_rl6347a mac80211 snd_soc_sst_haswell_pcm snd_soc_sst_ipc
snd_soc_sst_dsp snd_soc_core iTCO_wdt iTCO_vendor_support snd_compress
ppdev snd_pcm_dmaengine ac97_bus intel_rapl x86_pkg_temp_thermal
coretemp kvm_intel kvm snd_hda_intel irqbypass crct10dif_pclmul vfat
snd_hda_codec crc32_pclmul fat iwlwifi uvcvideo crc32c_intel btusb
snd_hda_core btrtl videobuf2_vmalloc btbcm videobuf2_v4l2 videobuf2_core
btintel snd_hwdep snd_seq bluetooth videobuf2_memops v4l2_common
cfg80211 videodev snd_seq_device snd_pcm pcspkr cdc_acm media i2c_i801
snd_timer snd mei_me mei processor_thermal_device shpchp
intel_soc_dts_iosf iosf_mbi lpc_ich soundcore acpi_als winbond_cir
kfifo_buf
[  128.156449]  soc_button_array industrialio rc_core int3403_thermal
parport_pc parport rfkill_gpio dw_dmac int3400_thermal snd_soc_sst_acpi
dw_dmac_core i2c_designware_platform acpi_thermal_rel rfkill
i2c_designware_core tpm_crb tpm_tis tpm int3402_thermal acpi_pad
int340x_thermal_zone nfsd nfs_acl lockd auth_rpcgss grace sunrpc
binfmt_misc cdc_mbim cdc_wdm cdc_ncm usbnet mii i915 8021q garp stp llc
mrp i2c_algo_bit drm_kms_helper drm e1000e sdhci_pci serio_raw
sdhci_acpi ptp sdhci pps_core mmc_core video i2c_hid [last unloaded:
acpi_cpufreq]
[  128.156502] CPU: 0 PID: 3201 Comm: modprobe Tainted: G        W  OE
4.4.0-rc1 #84
[  128.156505] Hardware name: Intel Corporation Broadwell Client
platform/Wilson Beach SDS, BIOS BDW-E2R1.86C.0121.R04.1505080303
05/08/2015
[  128.156508]  0000000000000000 000000005dac0241 ffff88026000fa70
ffffffff813a3fff
[  128.156513]  ffff88026000fab8 ffff88026000faa8 ffffffff810a0852
ffff8802194f3000
[  128.156518]  ffffffff81ab37c2 ffff880263f992d0 ffff880263f992d0
ffffffffffffffef
[  128.156524] Call Trace:
[  128.156529]  [<ffffffff813a3fff>] dump_stack+0x44/0x55
[  128.156535]  [<ffffffff810a0852>] warn_slowpath_common+0x82/0xc0
[  128.156540]  [<ffffffff810a08ec>] warn_slowpath_fmt+0x5c/0x80
[  128.156547]  [<ffffffff8129c4d8>] ? kernfs_path+0x48/0x60
[  128.156551]  [<ffffffff8129fae2>] sysfs_warn_dup+0x62/0x80
[  128.156556]  [<ffffffff8129fe67>] sysfs_do_create_link_sd.isra.2
+0x97/0xb0
[  128.156566]  [<ffffffff8129fea5>] sysfs_create_link+0x25/0x40
[  128.156573]  [<ffffffff81619709>] add_cpu_dev_symlink+0x49/0x90
[  128.156577]  [<ffffffff8161b415>] cpufreq_online+0x215/0x790
[  128.156582]  [<ffffffffa03c1000>] ? 0xffffffffa03c1000
[  128.156586]  [<ffffffff8161ba52>] cpufreq_add_dev+0x62/0x90
[  128.156591]  [<ffffffff814d7ea1>] subsys_interface_register
+0xb1/0x100
[  128.156596]  [<ffffffff8161af4f>] cpufreq_register_driver+0x10f/0x220
[  128.156602]  [<ffffffffa03c1231>] acpi_cpufreq_init+0x231/0x1000
[acpi_cpufreq]
[  128.156608]  [<ffffffff81002123>] do_one_initcall+0xb3/0x200
[  128.156613]  [<ffffffff81204002>] ? kmem_cache_alloc_trace
+0x182/0x1f0
[  128.156618]  [<ffffffff811a45dd>] ? do_init_module+0x27/0x1e5
[  128.156623]  [<ffffffff811a4615>] do_init_module+0x5f/0x1e5
[  128.156628]  [<ffffffff8112479c>] load_module+0x201c/0x2630
[  128.156634]  [<ffffffff81120cc0>] ? __symbol_put+0x60/0x60
[  128.156642]  [<ffffffff81228fc0>] ? kernel_read+0x50/0x80
[  128.156647]  [<ffffffff81124ff9>] SyS_finit_module+0xb9/0xf0
[  128.156654]  [<ffffffff817818ee>] entry_SYSCALL_64_fastpath+0x12/0x71
[  128.156657] ---[ end trace 7d344a24810d0a63 ]---


Thanks,
Srinivas

