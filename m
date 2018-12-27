From: DeX77 <dex@dragonslave.de>
Subject: Re: =?iso-8859-1?Q?ath10=5Fpci:_WARN(()_on_resume_from_S3?=
Date: Thu, 27 Dec 2018 12:19:39 +0100
Message-ID: <61b6a969-9692-4ebc-91fa-9c221ca5d4d4@frugalware.org>
References: <de26281344602d5edbd3600e0ef4afd3@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <de26281344602d5edbd3600e0ef4afd3@frugalware.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriel C <crazy@frugalware.org>
Cc: Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dex77@frugalware.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, nix.or.die@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi,


> 4.20.0 I see now two.
>
> Also I see Unknown eventid: xxx and on 4.20.0
> a unsupported HTC service id: xxx message(s).

I have a similar trace on my Dell XPS 13:

[31530.551292] ath10k_pci 0000:3a:00.0: unsupported HTC service id: 1536
[31530.566621] ath10k_pci 0000:3a:00.0: Unknown eventid: 118809
[31530.589165] WARNING: CPU: 0 PID: 6424 at=20
drivers/net/wireless/ath/ath10k/mac.c:5687=20
ath10k_bss_info_changed+0xad4/0xef0 [ath10k_core]
[31530.589166] Modules linked in: tun ctr ccm cmac bnep uvcvideo=20
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev=20=

btusb media btrtl btbcm btintel bluetooth ecdh_generic crc16 af_packet=20
joydev arc4 nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct=20=

xt_tcpudp xt_state xt_conntrack nf_conntrack nf_tables_set nf_defrag_ipv6=20
nf_defrag_ipv4 iptable_filter nf_tables ip_tables x_tables nfnetlink=20
snd_hda_codec_hdmi iTCO_wdt iTCO_vendor_support ath10k_pci=20
i2c_designware_platform i2c_designware_core ath10k_core snd_soc_skl=20
snd_soc_hdac_hda coretemp intel_rapl snd_hda_ext_core x86_pkg_temp_thermal=20=

intel_powerclamp snd_soc_skl_ipc kvm_intel snd_soc_sst_ipc snd_soc_sst_dsp=20=

ath snd_soc_acpi_intel_match snd_soc_acpi mac80211 dell_laptop kvm=20
snd_soc_core nls_utf8 nls_cp437 snd_hda_codec_realtek vfat=20
snd_hda_codec_generic fat snd_compress dell_wmi snd_pcm_dmaengine=20
dell_smbios snd_hda_intel dcdbas cfg80211 snd_hda_codec irqbypass=20
efi_pstore intel_wmi_thunderbolt rfkill
[31530.589196]  efivars snd_hda_core dell_wmi_descriptor wmi_bmof pcspkr=20
hwmon rtsx_pci_ms ucsi_acpi snd_hwdep i2c_i801 memstick typec_ucsi thermal=20=

typec mei_wdt battery soc_button_array intel_vbtn evdev=20
pinctrl_sunrisepoint mac_hid pinctrl_intel intel_hid=20
processor_thermal_device int3403_thermal sparse_keymap int3400_thermal=20
acpi_pad idma64 acpi_thermal_rel pcc_cpufreq int340x_thermal_zone ac button=20=

intel_soc_dts_iosf intel_pch_thermal intel_lpss_pci intel_lpss ppdev=20
sch_fq_codel binfmt_misc btrfs libcrc32c crc32c_generic xor raid6_pq=20
dm_crypt algif_skcipher af_alg hid_multitouch hid_generic usbhid i915=20
rtsx_pci_sdmmc mmc_core intel_gtt i2c_algo_bit cec rc_core drm_kms_helper=20
syscopyarea sysfillrect sysimgblt fb_sys_fops drm crct10dif_pclmul xhci_pci=20=

xhci_hcd crc32_pclmul ghash_clmulni_intel aesni_intel usbcore aes_x86_64=20
crypto_simd cryptd glue_helper serio_raw i2c_hid agpgart rtsx_pci hid=20
i2c_core wmi video dm_mirror dm_region_hash dm_log dm_mod fuse crc32c_intel=20=

snd_pcm_oss snd_mixer_oss
[31530.589230]  snd_pcm snd_seq_oss snd_seq_midi_event snd_seq snd_timer=20
snd_seq_device snd soundcore lp parport_pc parport efivarfs unix=20
sha256_ssse3 sha256_generic sha1_ssse3 sha1_generic hmac ipv6 autofs4
[31530.589240] CPU: 0 PID: 6424 Comm: kworker/u8:4 Tainted: G        W     =20=

   4.20-fw1 #1
[31530.589241] Hardware name: Dell Inc. XPS 13 9360/06CC14, BIOS 2.9.0=20
07/09/2018
[31530.589245] Workqueue: events_unbound async_run_entry_fn
[31530.589250] RIP: 0010:ath10k_bss_info_changed+0xad4/0xef0 [ath10k_core]
[31530.589251] Code: 00 00 e8 af 0c fc d1 e9 94 f8 ff ff 8b b5 68 01 00 00=20=

89 f2 89 c1 48 c7 c6 70 ef 0f c1 48 89 df e8 e1 35 00 00 e9 eb f5 ff ff=20
<0f> 0b 4c 89 f7 e8 f2 8f 5b d2 e9 4f f9 ff ff 66 83 f8 0a 0f 85 27
[31530.589252] RSP: 0018:ffffb733c428fcd8 EFLAGS: 00010282
[31530.589253] RAX: 00000000fffffffe RBX: ffff91ed1d781580 RCX:=20
0000000000000000
[31530.589254] RDX: ffff91ed1d7818f8 RSI: ffffb733c428fcf8 RDI:=20
ffff91ed17073380
[31530.589255] RBP: ffff91ed17073380 R08: 0000000000200000 R09:=20
0000000000000000
[31530.589256] R10: 000000000000001f R11: ffff91eb26c1b600 R12:=20
0000000000000020
[31530.589256] R13: ffff91ed17073388 R14: ffff91ed1d782558 R15:=20
ffff91ed1d781580
[31530.589258] FS:  0000000000000000(0000) GS:ffff91ed2e200000(0000)=20
knlGS:0000000000000000
[31530.589258] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[31530.589259] CR2: 000056125129f4d6 CR3: 00000002b200a002 CR4:=20
00000000003606f0
[31530.589260] Call Trace:
[31530.589266]  ? ath10k_conf_tx+0x12d/0x4c0 [ath10k_core]
[31530.589284]  ieee80211_bss_info_change_notify+0xa9/0x1c0 [mac80211]
[31530.589297]  ieee80211_reconfig+0xa4f/0x1560 [mac80211]
[31530.589313]  wiphy_resume+0x7e/0x150 [cfg80211]
[31530.589322]  ? wiphy_namespace+0x10/0x10 [cfg80211]
[31530.589325]  dpm_run_callback+0x2e/0x130
[31530.589327]  device_resume+0x97/0x190
[31530.589329]  async_resume+0x19/0x40
[31530.589331]  async_run_entry_fn+0x37/0xe0
[31530.589334]  process_one_work+0x1e9/0x410
[31530.589336]  worker_thread+0x2d/0x3d0
[31530.589338]  ? process_one_work+0x410/0x410
[31530.589340]  kthread+0x113/0x130
[31530.589341]  ? kthread_park+0x90/0x90
[31530.589344]  ret_from_fork+0x35/0x40
[31530.589346] ---[ end trace e8c7a75d6d802f88 ]---


Please keep me CC, as I'm currently not subscribed. Thx.

Greetings
DeX
