Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9641EEA54;
	Tue, 10 Mar 2026 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773119111; cv=none; b=khLDBqMpzWlPg150z1U7SSGxqBRUZZ9Risi2eP7ikpuopg/NdSIhyMNhjIcnLk26ULzj/E2OVKW2DK7RHIDRuwa26pZIIU0jDQhluQBC95to/rtLN09gSTjHxHL093o18Ta1xz4XAOu7diHOaQeFJJadgyHRmhu5sf2zTuGWDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773119111; c=relaxed/simple;
	bh=mra5TptDRRJmxYMrApQ6i7Df1rPRGEL65tz1RpoHlJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CgiTf1YuuiPAhCNlOQDHvzYCmkL0FG1786NU0FwNhsqAorzpMRByixpYbbfQWbf12N0gGFsMiJMjLmWDrVFsEEUJ/cmi6Y6GTytoZ7Z1oVdqMMaTXl0W9vSRnPlJjnZo4ORVyKLM2MNngqLpW2+juEgbk4YWVPvuC1nvd329ghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=z7ghDMcJ; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="z7ghDMcJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5JySNzjmG8LkMOeV9uiL3YXSbA6n0WEZ/o9XWWZc4mc=;
	b=z7ghDMcJ09/viYTKhh40wSQUwljfNKHJ/LTx9/HEZUv7XqhMdBr27YAz7Kn6w643TX4ABzacZ
	Wqjt/1Qcgo+DlK8Lk3suLO+4EJUMU9hu2BhlEpGC2YwaPzMk6s2h0t15XUqQY4zK/U45BxJmPa7
	7crX1cxAgUuhYLQO5M5vtkk=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fVM9s4ltBz12LDR;
	Tue, 10 Mar 2026 12:59:29 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id C5DDC20104;
	Tue, 10 Mar 2026 13:05:05 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Mar
 2026 13:05:05 +0800
Message-ID: <70469192-ab9e-406a-999d-a72d0f2ce0fe@huawei.com>
Date: Tue, 10 Mar 2026 13:05:04 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: CPPC: Move reference performance to capabilities
To: Nathan Chancellor <nathan@kernel.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <viresh.kumar@linaro.org>,
	<robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20260213100935.19111-1-zhangpengjie2@huawei.com>
 <20260310003026.GA2639793@ax162>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <20260310003026.GA2639793@ax162>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr200004.china.huawei.com (7.202.195.241)



Hi Nathan,

On 3/10/2026 8:30 AM, Nathan Chancellor wrote:
> Hi Pengjie,
>
> On Fri, Feb 13, 2026 at 06:09:35PM +0800, Pengjie Zhang wrote:
>> Currently, the `Reference Performance` register is read every time
>> the CPU frequency is sampled in `cppc_get_perf_ctrs()`. This function
>> is on the hot path of the cpufreq driver.
>>
>> Reference Performance indicates the performance level that corresponds
>> to the Reference Counter incrementing and is not expected to change
>> dynamically during runtime (unlike the Delivered and Reference counters).
>>
>> Reading this register in the hot path incurs unnecessary overhead,
>> particularly on platforms where CPC registers are located in the PCC
>> (Platform Communication Channel) subspace. This patch moves
>> `reference_perf` from the dynamic feedback counters structure
>> (`cppc_perf_fb_ctrs`) to the static capabilities structure
>> (`cppc_perf_caps`).
>>
>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> After this change landed in -next as commit 8505bfb4e4ec ("ACPI: CPPC:
> Move reference performance to capabilities"), I am seeing the following
> dmesg errors on one of my test machines.
>
>    Could not retrieve perf counters (-14)
>    amd_pstate: Failed to initialize CPU 0: -14
>    amd_pstate: Failed to initialize CPU 1: -14
>    amd_pstate: Failed to initialize CPU 2: -14
>    amd_pstate: Failed to initialize CPU 3: -14
>    amd_pstate: Failed to initialize CPU 4: -14
>    amd_pstate: Failed to initialize CPU 5: -14
>    amd_pstate: Failed to initialize CPU 6: -14
>    amd_pstate: Failed to initialize CPU 7: -14
>    amd_pstate: Failed to initialize CPU 8: -14
>    amd_pstate: Failed to initialize CPU 9: -14
>    amd_pstate: Failed to initialize CPU 10: -14
>    amd_pstate: Failed to initialize CPU 11: -14
>    amd_pstate: Failed to initialize CPU 12: -14
>    amd_pstate: Failed to initialize CPU 13: -14
>    amd_pstate: Failed to initialize CPU 14: -14
>    amd_pstate: Failed to initialize CPU 15: -14
>    amd_pstate: Failed to initialize CPU 16: -14
>    amd_pstate: Failed to initialize CPU 17: -14
>    amd_pstate: Failed to initialize CPU 18: -14
>    amd_pstate: Failed to initialize CPU 19: -14
>    amd_pstate: Failed to initialize CPU 20: -14
>    amd_pstate: Failed to initialize CPU 21: -14
>    amd_pstate: Failed to initialize CPU 22: -14
>    amd_pstate: Failed to initialize CPU 23: -14
>    amd_pstate: Failed to initialize CPU 24: -14
>    amd_pstate: Failed to initialize CPU 25: -14
>    amd_pstate: Failed to initialize CPU 26: -14
>    amd_pstate: Failed to initialize CPU 27: -14
>    amd_pstate: Failed to initialize CPU 28: -14
>    amd_pstate: Failed to initialize CPU 29: -14
>    amd_pstate: Failed to initialize CPU 30: -14
>    amd_pstate: Failed to initialize CPU 31: -14
>    amd_pstate: failed to register with return -19
>
> At the parent change, there are no errors from amd_pstate and I see
>
>    $ cat /sys/devices/system/cpu/amd_pstate/status
>    active
>
> in sysfs. Is this expected? If not, I am happy to provide any additional
> information and test patches. I have attached dmesg outputs from the
> good and bad revisions, in case they would be helpful for gathering
> information.
>
> Cheers,
> Nathan
Thanks for testing and reporting this! The error code -14 (-EFAULT)
you are seeing is exactly due to a logical flaw introduced in that commit
  when handling the local `ref` variable. On platforms that do not support
  the reference performance register, the code falls into the `else` branch
and correctly assigns `perf_caps->reference_perf = nom;`.
However, it forgets to update the local `ref` variable. Because `ref` 
remains
uninitialized (or 0), the subsequent sanity check
  `if (!high || !low || !nom || !ref || !min_nonlinear)`  fails and 
mistakenly returns
  `-EFAULT` (-14).  Could you please apply the following diff and see if 
it resolves
  the amd_pstate initialization failure on your test machine?

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 07bbf5b366a4..ac90c0c55c14 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1411,7 +1411,8 @@ int cppc_get_perf_caps(int cpunum, struct 
cppc_perf_caps *perf_caps)
                 cpc_read(cpunum, reference_reg, &ref);
                 perf_caps->reference_perf = ref;
         } else {
-               perf_caps->reference_perf = nom;
+               ref = nom;
+               perf_caps->reference_perf = ref;
         }

         if (guaranteed_reg->type != ACPI_TYPE_BUFFER  ||

---

Thanks, Pengjie


> # bad: [ea4134533224d500b2985d30cde106aa3680905d] Add linux-next specific files for 20260309
> # good: [1f318b96cc84d7c2ab792fcc0bfd42a7ca890681] Linux 7.0-rc3
> git bisect start 'ea4134533224d500b2985d30cde106aa3680905d' '1f318b96cc84d7c2ab792fcc0bfd42a7ca890681'
> # bad: [57a0c77d3b89916ae8a01266ed6773038daba7e6] Merge branch 'main' of https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect bad 57a0c77d3b89916ae8a01266ed6773038daba7e6
> # good: [2254ba55816e189211a37c14cf4022db826c17ba] Merge branch 'riscv-dt-for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git
> git bisect good 2254ba55816e189211a37c14cf4022db826c17ba
> # good: [57c49b297b6134e349418ad439895acb2b5fdd05] Merge branch 'i2c/for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
> git bisect good 57c49b297b6134e349418ad439895acb2b5fdd05
> # good: [8d282b680c729203d04d4eee396f3216f29b35aa] eth: fbnic: Fetch TX pause storm stats
> git bisect good 8d282b680c729203d04d4eee396f3216f29b35aa
> # bad: [397b4a14684942a64d32ca767816f42c8199bee0] Merge branch 'devfreq-next' of https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
> git bisect bad 397b4a14684942a64d32ca767816f42c8199bee0
> # good: [44f09a027369c62cf5dbe74ef359f41debbbce7c] Merge branch 'docs-next' of git://git.lwn.net/linux.git
> git bisect good 44f09a027369c62cf5dbe74ef359f41debbbce7c
> # bad: [ef5af3b0263db70168ad2d1be317d79568411ad4] Merge branches 'acpi-tad' and 'acpi-cppc' into linux-next
> git bisect bad ef5af3b0263db70168ad2d1be317d79568411ad4
> # good: [9c8e43e3ee8de15d29c2536540de53011e6760bb] Merge branch 'acpi-cmos-rtc' into linux-next
> git bisect good 9c8e43e3ee8de15d29c2536540de53011e6760bb
> # good: [da0f602a7202a65a6029c8e5c2e92a621a473f5b] Merge branch 'acpi-cppc' into linux-next
> git bisect good da0f602a7202a65a6029c8e5c2e92a621a473f5b
> # good: [76f9d5b4246705f45d254353cb55a7d598a87591] ACPI: TAD: Rearrange RT data validation checking
> git bisect good 76f9d5b4246705f45d254353cb55a7d598a87591
> # good: [2fc2d223e9809504089ab2cec334d82940e985d9] ACPI: TAD: Add RTC class device interface
> git bisect good 2fc2d223e9809504089ab2cec334d82940e985d9
> # good: [c30c96dc51e51cf77e2eea5ab1f26fc3177163b2] ACPI: TAD: Update the driver description comment
> git bisect good c30c96dc51e51cf77e2eea5ab1f26fc3177163b2
> # bad: [8505bfb4e4eca28ef1b20d3369435ec2d6a125c6] ACPI: CPPC: Move reference performance to capabilities
> git bisect bad 8505bfb4e4eca28ef1b20d3369435ec2d6a125c6
> # first bad commit: [8505bfb4e4eca28ef1b20d3369435ec2d6a125c6] ACPI: CPPC: Move reference performance to capabilities
