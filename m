Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4765A3D8100
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004510; cv=none; b=OUvVvxZ+DyymtgYkzOx2Oz/6dxmQte/3PHVo67F/aYiQt19eVZagm1Jd1Yqo36Nrb9iUCr7FyEH3cLGJ3HxwkR61HOs/lbh/gaPZko9TboB+j6EXZSYZGjJ2YLdP2JANmuTZrMq3w2ZdNZdwXqMHUUnhRkFnj9TzQH3a4N8Mtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004510; c=relaxed/simple;
	bh=4ns94LogX5OA2pP65C8E1PBfvQ7/rCEkhv9gb+l2PE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Li6+hcbX1RvmD1WVE4ufGmrSL9QUl+0Dv2xoOPD/v02pJu1/onq/88bVUaHz9YfFAu96mRaUE8QOXVjGRIK36iRX7mdFILmvinknq6crxnsNOj51/kTxqdsRimex+2A9PNSJQPRPKTVZ3mkUi2Ec8aJEVXtBNRlrmP8203fqy1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu0cIiDQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu0cIiDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F219D1F0089B
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790004509;
	bh=4ns94LogX5OA2pP65C8E1PBfvQ7/rCEkhv9gb+l2PE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fu0cIiDQD/YqTDk1JAy5zclqVsYW+2AjMfmGi0g4fmMhZsovzfkIUp/mfOa2PgMNR
	 g2oQwxBh8UFDVkFNNcONs2kKLkg2LAAqBaB2Ed+QwBSkoZrrMLhNZ51aBUv4MtUU4i
	 nsRb3doYkD2eNFLNHYZDB9vLdiNx+xkBhF1mV+7WdXGJgtewIZqdNIuOBf6ruZxUQD
	 vMb4ug3Sk2CTOFq1IRL19IJVZNWt8/HbNgCwLLg3clsBKEO2orufxth9zXFq57nqN1
	 UmUz26i+2SFaqoWVVxftYbTKufFW/BN08nnTiCPQJCQ85JibDVVdzDDqr8z56j04HN
	 KJqm7XTlQJtjA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a2015bbfceso23891811fa.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 08:28:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx+Km9i+wTuX72LR0ENT6sjs8hyXhuW9Cw3lE9XjDmzo5ZzVIW2NymBxbCKrTADqYLyuZAlbICeGQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lGAAN2I507FGSDtCfh+WtyxSVoyVrAGZHlNKg3+Wuy0eNBgHNC
	Kl7i6ZNGwUMDOu2XnHvst5iylOqWoGX2bVldc3KSTXg4Z4tHkExPK3KXwURxrG6U/g/NiuCFsF4
	c54eEwfucsK7Oa5qBMX46+zlKy2pRkXk=
X-Received: by 2002:a05:651c:a208:20b0:3a5:f142:af6e with SMTP id
 38308e7fff4ca-3a5f142b0a9mr21380951fa.21.1790004507202; Mon, 21 Sep 2026
 08:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <905771062.272724286.1789919301858.JavaMail.zimbra@trinity-net.com>
In-Reply-To: <905771062.272724286.1789919301858.JavaMail.zimbra@trinity-net.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 21 Sep 2026 17:26:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gg7kBtEhagR9SYKaPNstPC6aSyP7W4xBjP1r-kzbcH1A@mail.gmail.com>
X-Gm-Features: AcwNN1UxyJztudU9HEP_x1NXmMgrHZXRAKUGqrNcukJ4vaLpZv_8ujS2owei2hI
Message-ID: <CAJZ5v0gg7kBtEhagR9SYKaPNstPC6aSyP7W4xBjP1r-kzbcH1A@mail.gmail.com>
Subject: Re: [REGRESSION] ACPI processor/cpuidle change in 6.18.52 breaks
 bare-metal Xen dom0 boot
To: Support TRINITY <support@trinity-net.com>
Cc: regressions <regressions@lists.linux.dev>, linux-acpi <linux-acpi@vger.kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 5:48=E2=80=AFPM Support TRINITY <support@trinity-ne=
t.com> wrote:
>
> Hello,
>
> I am reporting a bare-metal Xen dom0 boot regression seen with Linux 6.18=
.52.
>
> On affected systems, Linux 6.18.51 boots successfully as Xen dom0 on bare=
 metal, while Linux 6.18.52 consistently black-screens before dom0 userspac=
e/networking comes up.
>
> #regzbot introduced: v6.18.51..v6.18.52
> #regzbot title: ACPI processor/cpuidle lifecycle change breaks bare-metal=
 Xen dom0 boot
> #regzbot link: https://gitlab.alpinelinux.org/alpine/aports/-/work_items/=
18447
>
> Tested results:
>
> Linux 6.18.51-r0, Xen dom0, bare metal: boots
> Linux 6.18.52-r0, Xen dom0, bare metal: black screen before userspace/net=
work

I'm wondering what's special about Xen dom0 bare metal.

Does adding processor=3Dnocst to the kernel command line help, by any chanc=
e?

> Linux 6.18.52-r0, Xen domU: boots
> Linux 6.18.52-r0 with Xenbus notifier change reverted: still fails
> Linux 6.18.52-r0 with only ACPI processor/cpuidle changes reverted: boots
> Linux 6.18.52-r0 with refined ACPI idle lifecycle patch: boots
>
> Affected hardware tested:
>
> Intel Core i7-4785T thin mini-ITX, 16 GB DDR3
> Intel N305 thin mini-ITX, 16 GB DDR5
> Supermicro / Intel Xeon E5-1650, 32 GB DDR3
>
> The successful boot used the regular Xen command line:
>
> multiboot2 /boot/xen.gz cpufreq=3Dxen:performance
> module2 /boot/vmlinuz-lts modules=3Dloop,squashfs,sd-mod,usb-storage,xfs =
quiet
> module2 /boot/initramfs-lts
>
> No IOMMU workaround, serial console parameter, debug parameter, storage w=
orkaround, or Xen command-line change was required.
>
> The regression was narrowed to ACPI processor/cpuidle changes between 6.1=
8.51 and 6.18.52, specifically the idle-driver registration lifecycle.
>
> The working 6.18.51-style behavior registers the ACPI idle driver from ac=
pi_processor_power_init() and unregisters it from acpi_processor_power_exit=
().
>
> The failing 6.18.52 behavior registers the ACPI idle driver globally from=
 acpi_processor_driver_init() before driver_register().
>
> A first ACPI-only revert confirmed the regression source. A refined candi=
date patch was then prepared to preserve the working ACPI idle lifecycle wh=
ile keeping unrelated 6.18.52 safety fixes, including:
>
> _LPI bounds checks
> cpufreq notifier cleanup on acpi_processor_driver_init() failure
>
> The refined candidate patch modifies only:
>
> drivers/acpi/processor_driver.c
> drivers/acpi/processor_idle.c
> include/acpi/processor.h
>
> It does not modify Xen, Xenbus, IOMMU, APIC, PCI/ASPM, intel_idle, syscor=
e, USB, storage, XFS, networking, printk, or the cpuidle core API.
>
> The earlier cpuidle_disabled() workaround is not included.
>
> The refined patch has been rebuilt and boot-tested successfully as Xen do=
m0 on bare metal on TRINITY-EDGE.
>
> This issue is currently visible to Alpine users because the Alpine v3.24 =
stable repository contains:
>
> alpine-release 3.24.2-r0
> linux-lts 6.18.52-r0
>
> Systems tracking Alpine 3.24 stable / latest-stable may therefore receive=
 Linux 6.18.52 as the default LTS kernel.
>
> Attachments:
>
> revert-acpi-idle-registration-lifecycle.patch
> APKBUILD
>
> The original Alpine report is here:
>
> https://gitlab.alpinelinux.org/alpine/aports/-/work_items/18447
>
> Please let me know if this should be submitted as a formal patch with Sig=
ned-off-by, or if there is a better upstream fix/dependency that should be =
backported instead.

The patch is essentially a revert of commit 13ebeef6a1b9 ("ACPI:
processor: idle: Optimize ACPI idle driver registration") which I'd
rather not do without knowing what exactly is going on.

At this point it looks like a missing check somewhere or similar, so
it would be good to find out where exactly it crashes.
