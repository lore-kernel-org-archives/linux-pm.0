From: Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>
Subject: Re: [PATCH v4 0/2] Exynos IOMMU: proper runtime PM support (use
	device dependencies)
Date: Thu, 6 Oct 2016 18:28:30 +0200
Message-ID: <57F67BAE.2090505@math.uni-bielefeld.de>
References: <CGME20160929081238eucas1p1a064e5371ce549f860d6cff4bd43b557@eucas1p1.samsung.com>
	<1475136751-31340-1-git-send-email-m.szyprowski@samsung.com>
	<57F581BD.3070208@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <57F581BD.3070208-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello again,


Tobias Jakobi wrote:
> Hello Marek,
> 
> I have applied the new version onto 4.8.0 but I'm seeing this Oops on
> shutdown/reboot. However it only shows up with my non-debug config.
sorry for the false alarm. That Oops on reboot was due to some other
patch I had applied.


With best wishes,
Tobias


>> [  897.046373] Internal error: Oops: 80000005 [#1] PREEMPT SMP ARM
>> [  897.046652] Modules linked in: bridge stp llc bnep btrfs xor xor_neon zlib_inflate zlib_deflate raid6_pq s5p_mfc extcon_odroid_usbotg btusb btbcm btintel s5p_jpeg videobuf2_dma_contig v4l2_mem2mem videobuf2_memops videobuf2_v4l2 videobuf2_core
>> [  897.068174] CPU: 2 PID: 9437 Comm: reboot Not tainted 4.8.0-vanilla+ #2
>> [  897.074772] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>> [  897.080848] task: eea02100 task.stack: cb488000
>> [  897.085363] PC is at 0xb886c672
>> [  897.088489] LR is at device_shutdown+0x134/0x1c0
>> [  897.093087] pc : [<b886c672>]    lr : [<c0405b14>]    psr: 600a0073
>> [  897.093087] sp : cb489e28  ip : 00000000  fp : cb489e4c
>> [  897.104547] r10: 00000000  r9 : ee0cfe44  r8 : c0a39020
>> [  897.109752] r7 : c0a6d774  r6 : ee0cfe10  r5 : ee08b810  r4 : ee0cfe1c
>> [  897.116262] r3 : b886c673  r2 : 00000000  r1 : 00000002  r0 : ee0cfe10
>> [  897.122773] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA Thumb  Segment none
>> [  897.130151] Control: 10c5387d  Table: 6a24404a  DAC: 00000051
>> [  897.135879] Process reboot (pid: 9437, stack limit = 0xcb488218)
>> [  897.141868] Stack: (0xcb489e28 to 0xcb48a000)
>> [  897.146209] 9e20:                   00000000 00000000 01234567 c0a09d4c 00000010 c0a09a88
>> [  897.154371] 9e40: cb489e5c cb489e50 c013eb5c c04059ec cb489e74 cb489e60 c013ec38 c013eb2c
>> [  897.162530] 9e60: 01234567 c0a02448 cb489fa4 cb489e78 c013ef08 c013ec30 eb87ca80 00c0d000
>> [  897.170698] 9e80: cb489ea4 cb489e90 c01c9660 c01c9434 ef026000 00000000 cb489eb4 cb489ea8
>> [  897.178855] 9ea0: c01c977c c01c961c cb489ec4 cb489eb8 c01c9798 c01c9760 cb489f3c cb489ec8
>> [  897.187014] 9ec0: c01eeaa4 c01c978c eb87ca80 00000000 ec421210 00c0d000 ed8af3c0 eefd5140
>> [  897.195173] 9ee0: ee84a140 eea11e40 cb489f14 cb489ef8 c022bc58 c016cfa0 ed8afa80 ee665c38
>> [  897.203333] 9f00: 00000000 eea11e50 cb489f24 cb489f18 c022be1c c022bc20 cb489f5c cb489f28
>> [  897.211492] 9f20: c020ce88 c022bdfc 00000020 00000000 cb489f54 eea024f8 c0a39f7c 00000000
>> [  897.219651] 9f40: eea02100 c0107ee4 cb488000 00000000 cb489f6c cb489f60 c020cf80 c020cd5c
>> [  897.227810] 9f60: cb489f8c cb489f70 c013aa40 c06dd2dc cb488010 c0107ee4 cb489fb0 00040800
>> [  897.235969] 9f80: 00000001 be966ce0 00bec008 00000058 c0107ee4 cb488000 00000000 cb489fa8
>> [  897.244129] 9fa0: c0107d20 c013ee04 00000001 be966ce0 fee1dead 28121969 01234567 00000010
>> [  897.252287] 9fc0: 00000001 be966ce0 00bec008 00000058 00000000 000230e4 00000000 00000000
>> [  897.260447] 9fe0: 00023030 be966cc4 00010e9c b6f3f290 200a0050 fee1dead 00000000 00000000
>> [  897.268603] Backtrace: 
>> [  897.271033] [<c04059e0>] (device_shutdown) from [<c013eb5c>] (kernel_restart_prepare+0x3c/0x40)
>> [  897.279715]  r9:c0a09a88 r8:00000010 r7:c0a09d4c r6:01234567 r5:00000000 r4:00000000
>> [  897.287439] [<c013eb20>] (kernel_restart_prepare) from [<c013ec38>] (kernel_restart+0x14/0x58)
>> [  897.296036] [<c013ec24>] (kernel_restart) from [<c013ef08>] (SyS_reboot+0x110/0x1f8)
>> [  897.303757]  r4:c0a02448 r3:01234567
>> [  897.307314] [<c013edf8>] (SyS_reboot) from [<c0107d20>] (ret_fast_syscall+0x0/0x3c)
>> [  897.314955]  r9:cb488000 r8:c0107ee4 r7:00000058 r6:00bec008 r5:be966ce0 r4:00000001
>> [  897.322680] Code: bad PC value
>> [  897.325940] ---[ end trace 861fd282a7bdc01e ]---
> 
> 
> The corresponding config:
> https://github.com/tobiasjakobi/odroid-environment/blob/master/sourcecode/system/vanilla-4.8.conf
> 
> 
> With best wishes,
> Tobias
> 
> 
> 
> 
> Marek Szyprowski wrote:
>> Hello,
>>
>> This patch series finally implements proper runtime PM support in Exynos
>> IOMMU driver. This has been achieved by using recently introduce device
>> links, which lets SYSMMU controller's runtime PM to follow master's device
>> runtime PM state (the device which actually performs DMA transaction).
>> The main idea behind this solution is an observation that any DMA activity
>> from master device can be done only when master device is active, thus when
>> master device is suspended SYSMMU controller device can also be suspended.
>>
>> This patchset solves the situation that power domains are always enabled,
>> because all SYSMMU controllers (which belongs to those domains) are
>> permanently active (because existing driver was simplified and kept
>> SYSMMU device active all the time after initialization).
>>
>> Patch requires fourth version of Rafeal's "Functional dependencies
>> between devices" patchset, which is available here:
>> https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1241473.html
>>
>> If one wants to test this patchset, I've provided a branch with all needed
>> patches (some fixes for Exynos4 FIMC-IS driver are needed):
>> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.8-iommu-pm-v4
>>
>> Patches are based on vanilla v4.8-rc8 kernel with Rafael's device
>> dependencies v4 patchset applied.
>>
>> Best regards
>> Marek Szyprowski
>> Samsung R&D Institute Poland
>>
>>
>> Changelog:
>> v4:
>> - rebased on top of v4 of device dependencies/links patchset, what resolved
>>   system hang on reboot
>>
>> v3: http://www.spinics.net/lists/linux-samsung-soc/msg55256.html
>> - rebased on top of latest device dependencies/links patchset
>> - added proper locking between runtime pm, iommu_attach/detach and sysmmu
>>   enable/disable(added per iommu owner device's rpm lock)
>>
>> v2: http://www.spinics.net/lists/arm-kernel/msg512082.html
>> - replaced PM notifiers with generic device dependencies/links developped
>>   by Rafael J. Wysocki
>>
>> v1: http://www.spinics.net/lists/arm-kernel/msg509600.html
>> - initial version
>>
>>
>> Patch summary:
>>
>> Marek Szyprowski (2):
>>   iommu/exynos: Remove excessive, useless debug
>>   iommu/exynos: Add proper runtime pm support
>>
>>  drivers/iommu/exynos-iommu.c | 228 ++++++++++++++++++-------------------------
>>  1 file changed, 94 insertions(+), 134 deletions(-)
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
