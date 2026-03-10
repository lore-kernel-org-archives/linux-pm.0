Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950C18DB1A;
	Tue, 10 Mar 2026 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773102633; cv=none; b=kEPsEKf4hCv29auDtgNTfSbHS3o9ZfQqqKAAlkKwL+aHeSsoEwmnrKcgDCZwN95XihizzBL3jUcyflD+sSXx9Cd0JWQ2Um0uRfCSbcz0+gvZ16AUjyZ6gHcpRCooeiqA8+mLOFSxV9mZnndsRyZmZT0/ExkF2qU36dRtGOuTstQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773102633; c=relaxed/simple;
	bh=n18tT61Zj7t5w2k+YhfUfbzS5EwS/8CBeJsPH9PplB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co96VFWSWGqfuOIaLmC8EBniQ/WsH3Lk9IMApMcVmhvMPT1AbBdZaBtdiouXGC6wGM17+EOnN/Y1ljmHLglYrDz8aXLPloN2qfo08AVGBtHoJTp6wZmy9BOqoVOXYfd+O+1ZHRvpsTUe42Sy5vDo8rwlk5vIo2dFGJ57jzmDo8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpW5cbNz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpW5cbNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F945C4CEF7;
	Tue, 10 Mar 2026 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773102632;
	bh=n18tT61Zj7t5w2k+YhfUfbzS5EwS/8CBeJsPH9PplB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpW5cbNzKRPEEKCQkRF2TR5f1JpsXAAwpe0QxkNKJzCtcTlTvFHobq1FHwCExtPRJ
	 O983Bda5co05+yiciF4t6kFJArBsg76z5IGZwygfmyFlBQwPnTLgXArQkKMLwDRWys
	 eJMVmPMZNP92tyNvXtc6w9gWdqAhAFk/eTIBWTRQk3noyZ5AbjrO6QHoroGuBg5mx8
	 BmVx93OY090JsoHfEdUHWt9XlDVfX+k6uL6sbQ7IKPPrL15+BIwcNlh4LKCLNU4ke1
	 1UKNT6DfM71hEYt8nQvQNq/zWz7gSv7hgySwROFiXWa4YyO6DW6sb8jkm3r9MaBNRo
	 +124Ou2CD9WYA==
Date: Mon, 9 Mar 2026 17:30:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
	robert.moore@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev, zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com, lihuisong@huawei.com, yubowen8@huawei.com,
	linhongye@h-partners.com, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, wangzhi12@huawei.com
Subject: Re: [PATCH v2] ACPI: CPPC: Move reference performance to capabilities
Message-ID: <20260310003026.GA2639793@ax162>
References: <20260213100935.19111-1-zhangpengjie2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dlmdegZ76qxTp6Nd"
Content-Disposition: inline
In-Reply-To: <20260213100935.19111-1-zhangpengjie2@huawei.com>


--dlmdegZ76qxTp6Nd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pengjie,

On Fri, Feb 13, 2026 at 06:09:35PM +0800, Pengjie Zhang wrote:
> Currently, the `Reference Performance` register is read every time
> the CPU frequency is sampled in `cppc_get_perf_ctrs()`. This function
> is on the hot path of the cpufreq driver.
> 
> Reference Performance indicates the performance level that corresponds
> to the Reference Counter incrementing and is not expected to change
> dynamically during runtime (unlike the Delivered and Reference counters).
> 
> Reading this register in the hot path incurs unnecessary overhead,
> particularly on platforms where CPC registers are located in the PCC
> (Platform Communication Channel) subspace. This patch moves
> `reference_perf` from the dynamic feedback counters structure
> (`cppc_perf_fb_ctrs`) to the static capabilities structure
> (`cppc_perf_caps`).
> 
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>

After this change landed in -next as commit 8505bfb4e4ec ("ACPI: CPPC:
Move reference performance to capabilities"), I am seeing the following
dmesg errors on one of my test machines.

  Could not retrieve perf counters (-14)
  amd_pstate: Failed to initialize CPU 0: -14
  amd_pstate: Failed to initialize CPU 1: -14
  amd_pstate: Failed to initialize CPU 2: -14
  amd_pstate: Failed to initialize CPU 3: -14
  amd_pstate: Failed to initialize CPU 4: -14
  amd_pstate: Failed to initialize CPU 5: -14
  amd_pstate: Failed to initialize CPU 6: -14
  amd_pstate: Failed to initialize CPU 7: -14
  amd_pstate: Failed to initialize CPU 8: -14
  amd_pstate: Failed to initialize CPU 9: -14
  amd_pstate: Failed to initialize CPU 10: -14
  amd_pstate: Failed to initialize CPU 11: -14
  amd_pstate: Failed to initialize CPU 12: -14
  amd_pstate: Failed to initialize CPU 13: -14
  amd_pstate: Failed to initialize CPU 14: -14
  amd_pstate: Failed to initialize CPU 15: -14
  amd_pstate: Failed to initialize CPU 16: -14
  amd_pstate: Failed to initialize CPU 17: -14
  amd_pstate: Failed to initialize CPU 18: -14
  amd_pstate: Failed to initialize CPU 19: -14
  amd_pstate: Failed to initialize CPU 20: -14
  amd_pstate: Failed to initialize CPU 21: -14
  amd_pstate: Failed to initialize CPU 22: -14
  amd_pstate: Failed to initialize CPU 23: -14
  amd_pstate: Failed to initialize CPU 24: -14
  amd_pstate: Failed to initialize CPU 25: -14
  amd_pstate: Failed to initialize CPU 26: -14
  amd_pstate: Failed to initialize CPU 27: -14
  amd_pstate: Failed to initialize CPU 28: -14
  amd_pstate: Failed to initialize CPU 29: -14
  amd_pstate: Failed to initialize CPU 30: -14
  amd_pstate: Failed to initialize CPU 31: -14
  amd_pstate: failed to register with return -19

At the parent change, there are no errors from amd_pstate and I see

  $ cat /sys/devices/system/cpu/amd_pstate/status
  active

in sysfs. Is this expected? If not, I am happy to provide any additional
information and test patches. I have attached dmesg outputs from the
good and bad revisions, in case they would be helpful for gathering
information.

Cheers,
Nathan

# bad: [ea4134533224d500b2985d30cde106aa3680905d] Add linux-next specific files for 20260309
# good: [1f318b96cc84d7c2ab792fcc0bfd42a7ca890681] Linux 7.0-rc3
git bisect start 'ea4134533224d500b2985d30cde106aa3680905d' '1f318b96cc84d7c2ab792fcc0bfd42a7ca890681'
# bad: [57a0c77d3b89916ae8a01266ed6773038daba7e6] Merge branch 'main' of https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad 57a0c77d3b89916ae8a01266ed6773038daba7e6
# good: [2254ba55816e189211a37c14cf4022db826c17ba] Merge branch 'riscv-dt-for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git
git bisect good 2254ba55816e189211a37c14cf4022db826c17ba
# good: [57c49b297b6134e349418ad439895acb2b5fdd05] Merge branch 'i2c/for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
git bisect good 57c49b297b6134e349418ad439895acb2b5fdd05
# good: [8d282b680c729203d04d4eee396f3216f29b35aa] eth: fbnic: Fetch TX pause storm stats
git bisect good 8d282b680c729203d04d4eee396f3216f29b35aa
# bad: [397b4a14684942a64d32ca767816f42c8199bee0] Merge branch 'devfreq-next' of https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
git bisect bad 397b4a14684942a64d32ca767816f42c8199bee0
# good: [44f09a027369c62cf5dbe74ef359f41debbbce7c] Merge branch 'docs-next' of git://git.lwn.net/linux.git
git bisect good 44f09a027369c62cf5dbe74ef359f41debbbce7c
# bad: [ef5af3b0263db70168ad2d1be317d79568411ad4] Merge branches 'acpi-tad' and 'acpi-cppc' into linux-next
git bisect bad ef5af3b0263db70168ad2d1be317d79568411ad4
# good: [9c8e43e3ee8de15d29c2536540de53011e6760bb] Merge branch 'acpi-cmos-rtc' into linux-next
git bisect good 9c8e43e3ee8de15d29c2536540de53011e6760bb
# good: [da0f602a7202a65a6029c8e5c2e92a621a473f5b] Merge branch 'acpi-cppc' into linux-next
git bisect good da0f602a7202a65a6029c8e5c2e92a621a473f5b
# good: [76f9d5b4246705f45d254353cb55a7d598a87591] ACPI: TAD: Rearrange RT data validation checking
git bisect good 76f9d5b4246705f45d254353cb55a7d598a87591
# good: [2fc2d223e9809504089ab2cec334d82940e985d9] ACPI: TAD: Add RTC class device interface
git bisect good 2fc2d223e9809504089ab2cec334d82940e985d9
# good: [c30c96dc51e51cf77e2eea5ab1f26fc3177163b2] ACPI: TAD: Update the driver description comment
git bisect good c30c96dc51e51cf77e2eea5ab1f26fc3177163b2
# bad: [8505bfb4e4eca28ef1b20d3369435ec2d6a125c6] ACPI: CPPC: Move reference performance to capabilities
git bisect bad 8505bfb4e4eca28ef1b20d3369435ec2d6a125c6
# first bad commit: [8505bfb4e4eca28ef1b20d3369435ec2d6a125c6] ACPI: CPPC: Move reference performance to capabilities

--dlmdegZ76qxTp6Nd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=dmesg-good-856250ba2e810e772dc95b3234ebf0d6393a51d9

[    0.000000] Linux version 7.0.0-rc1-debug-00007-g856250ba2e81 (nathan@framework-amd-ryzen-maxplus-395) (x86_64-linux-gcc (GCC) 15.2.0, GNU ld (GNU Binutils) 2.45) #1 SMP PREEMPT_DYNAMIC Mon Mar  9 17:11:28 MST 2026
[    0.000000] Command line: initrd=\initramfs-linux-debug.img amd_pstate=active kvm.mitigate_smt_rsb=1 root=PARTUUID=29eee245-b7e0-43d2-8cb3-5516b5464a96 rootflags=subvol=@ rootfstype=btrfs rw zswap.enabled=0
[    0.000000] x86/split lock detection: #DB: warning on user-space bus_locks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff]  System RAM
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff]  System RAM
[    0.000000] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff]  System RAM
[    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f87fff]  ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000009f88000-0x0000000070b53fff]  System RAM
[    0.000000] BIOS-e820: [mem 0x0000000070b54000-0x0000000072d53fff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000072d54000-0x0000000072d66fff]  System RAM
[    0.000000] BIOS-e820: [mem 0x0000000072d67000-0x0000000072d6bfff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000072d6c000-0x0000000076f7efff]  System RAM
[    0.000000] BIOS-e820: [mem 0x0000000076f7f000-0x000000007977efff]  device reserved
[    0.000000] BIOS-e820: [mem 0x000000007977f000-0x0000000079f7efff]  ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000079f7f000-0x0000000079ffefff]  ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000079fff000-0x0000000079ffffff]  System RAM
[    0.000000] BIOS-e820: [mem 0x000000007a000000-0x000000007bffffff]  device reserved
[    0.000000] BIOS-e820: [gap 0x000000007c000000-0x000000007d674fff]
[    0.000000] BIOS-e820: [mem 0x000000007d675000-0x00000000ffffffff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000105e0bffff]  System RAM
[    0.000000] BIOS-e820: [mem 0x000000105e0c0000-0x00000010b01fffff]  device reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.9 by INSYDE Corp.
[    0.000000] efi: ACPI=0x79ffe000 ACPI 2.0=0x79ffe014 TPMFinalLog=0x79f3e000 SMBIOS=0x77e74000 SMBIOS 3.0=0x77e71000 MEMATTR=0x681e7018 ESRT=0x73468e18 RNG=0x79f93f18 INITRD=0x681d6f18 TPMEventLog=0x79f87018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem57: MMIO range=[0x80000000-0xffffffff] (2048MB) from e820 map
[    0.000000] e820: remove [mem 0x80000000-0xffffffff] device reserved
[    0.000000] efi: Remove mem59: MMIO range=[0x1090000000-0x10b01fffff] (514MB) from e820 map
[    0.000000] e820: remove [mem 0x1090000000-0x10b01fffff] device reserved
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: Framework Desktop (AMD Ryzen AI Max 300 Series)/FRANMFCP04, BIOS 03.02 07/22/2025
[    0.000000] DMI: Memory slots populated: 8/8
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2994.388 MHz processor
[    0.000012] e820: update [mem 0x00000000-0x00000fff] System RAM ==> device reserved
[    0.000015] e820: remove [mem 0x000a0000-0x000fffff] System RAM
[    0.000026] last_pfn = 0x105e0c0 max_arch_pfn = 0x400000000
[    0.000038] MTRR map: 8 entries (3 fixed + 5 variable; max 20), built from 9 variable MTRRs
[    0.000041] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000272] last_pfn = 0x7a000 max_arch_pfn = 0x400000000
[    0.007359] esrt: Reserving ESRT space from 0x0000000073468e18 to 0x0000000073468e50.
[    0.007369] e820: update [mem 0x73468000-0x73468fff] System RAM ==> device reserved
[    0.007393] Using GB pages for direct mapping
[    0.007894] Secure boot disabled
[    0.007895] RAMDISK: [mem 0x60247000-0x62b7efff]
[    0.008091] ACPI: Early table checksum verification disabled
[    0.008096] ACPI: RSDP 0x0000000079FFE014 000024 (v02 INSYDE)
[    0.008101] ACPI: XSDT 0x0000000079FA8228 00019C (v01 INSYDE EDK2     00000001      01000013)
[    0.008110] ACPI: FACP 0x0000000079FEE000 000114 (v06 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008117] ACPI: DSDT 0x0000000079FC6000 0073D8 (v02 INSYDE EDK2     00040000 ACPI 00040000)
[    0.008120] ACPI: FACS 0x0000000079E32000 000040
[    0.008122] ACPI: UEFI 0x0000000079F66000 0001CF (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008125] ACPI: ASF! 0x0000000079FFC000 000085 (v32 INSYDE EDK2     00000002 ACPI 00040000)
[    0.008127] ACPI: SSDT 0x0000000079FF3000 00848D (v02 INSYDE EDK2     00000002 ACPI 00040000)
[    0.008130] ACPI: SSDT 0x0000000079FF2000 00033E (v02 INSYDE EDK2     00001000 ACPI 00040000)
[    0.008132] ACPI: ASF! 0x0000000079FF0000 0000A5 (v32 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008134] ACPI: BOOT 0x0000000079FEF000 000028 (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008136] ACPI: HPET 0x0000000079FED000 000038 (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008139] ACPI: MCFG 0x0000000079FEC000 00003C (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008141] ACPI: SLIC 0x0000000079FEB000 000176 (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008143] ACPI: APIC 0x0000000079FE1000 00016A (v06 INSYDE EDK2     00000002 ACPI 00040000)
[    0.008145] ACPI: SSDT 0x0000000079FE0000 000A6A (v02 INSYDE EDK2     00001000 ACPI 00040000)
[    0.008148] ACPI: SSDT 0x0000000079FD5000 00A8CE (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008150] ACPI: VFCT 0x0000000079FD0000 004484 (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008152] ACPI: FPDT 0x0000000079FCF000 000044 (v01 INSYDE EDK2     00000002 ACPI 00040000)
[    0.008154] ACPI: SSDT 0x0000000079FCE000 0000FA (v02 INSYDE EDK2     00001000 ACPI 00040000)
[    0.008157] ACPI: SSDT 0x0000000079FE8000 0006A2 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008159] ACPI: SSDT 0x0000000079FE7000 0008F9 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008161] ACPI: SSDT 0x0000000079FE4000 001DB7 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008163] ACPI: SSDT 0x0000000079FFD000 000782 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008166] ACPI: SSDT 0x0000000079FE3000 00073F (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008168] ACPI: SSDT 0x0000000079FE2000 000CA9 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008170] ACPI: SSDT 0x0000000079FC3000 002AA6 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008172] ACPI: SSDT 0x0000000079FB9000 009A9F (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008175] ACPI: WSMT 0x0000000079FB7000 000028 (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008177] ACPI: TPM2 0x0000000079FEA000 000050 (v05 INSYDE EDK2     20505348 ACPI 00040000)
[    0.008179] ACPI: SSDT 0x0000000079FB5000 001EE8 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008181] ACPI: SSDT 0x0000000079FE9000 00010D (v02 INSYDE EDK2     00000004 ACPI 00040000)
[    0.008184] ACPI: SSDT 0x0000000079FB4000 000051 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008186] ACPI: IVRS 0x0000000079FB3000 0001F6 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008188] ACPI: SSDT 0x0000000079FB2000 000B07 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008190] ACPI: SSDT 0x0000000079FB1000 00085D (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008192] ACPI: SSDT 0x0000000079FB0000 000AF4 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008195] ACPI: SSDT 0x0000000079FAF000 000CEE (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008197] ACPI: SSDT 0x0000000079FAE000 000CEE (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008199] ACPI: SSDT 0x0000000079FAD000 0004FC (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008201] ACPI: SSDT 0x0000000079FAC000 00005E (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008204] ACPI: SSDT 0x0000000079FAA000 001880 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008206] ACPI: SSDT 0x0000000079FA9000 000500 (v02 INSYDE EDK2     00000002 ACPI 00040000)
[    0.008208] ACPI: SSDT 0x0000000079FA6000 0010BB (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008210] ACPI: SSDT 0x0000000079F9C000 0097A5 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008212] ACPI: SSDT 0x0000000079F97000 0046FB (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008215] ACPI: SSDT 0x0000000079FE6000 000A40 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008217] ACPI: SSDT 0x0000000079F96000 0009D0 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008219] ACPI: SSDT 0x0000000079F95000 00008D (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008221] ACPI: SSDT 0x0000000079F94000 000F5C (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008224] ACPI: BGRT 0x0000000079FB8000 000038 (v01 INSYDE EDK2     00000002 ACPI 00040000)
[    0.008226] ACPI: Reserving FACP table memory at [mem 0x79fee000-0x79fee113]
[    0.008227] ACPI: Reserving DSDT table memory at [mem 0x79fc6000-0x79fcd3d7]
[    0.008228] ACPI: Reserving FACS table memory at [mem 0x79e32000-0x79e3203f]
[    0.008229] ACPI: Reserving UEFI table memory at [mem 0x79f66000-0x79f661ce]
[    0.008229] ACPI: Reserving ASF! table memory at [mem 0x79ffc000-0x79ffc084]
[    0.008230] ACPI: Reserving SSDT table memory at [mem 0x79ff3000-0x79ffb48c]
[    0.008231] ACPI: Reserving SSDT table memory at [mem 0x79ff2000-0x79ff233d]
[    0.008231] ACPI: Reserving ASF! table memory at [mem 0x79ff0000-0x79ff00a4]
[    0.008232] ACPI: Reserving BOOT table memory at [mem 0x79fef000-0x79fef027]
[    0.008233] ACPI: Reserving HPET table memory at [mem 0x79fed000-0x79fed037]
[    0.008233] ACPI: Reserving MCFG table memory at [mem 0x79fec000-0x79fec03b]
[    0.008234] ACPI: Reserving SLIC table memory at [mem 0x79feb000-0x79feb175]
[    0.008234] ACPI: Reserving APIC table memory at [mem 0x79fe1000-0x79fe1169]
[    0.008235] ACPI: Reserving SSDT table memory at [mem 0x79fe0000-0x79fe0a69]
[    0.008236] ACPI: Reserving SSDT table memory at [mem 0x79fd5000-0x79fdf8cd]
[    0.008236] ACPI: Reserving VFCT table memory at [mem 0x79fd0000-0x79fd4483]
[    0.008237] ACPI: Reserving FPDT table memory at [mem 0x79fcf000-0x79fcf043]
[    0.008238] ACPI: Reserving SSDT table memory at [mem 0x79fce000-0x79fce0f9]
[    0.008238] ACPI: Reserving SSDT table memory at [mem 0x79fe8000-0x79fe86a1]
[    0.008239] ACPI: Reserving SSDT table memory at [mem 0x79fe7000-0x79fe78f8]
[    0.008239] ACPI: Reserving SSDT table memory at [mem 0x79fe4000-0x79fe5db6]
[    0.008240] ACPI: Reserving SSDT table memory at [mem 0x79ffd000-0x79ffd781]
[    0.008241] ACPI: Reserving SSDT table memory at [mem 0x79fe3000-0x79fe373e]
[    0.008241] ACPI: Reserving SSDT table memory at [mem 0x79fe2000-0x79fe2ca8]
[    0.008242] ACPI: Reserving SSDT table memory at [mem 0x79fc3000-0x79fc5aa5]
[    0.008243] ACPI: Reserving SSDT table memory at [mem 0x79fb9000-0x79fc2a9e]
[    0.008243] ACPI: Reserving WSMT table memory at [mem 0x79fb7000-0x79fb7027]
[    0.008244] ACPI: Reserving TPM2 table memory at [mem 0x79fea000-0x79fea04f]
[    0.008245] ACPI: Reserving SSDT table memory at [mem 0x79fb5000-0x79fb6ee7]
[    0.008245] ACPI: Reserving SSDT table memory at [mem 0x79fe9000-0x79fe910c]
[    0.008246] ACPI: Reserving SSDT table memory at [mem 0x79fb4000-0x79fb4050]
[    0.008247] ACPI: Reserving IVRS table memory at [mem 0x79fb3000-0x79fb31f5]
[    0.008247] ACPI: Reserving SSDT table memory at [mem 0x79fb2000-0x79fb2b06]
[    0.008248] ACPI: Reserving SSDT table memory at [mem 0x79fb1000-0x79fb185c]
[    0.008249] ACPI: Reserving SSDT table memory at [mem 0x79fb0000-0x79fb0af3]
[    0.008249] ACPI: Reserving SSDT table memory at [mem 0x79faf000-0x79fafced]
[    0.008250] ACPI: Reserving SSDT table memory at [mem 0x79fae000-0x79faeced]
[    0.008250] ACPI: Reserving SSDT table memory at [mem 0x79fad000-0x79fad4fb]
[    0.008251] ACPI: Reserving SSDT table memory at [mem 0x79fac000-0x79fac05d]
[    0.008252] ACPI: Reserving SSDT table memory at [mem 0x79faa000-0x79fab87f]
[    0.008252] ACPI: Reserving SSDT table memory at [mem 0x79fa9000-0x79fa94ff]
[    0.008253] ACPI: Reserving SSDT table memory at [mem 0x79fa6000-0x79fa70ba]
[    0.008254] ACPI: Reserving SSDT table memory at [mem 0x79f9c000-0x79fa57a4]
[    0.008255] ACPI: Reserving SSDT table memory at [mem 0x79f97000-0x79f9b6fa]
[    0.008255] ACPI: Reserving SSDT table memory at [mem 0x79fe6000-0x79fe6a3f]
[    0.008256] ACPI: Reserving SSDT table memory at [mem 0x79f96000-0x79f969cf]
[    0.008257] ACPI: Reserving SSDT table memory at [mem 0x79f95000-0x79f9508c]
[    0.008257] ACPI: Reserving SSDT table memory at [mem 0x79f94000-0x79f94f5b]
[    0.008258] ACPI: Reserving BGRT table memory at [mem 0x79fb8000-0x79fb8037]
[    0.008343] No NUMA configuration found
[    0.008344] Faking a node at [mem 0x0000000000000000-0x000000105e0bffff]
[    0.008353] NODE_DATA(0) allocated [mem 0x105e095280-0x105e0bffff]
[    0.008875] ACPI: PM-Timer IO Port: 0x408
[    0.008887] ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
[    0.008890] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.008903] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0-23
[    0.008910] IOAPIC[1]: apic_id 34, version 33, address 0xfd280000, GSI 24-55
[    0.008912] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.008915] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.008920] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.008921] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.008929] e820: update [mem 0x68210000-0x6825efff] System RAM ==> device reserved
[    0.008945] CPU topo: Max. logical packages:   1
[    0.008946] CPU topo: Max. logical dies:       2
[    0.008947] CPU topo: Max. dies per package:   2
[    0.008951] CPU topo: Max. threads per core:   2
[    0.008952] CPU topo: Num. cores per package:    16
[    0.008953] CPU topo: Num. threads per package:  32
[    0.008953] CPU topo: Allowing 32 present CPUs plus 0 hotplug CPUs
[    0.008977] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.008979] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.008981] PM: hibernation: Registered nosave memory: [mem 0x09b00000-0x09dfffff]
[    0.008982] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0x09f87fff]
[    0.008984] PM: hibernation: Registered nosave memory: [mem 0x68210000-0x6825efff]
[    0.008985] PM: hibernation: Registered nosave memory: [mem 0x70b54000-0x72d53fff]
[    0.008987] PM: hibernation: Registered nosave memory: [mem 0x72d67000-0x72d6bfff]
[    0.008988] PM: hibernation: Registered nosave memory: [mem 0x73468000-0x73468fff]
[    0.008990] PM: hibernation: Registered nosave memory: [mem 0x76f7f000-0x79ffefff]
[    0.008991] PM: hibernation: Registered nosave memory: [mem 0x7a000000-0xffffffff]
[    0.008993] [gap 0x80000000-0xffffffff] available for PCI devices
[    0.008995] Booting paravirtualized kernel on bare hardware
[    0.008998] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.018021] Zone ranges:
[    0.018022]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.018025]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.018026]   Normal   [mem 0x0000000100000000-0x000000105e0bffff]
[    0.018028]   Device   empty
[    0.018029] Movable zone start for each node
[    0.018030] Early memory node ranges
[    0.018031]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.018033]   node   0: [mem 0x0000000000100000-0x0000000009afffff]
[    0.018034]   node   0: [mem 0x0000000009e00000-0x0000000009efffff]
[    0.018034]   node   0: [mem 0x0000000009f88000-0x0000000070b53fff]
[    0.018035]   node   0: [mem 0x0000000072d54000-0x0000000072d66fff]
[    0.018036]   node   0: [mem 0x0000000072d6c000-0x0000000076f7efff]
[    0.018037]   node   0: [mem 0x0000000079fff000-0x0000000079ffffff]
[    0.018037]   node   0: [mem 0x0000000100000000-0x000000105e0bffff]
[    0.018045] Initmem setup node 0 [mem 0x0000000000001000-0x000000105e0bffff]
[    0.018053] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.018069] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.018186] On node 0, zone DMA32: 768 pages in unavailable ranges
[    0.019517] On node 0, zone DMA32: 136 pages in unavailable ranges
[    0.019544] On node 0, zone DMA32: 8704 pages in unavailable ranges
[    0.019599] On node 0, zone DMA32: 5 pages in unavailable ranges
[    0.019638] On node 0, zone DMA32: 12416 pages in unavailable ranges
[    0.070241] On node 0, zone Normal: 24576 pages in unavailable ranges
[    0.070270] On node 0, zone Normal: 8000 pages in unavailable ranges
[    0.070285] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[    0.070740] percpu: Embedded 63 pages/cpu s221184 r8192 d28672 u262144
[    0.070749] pcpu-alloc: s221184 r8192 d28672 u262144 alloc=1*2097152
[    0.070752] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.070761] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27 28 29 30 31 
[    0.070789] Kernel command line: initrd=\initramfs-linux-debug.img amd_pstate=active kvm.mitigate_smt_rsb=1 root=PARTUUID=29eee245-b7e0-43d2-8cb3-5516b5464a96 rootflags=subvol=@ rootfstype=btrfs rw zswap.enabled=0
[    0.070906] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.070908] printk: log_buf_len total cpu_extra contributions: 126976 bytes
[    0.070908] printk: log_buf_len min size: 131072 bytes
[    0.071034] printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes
[    0.071035] printk: early log buf free: 114416(87%)
[    0.073414] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.074637] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.075000] software IO TLB: area num 32.
[    0.079815] Fallback order for Node 0: 0 
[    0.079826] Built 1 zonelists, mobility grouping on.  Total pages: 16591441
[    0.079828] Policy zone: Normal
[    0.079938] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.167983] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.183801] ftrace: allocating 54723 entries in 216 pages
[    0.183804] ftrace: allocated 216 pages with 4 groups
[    0.183923] Dynamic Preempt: full
[    0.184066] rcu: Preemptible hierarchical RCU implementation.
[    0.184067] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
[    0.184068] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.184070] 	Trampoline variant of Tasks RCU enabled.
[    0.184071] 	Rude variant of Tasks RCU enabled.
[    0.184072] 	Tracing variant of Tasks RCU enabled.
[    0.184073] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.184074] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.184095] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.184099] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.189992] NR_IRQS: 524544, nr_irqs: 1224, preallocated irqs: 16
[    0.190263] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.190456] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.190542] Console: colour dummy device 80x25
[    0.190546] printk: legacy console [tty0] enabled
[    0.190619] ACPI: Core revision 20251212
[    0.191030] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.191052] APIC: Switch to symmetric I/O mode setup
[    0.191372] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID00, rdevid:0xa0
[    0.191375] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID01, rdevid:0xa0
[    0.191376] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID02, rdevid:0xa0
[    0.191377] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID03, rdevid:0xa0
[    0.191379] AMD-Vi: ivrs, add hid:MSFT0201, uid:1, rdevid:0x60
[    0.191380] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID04, rdevid:0xa0
[    0.191381] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x10
[    0.192720] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.197062] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2b29902f492, max_idle_ns: 440795275391 ns
[    0.197067] Calibrating delay loop (skipped), value calculated using timer frequency.. 5988.77 BogoMIPS (lpj=2994388)
[    0.197099] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.197171] LVT offset 1 assigned for vector 0xf9
[    0.197173] LVT offset 2 assigned for vector 0xf4
[    0.197470] Last level iTLB entries: 4KB 64, 2MB 64, 4MB 32
[    0.197471] Last level dTLB entries: 4KB 128, 2MB 128, 4MB 64, 1GB 0
[    0.197478] process: using mwait in idle threads
[    0.197481] mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
[    0.197486] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.197488] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.197490] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.197491] Speculative Return Stack Overflow: Mitigation: IBPB on VMEXIT only
[    0.197492] VMSCAPE: Mitigation: IBPB on VMEXIT
[    0.197493] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.197495] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.197507] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.197509] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.197510] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.197511] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.197513] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.197514] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.197515] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.197516] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.197518] x86/fpu: Supporting XSAVE feature 0x1000: 'Control-flow Kernel registers (KVM only)'
[    0.197520] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.197522] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.197523] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.197525] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.197526] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.197528] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
[    0.197529] x86/fpu: xstate_offset[12]: 2456, xstate_sizes[12]:   24
[    0.197530] x86/fpu: Enabled xstate features 0x1ae7, context size is 2480 bytes, using 'compacted' format.
[    0.246710] Freeing SMP alternatives memory: 52K
[    0.246715] pid_max: default: 32768 minimum: 301
[    0.246891] landlock: Up and running.
[    0.246893] Yama: becoming mindful.
[    0.247107] LSM support for eBPF active
[    0.247208] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.247261] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.247352] VFS: Finished mounting rootfs on nullfs
[    0.350803] smpboot: CPU0: AMD RYZEN AI MAX+ 395 w/ Radeon 8060S (family: 0x1a, model: 0x70, stepping: 0x0)
[    0.350996] Performance Events: Fam17h+ 16-deep LBR, core perfctr, AMD PMU driver.
[    0.351065] ... version:                   2
[    0.351065] ... bit width:                 48
[    0.351065] ... generic counters:          6
[    0.351065] ... generic bitmap:            000000000000003f
[    0.351065] ... fixed-purpose counters:    0
[    0.351065] ... fixed-purpose bitmap:      0000000000000000
[    0.351065] ... value mask:                0000ffffffffffff
[    0.351065] ... max period:                00007fffffffffff
[    0.351065] ... global_ctrl mask:          000000000000003f
[    0.351065] signal: max sigframe size: 3376
[    0.351065] rcu: Hierarchical SRCU implementation.
[    0.351065] rcu: 	Max phase no-delay instances is 400.
[    0.351065] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.351065] MCE: In-kernel MCE decoding enabled.
[    0.351080] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.351272] smp: Bringing up secondary CPUs ...
[    0.351361] smpboot: x86: Booting SMP configuration:
[    0.351362] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
[    0.361456] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.364094] smp: Brought up 1 node, 32 CPUs
[    0.364098] smpboot: Total of 32 processors activated (191640.83 BogoMIPS)
[    0.366226] Memory: 65011448K/66365764K available (19612K kernel code, 2940K rwdata, 15356K rodata, 4648K init, 5076K bss, 1315588K reserved, 0K cma-reserved)
[    0.367067] devtmpfs: initialized
[    0.367134] x86/mm: Memory block size: 2048MB
[    0.368335] ACPI: PM: Registering ACPI NVS region [mem 0x09f00000-0x09f87fff] (557056 bytes)
[    0.368335] ACPI: PM: Registering ACPI NVS region [mem 0x7977f000-0x79f7efff] (8388608 bytes)
[    0.368335] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.368335] posixtimers hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.368335] futex hash table entries: 8192 (524288 bytes on 1 NUMA nodes, total 512 KiB, linear).
[    0.368434] PM: RTC time: 00:15:45, date: 2026-03-10
[    0.369303] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.369638] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.369831] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.370024] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.370031] audit: initializing netlink subsys (disabled)
[    0.370075] audit: type=2000 audit(1773101745.178:1): state=initialized audit_enabled=0 res=1
[    0.370165] thermal_sys: Registered thermal governor 'fair_share'
[    0.370167] thermal_sys: Registered thermal governor 'bang_bang'
[    0.370169] thermal_sys: Registered thermal governor 'step_wise'
[    0.370170] thermal_sys: Registered thermal governor 'user_space'
[    0.370171] thermal_sys: Registered thermal governor 'power_allocator'
[    0.370194] cpuidle: using governor ladder
[    0.370203] cpuidle: using governor menu
[    0.370316] Simple Boot Flag at 0x44 set to 0x1
[    0.370316] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.370316] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    0.370316] PCI: Using configuration type 1 for base access
[    0.370410] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.372129] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.372129] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.372129] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.372129] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.373984] raid6: skipped pq benchmark and selected avx512x4
[    0.373988] raid6: using avx512x2 recovery algorithm
[    0.374112] ACPI: Added _OSI(Module Device)
[    0.374114] ACPI: Added _OSI(Processor Device)
[    0.374116] ACPI: Added _OSI(Processor Aggregator Device)
[    0.400754] ACPI: 33 ACPI AML tables successfully acquired and loaded
[    0.414894] ACPI: \_SB_: platform _OSC: OS support mask [006e7efe]
[    0.415442] ACPI: \_SB_: platform _OSC: OS control mask [006e7e7e]
[    0.415671] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
[    0.415674] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
[    0.416427] ACPI: EC: EC started
[    0.416428] ACPI: EC: interrupt blocked
[    0.416896] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.416898] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle transactions
[    0.416900] ACPI: Interpreter enabled
[    0.416918] ACPI: PM: (supports S0 S4 S5)
[    0.416919] ACPI: Using IOAPIC for interrupt routing
[    0.417745] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.417747] PCI: Ignoring E820 reservations for host bridge windows
[    0.418286] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.420955] ACPI: \_SB_.PCI0.GPP0.PWRS: New power resource
[    0.422042] ACPI: \_SB_.PCI0.GPP0.SWUS.PWRS: New power resource
[    0.423143] ACPI: \_SB_.PCI0.GPP1.PWRS: New power resource
[    0.424204] ACPI: \_SB_.PCI0.GPP1.SWUS.PWRS: New power resource
[    0.424454] ACPI: \_SB_.PCI0.GPP3.PWRS: New power resource
[    0.425118] ACPI: \_SB_.PCI0.GPP4.PWRS: New power resource
[    0.425704] ACPI: \_SB_.PCI0.GPP5.PWRS: New power resource
[    0.426385] ACPI: \_SB_.PCI0.GPP7.P0NV: New power resource
[    0.427361] ACPI: \_SB_.PCI0.GPP9.P0NV: New power resource
[    0.428377] ACPI: \_SB_.PCI0.GPPA.PWRS: New power resource
[    0.428603] ACPI: \_SB_.PCI0.GPPA.VGA_.PWRS: New power resource
[    0.428886] ACPI: \_SB_.PCI0.GPPA.ACP_.PWRS: New power resource
[    0.429198] ACPI: \_SB_.PCI0.GPPA.AZAL.PWRS: New power resource
[    0.429548] ACPI: \_SB_.PCI0.GPPA.HDAU.PWRS: New power resource
[    0.429907] ACPI: \_SB_.PCI0.GPPA.XHC1.PWRS: New power resource
[    0.431919] ACPI: \_SB_.PCI0.GPPC.XHC0.PWRS: New power resource
[    0.434182] ACPI: \_SB_.PCI0.GPPC.XHC3.PWRS: New power resource
[    0.435293] ACPI: \_SB_.PCI0.GPPC.XHC4.PWRS: New power resource
[    0.436405] ACPI: \_SB_.PCI0.GPPC.NHI0.PWRS: New power resource
[    0.437073] ACPI: \_SB_.PCI0.GPPC.NHI1.PWRS: New power resource
[    0.440893] ACPI: \_SB_.PRWL: New power resource
[    0.440915] ACPI: \_SB_.PRWB: New power resource
[    0.442124] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.442131] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.442203] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
[    0.442317] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
[    0.442821] PCI host bridge to bus 0000:00
[    0.442825] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.442828] pci_bus 0000:00: root bus resource [io  0x0d00-0xfeff window]
[    0.442830] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.442831] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000cffff window]
[    0.442833] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000effff window]
[    0.442834] pci_bus 0000:00: root bus resource [mem 0x80000000-0xdfffffff window]
[    0.442835] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfcffffff window]
[    0.442836] pci_bus 0000:00: root bus resource [mem 0x10b0200000-0x8b4fffffff window]
[    0.442838] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.442857] pci 0000:00:00.0: [1022:1507] type 00 class 0x060000 conventional PCI endpoint
[    0.442975] pci 0000:00:00.2: [1022:1508] type 00 class 0x080600 conventional PCI endpoint
[    0.443070] pci 0000:00:01.0: [1022:1509] type 00 class 0x060000 conventional PCI endpoint
[    0.443162] pci 0000:00:01.1: [1022:150a] type 01 class 0x060400 PCIe Root Port
[    0.443378] pci 0000:00:01.1: PCI bridge to [bus 01-5f]
[    0.443385] pci 0000:00:01.1:   bridge window [io  0x7000-0xafff]
[    0.443389] pci 0000:00:01.1:   bridge window [mem 0x98000000-0xafffffff]
[    0.443428] pci 0000:00:01.1:   bridge window [mem 0x3800000000-0x57ffffffff 64bit pref]
[    0.443702] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.444886] pci 0000:00:01.2: [1022:150a] type 01 class 0x060400 PCIe Root Port
[    0.445094] pci 0000:00:01.2: PCI bridge to [bus 60-be]
[    0.445101] pci 0000:00:01.2:   bridge window [io  0x3000-0x6fff]
[    0.445105] pci 0000:00:01.2:   bridge window [mem 0x80000000-0x97ffffff]
[    0.445144] pci 0000:00:01.2:   bridge window [mem 0x1800000000-0x37ffffffff 64bit pref]
[    0.445408] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.446555] pci 0000:00:02.0: [1022:1509] type 00 class 0x060000 conventional PCI endpoint
[    0.446634] pci 0000:00:02.1: [1022:150b] type 01 class 0x060400 PCIe Root Port
[    0.446654] pci 0000:00:02.1: PCI bridge to [bus bf]
[    0.446660] pci 0000:00:02.1:   bridge window [io  0x2000-0x2fff]
[    0.446662] pci 0000:00:02.1:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.446738] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.446896] pci 0000:00:02.3: [1022:150b] type 01 class 0x060400 PCIe Root Port
[    0.446916] pci 0000:00:02.3: PCI bridge to [bus c0]
[    0.446922] pci 0000:00:02.3:   bridge window [mem 0xb0600000-0xb08fffff]
[    0.446996] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.447153] pci 0000:00:02.5: [1022:150b] type 01 class 0x060400 PCIe Root Port
[    0.447173] pci 0000:00:02.5: PCI bridge to [bus c1]
[    0.447180] pci 0000:00:02.5:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.447253] pci 0000:00:02.5: PME# supported from D0 D3hot D3cold
[    0.447393] pci 0000:00:03.0: [1022:1509] type 00 class 0x060000 conventional PCI endpoint
[    0.447472] pci 0000:00:08.0: [1022:1509] type 00 class 0x060000 conventional PCI endpoint
[    0.447554] pci 0000:00:08.1: [1022:150c] type 01 class 0x060400 PCIe Root Port
[    0.447575] pci 0000:00:08.1: PCI bridge to [bus c2]
[    0.447580] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.447582] pci 0000:00:08.1:   bridge window [mem 0xb0000000-0xb05fffff]
[    0.447590] pci 0000:00:08.1:   bridge window [mem 0x5800000000-0x581fffffff 64bit pref]
[    0.447599] pci 0000:00:08.1: enabling Extended Tags
[    0.447656] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.447920] pci 0000:00:08.2: [1022:150c] type 01 class 0x060400 PCIe Root Port
[    0.447948] pci 0000:00:08.2: PCI bridge to [bus c3]
[    0.447954] pci 0000:00:08.2:   bridge window [mem 0xb0d00000-0xb0efffff]
[    0.447962] pci 0000:00:08.2:   bridge window [mem 0x5820000000-0x58200fffff 64bit pref]
[    0.447971] pci 0000:00:08.2: enabling Extended Tags
[    0.448027] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.448155] pci 0000:00:08.3: [1022:150c] type 01 class 0x060400 PCIe Root Port
[    0.448175] pci 0000:00:08.3: PCI bridge to [bus c4]
[    0.448182] pci 0000:00:08.3:   bridge window [mem 0xb0900000-0xb0cfffff]
[    0.448197] pci 0000:00:08.3: enabling Extended Tags
[    0.448254] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.448532] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional PCI endpoint
[    0.448650] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional PCI endpoint
[    0.448779] pci 0000:00:18.0: [1022:12b8] type 00 class 0x060000 conventional PCI endpoint
[    0.448824] pci 0000:00:18.1: [1022:12b9] type 00 class 0x060000 conventional PCI endpoint
[    0.448870] pci 0000:00:18.2: [1022:12ba] type 00 class 0x060000 conventional PCI endpoint
[    0.448914] pci 0000:00:18.3: [1022:12bb] type 00 class 0x060000 conventional PCI endpoint
[    0.448960] pci 0000:00:18.4: [1022:12bc] type 00 class 0x060000 conventional PCI endpoint
[    0.449005] pci 0000:00:18.5: [1022:12bd] type 00 class 0x060000 conventional PCI endpoint
[    0.449049] pci 0000:00:18.6: [1022:12be] type 00 class 0x060000 conventional PCI endpoint
[    0.449100] pci 0000:00:18.7: [1022:12bf] type 00 class 0x060000 conventional PCI endpoint
[    0.449254] pci 0000:00:01.1: PCI bridge to [bus 01-5f]
[    0.449375] pci 0000:00:01.2: PCI bridge to [bus 60-be]
[    0.449474] pci 0000:bf:00.0: [10ec:8126] type 00 class 0x020000 PCIe Endpoint
[    0.449525] pci 0000:bf:00.0: BAR 0 [io  0x2000-0x20ff]
[    0.449531] pci 0000:bf:00.0: BAR 2 [mem 0xb1000000-0xb100ffff 64bit]
[    0.449536] pci 0000:bf:00.0: BAR 4 [mem 0xb1010000-0xb1013fff 64bit]
[    0.449659] pci 0000:bf:00.0: supports D1 D2
[    0.449660] pci 0000:bf:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.449945] pci 0000:00:02.1: PCI bridge to [bus bf]
[    0.450183] pci 0000:c0:00.0: [14c3:0717] type 00 class 0x028000 PCIe Endpoint
[    0.450240] pci 0000:c0:00.0: BAR 0 [mem 0xb0600000-0xb07fffff 64bit]
[    0.450244] pci 0000:c0:00.0: BAR 2 [mem 0xb0800000-0xb0807fff 64bit]
[    0.450336] pci 0000:c0:00.0: PME# supported from D0 D3hot D3cold
[    0.451111] pci 0000:00:02.3: PCI bridge to [bus c0]
[    0.451333] pci 0000:c1:00.0: [1c5c:1959] type 00 class 0x010802 PCIe Endpoint
[    0.451373] pci 0000:c1:00.0: BAR 0 [mem 0xb0f00000-0xb0f03fff 64bit]
[    0.451634] pci 0000:00:02.5: PCI bridge to [bus c1]
[    0.451730] pci 0000:c2:00.0: [1002:1586] type 00 class 0x038000 PCIe Legacy Endpoint
[    0.452303] pci 0000:c2:00.0: BAR 0 [mem 0x5800000000-0x581fffffff 64bit pref]
[    0.452306] pci 0000:c2:00.0: BAR 2 [mem 0xb0000000-0xb01fffff 64bit pref]
[    0.452309] pci 0000:c2:00.0: BAR 4 [io  0x1000-0x10ff]
[    0.452311] pci 0000:c2:00.0: BAR 5 [mem 0xb0400000-0xb04fffff]
[    0.452317] pci 0000:c2:00.0: enabling Extended Tags
[    0.452387] pci 0000:c2:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.452966] pci 0000:c2:00.1: [1002:1640] type 00 class 0x040300 PCIe Legacy Endpoint
[    0.452995] pci 0000:c2:00.1: BAR 0 [mem 0xb0508000-0xb050bfff]
[    0.453005] pci 0000:c2:00.1: enabling Extended Tags
[    0.453049] pci 0000:c2:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.453271] pci 0000:c2:00.2: [1022:17e0] type 00 class 0x108000 PCIe Endpoint
[    0.453302] pci 0000:c2:00.2: BAR 2 [mem 0xb0300000-0xb03fffff]
[    0.453305] pci 0000:c2:00.2: BAR 5 [mem 0xb050c000-0xb050dfff]
[    0.453311] pci 0000:c2:00.2: enabling Extended Tags
[    0.453448] pci 0000:c2:00.4: [1022:1587] type 00 class 0x0c0330 PCIe Endpoint
[    0.453479] pci 0000:c2:00.4: BAR 0 [mem 0xb0200000-0xb02fffff 64bit]
[    0.453488] pci 0000:c2:00.4: enabling Extended Tags
[    0.453535] pci 0000:c2:00.4: PME# supported from D0 D3hot D3cold
[    0.453879] pci 0000:c2:00.6: [1022:15e3] type 00 class 0x040300 PCIe Endpoint
[    0.453907] pci 0000:c2:00.6: BAR 0 [mem 0xb0500000-0xb0507fff]
[    0.453917] pci 0000:c2:00.6: enabling Extended Tags
[    0.453961] pci 0000:c2:00.6: PME# supported from D0 D3hot D3cold
[    0.454196] pci 0000:00:08.1: PCI bridge to [bus c2]
[    0.454261] pci 0000:c3:00.0: [1022:150d] type 00 class 0x130000 PCIe Endpoint
[    0.454298] pci 0000:c3:00.0: enabling Extended Tags
[    0.454458] pci 0000:c3:00.1: [1022:17f0] type 00 class 0x118000 PCIe Endpoint
[    0.454491] pci 0000:c3:00.1: BAR 0 [mem 0xb0d00000-0xb0dfffff]
[    0.454493] pci 0000:c3:00.1: BAR 1 [mem 0xb0e00000-0xb0e01fff]
[    0.454495] pci 0000:c3:00.1: BAR 2 [mem 0x5820000000-0x582007ffff 64bit pref]
[    0.454497] pci 0000:c3:00.1: BAR 4 [mem 0xb0e03000-0xb0e03fff]
[    0.454499] pci 0000:c3:00.1: BAR 5 [mem 0xb0e02000-0xb0e02fff]
[    0.454505] pci 0000:c3:00.1: enabling Extended Tags
[    0.454659] pci 0000:00:08.2: PCI bridge to [bus c3]
[    0.454740] pci 0000:c4:00.0: [1022:1588] type 00 class 0x0c0330 PCIe Endpoint
[    0.454771] pci 0000:c4:00.0: BAR 0 [mem 0xb0900000-0xb09fffff 64bit]
[    0.454781] pci 0000:c4:00.0: enabling Extended Tags
[    0.454838] pci 0000:c4:00.0: PME# supported from D0 D3hot D3cold
[    0.455228] pci 0000:c4:00.3: [1022:1589] type 00 class 0x0c0330 PCIe Endpoint
[    0.455259] pci 0000:c4:00.3: BAR 0 [mem 0xb0a00000-0xb0afffff 64bit]
[    0.455269] pci 0000:c4:00.3: enabling Extended Tags
[    0.455315] pci 0000:c4:00.3: PME# supported from D0 D3hot D3cold
[    0.455644] pci 0000:c4:00.4: [1022:158b] type 00 class 0x0c0330 PCIe Endpoint
[    0.455675] pci 0000:c4:00.4: BAR 0 [mem 0xb0b00000-0xb0bfffff 64bit]
[    0.455684] pci 0000:c4:00.4: enabling Extended Tags
[    0.455731] pci 0000:c4:00.4: PME# supported from D0 D3hot D3cold
[    0.456055] pci 0000:c4:00.5: [1022:158d] type 00 class 0x0c0340 PCIe Endpoint
[    0.456090] pci 0000:c4:00.5: BAR 0 [mem 0xb0c00000-0xb0c7ffff 64bit]
[    0.456100] pci 0000:c4:00.5: Max Payload Size set to 128 (was 256, max 256)
[    0.456104] pci 0000:c4:00.5: enabling Extended Tags
[    0.456181] pci 0000:c4:00.5: PME# supported from D0 D3hot D3cold
[    0.456507] pci 0000:c4:00.6: [1022:158e] type 00 class 0x0c0340 PCIe Endpoint
[    0.456542] pci 0000:c4:00.6: BAR 0 [mem 0xb0c80000-0xb0cfffff 64bit]
[    0.456552] pci 0000:c4:00.6: Max Payload Size set to 128 (was 256, max 256)
[    0.456555] pci 0000:c4:00.6: enabling Extended Tags
[    0.456601] pci 0000:c4:00.6: PME# supported from D0 D3hot D3cold
[    0.456950] pci 0000:00:08.3: PCI bridge to [bus c4]
[    0.467814] Low-power S0 idle used by default for system suspend
[    0.467986] ACPI: EC: interrupt unblocked
[    0.467987] ACPI: EC: event unblocked
[    0.467991] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.467992] ACPI: EC: GPE=0xa
[    0.467994] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization complete
[    0.467995] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions and events
[    0.468089] iommu: Default domain type: Translated
[    0.468089] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.468224] SCSI subsystem initialized
[    0.468235] libata version 3.00 loaded.
[    0.468235] ACPI: bus type USB registered
[    0.468235] usbcore: registered new interface driver usbfs
[    0.468235] usbcore: registered new interface driver hub
[    0.468235] usbcore: registered new device driver usb
[    0.469071] EDAC MC: Ver: 3.0.0
[    0.469398] efivars: Registered efivars operations
[    0.469398] NetLabel: Initializing
[    0.469398] NetLabel:  domain hash size = 128
[    0.469398] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.469398] NetLabel:  unlabeled traffic allowed by default
[    0.469398] mctp: management component transport protocol core
[    0.469398] NET: Registered PF_MCTP protocol family
[    0.469398] PCI: Using ACPI for IRQ routing
[    0.478909] PCI: pci_cache_line_size set to 64 bytes
[    0.479323] e820: register RAM buffer resource [mem 0x0009f000-0x0009ffff]
[    0.479326] e820: register RAM buffer resource [mem 0x09b00000-0x0bffffff]
[    0.479328] e820: register RAM buffer resource [mem 0x09f00000-0x0bffffff]
[    0.479329] e820: register RAM buffer resource [mem 0x68210000-0x6bffffff]
[    0.479330] e820: register RAM buffer resource [mem 0x70b54000-0x73ffffff]
[    0.479331] e820: register RAM buffer resource [mem 0x72d67000-0x73ffffff]
[    0.479332] e820: register RAM buffer resource [mem 0x73468000-0x73ffffff]
[    0.479333] e820: register RAM buffer resource [mem 0x76f7f000-0x77ffffff]
[    0.479334] e820: register RAM buffer resource [mem 0x7a000000-0x7bffffff]
[    0.479335] e820: register RAM buffer resource [mem 0x105e0c0000-0x105fffffff]
[    0.479371] vgaarb: loaded
[    0.479371] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.479371] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.481170] clocksource: Switched to clocksource tsc-early
[    0.481365] VFS: Disk quotas dquot_6.6.0
[    0.481378] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.481405] acpi PNP0C02:00: Reserved [mem 0xe0000000-0xefffffff]
[    0.481416] acpi PNP0C02:01: Skipped [io  0x0010-0x001f]
[    0.481418] acpi PNP0C02:01: Skipped [io  0x0020-0x0021]
[    0.481419] acpi PNP0C02:01: Skipped [io  0x00a0-0x00a1]
[    0.481420] acpi PNP0C02:01: Skipped [io  0x0072-0x0073]
[    0.481421] acpi PNP0C02:01: Skipped [io  0x0080]
[    0.481421] acpi PNP0C02:01: Skipped [io  0x00b0-0x00b1]
[    0.481422] acpi PNP0C02:01: Skipped [io  0x0092]
[    0.481423] acpi PNP0C02:01: Skipped [io  0x00f0]
[    0.481425] acpi PNP0C02:01: Reserved [io  0x0400-0x04cf]
[    0.481426] acpi PNP0C02:01: Reserved [io  0x04d0-0x04d1]
[    0.481427] acpi PNP0C02:01: Reserved [io  0x04d6]
[    0.481429] acpi PNP0C02:01: Reserved [io  0x0c00-0x0c01]
[    0.481430] acpi PNP0C02:01: Reserved [io  0x0c14]
[    0.481431] acpi PNP0C02:01: Reserved [io  0x0c50-0x0c52]
[    0.481432] acpi PNP0C02:01: Reserved [io  0x0c6c]
[    0.481433] acpi PNP0C02:01: Reserved [io  0x0c6f]
[    0.481433] acpi PNP0C02:01: Reserved [io  0x0cd0-0x0cdb]
[    0.481435] acpi PNP0C02:01: Could not reserve [mem 0xfec00000-0xfec0ffff]
[    0.481437] acpi PNP0C02:01: Reserved [mem 0xfed45000-0xfed811ff]
[    0.481438] acpi PNP0C02:01: Reserved [mem 0xfed81900-0xfed81fff]
[    0.481440] acpi PNP0C02:01: Reserved [mem 0xfedc0000-0xfedc0fff]
[    0.481441] acpi PNP0C02:01: Reserved [mem 0xfedc6000-0xfedc6fff]
[    0.481443] acpi PNP0C02:01: Reserved [mem 0xfee01000-0xffffffff]
[    0.481447] acpi PNP0C01:00: Reserved [mem 0xff000000-0xffffffff]
[    0.481494] pnp: PnP ACPI init
[    0.485462] pnp: PnP ACPI: found 1 devices
[    0.491451] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.491531] NET: Registered PF_INET protocol family
[    0.491651] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.494219] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes, linear)
[    0.494267] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.494452] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.494945] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.495078] TCP: Hash tables configured (established 524288 bind 65536)
[    0.495262] MPTCP token hash table entries: 65536 (order: 9, 1572864 bytes, linear)
[    0.495452] UDP hash table entries: 32768 (order: 9, 2097152 bytes, linear)
[    0.495671] UDP-Lite hash table entries: 32768 (order: 9, 2097152 bytes, linear)
[    0.495875] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.495882] NET: Registered PF_XDP protocol family
[    0.495898] pci 0000:00:01.1: PCI bridge to [bus 01-5f]
[    0.495907] pci 0000:00:01.1:   bridge window [io  0x7000-0xafff]
[    0.495917] pci 0000:00:01.1:   bridge window [mem 0x98000000-0xafffffff]
[    0.495943] pci 0000:00:01.1:   bridge window [mem 0x3800000000-0x57ffffffff 64bit pref]
[    0.495971] pci 0000:00:01.2: PCI bridge to [bus 60-be]
[    0.495974] pci 0000:00:01.2:   bridge window [io  0x3000-0x6fff]
[    0.495998] pci 0000:00:01.2:   bridge window [mem 0x80000000-0x97ffffff]
[    0.496024] pci 0000:00:01.2:   bridge window [mem 0x1800000000-0x37ffffffff 64bit pref]
[    0.496053] pci 0000:00:02.1: PCI bridge to [bus bf]
[    0.496055] pci 0000:00:02.1:   bridge window [io  0x2000-0x2fff]
[    0.496058] pci 0000:00:02.1:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.496064] pci 0000:00:02.3: PCI bridge to [bus c0]
[    0.496067] pci 0000:00:02.3:   bridge window [mem 0xb0600000-0xb08fffff]
[    0.496073] pci 0000:00:02.5: PCI bridge to [bus c1]
[    0.496076] pci 0000:00:02.5:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.496083] pci 0000:00:08.1: PCI bridge to [bus c2]
[    0.496089] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.496093] pci 0000:00:08.1:   bridge window [mem 0xb0000000-0xb05fffff]
[    0.496095] pci 0000:00:08.1:   bridge window [mem 0x5800000000-0x581fffffff 64bit pref]
[    0.496100] pci 0000:00:08.2: PCI bridge to [bus c3]
[    0.496103] pci 0000:00:08.2:   bridge window [mem 0xb0d00000-0xb0efffff]
[    0.496106] pci 0000:00:08.2:   bridge window [mem 0x5820000000-0x58200fffff 64bit pref]
[    0.496111] pci 0000:00:08.3: PCI bridge to [bus c4]
[    0.496114] pci 0000:00:08.3:   bridge window [mem 0xb0900000-0xb0cfffff]
[    0.496120] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.496123] pci_bus 0000:00: resource 5 [io  0x0d00-0xfeff window]
[    0.496124] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.496125] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000cffff window]
[    0.496126] pci_bus 0000:00: resource 8 [mem 0x000d0000-0x000effff window]
[    0.496127] pci_bus 0000:00: resource 9 [mem 0x80000000-0xdfffffff window]
[    0.496128] pci_bus 0000:00: resource 10 [mem 0xf0000000-0xfcffffff window]
[    0.496130] pci_bus 0000:00: resource 11 [mem 0x10b0200000-0x8b4fffffff window]
[    0.496131] pci_bus 0000:01: resource 0 [io  0x7000-0xafff]
[    0.496132] pci_bus 0000:01: resource 1 [mem 0x98000000-0xafffffff]
[    0.496133] pci_bus 0000:01: resource 2 [mem 0x3800000000-0x57ffffffff 64bit pref]
[    0.496135] pci_bus 0000:60: resource 0 [io  0x3000-0x6fff]
[    0.496136] pci_bus 0000:60: resource 1 [mem 0x80000000-0x97ffffff]
[    0.496137] pci_bus 0000:60: resource 2 [mem 0x1800000000-0x37ffffffff 64bit pref]
[    0.496138] pci_bus 0000:bf: resource 0 [io  0x2000-0x2fff]
[    0.496139] pci_bus 0000:bf: resource 1 [mem 0xb1000000-0xb10fffff]
[    0.496140] pci_bus 0000:c0: resource 1 [mem 0xb0600000-0xb08fffff]
[    0.496141] pci_bus 0000:c1: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.496142] pci_bus 0000:c2: resource 0 [io  0x1000-0x1fff]
[    0.496143] pci_bus 0000:c2: resource 1 [mem 0xb0000000-0xb05fffff]
[    0.496144] pci_bus 0000:c2: resource 2 [mem 0x5800000000-0x581fffffff 64bit pref]
[    0.496145] pci_bus 0000:c3: resource 1 [mem 0xb0d00000-0xb0efffff]
[    0.496146] pci_bus 0000:c3: resource 2 [mem 0x5820000000-0x58200fffff 64bit pref]
[    0.496147] pci_bus 0000:c4: resource 1 [mem 0xb0900000-0xb0cfffff]
[    0.496489] pci 0000:c2:00.1: D0 power state depends on 0000:c2:00.0
[    0.496763] PCI: CLS 64 bytes, default 64
[    0.496790] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.496828] Unpacking initramfs...
[    0.496831] platform AMDI0020:00: Adding to iommu group 0
[    0.496841] platform MSFT0201:00: Adding to iommu group 1
[    0.497262] pci 0000:00:01.0: Adding to iommu group 2
[    0.497283] pci 0000:00:01.1: Adding to iommu group 3
[    0.497306] pci 0000:00:01.2: Adding to iommu group 4
[    0.497353] pci 0000:00:02.0: Adding to iommu group 5
[    0.497366] pci 0000:00:02.1: Adding to iommu group 6
[    0.497380] pci 0000:00:02.3: Adding to iommu group 7
[    0.497393] pci 0000:00:02.5: Adding to iommu group 8
[    0.497411] pci 0000:00:03.0: Adding to iommu group 9
[    0.497459] pci 0000:00:08.0: Adding to iommu group 10
[    0.497473] pci 0000:00:08.1: Adding to iommu group 11
[    0.497489] pci 0000:00:08.2: Adding to iommu group 12
[    0.497502] pci 0000:00:08.3: Adding to iommu group 13
[    0.497527] pci 0000:00:14.0: Adding to iommu group 14
[    0.497539] pci 0000:00:14.3: Adding to iommu group 14
[    0.497601] pci 0000:00:18.0: Adding to iommu group 15
[    0.497614] pci 0000:00:18.1: Adding to iommu group 15
[    0.497627] pci 0000:00:18.2: Adding to iommu group 15
[    0.497641] pci 0000:00:18.3: Adding to iommu group 15
[    0.497655] pci 0000:00:18.4: Adding to iommu group 15
[    0.497668] pci 0000:00:18.5: Adding to iommu group 15
[    0.497681] pci 0000:00:18.6: Adding to iommu group 15
[    0.497694] pci 0000:00:18.7: Adding to iommu group 15
[    0.497714] pci 0000:bf:00.0: Adding to iommu group 16
[    0.497727] pci 0000:c0:00.0: Adding to iommu group 17
[    0.497741] pci 0000:c1:00.0: Adding to iommu group 18
[    0.497786] pci 0000:c2:00.0: Adding to iommu group 19
[    0.497801] pci 0000:c2:00.1: Adding to iommu group 20
[    0.497816] pci 0000:c2:00.2: Adding to iommu group 21
[    0.497832] pci 0000:c2:00.4: Adding to iommu group 22
[    0.497847] pci 0000:c2:00.6: Adding to iommu group 23
[    0.497864] pci 0000:c3:00.0: Adding to iommu group 24
[    0.497881] pci 0000:c3:00.1: Adding to iommu group 25
[    0.497895] pci 0000:c4:00.0: Adding to iommu group 26
[    0.497912] pci 0000:c4:00.3: Adding to iommu group 27
[    0.497927] pci 0000:c4:00.4: Adding to iommu group 28
[    0.497942] pci 0000:c4:00.5: Adding to iommu group 29
[    0.497957] pci 0000:c4:00.6: Adding to iommu group 30
[    0.501933] AMD-Vi: Extended features (0x246577efa2254afa, 0x10): PPR NX GT [5] IA GA PC GA_vAPIC
[    0.501943] AMD-Vi: Interrupt remapping enabled
[    0.502090] AMD-Vi: Virtual APIC enabled
[    0.502118] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.502142] software IO TLB: mapped [mem 0x00000000641d1000-0x00000000681d1000] (64MB)
[    0.502192] LVT offset 0 assigned for vector 0x400
[    0.503003] perf: AMD IBS detected (0x00081bff)
[    0.503012] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.523004] Initialise system trusted keyrings
[    0.523019] Key type blacklist registered
[    0.523056] workingset: timestamp_bits=36 max_order=24 bucket_order=0
[    0.523420] fuse: init (API version 7.45)
[    0.523523] integrity: Platform Keyring initialized
[    0.523526] integrity: Machine keyring initialized
[    0.534875] xor: automatically using best checksumming function   avx       
[    0.534877] Key type asymmetric registered
[    0.534878] Asymmetric key parser 'x509' registered
[    0.534903] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.534968] io scheduler mq-deadline registered
[    0.534970] io scheduler kyber registered
[    0.534982] io scheduler bfq registered
[    0.537590] ledtrig-cpu: registered to indicate activity on CPUs
[    0.537891] pcieport 0000:00:01.1: PME: Signaling with IRQ 33
[    0.537942] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.538511] pcieport 0000:00:01.2: PME: Signaling with IRQ 34
[    0.538563] pcieport 0000:00:01.2: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.538957] pcieport 0000:00:02.1: PME: Signaling with IRQ 35
[    0.539138] pcieport 0000:00:02.3: PME: Signaling with IRQ 36
[    0.539307] pcieport 0000:00:02.5: PME: Signaling with IRQ 37
[    0.539483] pcieport 0000:00:08.1: PME: Signaling with IRQ 38
[    0.539692] pcieport 0000:00:08.2: PME: Signaling with IRQ 39
[    0.539870] pcieport 0000:00:08.3: PME: Signaling with IRQ 40
[    0.540263] ACPI: AC: AC Adapter [ACAD] (on-line)
[    0.540310] input: Power Button as /devices/platform/PNP0C0C:00/input/input0
[    0.540334] ACPI: button: Power Button [PWRB]
[    0.540368] Monitor-Mwait will be used to enter C-1 state
[    0.544526] Estimated ratio of average max frequency by base frequency (times 1024): 1397
[    0.544781] acpi LNXTHERM:00: registered as thermal_zone0
[    0.544783] ACPI: thermal: Thermal Zone [TZ00] (36 C)
[    0.544926] acpi LNXTHERM:01: registered as thermal_zone1
[    0.544928] ACPI: thermal: Thermal Zone [TZ01] (35 C)
[    0.545067] acpi LNXTHERM:02: registered as thermal_zone2
[    0.545068] ACPI: thermal: Thermal Zone [TZ02] (35 C)
[    0.545204] acpi LNXTHERM:03: registered as thermal_zone3
[    0.545205] ACPI: thermal: Thermal Zone [TZ03] (37 C)
[    0.545437] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.547205] Freeing initrd memory: 42208K
[    0.547243] Non-volatile memory driver v1.3
[    0.547245] Linux agpgart interface v0.103
[    1.503827] tsc: Refined TSC clocksource calibration: 2994.347 MHz
[    1.503851] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b2969864ac, max_idle_ns: 440795350248 ns
[    1.504165] clocksource: Switched to clocksource tsc
[    1.791092] tpm_crb MSFT0101:00: Disabling hwrng
[    1.796461] xhci_hcd 0000:c2:00.4: xHCI Host Controller
[    1.796473] xhci_hcd 0000:c2:00.4: new USB bus registered, assigned bus number 1
[    1.796848] xhci_hcd 0000:c2:00.4: hcc params 0x0118ffc5 hci version 0x120 quirks 0x0000000200000010
[    1.797325] xhci_hcd 0000:c2:00.4: xHCI Host Controller
[    1.797327] xhci_hcd 0000:c2:00.4: new USB bus registered, assigned bus number 2
[    1.797329] xhci_hcd 0000:c2:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    1.797379] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    1.797382] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.797383] usb usb1: Product: xHCI Host Controller
[    1.797384] usb usb1: Manufacturer: Linux 7.0.0-rc1-debug-00007-g856250ba2e81 xhci-hcd
[    1.797386] usb usb1: SerialNumber: 0000:c2:00.4
[    1.797537] hub 1-0:1.0: USB hub found
[    1.797562] hub 1-0:1.0: 1 port detected
[    1.798194] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.798209] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    1.798211] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.798212] usb usb2: Product: xHCI Host Controller
[    1.798213] usb usb2: Manufacturer: Linux 7.0.0-rc1-debug-00007-g856250ba2e81 xhci-hcd
[    1.798214] usb usb2: SerialNumber: 0000:c2:00.4
[    1.798315] hub 2-0:1.0: USB hub found
[    1.798338] hub 2-0:1.0: 1 port detected
[    1.799001] xhci_hcd 0000:c4:00.0: xHCI Host Controller
[    1.799005] xhci_hcd 0000:c4:00.0: new USB bus registered, assigned bus number 3
[    1.799421] xhci_hcd 0000:c4:00.0: hcc params 0x0128ffc5 hci version 0x120 quirks 0x0000000200000010
[    1.799715] xhci_hcd 0000:c4:00.0: xHCI Host Controller
[    1.799717] xhci_hcd 0000:c4:00.0: new USB bus registered, assigned bus number 4
[    1.799719] xhci_hcd 0000:c4:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    1.799743] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    1.799745] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.799746] usb usb3: Product: xHCI Host Controller
[    1.799747] usb usb3: Manufacturer: Linux 7.0.0-rc1-debug-00007-g856250ba2e81 xhci-hcd
[    1.799748] usb usb3: SerialNumber: 0000:c4:00.0
[    1.799859] hub 3-0:1.0: USB hub found
[    1.799880] hub 3-0:1.0: 5 ports detected
[    1.801262] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.801279] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    1.801280] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.801281] usb usb4: Product: xHCI Host Controller
[    1.801282] usb usb4: Manufacturer: Linux 7.0.0-rc1-debug-00007-g856250ba2e81 xhci-hcd
[    1.801283] usb usb4: SerialNumber: 0000:c4:00.0
[    1.801691] hub 4-0:1.0: USB hub found
[    1.801714] hub 4-0:1.0: 2 ports detected
[    1.802472] xhci_hcd 0000:c4:00.3: xHCI Host Controller
[    1.802476] xhci_hcd 0000:c4:00.3: new USB bus registered, assigned bus number 5
[    1.802857] xhci_hcd 0000:c4:00.3: hcc params 0x0118ffc5 hci version 0x120 quirks 0x0000000200000010
[    1.803230] xhci_hcd 0000:c4:00.3: xHCI Host Controller
[    1.803232] xhci_hcd 0000:c4:00.3: new USB bus registered, assigned bus number 6
[    1.803233] xhci_hcd 0000:c4:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    1.803257] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    1.803258] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.803259] usb usb5: Product: xHCI Host Controller
[    1.803260] usb usb5: Manufacturer: Linux 7.0.0-rc1-debug-00007-g856250ba2e81 xhci-hcd
[    1.803261] usb usb5: SerialNumber: 0000:c4:00.3
[    1.803380] hub 5-0:1.0: USB hub found
[    1.803402] hub 5-0:1.0: 1 port detected
[    1.803976] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.803990] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    1.803991] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.803992] usb usb6: Product: xHCI Host Controller
[    1.803993] usb usb6: Manufacturer: Linux 7.0.0-rc1-debug-00007-g856250ba2e81 xhci-hcd
[    1.803994] usb usb6: SerialNumber: 0000:c4:00.3
[    1.804099] hub 6-0:1.0: USB hub found
[    1.804121] hub 6-0:1.0: 1 port detected
[    1.804862] xhci_hcd 0000:c4:00.4: xHCI Host Controller
[    1.804865] xhci_hcd 0000:c4:00.4: new USB bus registered, assigned bus number 7
[    1.805238] xhci_hcd 0000:c4:00.4: hcc params 0x0118ffc5 hci version 0x120 quirks 0x0000000200000010
[    1.805589] xhci_hcd 0000:c4:00.4: xHCI Host Controller
[    1.805591] xhci_hcd 0000:c4:00.4: new USB bus registered, assigned bus number 8
[    1.805592] xhci_hcd 0000:c4:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    1.805616] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    1.805617] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.805618] usb usb7: Product: xHCI Host Controller
[    1.805619] usb usb7: Manufacturer: Linux 7.0.0-rc1-debug-00007-g856250ba2e81 xhci-hcd
[    1.805620] usb usb7: SerialNumber: 0000:c4:00.4
[    1.805728] hub 7-0:1.0: USB hub found
[    1.805753] hub 7-0:1.0: 1 port detected
[    1.806309] usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.806322] usb usb8: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    1.806324] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.806325] usb usb8: Product: xHCI Host Controller
[    1.806325] usb usb8: Manufacturer: Linux 7.0.0-rc1-debug-00007-g856250ba2e81 xhci-hcd
[    1.806326] usb usb8: SerialNumber: 0000:c4:00.4
[    1.806440] hub 8-0:1.0: USB hub found
[    1.806462] hub 8-0:1.0: 1 port detected
[    1.807179] usbcore: registered new interface driver usbserial_generic
[    1.807190] usbserial: USB Serial support registered for generic
[    1.807217] i8042: PNP: No PS/2 controller found.
[    1.807218] i8042: Probing ports directly.
[    2.382558] i8042: Can't read CTR while initializing i8042
[    2.382564] fbcon: Taking over console
[    2.382568] i8042 i8042: probe with driver i8042 failed with error -5
[    2.382738] rtc_cmos 00:00: RTC can wake from S4
[    2.383063] rtc_cmos 00:00: registered as rtc0
[    2.383107] rtc_cmos 00:00: setting system clock to 2026-03-10T00:15:47 UTC (1773101747)
[    2.383138] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
[    2.385857] hid: raw HID events driver (C) Jiri Kosina
[    2.385866] usbcore: registered new interface driver usbhid
[    2.385867] usbhid: USB HID core driver
[    2.385910] drop_monitor: Initializing network drop monitor service
[    2.385990] NET: Registered PF_INET6 protocol family
[    2.386157] Segment Routing with IPv6
[    2.386158] RPL Segment Routing with IPv6
[    2.386161] In-situ OAM (IOAM) with IPv6
[    2.386172] NET: Registered PF_PACKET protocol family
[    2.388041] x86/amd: Previous system reset reason [0x00080800]: software wrote 0x6 to reset control register 0xCF9
[    2.388047] microcode: Current revision: 0x0b700037
[    2.388048] microcode: Updated early from: 0x0b700032
[    2.388622] resctrl: L3 allocation detected
[    2.388623] resctrl: MB allocation detected
[    2.388624] resctrl: SMBA allocation detected
[    2.388625] resctrl: L3 monitoring detected
[    2.388646] IPI shorthand broadcast: enabled
[    2.389710] sched_clock: Marking stable (2387001747, 1766558)->(2397192160, -8423855)
[    2.390033] registered taskstats version 1
[    2.390639] Loading compiled-in X.509 certificates
[    2.394937] Loaded X.509 cert 'Build time autogenerated kernel key: 60c12c501ae832d6996ea5b330fa9525ca6cf60f'
[    2.396076] Demotion targets for Node 0: null
[    2.396206] Key type .fscrypt registered
[    2.396207] Key type fscrypt-provisioning registered
[    2.396372] Btrfs loaded, zoned=yes, fsverity=yes
[    2.396394] Key type big_key registered
[    2.401321] integrity: Loading X.509 certificate: UEFI:db
[    2.401336] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    2.401343] integrity: Loading X.509 certificate: UEFI:db
[    2.401374] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    2.401376] integrity: Loading X.509 certificate: UEFI:db
[    2.401393] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    2.401394] integrity: Loading X.509 certificate: UEFI:db
[    2.401408] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    2.401409] integrity: Loading X.509 certificate: UEFI:db
[    2.401420] integrity: Loaded X.509 cert 'Microsoft Option ROM UEFI CA 2023: 514fbf937fa46fb57bf07af8bed84b3b864b1711'
[    2.401421] integrity: Loading X.509 certificate: UEFI:db
[    2.401430] integrity: Loaded X.509 cert 'frame.work-LaptopDB: b9b0a774d4c4017582a0ee01b43205f970aec47c'
[    2.406691] PM:   Magic number: 2:448:253
[    2.406873] RAS: Correctable Errors collector initialized.
[    2.407403] clk: Disabling unused clocks
[    2.407406] PM: genpd: Disabling unused power domains
[    2.408128] Freeing unused decrypted memory: 2028K
[    2.408538] Freeing unused kernel image (initmem) memory: 4648K
[    2.408548] Write protecting the kernel read-only data: 36864k
[    2.408779] Freeing unused kernel image (text/rodata gap) memory: 864K
[    2.408921] Freeing unused kernel image (rodata/data gap) memory: 1028K
[    2.434968] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.434972] rodata_test: all tests were successful
[    2.434976] Run /init as init process
[    2.434977]   with arguments:
[    2.434978]     /init
[    2.434978]   with environment:
[    2.434979]     HOME=/
[    2.434979]     TERM=linux
[    2.543486] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    2.543836] input: Video Bus as /devices/pci0000:00/0000:00:08.1/LNXVIDEO:00/input/input1
[    2.546239] Key type psk registered
[    2.559110] ACPI: bus type drm_connector registered
[    2.559119] Unsupported value for CONFIG_DRM_PANIC_SCREEN ('qr_code'), falling back to 'user'...
[    2.562494] nvme 0000:c1:00.0: platform quirk: setting simple suspend
[    2.562571] nvme nvme0: pci function 0000:c1:00.0
[    2.581954] nvme nvme0: 32/0/0 default/read/poll queues
[    2.585553]  nvme0n1: p1 p2
[    2.602838] usb 2-1: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
[    2.602952] usb 4-2: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
[    2.617107] usb 4-2: New USB device found, idVendor=05e3, idProduct=0625, bcdDevice=10.01
[    2.617109] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.617110] usb 4-2: Product: USB3.2 Hub
[    2.617111] usb 4-2: Manufacturer: GenesysLogic
[    2.617698] usb 2-1: New USB device found, idVendor=0bda, idProduct=0424, bcdDevice= 1.88
[    2.617700] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.617701] usb 2-1: Product: 2-Port USB 3.0 Hub
[    2.617702] usb 2-1: Manufacturer: Generic
[    2.647412] hub 2-1:1.0: USB hub found
[    2.647721] hub 2-1:1.0: 2 ports detected
[    2.648531] hub 4-2:1.0: USB hub found
[    2.648863] hub 4-2:1.0: 2 ports detected
[    2.728781] usb 3-2: new high-speed USB device number 2 using xhci_hcd
[    2.728822] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    2.857567] usb 1-1: New USB device found, idVendor=0bda, idProduct=5424, bcdDevice= 1.88
[    2.857569] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.857571] usb 1-1: Product: 2-Port USB 2.0 Hub
[    2.857572] usb 1-1: Manufacturer: Generic
[    2.858897] usb 3-2: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice=10.01
[    2.858898] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.858899] usb 3-2: Product: USB2.1 Hub
[    2.858900] usb 3-2: Manufacturer: GenesysLogic
[    2.918144] hub 1-1:1.0: USB hub found
[    2.918745] hub 1-1:1.0: 2 ports detected
[    2.920189] hub 3-2:1.0: USB hub found
[    2.920846] hub 3-2:1.0: 2 ports detected
[    3.098770] usb 3-3: new high-speed USB device number 3 using xhci_hcd
[    3.226697] usb 3-3: New USB device found, idVendor=0e8d, idProduct=0717, bcdDevice= 1.00
[    3.226698] usb 3-3: New USB device strings: Mfr=5, Product=6, SerialNumber=7
[    3.226700] usb 3-3: Product: Wireless_Device
[    3.226700] usb 3-3: Manufacturer: MediaTek Inc.
[    3.226701] usb 3-3: SerialNumber: 000000000
[    3.319248] usb 2-1.1: new SuperSpeed USB device number 3 using xhci_hcd
[    3.337917] usb 2-1.1: New USB device found, idVendor=05e3, idProduct=0626, bcdDevice= 6.63
[    3.337922] usb 2-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.337924] usb 2-1.1: Product: USB3.1 Hub
[    3.337926] usb 2-1.1: Manufacturer: GenesysLogic
[    3.367069] hub 2-1.1:1.0: USB hub found
[    3.367903] hub 2-1.1:1.0: 4 ports detected
[    3.667778] usb 1-1.1: new high-speed USB device number 3 using xhci_hcd
[    3.680661] amdgpu: Virtual CRAT table created for CPU
[    3.680667] amdgpu: Topology: Add CPU node
[    3.680790] amdgpu 0000:c2:00.0: enabling device (0006 -> 0007)
[    3.680838] amdgpu 0000:c2:00.0: initializing kernel modesetting (IP DISCOVERY 0x1002:0x1586 0xF111:0x000A 0xC1).
[    3.680875] amdgpu 0000:c2:00.0: register mmio base: 0xB0400000
[    3.680876] amdgpu 0000:c2:00.0: register mmio size: 1048576
[    3.684130] amdgpu 0000:c2:00.0: detected ip block number 0 <common_v1_0_0> (soc21_common)
[    3.684132] amdgpu 0000:c2:00.0: detected ip block number 1 <gmc_v11_0_0> (gmc_v11_0)
[    3.684133] amdgpu 0000:c2:00.0: detected ip block number 2 <ih_v6_0_0> (ih_v6_1)
[    3.684134] amdgpu 0000:c2:00.0: detected ip block number 3 <psp_v13_0_0> (psp)
[    3.684135] amdgpu 0000:c2:00.0: detected ip block number 4 <smu_v14_0_0> (smu)
[    3.684136] amdgpu 0000:c2:00.0: detected ip block number 5 <dce_v1_0_0> (dm)
[    3.684136] amdgpu 0000:c2:00.0: detected ip block number 6 <gfx_v11_0_0> (gfx_v11_0)
[    3.684137] amdgpu 0000:c2:00.0: detected ip block number 7 <sdma_v6_0_0> (sdma_v6_0)
[    3.684138] amdgpu 0000:c2:00.0: detected ip block number 8 <vcn_v4_0_5> (vcn_v4_0_5)
[    3.684139] amdgpu 0000:c2:00.0: detected ip block number 9 <jpeg_v4_0_5> (jpeg_v4_0_5)
[    3.684139] amdgpu 0000:c2:00.0: detected ip block number 10 <mes_v11_0_0> (mes_v11_0)
[    3.684140] amdgpu 0000:c2:00.0: detected ip block number 11 <vpe_v6_1_0> (vpe_v6_1)
[    3.684141] amdgpu 0000:c2:00.0: detected ip block number 12 <isp_v4_1_1> (isp_ip)
[    3.684162] amdgpu 0000:c2:00.0: Fetched VBIOS from VFCT
[    3.684163] amdgpu 0000:c2:00.0: [drm] ATOM BIOS: 113-STRXLGEN-001
[    3.687775] amdgpu 0000:c2:00.0: VPE: collaborate mode true
[    3.692464] amdgpu 0000:c2:00.0: Trusted Memory Zone (TMZ) feature disabled as experimental (default)
[    3.692497] amdgpu 0000:c2:00.0: vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    3.692516] amdgpu 0000:c2:00.0: VRAM: 512M 0x0000008000000000 - 0x000000801FFFFFFF (512M used)
[    3.692518] amdgpu 0000:c2:00.0: GART: 512M 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[    3.692539] amdgpu 0000:c2:00.0: [drm] Detected VRAM RAM=512M, BAR=512M
[    3.692539] amdgpu 0000:c2:00.0: [drm] RAM width 256bits LPDDR5
[    3.692933] amdgpu 0000:c2:00.0:  512M of VRAM memory ready
[    3.692935] amdgpu 0000:c2:00.0:  31787M of GTT memory ready.
[    3.692951] amdgpu 0000:c2:00.0: [drm] GART: num cpu pages 131072, num gpu pages 131072
[    3.693626] amdgpu 0000:c2:00.0: [drm] PCIE GART of 512M enabled (table at 0x0000008000F00000).
[    3.694016] amdgpu 0000:c2:00.0: [drm] Loading DMUB firmware via PSP: version=0x09003D00
[    3.694380] amdgpu 0000:c2:00.0: [VCN instance 0] Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 27
[    3.694421] amdgpu 0000:c2:00.0: [VCN instance 1] Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 27
[    3.694531] amdgpu 0000:c2:00.0: MES: vmid_mask_mmhub 0x0000ff00, vmid_mask_gfxhub 0x0000ff00
[    3.694532] amdgpu 0000:c2:00.0: MES: gfx_hqd_mask 0x00000002, compute_hqd_mask 0x0000000c, sdma_hqd_mask 0x000000fc
[    3.718175] amdgpu 0000:c2:00.0: reserve 0x8c00000 from 0x8010000000 for PSP TMR
[    3.759477] usb 1-1.1: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice= 6.63
[    3.759482] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.759484] usb 1-1.1: Product: USB2.1 Hub
[    3.759486] usb 1-1.1: Manufacturer: GenesysLogic
[    3.814410] hub 1-1.1:1.0: USB hub found
[    3.814977] hub 1-1.1:1.0: 4 ports detected
[    3.890787] usb 1-1.2: new high-speed USB device number 4 using xhci_hcd
[    3.980591] usb 1-1.2: New USB device found, idVendor=38eb, idProduct=0002, bcdDevice= 1.00
[    3.980596] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.980597] usb 1-1.2: Product: Glinet Composite Device
[    3.980599] usb 1-1.2: Manufacturer: Glinet
[    3.980600] usb 1-1.2: SerialNumber: CAFEBABE
[    4.106404] input: Glinet Glinet Composite Device as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.2/1-1.2:1.0/0003:38EB:0002.0001/input/input2
[    4.124787] usb 1-1.1.2: new full-speed USB device number 5 using xhci_hcd
[    4.180933] hid-generic 0003:38EB:0002.0001: input,hidraw0: USB HID v1.01 Keyboard [Glinet Glinet Composite Device] on usb-0000:c2:00.4-1.2/input0
[    4.183850] input: Glinet Glinet Composite Device as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.2/1-1.2:1.1/0003:38EB:0002.0002/input/input3
[    4.183933] hid-generic 0003:38EB:0002.0002: input,hidraw1: USB HID v1.01 Mouse [Glinet Glinet Composite Device] on usb-0000:c2:00.4-1.2/input1
[    4.186463] input: Glinet Glinet Composite Device as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.2/1-1.2:1.2/0003:38EB:0002.0003/input/input4
[    4.186510] hid-generic 0003:38EB:0002.0003: input,hidraw2: USB HID v1.01 Mouse [Glinet Glinet Composite Device] on usb-0000:c2:00.4-1.2/input2
[    4.244350] usb 1-1.1.2: New USB device found, idVendor=1532, idProduct=011b, bcdDevice= 2.00
[    4.244352] usb 1-1.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.244353] usb 1-1.1.2: Product: Razer BlackWidow
[    4.244353] usb 1-1.1.2: Manufacturer: Razer
[    4.301275] amdgpu 0000:c2:00.0: RAS: optional ras ta ucode is not available
[    4.305275] amdgpu 0000:c2:00.0: RAP: optional rap ta ucode is not available
[    4.305276] amdgpu 0000:c2:00.0: SECUREDISPLAY: optional securedisplay ta ucode is not available
[    4.336642] amdgpu 0000:c2:00.0: SMU is initialized successfully!
[    4.338020] amdgpu 0000:c2:00.0: [drm] Display Core v3.2.369 initialized on DCN 3.5.1
[    4.338022] amdgpu 0000:c2:00.0: [drm] DP-HDMI FRL PCON supported
[    4.341112] amdgpu 0000:c2:00.0: [drm] DMUB hardware initialized: version=0x09003D00
[    4.343864] amdgpu 0000:c2:00.0: [drm] DP-1: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.363417] input: Razer Razer BlackWidow as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003:1532:011B.0004/input/input5
[    4.372667] amdgpu 0000:c2:00.0: [drm] HDMI-A-1: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.372717] amdgpu 0000:c2:00.0: [drm] DP-2: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.372758] amdgpu 0000:c2:00.0: [drm] DP-3: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.432812] hid-generic 0003:1532:011B.0004: input,hidraw3: USB HID v1.11 Keyboard [Razer Razer BlackWidow] on usb-0000:c2:00.4-1.1.2/input0
[    4.436468] input: Razer Razer BlackWidow Keyboard as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.1/0003:1532:011B.0005/input/input6
[    4.486820] input: Razer Razer BlackWidow as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.1/0003:1532:011B.0005/input/input7
[    4.486850] hid-generic 0003:1532:011B.0005: input,hidraw4: USB HID v1.11 Keyboard [Razer Razer BlackWidow] on usb-0000:c2:00.4-1.1.2/input1
[    4.490604] input: Razer Razer BlackWidow as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.2/0003:1532:011B.0006/input/input8
[    4.490638] hid-generic 0003:1532:011B.0006: input,hidraw5: USB HID v1.11 Mouse [Razer Razer BlackWidow] on usb-0000:c2:00.4-1.1.2/input2
[    4.555879] input: Razer Razer BlackWidow as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003:1532:011B.0004/input/input9
[    4.578770] usb 1-1.1.3: new full-speed USB device number 6 using xhci_hcd
[    4.624869] razer 0003:1532:011B.0004: input,hidraw3: USB HID v1.11 Keyboard [Razer Razer BlackWidow] on usb-0000:c2:00.4-1.1.2/input0
[    4.651059] input: Razer Razer BlackWidow as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.1/0003:1532:011B.0005/input/input10
[    4.698558] usb 1-1.1.3: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=12.11
[    4.698559] usb 1-1.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.698560] usb 1-1.1.3: Product: USB Receiver
[    4.698561] usb 1-1.1.3: Manufacturer: Logitech
[    4.701857] razer 0003:1532:011B.0005: input,hidraw4: USB HID v1.11 Keyboard [Razer Razer BlackWidow] on usb-0000:c2:00.4-1.1.2/input1
[    4.710608] input: Razer Razer BlackWidow as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.2/0003:1532:011B.0006/input/input11
[    4.710665] razer 0003:1532:011B.0006: input,hidraw5: USB HID v1.11 Mouse [Razer Razer BlackWidow] on usb-0000:c2:00.4-1.1.2/input2
[    4.814626] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.0/0003:046D:C52B.0007/input/input12
[    4.888828] hid-generic 0003:046D:C52B.0007: input,hidraw6: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:c2:00.4-1.1.3/input0
[    4.892668] input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.1/0003:046D:C52B.0008/input/input13
[    4.892771] input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.1/0003:046D:C52B.0008/input/input14
[    4.943814] input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.1/0003:046D:C52B.0008/input/input15
[    4.943883] hid-generic 0003:046D:C52B.0008: input,hiddev96,hidraw7: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:c2:00.4-1.1.3/input1
[    4.946673] hid-generic 0003:046D:C52B.0009: hiddev97,hidraw8: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:c2:00.4-1.1.3/input2
[    4.946736] usb-storage 1-1.2:1.3: USB Mass Storage device detected
[    4.946967] scsi host0: usb-storage 1-1.2:1.3
[    4.947091] usb-storage 1-1.2:1.4: USB Mass Storage device detected
[    4.947469] scsi host1: usb-storage 1-1.2:1.4
[    4.947523] usbcore: registered new interface driver usb-storage
[    4.951125] usbcore: registered new interface driver uas
[    5.045268] logitech-djreceiver 0003:046D:C52B.0009: hiddev96,hidraw6: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:c2:00.4-1.1.3/input2
[    5.149936] input: Logitech Wireless Device PID:4096 Mouse as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.2/0003:046D:C52B.0009/0003:046D:4096.000A/input/input17
[    5.150020] hid-generic 0003:046D:4096.000A: input,hidraw7: USB HID v1.11 Mouse [Logitech Wireless Device PID:4096] on usb-0000:c2:00.4-1.1.3/input2:1
[    5.175603] input: Logitech ERGO M575 as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.2/0003:046D:C52B.0009/0003:046D:4096.000A/input/input21
[    5.175645] logitech-hidpp-device 0003:046D:4096.000A: input,hidraw7: USB HID v1.11 Mouse [Logitech ERGO M575] on usb-0000:c2:00.4-1.1.3/input2:1
[    5.862223] amdgpu 0000:c2:00.0: [drm] DP-5: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    5.862273] amdgpu 0000:c2:00.0: [drm] DP-6: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    5.862310] amdgpu 0000:c2:00.0: [drm] DP-7: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    5.862346] amdgpu 0000:c2:00.0: [drm] DP-8: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    5.872096] kfd kfd: Allocated 3969056 bytes on gart
[    5.872110] kfd kfd: Total number of KFD nodes to be created: 1
[    5.872945] amdgpu: Virtual CRAT table created for GPU
[    5.873827] amdgpu: Topology: Add GPU node [0x1002:0x1586]
[    5.873828] kfd kfd: added device 1002:1586
[    5.873837] amdgpu 0000:c2:00.0: SE 2, SH per SE 2, CU per SH 10, active_cu_number 40
[    5.873840] amdgpu 0000:c2:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[    5.873841] amdgpu 0000:c2:00.0: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    5.873842] amdgpu 0000:c2:00.0: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    5.873842] amdgpu 0000:c2:00.0: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[    5.873843] amdgpu 0000:c2:00.0: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[    5.873843] amdgpu 0000:c2:00.0: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[    5.873844] amdgpu 0000:c2:00.0: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[    5.873845] amdgpu 0000:c2:00.0: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[    5.873845] amdgpu 0000:c2:00.0: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[    5.873846] amdgpu 0000:c2:00.0: ring sdma0 uses VM inv eng 12 on hub 0
[    5.873846] amdgpu 0000:c2:00.0: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[    5.873847] amdgpu 0000:c2:00.0: ring vcn_unified_1 uses VM inv eng 1 on hub 8
[    5.873847] amdgpu 0000:c2:00.0: ring jpeg_dec_0 uses VM inv eng 4 on hub 8
[    5.873848] amdgpu 0000:c2:00.0: ring jpeg_dec_1 uses VM inv eng 6 on hub 8
[    5.873849] amdgpu 0000:c2:00.0: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
[    5.873849] amdgpu 0000:c2:00.0: ring vpe uses VM inv eng 7 on hub 8
[    5.877071] amdgpu 0000:c2:00.0: Runtime PM not available
[    5.877679] amdgpu 0000:c2:00.0: [drm] Registered 4 planes with drm panic
[    5.886777] [drm] Initialized amdgpu 3.64.0 for 0000:c2:00.0 on minor 0
[    5.893273] amdgpu 0000:c2:00.0: [drm] Failed to setup vendor infoframe on connector HDMI-A-1: -22
[    5.895188] fbcon: amdgpudrmfb (fb0) is primary device
[    5.895374] [drm] pre_validate_dsc:1667 MST_DSC dsc precompute is not needed
[    5.985533] scsi 1:0:0:0: Direct-Access     Glinet   Flash Drive      1.00 PQ: 0 ANSI: 2
[    5.985553] scsi 0:0:0:0: CD-ROM            Glinet   Optical Drive    1.00 PQ: 0 ANSI: 2
[    5.986356] sd 1:0:0:0: Power-on or device reset occurred
[    5.986865] sd 1:0:0:0: [sda] Media removed, stopped polling
[    5.994817] sd 1:0:0:0: [sda] Attached SCSI removable disk
[    5.998023] sr 0:0:0:0: Power-on or device reset occurred
[    5.998675] sr 0:0:0:0: [sr0] scsi-1 drive
[    5.998677] cdrom: Uniform CD-ROM driver Revision: 3.20
[    6.014816] sr 0:0:0:0: Attached scsi CD-ROM sr0
[    6.518967] amdgpu 0000:c2:00.0: [drm] REG_WAIT timeout 1us * 100000 tries - optc35_disable_crtc line:162
[    7.005555] amdgpu 0000:c2:00.0: [drm] REG_WAIT timeout 1us * 100000 tries - optc35_disable_crtc line:165
[    7.055425] Console: switching to colour frame buffer device 160x45
[    7.092203] amdgpu 0000:c2:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    7.126230] BTRFS: device fsid 7293a5c6-dc73-4666-8b70-c7f343e87fb2 devid 1 transid 125503 /dev/nvme0n1p2 (259:2) scanned by mount (517)
[    7.126516] BTRFS info (device nvme0n1p2): first mount of filesystem 7293a5c6-dc73-4666-8b70-c7f343e87fb2
[    7.126519] BTRFS info (device nvme0n1p2): using crc32c checksum algorithm
[    7.149721] BTRFS info (device nvme0n1p2): enabling ssd optimizations
[    7.149723] BTRFS info (device nvme0n1p2): turning on async discard
[    7.149723] BTRFS info (device nvme0n1p2): enabling free space tree
[    7.211289] systemd[1]: systemd 259.3-1-arch running in system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    7.211295] systemd[1]: Detected architecture x86-64.
[    7.211973] systemd[1]: Hostname set to <framework-amd-ryzen-maxplus-395>.
[    7.275550] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    7.366855] zram: Added device: zram0
[    7.415890] systemd[1]: Queued start job for default target Graphical Interface.
[    7.431898] systemd[1]: Created slice Virtual Machine and Container Slice.
[    7.432426] systemd[1]: Created slice Slice /system/dirmngr.
[    7.432616] systemd[1]: Created slice Slice /system/getty.
[    7.432810] systemd[1]: Created slice Slice /system/gpg-agent.
[    7.432997] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    7.433178] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    7.433368] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    7.433541] systemd[1]: Created slice Slice /system/keyboxd.
[    7.433718] systemd[1]: Created slice Slice /system/modprobe.
[    7.433903] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    7.434078] systemd[1]: Created slice User and Session Slice.
[    7.434128] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    7.434166] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    7.434298] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    7.434338] systemd[1]: Expecting device /dev/disk/by-uuid/7293a5c6-dc73-4666-8b70-c7f343e87fb2...
[    7.434367] systemd[1]: Expecting device /dev/disk/by-uuid/C0F2-BB08...
[    7.434388] systemd[1]: Expecting device /dev/zram0...
[    7.434409] systemd[1]: Reached target Local Encrypted Volumes.
[    7.434435] systemd[1]: Reached target Login Prompts.
[    7.434457] systemd[1]: Reached target Image Downloads.
[    7.434478] systemd[1]: Reached target Local Integrity Protected Volumes.
[    7.434508] systemd[1]: Reached target Preparation for Network.
[    7.434533] systemd[1]: Reached target Path Units.
[    7.434557] systemd[1]: Reached target Remote File Systems.
[    7.434579] systemd[1]: Reached target Slice Units.
[    7.434615] systemd[1]: Reached target Local Verity Protected Volumes.
[    7.434676] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.435326] systemd[1]: Listening on Query the User Interactively for a Password.
[    7.435945] systemd[1]: Listening on Process Core Dump Socket.
[    7.436299] systemd[1]: Listening on Credential Encryption/Decryption.
[    7.436776] systemd[1]: Listening on Factory Reset Management.
[    7.437137] systemd[1]: Listening on Journal Socket (/dev/log).
[    7.437403] systemd[1]: Listening on Journal Sockets.
[    7.438093] systemd[1]: Listening on Console Output Muting Service Socket.
[    7.438395] systemd[1]: TPM PCR Measurements skipped, unmet condition check ConditionSecurity=measured-uki
[    7.438404] systemd[1]: Make TPM PCR Policy skipped, unmet condition check ConditionSecurity=measured-uki
[    7.438733] systemd[1]: Listening on Disk Repartitioning Service Socket.
[    7.438995] systemd[1]: Listening on udev Control Socket.
[    7.440022] systemd[1]: Listening on udev Kernel Socket.
[    7.440270] systemd[1]: Listening on udev Varlink Socket.
[    7.440499] systemd[1]: Listening on User Database Manager Socket.
[    7.441756] systemd[1]: Mounting Huge Pages File System...
[    7.442414] systemd[1]: Mounting POSIX Message Queue File System...
[    7.443161] systemd[1]: Mounting Kernel Debug File System...
[    7.444221] systemd[1]: Mounting Kernel Trace File System...
[    7.445865] systemd[1]: Starting Create List of Static Device Nodes...
[    7.446116] systemd[1]: Load Kernel Module configfs skipped, unmet condition check ConditionKernelModuleLoaded=!configfs
[    7.446679] systemd[1]: Mounting Kernel Configuration File System...
[    7.447419] systemd[1]: Starting Load Kernel Module dm_mod...
[    7.447655] systemd[1]: Load Kernel Module drm skipped, unmet condition check ConditionKernelModuleLoaded=!drm
[    7.447675] systemd[1]: Load Kernel Module fuse skipped, unmet condition check ConditionKernelModuleLoaded=!fuse
[    7.448176] systemd[1]: Mounting FUSE Control File System...
[    7.448947] systemd[1]: Starting Load Kernel Module loop...
[    7.449925] systemd[1]: Starting Load Kernel Module tun...
[    7.450199] systemd[1]: Clear Stale Hibernate Storage Info skipped, unmet condition check ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67
[    7.451248] systemd[1]: Starting Journal Service...
[    7.452239] systemd[1]: Starting Load Kernel Modules...
[    7.452496] systemd[1]: TPM PCR Machine ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
[    7.452521] systemd[1]: TPM NvPCR Product ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
[    7.453107] systemd[1]: Starting Remount Root and Kernel File Systems...
[    7.453626] systemd[1]: Early TPM SRK Setup skipped, unmet condition check ConditionSecurity=measured-uki
[    7.454126] systemd[1]: Starting Load udev Rules from Credentials...
[    7.454852] systemd[1]: Starting Coldplug All udev Devices...
[    7.456011] loop: module loaded
[    7.456911] systemd[1]: Mounted Huge Pages File System.
[    7.457276] systemd[1]: Mounted POSIX Message Queue File System.
[    7.457608] systemd[1]: Mounted Kernel Debug File System.
[    7.457913] systemd[1]: Mounted Kernel Trace File System.
[    7.458169] tun: Universal TUN/TAP device driver, 1.6
[    7.458223] device-mapper: uevent: version 1.0.3
[    7.458296] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    7.458313] systemd[1]: Finished Create List of Static Device Nodes.
[    7.460049] Asymmetric key parser 'pkcs8' registered
[    7.471049] systemd[1]: Mounted Kernel Configuration File System.
[    7.471388] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[    7.471490] systemd[1]: Finished Load Kernel Module dm_mod.
[    7.471794] systemd[1]: Mounted FUSE Control File System.
[    7.472080] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    7.472162] systemd[1]: Finished Load Kernel Module loop.
[    7.472306] systemd-journald[611]: Collecting audit messages is disabled.
[    7.472460] systemd[1]: modprobe@tun.service: Deactivated successfully.
[    7.472538] systemd[1]: Finished Load Kernel Module tun.
[    7.472912] systemd[1]: Finished Load Kernel Modules.
[    7.473305] systemd[1]: Finished Load udev Rules from Credentials.
[    7.474528] systemd[1]: Starting Apply Kernel Variables...
[    7.475133] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    7.480353] systemd[1]: Finished Apply Kernel Variables.
[    7.483815] systemd[1]: Starting User Database Manager...
[    7.508591] systemd[1]: Started Journal Service.
[    7.532292] BTRFS info (device nvme0n1p2 state M): use zstd compression, level 3
[    7.675875] AMDI0020:00: ttyS4 at MMIO 0xfedc9000 (irq = 11, base_baud = 3000000) is a 16550A
[    7.681176] ACPI: bus type thunderbolt registered
[    7.681828] zram0: detected capacity change from 0 to 8388608
[    7.684068] input: PC Speaker as /devices/platform/pcspkr/input/input22
[    7.685164] ccp 0000:c2:00.2: enabling device (0000 -> 0002)
[    7.685339] cros_ec_lpcs FRMWC004:00: loaded with quirks 00000001
[    7.686489] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    7.686493] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
[    7.688132] ccp 0000:c2:00.2: tee enabled
[    7.690003] ccp 0000:c2:00.2: psp enabled
[    7.691610] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    7.691805] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms ovfl timer
[    7.691808] RAPL PMU: hw unit of domain package 2^-16 Joules
[    7.691810] RAPL PMU: hw unit of domain core 2^-16 Joules
[    7.693134] i2c i2c-19: Successfully instantiated SPD at 0x50
[    7.693524] i2c i2c-19: Successfully instantiated SPD at 0x51
[    7.694131] i2c i2c-19: Successfully instantiated SPD at 0x52
[    7.694726] i2c i2c-19: Successfully instantiated SPD at 0x53
[    7.695299] i2c i2c-19: Successfully instantiated SPD at 0x54
[    7.695843] i2c i2c-19: Successfully instantiated SPD at 0x55
[    7.697034] i2c i2c-19: Successfully instantiated SPD at 0x56
[    7.699942] i2c i2c-19: Successfully instantiated SPD at 0x57
[    7.709572] cros_ec_lpcs FRMWC004:00: Chrome EC device registered
[    7.719492] mousedev: PS/2 mouse device common for all mice
[    7.719641] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    7.720842] amdxdna 0000:c3:00.1: enabling device (0000 -> 0002)
[    7.721796] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    7.721913] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    7.722073] faux_driver regulatory: Direct firmware load for regulatory.db failed with error -2
[    7.722076] cfg80211: failed to load regulatory.db
[    7.735415] Bluetooth: Core ver 2.22
[    7.735491] NET: Registered PF_BLUETOOTH protocol family
[    7.735492] Bluetooth: HCI device and connection manager initialized
[    7.735496] Bluetooth: HCI socket layer initialized
[    7.735498] Bluetooth: L2CAP socket layer initialized
[    7.735501] Bluetooth: SCO socket layer initialized
[    7.735862] r8169 0000:bf:00.0: enabling device (0000 -> 0003)
[    7.742565] r8169 0000:bf:00.0 eth0: RTL8126A, 9c:bf:0d:00:ed:6f, XID 64a, IRQ 137
[    7.742570] r8169 0000:bf:00.0 eth0: jumbo features [frames: 16362 bytes, tx checksumming: ko]
[    7.749110] Adding 4194300k swap on /dev/zram0.  Priority:100 extents:1 across:4194300k SSDsc
[    7.845125] [drm] Initialized amdxdna_accel_driver 0.6.0 for 0000:c3:00.1 on minor 0
[    7.845834] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    7.847260] usbcore: registered new interface driver btusb
[    7.847571] r8169 0000:bf:00.0 enp191s0: renamed from eth0
[    7.849938] Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260106153314
[    7.852186] kvm_amd: TSC scaling supported
[    7.852189] kvm_amd: Nested Virtualization enabled
[    7.852191] kvm_amd: Nested Paging enabled
[    7.852192] kvm_amd: LBR virtualization supported
[    7.852195] kvm_amd: AVIC enabled
[    7.852195] kvm_amd: x2AVIC enabled (max 512 vCPUs)
[    7.852196] kvm_amd: Virtual VMLOAD VMSAVE supported
[    7.852197] kvm_amd: Virtual GIF supported
[    7.852197] kvm_amd: Virtual NMI enabled
[    7.852727] snd_hda_intel 0000:c2:00.1: enabling device (0000 -> 0002)
[    7.852794] snd_hda_intel 0000:c2:00.1: Handle vga_switcheroo audio client
[    7.852846] snd_hda_intel 0000:c2:00.6: enabling device (0000 -> 0002)
[    7.867529] snd_hda_intel 0000:c2:00.1: bound 0000:c2:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    7.871404] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:c2:00.1/sound/card0/input23
[    7.871415] amd_atl: AMD Address Translation Library initialized
[    7.871447] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:c2:00.1/sound/card0/input24
[    7.871558] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:c2:00.1/sound/card0/input25
[    7.871582] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:c2:00.1/sound/card0/input26
[    7.877195] mt7925e 0000:c0:00.0: ASIC revision: 79250000
[    7.879228] snd_hda_codec_alc269 hdaudioC1D0: autoconfig for ALC623: line_outs=2 (0x21/0x14/0x0/0x0/0x0) type:hp
[    7.879232] snd_hda_codec_alc269 hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    7.879233] snd_hda_codec_alc269 hdaudioC1D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    7.879234] snd_hda_codec_alc269 hdaudioC1D0:    mono: mono_out=0x0
[    7.879234] snd_hda_codec_alc269 hdaudioC1D0:    inputs:
[    7.879235] snd_hda_codec_alc269 hdaudioC1D0:      Mic=0x19
[    7.919590] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:c2:00.6/sound/card1/input27
[    7.919628] input: HD-Audio Generic Headphone Front as /devices/pci0000:00/0000:00:08.1/0000:c2:00.6/sound/card1/input28
[    7.919658] input: HD-Audio Generic Front Headphone Surround as /devices/pci0000:00/0000:00:08.1/0000:c2:00.6/sound/card1/input29
[    7.942110] amd-pmf AMDI0105:00: No Smart PC policy present
[    7.942115] amd-pmf AMDI0105:00: registered PMF device successfully
[    7.953459] mt7925e 0000:c0:00.0: HW/SW Version: 0x8a108a10, Build Time: 20260106153007a
[    8.109392] intel_rapl_common: Found RAPL domain package
[    8.109397] intel_rapl_common: Found RAPL domain core
[    8.109396] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
[    8.109510] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[    8.233989] Bluetooth: hci0: Device setup in 377623 usecs
[    8.234001] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[    8.293378] mt7925e 0000:c0:00.0: WM Firmware Version: ____000000, Build Time: 20260106153120
[    8.326110] Bluetooth: hci0: AOSP extensions version v1.00
[    8.326123] Bluetooth: hci0: AOSP quality report is supported
[    8.490593] FAT-fs (nvme0n1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[    8.490897] systemd-journald[611]: Received client request to flush runtime journal.
[    8.941874] Realtek Internal NBASE-T PHY r8169-0-bf00:00: attached PHY driver (mii_bus:phy_addr=r8169-0-bf00:00, irq=MAC)
[    9.271218] r8169 0000:bf:00.0 enp191s0: Link is Down
[   12.569910] r8169 0000:bf:00.0 enp191s0: Link is Up - 2.5Gbps/Full - flow control off
[   12.767024] netfs: FS-Cache loaded
[   12.813352] RPC: Registered named UNIX socket transport module.
[   12.813355] RPC: Registered udp transport module.
[   12.813356] RPC: Registered tcp transport module.
[   12.813356] RPC: Registered tcp-with-tls transport module.
[   12.813357] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   12.869866] Key type dns_resolver registered
[   12.954633] NFS: Registering the id_resolver key type
[   12.954641] Key type id_resolver registered
[   12.954642] Key type id_legacy registered
[   21.153873] pcieport 0000:00:08.1: PME: Spurious native interrupt!
[   21.385125] rfkill: input handler disabled
[   43.154853] pcieport 0000:00:08.1: PME: Spurious native interrupt!

--dlmdegZ76qxTp6Nd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=dmesg-bad-8505bfb4e4eca28ef1b20d3369435ec2d6a125c6

[    0.000000] Linux version 7.0.0-rc1-debug-00008-g8505bfb4e4ec (nathan@framework-amd-ryzen-maxplus-395) (x86_64-linux-gcc (GCC) 15.2.0, GNU ld (GNU Binutils) 2.45) #1 SMP PREEMPT_DYNAMIC Mon Mar  9 17:20:04 MST 2026
[    0.000000] Command line: initrd=\initramfs-linux-debug.img amd_pstate=active kvm.mitigate_smt_rsb=1 root=PARTUUID=29eee245-b7e0-43d2-8cb3-5516b5464a96 rootflags=subvol=@ rootfstype=btrfs rw zswap.enabled=0
[    0.000000] x86/split lock detection: #DB: warning on user-space bus_locks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff]  System RAM
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff]  System RAM
[    0.000000] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff]  System RAM
[    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f87fff]  ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000009f88000-0x0000000070b53fff]  System RAM
[    0.000000] BIOS-e820: [mem 0x0000000070b54000-0x0000000072d53fff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000072d54000-0x0000000072d66fff]  System RAM
[    0.000000] BIOS-e820: [mem 0x0000000072d67000-0x0000000072d6bfff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000072d6c000-0x0000000076f7efff]  System RAM
[    0.000000] BIOS-e820: [mem 0x0000000076f7f000-0x000000007977efff]  device reserved
[    0.000000] BIOS-e820: [mem 0x000000007977f000-0x0000000079f7efff]  ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000079f7f000-0x0000000079ffefff]  ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000079fff000-0x0000000079ffffff]  System RAM
[    0.000000] BIOS-e820: [mem 0x000000007a000000-0x000000007bffffff]  device reserved
[    0.000000] BIOS-e820: [gap 0x000000007c000000-0x000000007d674fff]
[    0.000000] BIOS-e820: [mem 0x000000007d675000-0x00000000ffffffff]  device reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000105e0bffff]  System RAM
[    0.000000] BIOS-e820: [mem 0x000000105e0c0000-0x00000010b01fffff]  device reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.9 by INSYDE Corp.
[    0.000000] efi: ACPI=0x79ffe000 ACPI 2.0=0x79ffe014 TPMFinalLog=0x79f3e000 SMBIOS=0x77e74000 SMBIOS 3.0=0x77e71000 MEMATTR=0x681e0018 ESRT=0x73468e18 RNG=0x79f93f18 INITRD=0x681cff18 TPMEventLog=0x79f87018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem57: MMIO range=[0x80000000-0xffffffff] (2048MB) from e820 map
[    0.000000] e820: remove [mem 0x80000000-0xffffffff] device reserved
[    0.000000] efi: Remove mem59: MMIO range=[0x1090000000-0x10b01fffff] (514MB) from e820 map
[    0.000000] e820: remove [mem 0x1090000000-0x10b01fffff] device reserved
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: Framework Desktop (AMD Ryzen AI Max 300 Series)/FRANMFCP04, BIOS 03.02 07/22/2025
[    0.000000] DMI: Memory slots populated: 8/8
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2994.150 MHz processor
[    0.000012] e820: update [mem 0x00000000-0x00000fff] System RAM ==> device reserved
[    0.000015] e820: remove [mem 0x000a0000-0x000fffff] System RAM
[    0.000026] last_pfn = 0x105e0c0 max_arch_pfn = 0x400000000
[    0.000038] MTRR map: 8 entries (3 fixed + 5 variable; max 20), built from 9 variable MTRRs
[    0.000041] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000269] last_pfn = 0x7a000 max_arch_pfn = 0x400000000
[    0.007362] esrt: Reserving ESRT space from 0x0000000073468e18 to 0x0000000073468e50.
[    0.007373] e820: update [mem 0x73468000-0x73468fff] System RAM ==> device reserved
[    0.007397] Using GB pages for direct mapping
[    0.007917] Secure boot disabled
[    0.007918] RAMDISK: [mem 0x60247000-0x62b7efff]
[    0.008115] ACPI: Early table checksum verification disabled
[    0.008120] ACPI: RSDP 0x0000000079FFE014 000024 (v02 INSYDE)
[    0.008126] ACPI: XSDT 0x0000000079FA8228 00019C (v01 INSYDE EDK2     00000001      01000013)
[    0.008134] ACPI: FACP 0x0000000079FEE000 000114 (v06 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008142] ACPI: DSDT 0x0000000079FC6000 0073D8 (v02 INSYDE EDK2     00040000 ACPI 00040000)
[    0.008145] ACPI: FACS 0x0000000079E32000 000040
[    0.008148] ACPI: UEFI 0x0000000079F66000 0001CF (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008150] ACPI: ASF! 0x0000000079FFC000 000085 (v32 INSYDE EDK2     00000002 ACPI 00040000)
[    0.008153] ACPI: SSDT 0x0000000079FF3000 00848D (v02 INSYDE EDK2     00000002 ACPI 00040000)
[    0.008155] ACPI: SSDT 0x0000000079FF2000 00033E (v02 INSYDE EDK2     00001000 ACPI 00040000)
[    0.008157] ACPI: ASF! 0x0000000079FF0000 0000A5 (v32 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008160] ACPI: BOOT 0x0000000079FEF000 000028 (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008162] ACPI: HPET 0x0000000079FED000 000038 (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008164] ACPI: MCFG 0x0000000079FEC000 00003C (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008167] ACPI: SLIC 0x0000000079FEB000 000176 (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008169] ACPI: APIC 0x0000000079FE1000 00016A (v06 INSYDE EDK2     00000002 ACPI 00040000)
[    0.008171] ACPI: SSDT 0x0000000079FE0000 000A6A (v02 INSYDE EDK2     00001000 ACPI 00040000)
[    0.008174] ACPI: SSDT 0x0000000079FD5000 00A8CE (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008176] ACPI: VFCT 0x0000000079FD0000 004484 (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008178] ACPI: FPDT 0x0000000079FCF000 000044 (v01 INSYDE EDK2     00000002 ACPI 00040000)
[    0.008180] ACPI: SSDT 0x0000000079FCE000 0000FA (v02 INSYDE EDK2     00001000 ACPI 00040000)
[    0.008183] ACPI: SSDT 0x0000000079FE8000 0006A2 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008185] ACPI: SSDT 0x0000000079FE7000 0008F9 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008187] ACPI: SSDT 0x0000000079FE4000 001DB7 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008189] ACPI: SSDT 0x0000000079FFD000 000782 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008192] ACPI: SSDT 0x0000000079FE3000 00073F (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008194] ACPI: SSDT 0x0000000079FE2000 000CA9 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008196] ACPI: SSDT 0x0000000079FC3000 002AA6 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008198] ACPI: SSDT 0x0000000079FB9000 009A9F (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008200] ACPI: WSMT 0x0000000079FB7000 000028 (v01 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008203] ACPI: TPM2 0x0000000079FEA000 000050 (v05 INSYDE EDK2     20505348 ACPI 00040000)
[    0.008205] ACPI: SSDT 0x0000000079FB5000 001EE8 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008207] ACPI: SSDT 0x0000000079FE9000 00010D (v02 INSYDE EDK2     00000004 ACPI 00040000)
[    0.008210] ACPI: SSDT 0x0000000079FB4000 000051 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008212] ACPI: IVRS 0x0000000079FB3000 0001F6 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008214] ACPI: SSDT 0x0000000079FB2000 000B07 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008216] ACPI: SSDT 0x0000000079FB1000 00085D (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008219] ACPI: SSDT 0x0000000079FB0000 000AF4 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008221] ACPI: SSDT 0x0000000079FAF000 000CEE (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008223] ACPI: SSDT 0x0000000079FAE000 000CEE (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008225] ACPI: SSDT 0x0000000079FAD000 0004FC (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008227] ACPI: SSDT 0x0000000079FAC000 00005E (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008230] ACPI: SSDT 0x0000000079FAA000 001880 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008232] ACPI: SSDT 0x0000000079FA9000 000500 (v02 INSYDE EDK2     00000002 ACPI 00040000)
[    0.008234] ACPI: SSDT 0x0000000079FA6000 0010BB (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008236] ACPI: SSDT 0x0000000079F9C000 0097A5 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008239] ACPI: SSDT 0x0000000079F97000 0046FB (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008241] ACPI: SSDT 0x0000000079FE6000 000A40 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008243] ACPI: SSDT 0x0000000079F96000 0009D0 (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008245] ACPI: SSDT 0x0000000079F95000 00008D (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008248] ACPI: SSDT 0x0000000079F94000 000F5C (v02 INSYDE EDK2     00000001 ACPI 00040000)
[    0.008250] ACPI: BGRT 0x0000000079FB8000 000038 (v01 INSYDE EDK2     00000002 ACPI 00040000)
[    0.008252] ACPI: Reserving FACP table memory at [mem 0x79fee000-0x79fee113]
[    0.008254] ACPI: Reserving DSDT table memory at [mem 0x79fc6000-0x79fcd3d7]
[    0.008254] ACPI: Reserving FACS table memory at [mem 0x79e32000-0x79e3203f]
[    0.008255] ACPI: Reserving UEFI table memory at [mem 0x79f66000-0x79f661ce]
[    0.008256] ACPI: Reserving ASF! table memory at [mem 0x79ffc000-0x79ffc084]
[    0.008256] ACPI: Reserving SSDT table memory at [mem 0x79ff3000-0x79ffb48c]
[    0.008257] ACPI: Reserving SSDT table memory at [mem 0x79ff2000-0x79ff233d]
[    0.008257] ACPI: Reserving ASF! table memory at [mem 0x79ff0000-0x79ff00a4]
[    0.008258] ACPI: Reserving BOOT table memory at [mem 0x79fef000-0x79fef027]
[    0.008259] ACPI: Reserving HPET table memory at [mem 0x79fed000-0x79fed037]
[    0.008259] ACPI: Reserving MCFG table memory at [mem 0x79fec000-0x79fec03b]
[    0.008260] ACPI: Reserving SLIC table memory at [mem 0x79feb000-0x79feb175]
[    0.008260] ACPI: Reserving APIC table memory at [mem 0x79fe1000-0x79fe1169]
[    0.008261] ACPI: Reserving SSDT table memory at [mem 0x79fe0000-0x79fe0a69]
[    0.008262] ACPI: Reserving SSDT table memory at [mem 0x79fd5000-0x79fdf8cd]
[    0.008262] ACPI: Reserving VFCT table memory at [mem 0x79fd0000-0x79fd4483]
[    0.008263] ACPI: Reserving FPDT table memory at [mem 0x79fcf000-0x79fcf043]
[    0.008263] ACPI: Reserving SSDT table memory at [mem 0x79fce000-0x79fce0f9]
[    0.008264] ACPI: Reserving SSDT table memory at [mem 0x79fe8000-0x79fe86a1]
[    0.008264] ACPI: Reserving SSDT table memory at [mem 0x79fe7000-0x79fe78f8]
[    0.008265] ACPI: Reserving SSDT table memory at [mem 0x79fe4000-0x79fe5db6]
[    0.008266] ACPI: Reserving SSDT table memory at [mem 0x79ffd000-0x79ffd781]
[    0.008266] ACPI: Reserving SSDT table memory at [mem 0x79fe3000-0x79fe373e]
[    0.008267] ACPI: Reserving SSDT table memory at [mem 0x79fe2000-0x79fe2ca8]
[    0.008268] ACPI: Reserving SSDT table memory at [mem 0x79fc3000-0x79fc5aa5]
[    0.008268] ACPI: Reserving SSDT table memory at [mem 0x79fb9000-0x79fc2a9e]
[    0.008269] ACPI: Reserving WSMT table memory at [mem 0x79fb7000-0x79fb7027]
[    0.008269] ACPI: Reserving TPM2 table memory at [mem 0x79fea000-0x79fea04f]
[    0.008270] ACPI: Reserving SSDT table memory at [mem 0x79fb5000-0x79fb6ee7]
[    0.008271] ACPI: Reserving SSDT table memory at [mem 0x79fe9000-0x79fe910c]
[    0.008271] ACPI: Reserving SSDT table memory at [mem 0x79fb4000-0x79fb4050]
[    0.008272] ACPI: Reserving IVRS table memory at [mem 0x79fb3000-0x79fb31f5]
[    0.008272] ACPI: Reserving SSDT table memory at [mem 0x79fb2000-0x79fb2b06]
[    0.008273] ACPI: Reserving SSDT table memory at [mem 0x79fb1000-0x79fb185c]
[    0.008274] ACPI: Reserving SSDT table memory at [mem 0x79fb0000-0x79fb0af3]
[    0.008274] ACPI: Reserving SSDT table memory at [mem 0x79faf000-0x79fafced]
[    0.008275] ACPI: Reserving SSDT table memory at [mem 0x79fae000-0x79faeced]
[    0.008275] ACPI: Reserving SSDT table memory at [mem 0x79fad000-0x79fad4fb]
[    0.008276] ACPI: Reserving SSDT table memory at [mem 0x79fac000-0x79fac05d]
[    0.008277] ACPI: Reserving SSDT table memory at [mem 0x79faa000-0x79fab87f]
[    0.008277] ACPI: Reserving SSDT table memory at [mem 0x79fa9000-0x79fa94ff]
[    0.008278] ACPI: Reserving SSDT table memory at [mem 0x79fa6000-0x79fa70ba]
[    0.008278] ACPI: Reserving SSDT table memory at [mem 0x79f9c000-0x79fa57a4]
[    0.008279] ACPI: Reserving SSDT table memory at [mem 0x79f97000-0x79f9b6fa]
[    0.008280] ACPI: Reserving SSDT table memory at [mem 0x79fe6000-0x79fe6a3f]
[    0.008281] ACPI: Reserving SSDT table memory at [mem 0x79f96000-0x79f969cf]
[    0.008281] ACPI: Reserving SSDT table memory at [mem 0x79f95000-0x79f9508c]
[    0.008282] ACPI: Reserving SSDT table memory at [mem 0x79f94000-0x79f94f5b]
[    0.008283] ACPI: Reserving BGRT table memory at [mem 0x79fb8000-0x79fb8037]
[    0.008368] No NUMA configuration found
[    0.008369] Faking a node at [mem 0x0000000000000000-0x000000105e0bffff]
[    0.008377] NODE_DATA(0) allocated [mem 0x105e095280-0x105e0bffff]
[    0.008902] ACPI: PM-Timer IO Port: 0x408
[    0.008914] ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
[    0.008917] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.008930] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0-23
[    0.008936] IOAPIC[1]: apic_id 34, version 33, address 0xfd280000, GSI 24-55
[    0.008939] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.008942] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.008946] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.008947] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.008955] e820: update [mem 0x68209000-0x68257fff] System RAM ==> device reserved
[    0.008972] CPU topo: Max. logical packages:   1
[    0.008973] CPU topo: Max. logical dies:       2
[    0.008973] CPU topo: Max. dies per package:   2
[    0.008977] CPU topo: Max. threads per core:   2
[    0.008978] CPU topo: Num. cores per package:    16
[    0.008979] CPU topo: Num. threads per package:  32
[    0.008980] CPU topo: Allowing 32 present CPUs plus 0 hotplug CPUs
[    0.009002] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.009004] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.009005] PM: hibernation: Registered nosave memory: [mem 0x09b00000-0x09dfffff]
[    0.009007] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0x09f87fff]
[    0.009008] PM: hibernation: Registered nosave memory: [mem 0x68209000-0x68257fff]
[    0.009010] PM: hibernation: Registered nosave memory: [mem 0x70b54000-0x72d53fff]
[    0.009011] PM: hibernation: Registered nosave memory: [mem 0x72d67000-0x72d6bfff]
[    0.009012] PM: hibernation: Registered nosave memory: [mem 0x73468000-0x73468fff]
[    0.009014] PM: hibernation: Registered nosave memory: [mem 0x76f7f000-0x79ffefff]
[    0.009015] PM: hibernation: Registered nosave memory: [mem 0x7a000000-0xffffffff]
[    0.009017] [gap 0x80000000-0xffffffff] available for PCI devices
[    0.009018] Booting paravirtualized kernel on bare hardware
[    0.009022] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.018032] Zone ranges:
[    0.018033]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.018035]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.018037]   Normal   [mem 0x0000000100000000-0x000000105e0bffff]
[    0.018038]   Device   empty
[    0.018039] Movable zone start for each node
[    0.018041] Early memory node ranges
[    0.018041]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.018043]   node   0: [mem 0x0000000000100000-0x0000000009afffff]
[    0.018044]   node   0: [mem 0x0000000009e00000-0x0000000009efffff]
[    0.018044]   node   0: [mem 0x0000000009f88000-0x0000000070b53fff]
[    0.018045]   node   0: [mem 0x0000000072d54000-0x0000000072d66fff]
[    0.018046]   node   0: [mem 0x0000000072d6c000-0x0000000076f7efff]
[    0.018046]   node   0: [mem 0x0000000079fff000-0x0000000079ffffff]
[    0.018047]   node   0: [mem 0x0000000100000000-0x000000105e0bffff]
[    0.018054] Initmem setup node 0 [mem 0x0000000000001000-0x000000105e0bffff]
[    0.018063] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.018078] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.018194] On node 0, zone DMA32: 768 pages in unavailable ranges
[    0.019520] On node 0, zone DMA32: 136 pages in unavailable ranges
[    0.019547] On node 0, zone DMA32: 8704 pages in unavailable ranges
[    0.019601] On node 0, zone DMA32: 5 pages in unavailable ranges
[    0.019640] On node 0, zone DMA32: 12416 pages in unavailable ranges
[    0.070280] On node 0, zone Normal: 24576 pages in unavailable ranges
[    0.070310] On node 0, zone Normal: 8000 pages in unavailable ranges
[    0.070326] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[    0.070780] percpu: Embedded 63 pages/cpu s221184 r8192 d28672 u262144
[    0.070789] pcpu-alloc: s221184 r8192 d28672 u262144 alloc=1*2097152
[    0.070793] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.070800] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27 28 29 30 31 
[    0.070827] Kernel command line: initrd=\initramfs-linux-debug.img amd_pstate=active kvm.mitigate_smt_rsb=1 root=PARTUUID=29eee245-b7e0-43d2-8cb3-5516b5464a96 rootflags=subvol=@ rootfstype=btrfs rw zswap.enabled=0
[    0.070944] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.070946] printk: log_buf_len total cpu_extra contributions: 126976 bytes
[    0.070947] printk: log_buf_len min size: 131072 bytes
[    0.071070] printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes
[    0.071071] printk: early log buf free: 114416(87%)
[    0.073454] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.074687] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.075049] software IO TLB: area num 32.
[    0.079881] Fallback order for Node 0: 0 
[    0.079892] Built 1 zonelists, mobility grouping on.  Total pages: 16591441
[    0.079894] Policy zone: Normal
[    0.080003] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.159865] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.175681] ftrace: allocating 54723 entries in 216 pages
[    0.175683] ftrace: allocated 216 pages with 4 groups
[    0.175803] Dynamic Preempt: full
[    0.175946] rcu: Preemptible hierarchical RCU implementation.
[    0.175947] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
[    0.175948] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.175951] 	Trampoline variant of Tasks RCU enabled.
[    0.175951] 	Rude variant of Tasks RCU enabled.
[    0.175952] 	Tracing variant of Tasks RCU enabled.
[    0.175953] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.175954] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.175975] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.175979] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.181862] NR_IRQS: 524544, nr_irqs: 1224, preallocated irqs: 16
[    0.182130] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.182411] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.182495] Console: colour dummy device 80x25
[    0.182499] printk: legacy console [tty0] enabled
[    0.182571] ACPI: Core revision 20251212
[    0.182979] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.183002] APIC: Switch to symmetric I/O mode setup
[    0.183322] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID00, rdevid:0xa0
[    0.183325] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID01, rdevid:0xa0
[    0.183326] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID02, rdevid:0xa0
[    0.183327] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID03, rdevid:0xa0
[    0.183328] AMD-Vi: ivrs, add hid:MSFT0201, uid:1, rdevid:0x60
[    0.183330] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID04, rdevid:0xa0
[    0.183331] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x10
[    0.184672] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.189012] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2b28af0fa68, max_idle_ns: 440795284941 ns
[    0.189017] Calibrating delay loop (skipped), value calculated using timer frequency.. 5988.30 BogoMIPS (lpj=2994150)
[    0.189049] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.189091] LVT offset 1 assigned for vector 0xf9
[    0.189092] LVT offset 2 assigned for vector 0xf4
[    0.189389] Last level iTLB entries: 4KB 64, 2MB 64, 4MB 32
[    0.189391] Last level dTLB entries: 4KB 128, 2MB 128, 4MB 64, 1GB 0
[    0.189397] process: using mwait in idle threads
[    0.189400] mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
[    0.189405] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.189407] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.189409] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.189410] Speculative Return Stack Overflow: Mitigation: IBPB on VMEXIT only
[    0.189411] VMSCAPE: Mitigation: IBPB on VMEXIT
[    0.189412] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.189414] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.189425] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.189427] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.189428] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.189429] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.189431] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.189432] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.189433] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.189434] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.189436] x86/fpu: Supporting XSAVE feature 0x1000: 'Control-flow Kernel registers (KVM only)'
[    0.189438] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.189440] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.189441] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.189443] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.189444] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.189446] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
[    0.189447] x86/fpu: xstate_offset[12]: 2456, xstate_sizes[12]:   24
[    0.189449] x86/fpu: Enabled xstate features 0x1ae7, context size is 2480 bytes, using 'compacted' format.
[    0.238615] Freeing SMP alternatives memory: 52K
[    0.238620] pid_max: default: 32768 minimum: 301
[    0.238795] landlock: Up and running.
[    0.238798] Yama: becoming mindful.
[    0.239012] LSM support for eBPF active
[    0.239113] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.239165] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.239257] VFS: Finished mounting rootfs on nullfs
[    0.342441] smpboot: CPU0: AMD RYZEN AI MAX+ 395 w/ Radeon 8060S (family: 0x1a, model: 0x70, stepping: 0x0)
[    0.342637] Performance Events: Fam17h+ 16-deep LBR, core perfctr, AMD PMU driver.
[    0.342716] ... version:                   2
[    0.342717] ... bit width:                 48
[    0.342718] ... generic counters:          6
[    0.342718] ... generic bitmap:            000000000000003f
[    0.342720] ... fixed-purpose counters:    0
[    0.342720] ... fixed-purpose bitmap:      0000000000000000
[    0.342721] ... value mask:                0000ffffffffffff
[    0.342722] ... max period:                00007fffffffffff
[    0.342722] ... global_ctrl mask:          000000000000003f
[    0.343015] signal: max sigframe size: 3376
[    0.343015] rcu: Hierarchical SRCU implementation.
[    0.343015] rcu: 	Max phase no-delay instances is 400.
[    0.343015] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.343015] MCE: In-kernel MCE decoding enabled.
[    0.343031] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.343221] smp: Bringing up secondary CPUs ...
[    0.343309] smpboot: x86: Booting SMP configuration:
[    0.343310] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
[    0.353406] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.356097] smp: Brought up 1 node, 32 CPUs
[    0.356097] smpboot: Total of 32 processors activated (191625.60 BogoMIPS)
[    0.358175] Memory: 65011444K/66365764K available (19612K kernel code, 2940K rwdata, 15356K rodata, 4648K init, 5076K bss, 1315592K reserved, 0K cma-reserved)
[    0.359187] devtmpfs: initialized
[    0.359187] x86/mm: Memory block size: 2048MB
[    0.360630] ACPI: PM: Registering ACPI NVS region [mem 0x09f00000-0x09f87fff] (557056 bytes)
[    0.360630] ACPI: PM: Registering ACPI NVS region [mem 0x7977f000-0x79f7efff] (8388608 bytes)
[    0.360630] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.360630] posixtimers hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.360630] futex hash table entries: 8192 (524288 bytes on 1 NUMA nodes, total 512 KiB, linear).
[    0.361230] PM: RTC time: 00:22:10, date: 2026-03-10
[    0.361607] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.361939] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.362136] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.362328] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.362334] audit: initializing netlink subsys (disabled)
[    0.362341] audit: type=2000 audit(1773102129.178:1): state=initialized audit_enabled=0 res=1
[    0.362341] thermal_sys: Registered thermal governor 'fair_share'
[    0.362341] thermal_sys: Registered thermal governor 'bang_bang'
[    0.362341] thermal_sys: Registered thermal governor 'step_wise'
[    0.362341] thermal_sys: Registered thermal governor 'user_space'
[    0.362341] thermal_sys: Registered thermal governor 'power_allocator'
[    0.362341] cpuidle: using governor ladder
[    0.362341] cpuidle: using governor menu
[    0.362341] Simple Boot Flag at 0x44 set to 0x1
[    0.362341] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.363045] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    0.363066] PCI: Using configuration type 1 for base access
[    0.363147] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.363152] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.363152] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.363152] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.363152] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.365216] raid6: skipped pq benchmark and selected avx512x4
[    0.365219] raid6: using avx512x2 recovery algorithm
[    0.365304] ACPI: Added _OSI(Module Device)
[    0.365306] ACPI: Added _OSI(Processor Device)
[    0.365307] ACPI: Added _OSI(Processor Aggregator Device)
[    0.383005] ACPI: 33 ACPI AML tables successfully acquired and loaded
[    0.395393] ACPI: \_SB_: platform _OSC: OS support mask [006e7efe]
[    0.395787] ACPI: \_SB_: platform _OSC: OS control mask [006e7e7e]
[    0.396024] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
[    0.396027] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
[    0.396762] ACPI: EC: EC started
[    0.396763] ACPI: EC: interrupt blocked
[    0.397232] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.397234] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle transactions
[    0.397236] ACPI: Interpreter enabled
[    0.397254] ACPI: PM: (supports S0 S4 S5)
[    0.397256] ACPI: Using IOAPIC for interrupt routing
[    0.398121] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.398123] PCI: Ignoring E820 reservations for host bridge windows
[    0.398634] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.401275] ACPI: \_SB_.PCI0.GPP0.PWRS: New power resource
[    0.402392] ACPI: \_SB_.PCI0.GPP0.SWUS.PWRS: New power resource
[    0.403488] ACPI: \_SB_.PCI0.GPP1.PWRS: New power resource
[    0.404532] ACPI: \_SB_.PCI0.GPP1.SWUS.PWRS: New power resource
[    0.404776] ACPI: \_SB_.PCI0.GPP3.PWRS: New power resource
[    0.405440] ACPI: \_SB_.PCI0.GPP4.PWRS: New power resource
[    0.406035] ACPI: \_SB_.PCI0.GPP5.PWRS: New power resource
[    0.406706] ACPI: \_SB_.PCI0.GPP7.P0NV: New power resource
[    0.407680] ACPI: \_SB_.PCI0.GPP9.P0NV: New power resource
[    0.408695] ACPI: \_SB_.PCI0.GPPA.PWRS: New power resource
[    0.408919] ACPI: \_SB_.PCI0.GPPA.VGA_.PWRS: New power resource
[    0.409207] ACPI: \_SB_.PCI0.GPPA.ACP_.PWRS: New power resource
[    0.409503] ACPI: \_SB_.PCI0.GPPA.AZAL.PWRS: New power resource
[    0.409846] ACPI: \_SB_.PCI0.GPPA.HDAU.PWRS: New power resource
[    0.410226] ACPI: \_SB_.PCI0.GPPA.XHC1.PWRS: New power resource
[    0.412203] ACPI: \_SB_.PCI0.GPPC.XHC0.PWRS: New power resource
[    0.414442] ACPI: \_SB_.PCI0.GPPC.XHC3.PWRS: New power resource
[    0.415547] ACPI: \_SB_.PCI0.GPPC.XHC4.PWRS: New power resource
[    0.416649] ACPI: \_SB_.PCI0.GPPC.NHI0.PWRS: New power resource
[    0.417303] ACPI: \_SB_.PCI0.GPPC.NHI1.PWRS: New power resource
[    0.421088] ACPI: \_SB_.PRWL: New power resource
[    0.421110] ACPI: \_SB_.PRWB: New power resource
[    0.422321] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.422328] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.422399] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
[    0.422512] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
[    0.423012] PCI host bridge to bus 0000:00
[    0.423017] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.423021] pci_bus 0000:00: root bus resource [io  0x0d00-0xfeff window]
[    0.423022] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.423024] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000cffff window]
[    0.423025] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000effff window]
[    0.423026] pci_bus 0000:00: root bus resource [mem 0x80000000-0xdfffffff window]
[    0.423027] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfcffffff window]
[    0.423028] pci_bus 0000:00: root bus resource [mem 0x10b0200000-0x8b4fffffff window]
[    0.423030] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.423049] pci 0000:00:00.0: [1022:1507] type 00 class 0x060000 conventional PCI endpoint
[    0.423167] pci 0000:00:00.2: [1022:1508] type 00 class 0x080600 conventional PCI endpoint
[    0.423259] pci 0000:00:01.0: [1022:1509] type 00 class 0x060000 conventional PCI endpoint
[    0.423350] pci 0000:00:01.1: [1022:150a] type 01 class 0x060400 PCIe Root Port
[    0.423565] pci 0000:00:01.1: PCI bridge to [bus 01-5f]
[    0.423572] pci 0000:00:01.1:   bridge window [io  0x7000-0xafff]
[    0.423576] pci 0000:00:01.1:   bridge window [mem 0x98000000-0xafffffff]
[    0.423615] pci 0000:00:01.1:   bridge window [mem 0x3800000000-0x57ffffffff 64bit pref]
[    0.423890] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.425072] pci 0000:00:01.2: [1022:150a] type 01 class 0x060400 PCIe Root Port
[    0.425288] pci 0000:00:01.2: PCI bridge to [bus 60-be]
[    0.425295] pci 0000:00:01.2:   bridge window [io  0x3000-0x6fff]
[    0.425298] pci 0000:00:01.2:   bridge window [mem 0x80000000-0x97ffffff]
[    0.425338] pci 0000:00:01.2:   bridge window [mem 0x1800000000-0x37ffffffff 64bit pref]
[    0.425598] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.426738] pci 0000:00:02.0: [1022:1509] type 00 class 0x060000 conventional PCI endpoint
[    0.426817] pci 0000:00:02.1: [1022:150b] type 01 class 0x060400 PCIe Root Port
[    0.426837] pci 0000:00:02.1: PCI bridge to [bus bf]
[    0.426842] pci 0000:00:02.1:   bridge window [io  0x2000-0x2fff]
[    0.426845] pci 0000:00:02.1:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.426920] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.427079] pci 0000:00:02.3: [1022:150b] type 01 class 0x060400 PCIe Root Port
[    0.427099] pci 0000:00:02.3: PCI bridge to [bus c0]
[    0.427105] pci 0000:00:02.3:   bridge window [mem 0xb0600000-0xb08fffff]
[    0.427179] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.427337] pci 0000:00:02.5: [1022:150b] type 01 class 0x060400 PCIe Root Port
[    0.427357] pci 0000:00:02.5: PCI bridge to [bus c1]
[    0.427363] pci 0000:00:02.5:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.427437] pci 0000:00:02.5: PME# supported from D0 D3hot D3cold
[    0.427573] pci 0000:00:03.0: [1022:1509] type 00 class 0x060000 conventional PCI endpoint
[    0.427652] pci 0000:00:08.0: [1022:1509] type 00 class 0x060000 conventional PCI endpoint
[    0.427734] pci 0000:00:08.1: [1022:150c] type 01 class 0x060400 PCIe Root Port
[    0.427754] pci 0000:00:08.1: PCI bridge to [bus c2]
[    0.427759] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.427762] pci 0000:00:08.1:   bridge window [mem 0xb0000000-0xb05fffff]
[    0.427770] pci 0000:00:08.1:   bridge window [mem 0x5800000000-0x581fffffff 64bit pref]
[    0.427779] pci 0000:00:08.1: enabling Extended Tags
[    0.427836] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.428101] pci 0000:00:08.2: [1022:150c] type 01 class 0x060400 PCIe Root Port
[    0.428129] pci 0000:00:08.2: PCI bridge to [bus c3]
[    0.428136] pci 0000:00:08.2:   bridge window [mem 0xb0d00000-0xb0efffff]
[    0.428144] pci 0000:00:08.2:   bridge window [mem 0x5820000000-0x58200fffff 64bit pref]
[    0.428152] pci 0000:00:08.2: enabling Extended Tags
[    0.428209] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.428333] pci 0000:00:08.3: [1022:150c] type 01 class 0x060400 PCIe Root Port
[    0.428353] pci 0000:00:08.3: PCI bridge to [bus c4]
[    0.428359] pci 0000:00:08.3:   bridge window [mem 0xb0900000-0xb0cfffff]
[    0.428375] pci 0000:00:08.3: enabling Extended Tags
[    0.428431] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.428709] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional PCI endpoint
[    0.428826] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional PCI endpoint
[    0.428955] pci 0000:00:18.0: [1022:12b8] type 00 class 0x060000 conventional PCI endpoint
[    0.429001] pci 0000:00:18.1: [1022:12b9] type 00 class 0x060000 conventional PCI endpoint
[    0.429048] pci 0000:00:18.2: [1022:12ba] type 00 class 0x060000 conventional PCI endpoint
[    0.429092] pci 0000:00:18.3: [1022:12bb] type 00 class 0x060000 conventional PCI endpoint
[    0.429137] pci 0000:00:18.4: [1022:12bc] type 00 class 0x060000 conventional PCI endpoint
[    0.429182] pci 0000:00:18.5: [1022:12bd] type 00 class 0x060000 conventional PCI endpoint
[    0.429226] pci 0000:00:18.6: [1022:12be] type 00 class 0x060000 conventional PCI endpoint
[    0.429271] pci 0000:00:18.7: [1022:12bf] type 00 class 0x060000 conventional PCI endpoint
[    0.429426] pci 0000:00:01.1: PCI bridge to [bus 01-5f]
[    0.429547] pci 0000:00:01.2: PCI bridge to [bus 60-be]
[    0.429645] pci 0000:bf:00.0: [10ec:8126] type 00 class 0x020000 PCIe Endpoint
[    0.429697] pci 0000:bf:00.0: BAR 0 [io  0x2000-0x20ff]
[    0.429704] pci 0000:bf:00.0: BAR 2 [mem 0xb1000000-0xb100ffff 64bit]
[    0.429708] pci 0000:bf:00.0: BAR 4 [mem 0xb1010000-0xb1013fff 64bit]
[    0.429832] pci 0000:bf:00.0: supports D1 D2
[    0.429833] pci 0000:bf:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.430134] pci 0000:00:02.1: PCI bridge to [bus bf]
[    0.430410] pci 0000:c0:00.0: [14c3:0717] type 00 class 0x028000 PCIe Endpoint
[    0.430467] pci 0000:c0:00.0: BAR 0 [mem 0xb0600000-0xb07fffff 64bit]
[    0.430471] pci 0000:c0:00.0: BAR 2 [mem 0xb0800000-0xb0807fff 64bit]
[    0.430564] pci 0000:c0:00.0: PME# supported from D0 D3hot D3cold
[    0.431385] pci 0000:00:02.3: PCI bridge to [bus c0]
[    0.431605] pci 0000:c1:00.0: [1c5c:1959] type 00 class 0x010802 PCIe Endpoint
[    0.431645] pci 0000:c1:00.0: BAR 0 [mem 0xb0f00000-0xb0f03fff 64bit]
[    0.431922] pci 0000:00:02.5: PCI bridge to [bus c1]
[    0.432021] pci 0000:c2:00.0: [1002:1586] type 00 class 0x038000 PCIe Legacy Endpoint
[    0.432419] pci 0000:c2:00.0: BAR 0 [mem 0x5800000000-0x581fffffff 64bit pref]
[    0.432422] pci 0000:c2:00.0: BAR 2 [mem 0xb0000000-0xb01fffff 64bit pref]
[    0.432425] pci 0000:c2:00.0: BAR 4 [io  0x1000-0x10ff]
[    0.432426] pci 0000:c2:00.0: BAR 5 [mem 0xb0400000-0xb04fffff]
[    0.432433] pci 0000:c2:00.0: enabling Extended Tags
[    0.432502] pci 0000:c2:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.433081] pci 0000:c2:00.1: [1002:1640] type 00 class 0x040300 PCIe Legacy Endpoint
[    0.433110] pci 0000:c2:00.1: BAR 0 [mem 0xb0508000-0xb050bfff]
[    0.433121] pci 0000:c2:00.1: enabling Extended Tags
[    0.433165] pci 0000:c2:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.433371] pci 0000:c2:00.2: [1022:17e0] type 00 class 0x108000 PCIe Endpoint
[    0.433402] pci 0000:c2:00.2: BAR 2 [mem 0xb0300000-0xb03fffff]
[    0.433405] pci 0000:c2:00.2: BAR 5 [mem 0xb050c000-0xb050dfff]
[    0.433411] pci 0000:c2:00.2: enabling Extended Tags
[    0.433546] pci 0000:c2:00.4: [1022:1587] type 00 class 0x0c0330 PCIe Endpoint
[    0.433577] pci 0000:c2:00.4: BAR 0 [mem 0xb0200000-0xb02fffff 64bit]
[    0.433587] pci 0000:c2:00.4: enabling Extended Tags
[    0.433634] pci 0000:c2:00.4: PME# supported from D0 D3hot D3cold
[    0.433981] pci 0000:c2:00.6: [1022:15e3] type 00 class 0x040300 PCIe Endpoint
[    0.434009] pci 0000:c2:00.6: BAR 0 [mem 0xb0500000-0xb0507fff]
[    0.434026] pci 0000:c2:00.6: enabling Extended Tags
[    0.434070] pci 0000:c2:00.6: PME# supported from D0 D3hot D3cold
[    0.434301] pci 0000:00:08.1: PCI bridge to [bus c2]
[    0.434366] pci 0000:c3:00.0: [1022:150d] type 00 class 0x130000 PCIe Endpoint
[    0.434403] pci 0000:c3:00.0: enabling Extended Tags
[    0.434563] pci 0000:c3:00.1: [1022:17f0] type 00 class 0x118000 PCIe Endpoint
[    0.434596] pci 0000:c3:00.1: BAR 0 [mem 0xb0d00000-0xb0dfffff]
[    0.434598] pci 0000:c3:00.1: BAR 1 [mem 0xb0e00000-0xb0e01fff]
[    0.434600] pci 0000:c3:00.1: BAR 2 [mem 0x5820000000-0x582007ffff 64bit pref]
[    0.434602] pci 0000:c3:00.1: BAR 4 [mem 0xb0e03000-0xb0e03fff]
[    0.434604] pci 0000:c3:00.1: BAR 5 [mem 0xb0e02000-0xb0e02fff]
[    0.434610] pci 0000:c3:00.1: enabling Extended Tags
[    0.434765] pci 0000:00:08.2: PCI bridge to [bus c3]
[    0.434847] pci 0000:c4:00.0: [1022:1588] type 00 class 0x0c0330 PCIe Endpoint
[    0.434878] pci 0000:c4:00.0: BAR 0 [mem 0xb0900000-0xb09fffff 64bit]
[    0.434887] pci 0000:c4:00.0: enabling Extended Tags
[    0.434944] pci 0000:c4:00.0: PME# supported from D0 D3hot D3cold
[    0.435327] pci 0000:c4:00.3: [1022:1589] type 00 class 0x0c0330 PCIe Endpoint
[    0.435358] pci 0000:c4:00.3: BAR 0 [mem 0xb0a00000-0xb0afffff 64bit]
[    0.435368] pci 0000:c4:00.3: enabling Extended Tags
[    0.435414] pci 0000:c4:00.3: PME# supported from D0 D3hot D3cold
[    0.435740] pci 0000:c4:00.4: [1022:158b] type 00 class 0x0c0330 PCIe Endpoint
[    0.435770] pci 0000:c4:00.4: BAR 0 [mem 0xb0b00000-0xb0bfffff 64bit]
[    0.435780] pci 0000:c4:00.4: enabling Extended Tags
[    0.435826] pci 0000:c4:00.4: PME# supported from D0 D3hot D3cold
[    0.436157] pci 0000:c4:00.5: [1022:158d] type 00 class 0x0c0340 PCIe Endpoint
[    0.436192] pci 0000:c4:00.5: BAR 0 [mem 0xb0c00000-0xb0c7ffff 64bit]
[    0.436202] pci 0000:c4:00.5: Max Payload Size set to 128 (was 256, max 256)
[    0.436205] pci 0000:c4:00.5: enabling Extended Tags
[    0.436251] pci 0000:c4:00.5: PME# supported from D0 D3hot D3cold
[    0.436578] pci 0000:c4:00.6: [1022:158e] type 00 class 0x0c0340 PCIe Endpoint
[    0.436612] pci 0000:c4:00.6: BAR 0 [mem 0xb0c80000-0xb0cfffff 64bit]
[    0.436622] pci 0000:c4:00.6: Max Payload Size set to 128 (was 256, max 256)
[    0.436625] pci 0000:c4:00.6: enabling Extended Tags
[    0.436671] pci 0000:c4:00.6: PME# supported from D0 D3hot D3cold
[    0.437021] pci 0000:00:08.3: PCI bridge to [bus c4]
[    0.447835] Low-power S0 idle used by default for system suspend
[    0.448024] ACPI: EC: interrupt unblocked
[    0.448025] ACPI: EC: event unblocked
[    0.448029] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.448031] ACPI: EC: GPE=0xa
[    0.448032] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization complete
[    0.448034] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions and events
[    0.448105] iommu: Default domain type: Translated
[    0.448105] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.448143] SCSI subsystem initialized
[    0.449024] libata version 3.00 loaded.
[    0.449029] ACPI: bus type USB registered
[    0.449038] usbcore: registered new interface driver usbfs
[    0.449038] usbcore: registered new interface driver hub
[    0.449042] usbcore: registered new device driver usb
[    0.449079] EDAC MC: Ver: 3.0.0
[    0.449387] efivars: Registered efivars operations
[    0.449387] NetLabel: Initializing
[    0.449387] NetLabel:  domain hash size = 128
[    0.449387] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.449387] NetLabel:  unlabeled traffic allowed by default
[    0.449387] mctp: management component transport protocol core
[    0.449387] NET: Registered PF_MCTP protocol family
[    0.449387] PCI: Using ACPI for IRQ routing
[    0.458851] PCI: pci_cache_line_size set to 64 bytes
[    0.459273] e820: register RAM buffer resource [mem 0x0009f000-0x0009ffff]
[    0.459276] e820: register RAM buffer resource [mem 0x09b00000-0x0bffffff]
[    0.459278] e820: register RAM buffer resource [mem 0x09f00000-0x0bffffff]
[    0.459279] e820: register RAM buffer resource [mem 0x68209000-0x6bffffff]
[    0.459280] e820: register RAM buffer resource [mem 0x70b54000-0x73ffffff]
[    0.459281] e820: register RAM buffer resource [mem 0x72d67000-0x73ffffff]
[    0.459282] e820: register RAM buffer resource [mem 0x73468000-0x73ffffff]
[    0.459283] e820: register RAM buffer resource [mem 0x76f7f000-0x77ffffff]
[    0.459283] e820: register RAM buffer resource [mem 0x7a000000-0x7bffffff]
[    0.459284] e820: register RAM buffer resource [mem 0x105e0c0000-0x105fffffff]
[    0.459320] vgaarb: loaded
[    0.459320] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.459320] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.461135] clocksource: Switched to clocksource tsc-early
[    0.461305] VFS: Disk quotas dquot_6.6.0
[    0.461318] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.461337] acpi PNP0C02:00: Reserved [mem 0xe0000000-0xefffffff]
[    0.461348] acpi PNP0C02:01: Skipped [io  0x0010-0x001f]
[    0.461350] acpi PNP0C02:01: Skipped [io  0x0020-0x0021]
[    0.461351] acpi PNP0C02:01: Skipped [io  0x00a0-0x00a1]
[    0.461353] acpi PNP0C02:01: Skipped [io  0x0072-0x0073]
[    0.461353] acpi PNP0C02:01: Skipped [io  0x0080]
[    0.461354] acpi PNP0C02:01: Skipped [io  0x00b0-0x00b1]
[    0.461355] acpi PNP0C02:01: Skipped [io  0x0092]
[    0.461356] acpi PNP0C02:01: Skipped [io  0x00f0]
[    0.461358] acpi PNP0C02:01: Reserved [io  0x0400-0x04cf]
[    0.461359] acpi PNP0C02:01: Reserved [io  0x04d0-0x04d1]
[    0.461360] acpi PNP0C02:01: Reserved [io  0x04d6]
[    0.461361] acpi PNP0C02:01: Reserved [io  0x0c00-0x0c01]
[    0.461362] acpi PNP0C02:01: Reserved [io  0x0c14]
[    0.461363] acpi PNP0C02:01: Reserved [io  0x0c50-0x0c52]
[    0.461364] acpi PNP0C02:01: Reserved [io  0x0c6c]
[    0.461365] acpi PNP0C02:01: Reserved [io  0x0c6f]
[    0.461366] acpi PNP0C02:01: Reserved [io  0x0cd0-0x0cdb]
[    0.461367] acpi PNP0C02:01: Could not reserve [mem 0xfec00000-0xfec0ffff]
[    0.461369] acpi PNP0C02:01: Reserved [mem 0xfed45000-0xfed811ff]
[    0.461371] acpi PNP0C02:01: Reserved [mem 0xfed81900-0xfed81fff]
[    0.461372] acpi PNP0C02:01: Reserved [mem 0xfedc0000-0xfedc0fff]
[    0.461374] acpi PNP0C02:01: Reserved [mem 0xfedc6000-0xfedc6fff]
[    0.461375] acpi PNP0C02:01: Reserved [mem 0xfee01000-0xffffffff]
[    0.461379] acpi PNP0C01:00: Reserved [mem 0xff000000-0xffffffff]
[    0.461426] pnp: PnP ACPI init
[    0.465393] pnp: PnP ACPI: found 1 devices
[    0.471352] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.471430] NET: Registered PF_INET protocol family
[    0.471549] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.474116] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes, linear)
[    0.474164] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.474350] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.474800] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.474972] TCP: Hash tables configured (established 524288 bind 65536)
[    0.475169] MPTCP token hash table entries: 65536 (order: 9, 1572864 bytes, linear)
[    0.475357] UDP hash table entries: 32768 (order: 9, 2097152 bytes, linear)
[    0.475577] UDP-Lite hash table entries: 32768 (order: 9, 2097152 bytes, linear)
[    0.475769] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.475776] NET: Registered PF_XDP protocol family
[    0.475792] pci 0000:00:01.1: PCI bridge to [bus 01-5f]
[    0.475801] pci 0000:00:01.1:   bridge window [io  0x7000-0xafff]
[    0.475811] pci 0000:00:01.1:   bridge window [mem 0x98000000-0xafffffff]
[    0.475837] pci 0000:00:01.1:   bridge window [mem 0x3800000000-0x57ffffffff 64bit pref]
[    0.475890] pci 0000:00:01.2: PCI bridge to [bus 60-be]
[    0.475892] pci 0000:00:01.2:   bridge window [io  0x3000-0x6fff]
[    0.475917] pci 0000:00:01.2:   bridge window [mem 0x80000000-0x97ffffff]
[    0.475943] pci 0000:00:01.2:   bridge window [mem 0x1800000000-0x37ffffffff 64bit pref]
[    0.475971] pci 0000:00:02.1: PCI bridge to [bus bf]
[    0.475973] pci 0000:00:02.1:   bridge window [io  0x2000-0x2fff]
[    0.475977] pci 0000:00:02.1:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.475983] pci 0000:00:02.3: PCI bridge to [bus c0]
[    0.475986] pci 0000:00:02.3:   bridge window [mem 0xb0600000-0xb08fffff]
[    0.475992] pci 0000:00:02.5: PCI bridge to [bus c1]
[    0.475995] pci 0000:00:02.5:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.476002] pci 0000:00:08.1: PCI bridge to [bus c2]
[    0.476008] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.476012] pci 0000:00:08.1:   bridge window [mem 0xb0000000-0xb05fffff]
[    0.476014] pci 0000:00:08.1:   bridge window [mem 0x5800000000-0x581fffffff 64bit pref]
[    0.476019] pci 0000:00:08.2: PCI bridge to [bus c3]
[    0.476022] pci 0000:00:08.2:   bridge window [mem 0xb0d00000-0xb0efffff]
[    0.476025] pci 0000:00:08.2:   bridge window [mem 0x5820000000-0x58200fffff 64bit pref]
[    0.476029] pci 0000:00:08.3: PCI bridge to [bus c4]
[    0.476032] pci 0000:00:08.3:   bridge window [mem 0xb0900000-0xb0cfffff]
[    0.476039] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.476041] pci_bus 0000:00: resource 5 [io  0x0d00-0xfeff window]
[    0.476042] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.476043] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000cffff window]
[    0.476044] pci_bus 0000:00: resource 8 [mem 0x000d0000-0x000effff window]
[    0.476045] pci_bus 0000:00: resource 9 [mem 0x80000000-0xdfffffff window]
[    0.476046] pci_bus 0000:00: resource 10 [mem 0xf0000000-0xfcffffff window]
[    0.476048] pci_bus 0000:00: resource 11 [mem 0x10b0200000-0x8b4fffffff window]
[    0.476049] pci_bus 0000:01: resource 0 [io  0x7000-0xafff]
[    0.476050] pci_bus 0000:01: resource 1 [mem 0x98000000-0xafffffff]
[    0.476051] pci_bus 0000:01: resource 2 [mem 0x3800000000-0x57ffffffff 64bit pref]
[    0.476052] pci_bus 0000:60: resource 0 [io  0x3000-0x6fff]
[    0.476053] pci_bus 0000:60: resource 1 [mem 0x80000000-0x97ffffff]
[    0.476054] pci_bus 0000:60: resource 2 [mem 0x1800000000-0x37ffffffff 64bit pref]
[    0.476055] pci_bus 0000:bf: resource 0 [io  0x2000-0x2fff]
[    0.476056] pci_bus 0000:bf: resource 1 [mem 0xb1000000-0xb10fffff]
[    0.476057] pci_bus 0000:c0: resource 1 [mem 0xb0600000-0xb08fffff]
[    0.476058] pci_bus 0000:c1: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.476059] pci_bus 0000:c2: resource 0 [io  0x1000-0x1fff]
[    0.476060] pci_bus 0000:c2: resource 1 [mem 0xb0000000-0xb05fffff]
[    0.476061] pci_bus 0000:c2: resource 2 [mem 0x5800000000-0x581fffffff 64bit pref]
[    0.476062] pci_bus 0000:c3: resource 1 [mem 0xb0d00000-0xb0efffff]
[    0.476063] pci_bus 0000:c3: resource 2 [mem 0x5820000000-0x58200fffff 64bit pref]
[    0.476064] pci_bus 0000:c4: resource 1 [mem 0xb0900000-0xb0cfffff]
[    0.476395] pci 0000:c2:00.1: D0 power state depends on 0000:c2:00.0
[    0.476666] PCI: CLS 64 bytes, default 64
[    0.476691] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.476732] Unpacking initramfs...
[    0.476736] platform AMDI0020:00: Adding to iommu group 0
[    0.476746] platform MSFT0201:00: Adding to iommu group 1
[    0.477109] pci 0000:00:01.0: Adding to iommu group 2
[    0.477135] pci 0000:00:01.1: Adding to iommu group 3
[    0.477160] pci 0000:00:01.2: Adding to iommu group 4
[    0.477199] pci 0000:00:02.0: Adding to iommu group 5
[    0.477215] pci 0000:00:02.1: Adding to iommu group 6
[    0.477228] pci 0000:00:02.3: Adding to iommu group 7
[    0.477242] pci 0000:00:02.5: Adding to iommu group 8
[    0.477260] pci 0000:00:03.0: Adding to iommu group 9
[    0.477309] pci 0000:00:08.0: Adding to iommu group 10
[    0.477322] pci 0000:00:08.1: Adding to iommu group 11
[    0.477336] pci 0000:00:08.2: Adding to iommu group 12
[    0.477351] pci 0000:00:08.3: Adding to iommu group 13
[    0.477375] pci 0000:00:14.0: Adding to iommu group 14
[    0.477390] pci 0000:00:14.3: Adding to iommu group 14
[    0.477455] pci 0000:00:18.0: Adding to iommu group 15
[    0.477467] pci 0000:00:18.1: Adding to iommu group 15
[    0.477481] pci 0000:00:18.2: Adding to iommu group 15
[    0.477493] pci 0000:00:18.3: Adding to iommu group 15
[    0.477506] pci 0000:00:18.4: Adding to iommu group 15
[    0.477519] pci 0000:00:18.5: Adding to iommu group 15
[    0.477532] pci 0000:00:18.6: Adding to iommu group 15
[    0.477545] pci 0000:00:18.7: Adding to iommu group 15
[    0.477564] pci 0000:bf:00.0: Adding to iommu group 16
[    0.477577] pci 0000:c0:00.0: Adding to iommu group 17
[    0.477594] pci 0000:c1:00.0: Adding to iommu group 18
[    0.477632] pci 0000:c2:00.0: Adding to iommu group 19
[    0.477647] pci 0000:c2:00.1: Adding to iommu group 20
[    0.477663] pci 0000:c2:00.2: Adding to iommu group 21
[    0.477677] pci 0000:c2:00.4: Adding to iommu group 22
[    0.477697] pci 0000:c2:00.6: Adding to iommu group 23
[    0.477717] pci 0000:c3:00.0: Adding to iommu group 24
[    0.477733] pci 0000:c3:00.1: Adding to iommu group 25
[    0.477748] pci 0000:c4:00.0: Adding to iommu group 26
[    0.477763] pci 0000:c4:00.3: Adding to iommu group 27
[    0.477779] pci 0000:c4:00.4: Adding to iommu group 28
[    0.477794] pci 0000:c4:00.5: Adding to iommu group 29
[    0.477808] pci 0000:c4:00.6: Adding to iommu group 30
[    0.481709] AMD-Vi: Extended features (0x246577efa2254afa, 0x10): PPR NX GT [5] IA GA PC GA_vAPIC
[    0.481719] AMD-Vi: Interrupt remapping enabled
[    0.481919] AMD-Vi: Virtual APIC enabled
[    0.481947] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.481971] software IO TLB: mapped [mem 0x00000000641ca000-0x00000000681ca000] (64MB)
[    0.482021] LVT offset 0 assigned for vector 0x400
[    0.482997] perf: AMD IBS detected (0x00081bff)
[    0.483004] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.501222] Initialise system trusted keyrings
[    0.501235] Key type blacklist registered
[    0.501271] workingset: timestamp_bits=36 max_order=24 bucket_order=0
[    0.501603] fuse: init (API version 7.45)
[    0.501698] integrity: Platform Keyring initialized
[    0.501701] integrity: Machine keyring initialized
[    0.513100] xor: automatically using best checksumming function   avx       
[    0.513102] Key type asymmetric registered
[    0.513103] Asymmetric key parser 'x509' registered
[    0.513132] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.513194] io scheduler mq-deadline registered
[    0.513195] io scheduler kyber registered
[    0.513214] io scheduler bfq registered
[    0.515714] ledtrig-cpu: registered to indicate activity on CPUs
[    0.515985] pcieport 0000:00:01.1: PME: Signaling with IRQ 33
[    0.516039] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.516634] pcieport 0000:00:01.2: PME: Signaling with IRQ 34
[    0.516686] pcieport 0000:00:01.2: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.517099] pcieport 0000:00:02.1: PME: Signaling with IRQ 35
[    0.517269] pcieport 0000:00:02.3: PME: Signaling with IRQ 36
[    0.517447] pcieport 0000:00:02.5: PME: Signaling with IRQ 37
[    0.517628] pcieport 0000:00:08.1: PME: Signaling with IRQ 38
[    0.517838] pcieport 0000:00:08.2: PME: Signaling with IRQ 39
[    0.518019] pcieport 0000:00:08.3: PME: Signaling with IRQ 40
[    0.518415] ACPI: AC: AC Adapter [ACAD] (on-line)
[    0.518463] input: Power Button as /devices/platform/PNP0C0C:00/input/input0
[    0.518485] ACPI: button: Power Button [PWRB]
[    0.518520] Monitor-Mwait will be used to enter C-1 state
[    0.522525] Could not retrieve perf counters (-14)
[    0.522792] acpi LNXTHERM:00: registered as thermal_zone0
[    0.522794] ACPI: thermal: Thermal Zone [TZ00] (36 C)
[    0.522950] acpi LNXTHERM:01: registered as thermal_zone1
[    0.522951] ACPI: thermal: Thermal Zone [TZ01] (35 C)
[    0.523090] acpi LNXTHERM:02: registered as thermal_zone2
[    0.523091] ACPI: thermal: Thermal Zone [TZ02] (36 C)
[    0.523240] acpi LNXTHERM:03: registered as thermal_zone3
[    0.523241] ACPI: thermal: Thermal Zone [TZ03] (35 C)
[    0.523439] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.525227] Non-volatile memory driver v1.3
[    0.525229] Linux agpgart interface v0.103
[    0.527153] Freeing initrd memory: 42208K
[    1.495904] tsc: Refined TSC clocksource calibration: 2994.372 MHz
[    1.495925] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b29812ce43, max_idle_ns: 440795323173 ns
[    1.496395] clocksource: Switched to clocksource tsc
[    1.769166] tpm_crb MSFT0101:00: Disabling hwrng
[    1.774509] xhci_hcd 0000:c2:00.4: xHCI Host Controller
[    1.774519] xhci_hcd 0000:c2:00.4: new USB bus registered, assigned bus number 1
[    1.774920] xhci_hcd 0000:c2:00.4: hcc params 0x0118ffc5 hci version 0x120 quirks 0x0000000200000010
[    1.775385] xhci_hcd 0000:c2:00.4: xHCI Host Controller
[    1.775388] xhci_hcd 0000:c2:00.4: new USB bus registered, assigned bus number 2
[    1.775390] xhci_hcd 0000:c2:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    1.775442] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    1.775445] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.775447] usb usb1: Product: xHCI Host Controller
[    1.775448] usb usb1: Manufacturer: Linux 7.0.0-rc1-debug-00008-g8505bfb4e4ec xhci-hcd
[    1.775450] usb usb1: SerialNumber: 0000:c2:00.4
[    1.775607] hub 1-0:1.0: USB hub found
[    1.775632] hub 1-0:1.0: 1 port detected
[    1.776393] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.776408] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    1.776410] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.776411] usb usb2: Product: xHCI Host Controller
[    1.776412] usb usb2: Manufacturer: Linux 7.0.0-rc1-debug-00008-g8505bfb4e4ec xhci-hcd
[    1.776414] usb usb2: SerialNumber: 0000:c2:00.4
[    1.776512] hub 2-0:1.0: USB hub found
[    1.776535] hub 2-0:1.0: 1 port detected
[    1.777190] xhci_hcd 0000:c4:00.0: xHCI Host Controller
[    1.777194] xhci_hcd 0000:c4:00.0: new USB bus registered, assigned bus number 3
[    1.777595] xhci_hcd 0000:c4:00.0: hcc params 0x0128ffc5 hci version 0x120 quirks 0x0000000200000010
[    1.777890] xhci_hcd 0000:c4:00.0: xHCI Host Controller
[    1.777893] xhci_hcd 0000:c4:00.0: new USB bus registered, assigned bus number 4
[    1.777894] xhci_hcd 0000:c4:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    1.777919] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    1.777920] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.777921] usb usb3: Product: xHCI Host Controller
[    1.777922] usb usb3: Manufacturer: Linux 7.0.0-rc1-debug-00008-g8505bfb4e4ec xhci-hcd
[    1.777924] usb usb3: SerialNumber: 0000:c4:00.0
[    1.778038] hub 3-0:1.0: USB hub found
[    1.778060] hub 3-0:1.0: 5 ports detected
[    1.779560] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.779583] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    1.779584] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.779585] usb usb4: Product: xHCI Host Controller
[    1.779586] usb usb4: Manufacturer: Linux 7.0.0-rc1-debug-00008-g8505bfb4e4ec xhci-hcd
[    1.779587] usb usb4: SerialNumber: 0000:c4:00.0
[    1.779682] hub 4-0:1.0: USB hub found
[    1.779705] hub 4-0:1.0: 2 ports detected
[    1.780469] xhci_hcd 0000:c4:00.3: xHCI Host Controller
[    1.780472] xhci_hcd 0000:c4:00.3: new USB bus registered, assigned bus number 5
[    1.780852] xhci_hcd 0000:c4:00.3: hcc params 0x0118ffc5 hci version 0x120 quirks 0x0000000200000010
[    1.781227] xhci_hcd 0000:c4:00.3: xHCI Host Controller
[    1.781229] xhci_hcd 0000:c4:00.3: new USB bus registered, assigned bus number 6
[    1.781230] xhci_hcd 0000:c4:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    1.781255] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    1.781257] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.781258] usb usb5: Product: xHCI Host Controller
[    1.781259] usb usb5: Manufacturer: Linux 7.0.0-rc1-debug-00008-g8505bfb4e4ec xhci-hcd
[    1.781260] usb usb5: SerialNumber: 0000:c4:00.3
[    1.781415] hub 5-0:1.0: USB hub found
[    1.781439] hub 5-0:1.0: 1 port detected
[    1.782000] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.782013] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    1.782014] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.782015] usb usb6: Product: xHCI Host Controller
[    1.782016] usb usb6: Manufacturer: Linux 7.0.0-rc1-debug-00008-g8505bfb4e4ec xhci-hcd
[    1.782017] usb usb6: SerialNumber: 0000:c4:00.3
[    1.782126] hub 6-0:1.0: USB hub found
[    1.782148] hub 6-0:1.0: 1 port detected
[    1.782906] xhci_hcd 0000:c4:00.4: xHCI Host Controller
[    1.782909] xhci_hcd 0000:c4:00.4: new USB bus registered, assigned bus number 7
[    1.783286] xhci_hcd 0000:c4:00.4: hcc params 0x0118ffc5 hci version 0x120 quirks 0x0000000200000010
[    1.783638] xhci_hcd 0000:c4:00.4: xHCI Host Controller
[    1.783640] xhci_hcd 0000:c4:00.4: new USB bus registered, assigned bus number 8
[    1.783642] xhci_hcd 0000:c4:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    1.783666] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.00
[    1.783667] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.783668] usb usb7: Product: xHCI Host Controller
[    1.783669] usb usb7: Manufacturer: Linux 7.0.0-rc1-debug-00008-g8505bfb4e4ec xhci-hcd
[    1.783670] usb usb7: SerialNumber: 0000:c4:00.4
[    1.783777] hub 7-0:1.0: USB hub found
[    1.783799] hub 7-0:1.0: 1 port detected
[    1.784351] usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.784365] usb usb8: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.00
[    1.784366] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.784367] usb usb8: Product: xHCI Host Controller
[    1.784368] usb usb8: Manufacturer: Linux 7.0.0-rc1-debug-00008-g8505bfb4e4ec xhci-hcd
[    1.784369] usb usb8: SerialNumber: 0000:c4:00.4
[    1.784485] hub 8-0:1.0: USB hub found
[    1.784508] hub 8-0:1.0: 1 port detected
[    1.785218] usbcore: registered new interface driver usbserial_generic
[    1.785223] usbserial: USB Serial support registered for generic
[    1.785251] i8042: PNP: No PS/2 controller found.
[    1.785252] i8042: Probing ports directly.
[    2.360644] i8042: Can't read CTR while initializing i8042
[    2.360652] fbcon: Taking over console
[    2.360658] i8042 i8042: probe with driver i8042 failed with error -5
[    2.361110] rtc_cmos 00:00: RTC can wake from S4
[    2.361446] rtc_cmos 00:00: registered as rtc0
[    2.361483] rtc_cmos 00:00: setting system clock to 2026-03-10T00:22:12 UTC (1773102132)
[    2.361522] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
[    2.361612] amd_pstate: Failed to initialize CPU 0: -14
[    2.361665] amd_pstate: Failed to initialize CPU 1: -14
[    2.361693] amd_pstate: Failed to initialize CPU 2: -14
[    2.361724] amd_pstate: Failed to initialize CPU 3: -14
[    2.361782] amd_pstate: Failed to initialize CPU 4: -14
[    2.361834] amd_pstate: Failed to initialize CPU 5: -14
[    2.361884] amd_pstate: Failed to initialize CPU 6: -14
[    2.361938] amd_pstate: Failed to initialize CPU 7: -14
[    2.362010] amd_pstate: Failed to initialize CPU 8: -14
[    2.362085] amd_pstate: Failed to initialize CPU 9: -14
[    2.362155] amd_pstate: Failed to initialize CPU 10: -14
[    2.362229] amd_pstate: Failed to initialize CPU 11: -14
[    2.362304] amd_pstate: Failed to initialize CPU 12: -14
[    2.362377] amd_pstate: Failed to initialize CPU 13: -14
[    2.362445] amd_pstate: Failed to initialize CPU 14: -14
[    2.362512] amd_pstate: Failed to initialize CPU 15: -14
[    2.362526] amd_pstate: Failed to initialize CPU 16: -14
[    2.362570] amd_pstate: Failed to initialize CPU 17: -14
[    2.362612] amd_pstate: Failed to initialize CPU 18: -14
[    2.362651] amd_pstate: Failed to initialize CPU 19: -14
[    2.362698] amd_pstate: Failed to initialize CPU 20: -14
[    2.362749] amd_pstate: Failed to initialize CPU 21: -14
[    2.362798] amd_pstate: Failed to initialize CPU 22: -14
[    2.362847] amd_pstate: Failed to initialize CPU 23: -14
[    2.362922] amd_pstate: Failed to initialize CPU 24: -14
[    2.362992] amd_pstate: Failed to initialize CPU 25: -14
[    2.363070] amd_pstate: Failed to initialize CPU 26: -14
[    2.363137] amd_pstate: Failed to initialize CPU 27: -14
[    2.363208] amd_pstate: Failed to initialize CPU 28: -14
[    2.363273] amd_pstate: Failed to initialize CPU 29: -14
[    2.363338] amd_pstate: Failed to initialize CPU 30: -14
[    2.363403] amd_pstate: Failed to initialize CPU 31: -14
[    2.363413] amd_pstate: failed to register with return -19
[    2.363625] hid: raw HID events driver (C) Jiri Kosina
[    2.363647] usbcore: registered new interface driver usbhid
[    2.363648] usbhid: USB HID core driver
[    2.363717] drop_monitor: Initializing network drop monitor service
[    2.363879] NET: Registered PF_INET6 protocol family
[    2.364205] Segment Routing with IPv6
[    2.364207] RPL Segment Routing with IPv6
[    2.364213] In-situ OAM (IOAM) with IPv6
[    2.364238] NET: Registered PF_PACKET protocol family
[    2.367145] x86/amd: Previous system reset reason [0x00080800]: software wrote 0x6 to reset control register 0xCF9
[    2.367159] microcode: Current revision: 0x0b700037
[    2.367161] microcode: Updated early from: 0x0b700032
[    2.368628] resctrl: L3 allocation detected
[    2.368630] resctrl: MB allocation detected
[    2.368631] resctrl: SMBA allocation detected
[    2.368632] resctrl: L3 monitoring detected
[    2.368660] IPI shorthand broadcast: enabled
[    2.370504] sched_clock: Marking stable (2368000852, 1849416)->(2377964086, -8113818)
[    2.370909] registered taskstats version 1
[    2.372058] Loading compiled-in X.509 certificates
[    2.378290] Loaded X.509 cert 'Build time autogenerated kernel key: ff11ae334d22158381c9df0110a92f6ccd1a6158'
[    2.380178] Demotion targets for Node 0: null
[    2.380388] Key type .fscrypt registered
[    2.380390] Key type fscrypt-provisioning registered
[    2.380650] Btrfs loaded, zoned=yes, fsverity=yes
[    2.380686] Key type big_key registered
[    2.385647] integrity: Loading X.509 certificate: UEFI:db
[    2.385671] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    2.385672] integrity: Loading X.509 certificate: UEFI:db
[    2.385684] integrity: Loaded X.509 cert 'Microsoft Corporation: Windows UEFI CA 2023: aefc5fbbbe055d8f8daa585473499417ab5a5272'
[    2.385685] integrity: Loading X.509 certificate: UEFI:db
[    2.385697] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    2.385698] integrity: Loading X.509 certificate: UEFI:db
[    2.385707] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023: 81aa6b3244c935bce0d6628af39827421e32497d'
[    2.385708] integrity: Loading X.509 certificate: UEFI:db
[    2.385716] integrity: Loaded X.509 cert 'Microsoft Option ROM UEFI CA 2023: 514fbf937fa46fb57bf07af8bed84b3b864b1711'
[    2.385717] integrity: Loading X.509 certificate: UEFI:db
[    2.385724] integrity: Loaded X.509 cert 'frame.work-LaptopDB: b9b0a774d4c4017582a0ee01b43205f970aec47c'
[    2.391765] PM:   Magic number: 2:551:354
[    2.391773] machinecheck machinecheck10: hash matches
[    2.391777] input event0: hash matches
[    2.391839] platform USBC000:00: hash matches
[    2.391856] acpi USBC000:00: hash matches
[    2.391883] acpi ACPI0007:12: hash matches
[    2.391999] RAS: Correctable Errors collector initialized.
[    2.392968] clk: Disabling unused clocks
[    2.392971] PM: genpd: Disabling unused power domains
[    2.394173] Freeing unused decrypted memory: 2028K
[    2.394765] Freeing unused kernel image (initmem) memory: 4648K
[    2.394782] Write protecting the kernel read-only data: 36864k
[    2.395146] Freeing unused kernel image (text/rodata gap) memory: 864K
[    2.395361] Freeing unused kernel image (rodata/data gap) memory: 1028K
[    2.441453] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.441459] rodata_test: all tests were successful
[    2.441464] Run /init as init process
[    2.441466]   with arguments:
[    2.441467]     /init
[    2.441468]   with environment:
[    2.441468]     HOME=/
[    2.441469]     TERM=linux
[    2.576881] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    2.577429] usb 4-2: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
[    2.594027] usb 4-2: New USB device found, idVendor=05e3, idProduct=0625, bcdDevice=10.01
[    2.594033] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.594035] usb 4-2: Product: USB3.2 Hub
[    2.594036] usb 4-2: Manufacturer: GenesysLogic
[    2.619245] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    2.619682] input: Video Bus as /devices/pci0000:00/0000:00:08.1/LNXVIDEO:00/input/input1
[    2.622035] Key type psk registered
[    2.626482] hub 4-2:1.0: USB hub found
[    2.626809] hub 4-2:1.0: 2 ports detected
[    2.651435] ACPI: bus type drm_connector registered
[    2.651452] Unsupported value for CONFIG_DRM_PANIC_SCREEN ('qr_code'), falling back to 'user'...
[    2.657348] nvme 0000:c1:00.0: platform quirk: setting simple suspend
[    2.657456] nvme nvme0: pci function 0000:c1:00.0
[    2.677264] nvme nvme0: 32/0/0 default/read/poll queues
[    2.681095]  nvme0n1: p1 p2
[    2.701890] usb 3-2: new high-speed USB device number 2 using xhci_hcd
[    2.707526] usb 1-1: New USB device found, idVendor=0bda, idProduct=5424, bcdDevice= 1.88
[    2.707529] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.707531] usb 1-1: Product: 2-Port USB 2.0 Hub
[    2.707533] usb 1-1: Manufacturer: Generic
[    2.768176] hub 1-1:1.0: USB hub found
[    2.768628] hub 1-1:1.0: 2 ports detected
[    2.832049] usb 2-1: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
[    2.845932] usb 2-1: New USB device found, idVendor=0bda, idProduct=0424, bcdDevice= 1.88
[    2.845936] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.845938] usb 2-1: Product: 2-Port USB 3.0 Hub
[    2.845940] usb 2-1: Manufacturer: Generic
[    2.848948] usb 3-2: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice=10.01
[    2.848954] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.848955] usb 3-2: Product: USB2.1 Hub
[    2.848957] usb 3-2: Manufacturer: GenesysLogic
[    2.864729] hub 2-1:1.0: USB hub found
[    2.865027] hub 2-1:1.0: 2 ports detected
[    2.898998] hub 3-2:1.0: USB hub found
[    2.899718] hub 3-2:1.0: 2 ports detected
[    3.077885] usb 3-3: new high-speed USB device number 3 using xhci_hcd
[    3.205714] usb 3-3: New USB device found, idVendor=0e8d, idProduct=0717, bcdDevice= 1.00
[    3.205718] usb 3-3: New USB device strings: Mfr=5, Product=6, SerialNumber=7
[    3.205720] usb 3-3: Product: Wireless_Device
[    3.205721] usb 3-3: Manufacturer: MediaTek Inc.
[    3.205722] usb 3-3: SerialNumber: 000000000
[    3.513865] usb 1-1.1: new high-speed USB device number 3 using xhci_hcd
[    3.606001] usb 1-1.1: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice= 6.63
[    3.606005] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.606007] usb 1-1.1: Product: USB2.1 Hub
[    3.606008] usb 1-1.1: Manufacturer: GenesysLogic
[    3.664223] hub 1-1.1:1.0: USB hub found
[    3.664753] hub 1-1.1:1.0: 4 ports detected
[    3.666077] usb 2-1.1: new SuperSpeed USB device number 3 using xhci_hcd
[    3.684665] usb 2-1.1: New USB device found, idVendor=05e3, idProduct=0626, bcdDevice= 6.63
[    3.684666] usb 2-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.684667] usb 2-1.1: Product: USB3.1 Hub
[    3.684667] usb 2-1.1: Manufacturer: GenesysLogic
[    3.712733] hub 2-1.1:1.0: USB hub found
[    3.713589] hub 2-1.1:1.0: 4 ports detected
[    3.755871] usb 1-1.2: new high-speed USB device number 4 using xhci_hcd
[    3.846000] usb 1-1.2: New USB device found, idVendor=38eb, idProduct=0002, bcdDevice= 1.00
[    3.846005] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.846007] usb 1-1.2: Product: Glinet Composite Device
[    3.846008] usb 1-1.2: Manufacturer: Glinet
[    3.846009] usb 1-1.2: SerialNumber: CAFEBABE
[    3.956008] input: Glinet Glinet Composite Device as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.2/1-1.2:1.0/0003:38EB:0002.0001/input/input2
[    3.974882] usb 1-1.1.2: new full-speed USB device number 5 using xhci_hcd
[    4.029769] amdgpu: Virtual CRAT table created for CPU
[    4.029776] amdgpu: Topology: Add CPU node
[    4.029906] amdgpu 0000:c2:00.0: enabling device (0006 -> 0007)
[    4.029948] amdgpu 0000:c2:00.0: initializing kernel modesetting (IP DISCOVERY 0x1002:0x1586 0xF111:0x000A 0xC1).
[    4.029974] amdgpu 0000:c2:00.0: register mmio base: 0xB0400000
[    4.029974] amdgpu 0000:c2:00.0: register mmio size: 1048576
[    4.032940] amdgpu 0000:c2:00.0: detected ip block number 0 <common_v1_0_0> (soc21_common)
[    4.032942] amdgpu 0000:c2:00.0: detected ip block number 1 <gmc_v11_0_0> (gmc_v11_0)
[    4.032943] amdgpu 0000:c2:00.0: detected ip block number 2 <ih_v6_0_0> (ih_v6_1)
[    4.032944] amdgpu 0000:c2:00.0: detected ip block number 3 <psp_v13_0_0> (psp)
[    4.032944] amdgpu 0000:c2:00.0: detected ip block number 4 <smu_v14_0_0> (smu)
[    4.032945] amdgpu 0000:c2:00.0: detected ip block number 5 <dce_v1_0_0> (dm)
[    4.032946] amdgpu 0000:c2:00.0: detected ip block number 6 <gfx_v11_0_0> (gfx_v11_0)
[    4.032947] amdgpu 0000:c2:00.0: detected ip block number 7 <sdma_v6_0_0> (sdma_v6_0)
[    4.032948] amdgpu 0000:c2:00.0: detected ip block number 8 <vcn_v4_0_5> (vcn_v4_0_5)
[    4.032948] amdgpu 0000:c2:00.0: detected ip block number 9 <jpeg_v4_0_5> (jpeg_v4_0_5)
[    4.032949] amdgpu 0000:c2:00.0: detected ip block number 10 <mes_v11_0_0> (mes_v11_0)
[    4.032950] amdgpu 0000:c2:00.0: detected ip block number 11 <vpe_v6_1_0> (vpe_v6_1)
[    4.032950] amdgpu 0000:c2:00.0: detected ip block number 12 <isp_v4_1_1> (isp_ip)
[    4.032968] amdgpu 0000:c2:00.0: Fetched VBIOS from VFCT
[    4.032969] amdgpu 0000:c2:00.0: [drm] ATOM BIOS: 113-STRXLGEN-001
[    4.036572] amdgpu 0000:c2:00.0: VPE: collaborate mode true
[    4.041282] amdgpu 0000:c2:00.0: Trusted Memory Zone (TMZ) feature disabled as experimental (default)
[    4.041318] amdgpu 0000:c2:00.0: vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    4.041338] amdgpu 0000:c2:00.0: VRAM: 512M 0x0000008000000000 - 0x000000801FFFFFFF (512M used)
[    4.041339] amdgpu 0000:c2:00.0: GART: 512M 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[    4.041361] amdgpu 0000:c2:00.0: [drm] Detected VRAM RAM=512M, BAR=512M
[    4.041362] amdgpu 0000:c2:00.0: [drm] RAM width 256bits LPDDR5
[    4.041753] amdgpu 0000:c2:00.0:  512M of VRAM memory ready
[    4.041755] amdgpu 0000:c2:00.0:  31787M of GTT memory ready.
[    4.041767] amdgpu 0000:c2:00.0: [drm] GART: num cpu pages 131072, num gpu pages 131072
[    4.042426] amdgpu 0000:c2:00.0: [drm] PCIE GART of 512M enabled (table at 0x0000008000F00000).
[    4.042809] amdgpu 0000:c2:00.0: [drm] Loading DMUB firmware via PSP: version=0x09003D00
[    4.043177] amdgpu 0000:c2:00.0: [VCN instance 0] Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 27
[    4.043217] amdgpu 0000:c2:00.0: [VCN instance 1] Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 27
[    4.043327] amdgpu 0000:c2:00.0: MES: vmid_mask_mmhub 0x0000ff00, vmid_mask_gfxhub 0x0000ff00
[    4.043328] amdgpu 0000:c2:00.0: MES: gfx_hqd_mask 0x00000002, compute_hqd_mask 0x0000000c, sdma_hqd_mask 0x000000fc
[    4.056276] hid-generic 0003:38EB:0002.0001: input,hidraw0: USB HID v1.01 Keyboard [Glinet Glinet Composite Device] on usb-0000:c2:00.4-1.2/input0
[    4.059010] input: Glinet Glinet Composite Device as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.2/1-1.2:1.1/0003:38EB:0002.0002/input/input3
[    4.059139] hid-generic 0003:38EB:0002.0002: input,hidraw1: USB HID v1.01 Mouse [Glinet Glinet Composite Device] on usb-0000:c2:00.4-1.2/input1
[    4.061741] input: Glinet Glinet Composite Device as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.2/1-1.2:1.2/0003:38EB:0002.0003/input/input4
[    4.061818] hid-generic 0003:38EB:0002.0003: input,hidraw2: USB HID v1.01 Mouse [Glinet Glinet Composite Device] on usb-0000:c2:00.4-1.2/input2
[    4.066845] amdgpu 0000:c2:00.0: reserve 0x8c00000 from 0x8010000000 for PSP TMR
[    4.095389] usb 1-1.1.2: New USB device found, idVendor=1532, idProduct=011b, bcdDevice= 2.00
[    4.095395] usb 1-1.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.095398] usb 1-1.1.2: Product: Razer BlackWidow
[    4.095400] usb 1-1.1.2: Manufacturer: Razer
[    4.213834] input: Razer Razer BlackWidow as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003:1532:011B.0004/input/input5
[    4.294303] hid-generic 0003:1532:011B.0004: input,hidraw3: USB HID v1.11 Keyboard [Razer Razer BlackWidow] on usb-0000:c2:00.4-1.1.2/input0
[    4.298900] input: Razer Razer BlackWidow Keyboard as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.1/0003:1532:011B.0005/input/input6
[    4.350009] input: Razer Razer BlackWidow as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.1/0003:1532:011B.0005/input/input7
[    4.350164] hid-generic 0003:1532:011B.0005: input,hidraw4: USB HID v1.11 Keyboard [Razer Razer BlackWidow] on usb-0000:c2:00.4-1.1.2/input1
[    4.354509] input: Razer Razer BlackWidow as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.2/0003:1532:011B.0006/input/input8
[    4.354694] hid-generic 0003:1532:011B.0006: input,hidraw5: USB HID v1.11 Mouse [Razer Razer BlackWidow] on usb-0000:c2:00.4-1.1.2/input2
[    4.422903] input: Razer Razer BlackWidow as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003:1532:011B.0004/input/input9
[    4.443869] usb 1-1.1.3: new full-speed USB device number 6 using xhci_hcd
[    4.496308] razer 0003:1532:011B.0004: input,hidraw3: USB HID v1.11 Keyboard [Razer Razer BlackWidow] on usb-0000:c2:00.4-1.1.2/input0
[    4.528206] input: Razer Razer BlackWidow as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.1/0003:1532:011B.0005/input/input10
[    4.563740] usb 1-1.1.3: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=12.11
[    4.563744] usb 1-1.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.563746] usb 1-1.1.3: Product: USB Receiver
[    4.563748] usb 1-1.1.3: Manufacturer: Logitech
[    4.579294] razer 0003:1532:011B.0005: input,hidraw4: USB HID v1.11 Keyboard [Razer Razer BlackWidow] on usb-0000:c2:00.4-1.1.2/input1
[    4.590690] input: Razer Razer BlackWidow as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.2/0003:1532:011B.0006/input/input11
[    4.590846] razer 0003:1532:011B.0006: input,hidraw5: USB HID v1.11 Mouse [Razer Razer BlackWidow] on usb-0000:c2:00.4-1.1.2/input2
[    4.650357] amdgpu 0000:c2:00.0: RAS: optional ras ta ucode is not available
[    4.654256] amdgpu 0000:c2:00.0: RAP: optional rap ta ucode is not available
[    4.654257] amdgpu 0000:c2:00.0: SECUREDISPLAY: optional securedisplay ta ucode is not available
[    4.685481] amdgpu 0000:c2:00.0: SMU is initialized successfully!
[    4.686733] amdgpu 0000:c2:00.0: [drm] Display Core v3.2.369 initialized on DCN 3.5.1
[    4.686734] amdgpu 0000:c2:00.0: [drm] DP-HDMI FRL PCON supported
[    4.689640] amdgpu 0000:c2:00.0: [drm] DMUB hardware initialized: version=0x09003D00
[    4.694607] amdgpu 0000:c2:00.0: [drm] DP-1: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.696540] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.0/0003:046D:C52B.0007/input/input12
[    4.723399] amdgpu 0000:c2:00.0: [drm] HDMI-A-1: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.723444] amdgpu 0000:c2:00.0: [drm] DP-2: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.723482] amdgpu 0000:c2:00.0: [drm] DP-3: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.771248] hid-generic 0003:046D:C52B.0007: input,hidraw6: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:c2:00.4-1.1.3/input0
[    4.775816] input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.1/0003:046D:C52B.0008/input/input13
[    4.776184] input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.1/0003:046D:C52B.0008/input/input14
[    4.827236] input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.1/0003:046D:C52B.0008/input/input15
[    4.827463] hid-generic 0003:046D:C52B.0008: input,hiddev96,hidraw7: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:c2:00.4-1.1.3/input1
[    4.830695] hid-generic 0003:046D:C52B.0009: hiddev97,hidraw8: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:c2:00.4-1.1.3/input2
[    4.830788] usb-storage 1-1.2:1.3: USB Mass Storage device detected
[    4.831073] scsi host0: usb-storage 1-1.2:1.3
[    4.831249] usb-storage 1-1.2:1.4: USB Mass Storage device detected
[    4.831352] scsi host1: usb-storage 1-1.2:1.4
[    4.831388] usbcore: registered new interface driver usb-storage
[    4.833492] usbcore: registered new interface driver uas
[    4.945094] logitech-djreceiver 0003:046D:C52B.0009: hiddev96,hidraw6: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:c2:00.4-1.1.3/input2
[    5.051833] input: Logitech Wireless Device PID:4096 Mouse as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.2/0003:046D:C52B.0009/0003:046D:4096.000A/input/input17
[    5.051978] hid-generic 0003:046D:4096.000A: input,hidraw7: USB HID v1.11 Mouse [Logitech Wireless Device PID:4096] on usb-0000:c2:00.4-1.1.3/input2:1
[    5.071616] input: Logitech ERGO M575 as /devices/pci0000:00/0000:00:08.1/0000:c2:00.4/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.2/0003:046D:C52B.0009/0003:046D:4096.000A/input/input21
[    5.071672] logitech-hidpp-device 0003:046D:4096.000A: input,hidraw7: USB HID v1.11 Mouse [Logitech ERGO M575] on usb-0000:c2:00.4-1.1.3/input2:1
[    5.849412] scsi 0:0:0:0: CD-ROM            Glinet   Optical Drive    1.00 PQ: 0 ANSI: 2
[    5.849417] scsi 1:0:0:0: Direct-Access     Glinet   Flash Drive      1.00 PQ: 0 ANSI: 2
[    5.849797] sd 1:0:0:0: Power-on or device reset occurred
[    5.850015] sd 1:0:0:0: [sda] Media removed, stopped polling
[    5.859920] sd 1:0:0:0: [sda] Attached SCSI removable disk
[    5.864759] sr 0:0:0:0: Power-on or device reset occurred
[    5.865760] sr 0:0:0:0: [sr0] scsi-1 drive
[    5.865765] cdrom: Uniform CD-ROM driver Revision: 3.20
[    5.875915] sr 0:0:0:0: Attached scsi CD-ROM sr0
[    6.219955] amdgpu 0000:c2:00.0: [drm] DP-5: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    6.220007] amdgpu 0000:c2:00.0: [drm] DP-6: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    6.220058] amdgpu 0000:c2:00.0: [drm] DP-7: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    6.220108] amdgpu 0000:c2:00.0: [drm] DP-8: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    6.229041] kfd kfd: Allocated 3969056 bytes on gart
[    6.229060] kfd kfd: Total number of KFD nodes to be created: 1
[    6.229472] amdgpu: Virtual CRAT table created for GPU
[    6.229670] amdgpu: Topology: Add GPU node [0x1002:0x1586]
[    6.229672] kfd kfd: added device 1002:1586
[    6.229684] amdgpu 0000:c2:00.0: SE 2, SH per SE 2, CU per SH 10, active_cu_number 40
[    6.229689] amdgpu 0000:c2:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[    6.229691] amdgpu 0000:c2:00.0: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    6.229692] amdgpu 0000:c2:00.0: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    6.229693] amdgpu 0000:c2:00.0: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[    6.229694] amdgpu 0000:c2:00.0: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[    6.229695] amdgpu 0000:c2:00.0: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[    6.229696] amdgpu 0000:c2:00.0: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[    6.229697] amdgpu 0000:c2:00.0: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[    6.229698] amdgpu 0000:c2:00.0: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[    6.229698] amdgpu 0000:c2:00.0: ring sdma0 uses VM inv eng 12 on hub 0
[    6.229699] amdgpu 0000:c2:00.0: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[    6.229700] amdgpu 0000:c2:00.0: ring vcn_unified_1 uses VM inv eng 1 on hub 8
[    6.229701] amdgpu 0000:c2:00.0: ring jpeg_dec_0 uses VM inv eng 4 on hub 8
[    6.229702] amdgpu 0000:c2:00.0: ring jpeg_dec_1 uses VM inv eng 6 on hub 8
[    6.229703] amdgpu 0000:c2:00.0: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
[    6.229704] amdgpu 0000:c2:00.0: ring vpe uses VM inv eng 7 on hub 8
[    6.231600] amdgpu 0000:c2:00.0: Runtime PM not available
[    6.232605] amdgpu 0000:c2:00.0: [drm] Registered 4 planes with drm panic
[    6.246855] [drm] Initialized amdgpu 3.64.0 for 0000:c2:00.0 on minor 0
[    6.250083] amdgpu 0000:c2:00.0: [drm] Failed to setup vendor infoframe on connector HDMI-A-1: -22
[    6.252933] fbcon: amdgpudrmfb (fb0) is primary device
[    6.253186] [drm] pre_validate_dsc:1667 MST_DSC dsc precompute is not needed
[    6.913044] amdgpu 0000:c2:00.0: [drm] REG_WAIT timeout 1us * 100000 tries - optc35_disable_crtc line:162
[    7.424007] amdgpu 0000:c2:00.0: [drm] REG_WAIT timeout 1us * 100000 tries - optc35_disable_crtc line:165
[    7.474369] Console: switching to colour frame buffer device 160x45
[    7.511738] amdgpu 0000:c2:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    7.552938] BTRFS: device fsid 7293a5c6-dc73-4666-8b70-c7f343e87fb2 devid 1 transid 125516 /dev/nvme0n1p2 (259:2) scanned by mount (514)
[    7.553277] BTRFS info (device nvme0n1p2): first mount of filesystem 7293a5c6-dc73-4666-8b70-c7f343e87fb2
[    7.553281] BTRFS info (device nvme0n1p2): using crc32c checksum algorithm
[    7.580839] BTRFS info (device nvme0n1p2): enabling ssd optimizations
[    7.580842] BTRFS info (device nvme0n1p2): turning on async discard
[    7.580844] BTRFS info (device nvme0n1p2): enabling free space tree
[    7.651432] systemd[1]: systemd 259.3-1-arch running in system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    7.651442] systemd[1]: Detected architecture x86-64.
[    7.652278] systemd[1]: Hostname set to <framework-amd-ryzen-maxplus-395>.
[    7.729443] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    7.850409] zram: Added device: zram0
[    7.931134] systemd[1]: Queued start job for default target Graphical Interface.
[    7.953436] systemd[1]: Created slice Virtual Machine and Container Slice.
[    7.954317] systemd[1]: Created slice Slice /system/dirmngr.
[    7.954642] systemd[1]: Created slice Slice /system/getty.
[    7.954949] systemd[1]: Created slice Slice /system/gpg-agent.
[    7.955258] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    7.955554] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    7.956037] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    7.956357] systemd[1]: Created slice Slice /system/keyboxd.
[    7.956661] systemd[1]: Created slice Slice /system/modprobe.
[    7.956973] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    7.957268] systemd[1]: Created slice User and Session Slice.
[    7.957350] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    7.957411] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    7.957615] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    7.957677] systemd[1]: Expecting device /dev/disk/by-uuid/7293a5c6-dc73-4666-8b70-c7f343e87fb2...
[    7.957721] systemd[1]: Expecting device /dev/disk/by-uuid/C0F2-BB08...
[    7.957757] systemd[1]: Expecting device /dev/zram0...
[    7.957792] systemd[1]: Reached target Local Encrypted Volumes.
[    7.957833] systemd[1]: Reached target Login Prompts.
[    7.957872] systemd[1]: Reached target Image Downloads.
[    7.957905] systemd[1]: Reached target Local Integrity Protected Volumes.
[    7.957956] systemd[1]: Reached target Preparation for Network.
[    7.957994] systemd[1]: Reached target Path Units.
[    7.958031] systemd[1]: Reached target Remote File Systems.
[    7.958546] systemd[1]: Reached target Slice Units.
[    7.958601] systemd[1]: Reached target Local Verity Protected Volumes.
[    7.958714] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.959660] systemd[1]: Listening on Query the User Interactively for a Password.
[    7.960772] systemd[1]: Listening on Process Core Dump Socket.
[    7.961401] systemd[1]: Listening on Credential Encryption/Decryption.
[    7.962689] systemd[1]: Listening on Factory Reset Management.
[    7.963162] systemd[1]: Listening on Journal Socket (/dev/log).
[    7.963604] systemd[1]: Listening on Journal Sockets.
[    7.964821] systemd[1]: Listening on Console Output Muting Service Socket.
[    7.965329] systemd[1]: TPM PCR Measurements skipped, unmet condition check ConditionSecurity=measured-uki
[    7.965344] systemd[1]: Make TPM PCR Policy skipped, unmet condition check ConditionSecurity=measured-uki
[    7.965952] systemd[1]: Listening on Disk Repartitioning Service Socket.
[    7.966381] systemd[1]: Listening on udev Control Socket.
[    7.966783] systemd[1]: Listening on udev Kernel Socket.
[    7.967200] systemd[1]: Listening on udev Varlink Socket.
[    7.967606] systemd[1]: Listening on User Database Manager Socket.
[    7.969467] systemd[1]: Mounting Huge Pages File System...
[    7.970511] systemd[1]: Mounting POSIX Message Queue File System...
[    7.971585] systemd[1]: Mounting Kernel Debug File System...
[    7.972541] systemd[1]: Mounting Kernel Trace File System...
[    7.981079] systemd[1]: Starting Create List of Static Device Nodes...
[    7.981516] systemd[1]: Load Kernel Module configfs skipped, unmet condition check ConditionKernelModuleLoaded=!configfs
[    7.982388] systemd[1]: Mounting Kernel Configuration File System...
[    7.983693] systemd[1]: Starting Load Kernel Module dm_mod...
[    7.984149] systemd[1]: Load Kernel Module drm skipped, unmet condition check ConditionKernelModuleLoaded=!drm
[    7.984183] systemd[1]: Load Kernel Module fuse skipped, unmet condition check ConditionKernelModuleLoaded=!fuse
[    7.985038] systemd[1]: Mounting FUSE Control File System...
[    7.986498] systemd[1]: Starting Load Kernel Module loop...
[    7.987685] systemd[1]: Starting Load Kernel Module tun...
[    7.988113] systemd[1]: Clear Stale Hibernate Storage Info skipped, unmet condition check ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67
[    7.989623] systemd[1]: Starting Journal Service...
[    7.991044] systemd[1]: Starting Load Kernel Modules...
[    7.991535] systemd[1]: TPM PCR Machine ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
[    7.991576] systemd[1]: TPM NvPCR Product ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
[    7.992201] systemd[1]: Starting Remount Root and Kernel File Systems...
[    7.992633] systemd[1]: Early TPM SRK Setup skipped, unmet condition check ConditionSecurity=measured-uki
[    7.993293] systemd[1]: Starting Load udev Rules from Credentials...
[    7.994228] systemd[1]: Starting Coldplug All udev Devices...
[    7.997194] systemd[1]: Mounted Huge Pages File System.
[    7.997656] loop: module loaded
[    7.997819] systemd[1]: Mounted POSIX Message Queue File System.
[    7.998293] systemd[1]: Mounted Kernel Debug File System.
[    7.998767] systemd[1]: Mounted Kernel Trace File System.
[    7.999359] systemd[1]: Finished Create List of Static Device Nodes.
[    8.001233] tun: Universal TUN/TAP device driver, 1.6
[    8.001237] systemd[1]: Mounted Kernel Configuration File System.
[    8.001299] device-mapper: uevent: version 1.0.3
[    8.001413] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    8.001718] systemd[1]: Mounted FUSE Control File System.
[    8.002239] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[    8.002386] systemd[1]: Finished Load Kernel Module dm_mod.
[    8.002904] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    8.003021] systemd[1]: Finished Load Kernel Module loop.
[    8.003584] systemd[1]: modprobe@tun.service: Deactivated successfully.
[    8.003718] systemd[1]: Finished Load Kernel Module tun.
[    8.003912] Asymmetric key parser 'pkcs8' registered
[    8.020258] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    8.021034] systemd[1]: Finished Load Kernel Modules.
[    8.021652] systemd[1]: Finished Load udev Rules from Credentials.
[    8.023261] systemd[1]: Starting Apply Kernel Variables...
[    8.023471] systemd-journald[612]: Collecting audit messages is disabled.
[    8.031745] systemd[1]: Finished Apply Kernel Variables.
[    8.034488] systemd[1]: Starting User Database Manager...
[    8.091974] systemd[1]: Started Journal Service.
[    8.132411] BTRFS info (device nvme0n1p2 state M): use zstd compression, level 3
[    8.392158] zram0: detected capacity change from 0 to 8388608
[    8.401271] AMDI0020:00: ttyS4 at MMIO 0xfedc9000 (irq = 11, base_baud = 3000000) is a 16550A
[    8.402728] ACPI: bus type thunderbolt registered
[    8.409524] ccp 0000:c2:00.2: enabling device (0000 -> 0002)
[    8.409704] cros_ec_lpcs FRMWC004:00: loaded with quirks 00000001
[    8.413139] ccp 0000:c2:00.2: tee enabled
[    8.415144] ccp 0000:c2:00.2: psp enabled
[    8.416403] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    8.416408] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
[    8.422268] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    8.423796] i2c i2c-19: Successfully instantiated SPD at 0x50
[    8.425815] i2c i2c-19: Successfully instantiated SPD at 0x51
[    8.426792] i2c i2c-19: Successfully instantiated SPD at 0x52
[    8.428038] i2c i2c-19: Successfully instantiated SPD at 0x53
[    8.429361] i2c i2c-19: Successfully instantiated SPD at 0x54
[    8.429965] i2c i2c-19: Successfully instantiated SPD at 0x55
[    8.431467] i2c i2c-19: Successfully instantiated SPD at 0x56
[    8.432402] i2c i2c-19: Successfully instantiated SPD at 0x57
[    8.435578] cros_ec_lpcs FRMWC004:00: Chrome EC device registered
[    8.435691] amdxdna 0000:c3:00.1: enabling device (0000 -> 0002)
[    8.437182] input: PC Speaker as /devices/platform/pcspkr/input/input22
[    8.439276] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms ovfl timer
[    8.439282] RAPL PMU: hw unit of domain package 2^-16 Joules
[    8.439284] RAPL PMU: hw unit of domain core 2^-16 Joules
[    8.476023] r8169 0000:bf:00.0: enabling device (0000 -> 0003)
[    8.476172] mousedev: PS/2 mouse device common for all mice
[    8.476381] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    8.479288] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    8.479499] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    8.479711] faux_driver regulatory: Direct firmware load for regulatory.db failed with error -2
[    8.479717] cfg80211: failed to load regulatory.db
[    8.482671] r8169 0000:bf:00.0 eth0: RTL8126A, 9c:bf:0d:00:ed:6f, XID 64a, IRQ 153
[    8.482680] r8169 0000:bf:00.0 eth0: jumbo features [frames: 16362 bytes, tx checksumming: ko]
[    8.485309] Adding 4194300k swap on /dev/zram0.  Priority:100 extents:1 across:4194300k SSDsc
[    8.519477] Bluetooth: Core ver 2.22
[    8.519512] NET: Registered PF_BLUETOOTH protocol family
[    8.519513] Bluetooth: HCI device and connection manager initialized
[    8.519519] Bluetooth: HCI socket layer initialized
[    8.519522] Bluetooth: L2CAP socket layer initialized
[    8.519526] Bluetooth: SCO socket layer initialized
[    8.569111] [drm] Initialized amdxdna_accel_driver 0.6.0 for 0000:c3:00.1 on minor 0
[    8.600812] r8169 0000:bf:00.0 enp191s0: renamed from eth0
[    8.615483] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    8.622714] snd_hda_intel 0000:c2:00.1: enabling device (0000 -> 0002)
[    8.622784] snd_hda_intel 0000:c2:00.1: Handle vga_switcheroo audio client
[    8.622939] snd_hda_intel 0000:c2:00.6: enabling device (0000 -> 0002)
[    8.629970] kvm_amd: TSC scaling supported
[    8.629974] kvm_amd: Nested Virtualization enabled
[    8.629976] kvm_amd: Nested Paging enabled
[    8.629978] kvm_amd: LBR virtualization supported
[    8.629982] kvm_amd: AVIC enabled
[    8.629983] kvm_amd: x2AVIC enabled (max 512 vCPUs)
[    8.629984] kvm_amd: Virtual VMLOAD VMSAVE supported
[    8.629984] kvm_amd: Virtual GIF supported
[    8.629985] kvm_amd: Virtual NMI enabled
[    8.638273] usbcore: registered new interface driver btusb
[    8.639239] snd_hda_intel 0000:c2:00.1: bound 0000:c2:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    8.641047] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:c2:00.1/sound/card0/input23
[    8.641147] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:c2:00.1/sound/card0/input24
[    8.641207] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:c2:00.1/sound/card0/input25
[    8.641265] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:c2:00.1/sound/card0/input26
[    8.642317] Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260106153314
[    8.659064] mt7925e 0000:c0:00.0: ASIC revision: 79250000
[    8.677530] amd_atl: AMD Address Translation Library initialized
[    8.683962] snd_hda_codec_alc269 hdaudioC1D0: autoconfig for ALC623: line_outs=2 (0x21/0x14/0x0/0x0/0x0) type:hp
[    8.683968] snd_hda_codec_alc269 hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    8.683970] snd_hda_codec_alc269 hdaudioC1D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    8.683971] snd_hda_codec_alc269 hdaudioC1D0:    mono: mono_out=0x0
[    8.683972] snd_hda_codec_alc269 hdaudioC1D0:    inputs:
[    8.683973] snd_hda_codec_alc269 hdaudioC1D0:      Mic=0x19
[    8.710620] amd-pmf AMDI0105:00: No Smart PC policy present
[    8.710625] amd-pmf AMDI0105:00: registered PMF device successfully
[    8.723990] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:c2:00.6/sound/card1/input27
[    8.724040] input: HD-Audio Generic Headphone Front as /devices/pci0000:00/0000:00:08.1/0000:c2:00.6/sound/card1/input28
[    8.724096] input: HD-Audio Generic Front Headphone Surround as /devices/pci0000:00/0000:00:08.1/0000:c2:00.6/sound/card1/input29
[    8.734616] mt7925e 0000:c0:00.0: HW/SW Version: 0x8a108a10, Build Time: 20260106153007a
[    8.779194] intel_rapl_common: Found RAPL domain package
[    8.779197] intel_rapl_common: Found RAPL domain core
[    8.779262] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
[    8.779360] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[    9.012151] Bluetooth: hci0: Device setup in 365036 usecs
[    9.012165] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[    9.037332] FAT-fs (nvme0n1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[    9.040925] systemd-journald[612]: Received client request to flush runtime journal.
[    9.075054] mt7925e 0000:c0:00.0: WM Firmware Version: ____000000, Build Time: 20260106153120
[    9.097064] Bluetooth: hci0: AOSP extensions version v1.00
[    9.097066] Bluetooth: hci0: AOSP quality report is supported
[    9.510896] Realtek Internal NBASE-T PHY r8169-0-bf00:00: attached PHY driver (mii_bus:phy_addr=r8169-0-bf00:00, irq=MAC)
[    9.840291] r8169 0000:bf:00.0 enp191s0: Link is Down
[   13.218399] r8169 0000:bf:00.0 enp191s0: Link is Up - 2.5Gbps/Full - flow control off
[   13.451952] netfs: FS-Cache loaded
[   13.515893] RPC: Registered named UNIX socket transport module.
[   13.515897] RPC: Registered udp transport module.
[   13.515898] RPC: Registered tcp transport module.
[   13.515899] RPC: Registered tcp-with-tls transport module.
[   13.515899] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   13.600525] Key type dns_resolver registered
[   13.740878] NFS: Registering the id_resolver key type
[   13.740888] Key type id_resolver registered
[   13.740890] Key type id_legacy registered
[   21.928863] rfkill: input handler disabled
[   80.407492] pcieport 0000:00:08.1: PME: Spurious native interrupt!

--dlmdegZ76qxTp6Nd--
