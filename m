Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D8A4A2064
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001173; cv=pass; b=nxYbfr9UOpCAG12vU234ebZn3rEO90nfGTgBTxXfPAr6PKsema+ShEkcd2D/RVbOQx3nuiUG+x8X4xEYdht2lfr2dg+NaudbW8X6lLGgAYFKSBsWSuYCmgJlO9qPiyQ5fGV90pVXCEkfCwc0Yul/kkiOLttELCqcn5B1UV0vYmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001173; c=relaxed/simple;
	bh=hzsKoddot+dY0EZ27aq5GfZZI/Lez7LJqexM7v1StJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPQ4igiN/olaCO4OCEUwOWp5t0xRo8XezsdjoGi7LgiAjPKi+pjeg5EsHbtocivVzi7NMQRdcuEbbz8/V/JqvAL17HqHTA3xy8GDsgmo4hgy9nzUxbf8JuQx/kS+z6IAW+HUbh3/Dtcppr5Pc6ZhsY21/853XrHbeqrM+SNfKok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IhPDDERP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bwHq1vyG; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IhPDDERP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bwHq1vyG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LEGdvW2568532
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8V9qRL8QsRUF83XpiMXUfrfmmQn7slBViBa0BqoAT0o=; b=IhPDDERPEIKbMFAd
	g4ug9QshGTwL0pna643qpJ0WaDvB6HfRtmpn9UQ3FmOO9xhx/lpZOMwF1GyOPPXM
	EsZnb5K7B8VtRS78CS+aZAXx+s9CXPeSCAG/w4sCEmgmifFcFnKU+utbEWQ3gGEf
	TiDyyAKUSJ09MzWPAgql/ZJuMpVYIFXkWr2Bu6o9kRqrfxfPQ4VxftA0Jh98sb0W
	jqT7GW/y6BxcOHfO6K39alWyOb8uJxDptadWSHP/rxq44Y7oTGNpuzaEjjarvHLp
	761Qz6vDg+47aHh35c+cNwqqwgvfFiholHvdXhvm8mJ2BPrUyxkqvdWfwD2/xiz+
	mAmeFw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3wtudu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:32:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc435388657so4624781a12.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 07:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790001170; cv=none;
        d=google.com; s=arc-20260327;
        b=mOAVqXOuCWc1qkR97cfSYy7pdlg9MfQcznBFj5K20LHiLVrFfO2cOZkRQkYyqvP6jF
         YJk2hQTMuTAqhA5yzpyk8tOLu24SR9Omw2CRr+IiltrGN0/z0SmWERApBDyubCm7LOcQ
         +zxq0WY5JhrI3FTdyxr18lAuM7n5Q2eAFBUcyT8jEH+V8UOo4gJhPj+sU5zrbv8fh1gR
         JZRkBdiSfqV1aoTSx+WsjXm8tuGWV2Rpq30lb3jA+RhwiWi/ex7zeG0tr5PMIc0MDhSJ
         JJ55ZPb+LFu/4wCbe7tQtBbY43CNOolZJ3AHkTXEzbIFMMSCMGQD36E1KSkyfs7jEBYS
         xzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8V9qRL8QsRUF83XpiMXUfrfmmQn7slBViBa0BqoAT0o=;
        fh=+5Cj4BsRIhqg9b3oUPwH995xlqfdbP5clhQNuKqQm5Q=;
        b=khfhtsEYdVFHCfmW3KP8O7KBoRskdGbrIcGdF+3bej7HTu4DeKtpNsrtzv+8aqow5P
         ROF6Il/xv9833S8v1x+VtEB0EWEYlsERIdppG1SjueJGdpAIXporzfN+5XY38N4vp8Jv
         SkQWXteuCZwIoiduJ9QUCjN95gv8lQZ6ApZ2vlxJoQNtewYspVRvg9RmIBPUx/LkbRk9
         hVeAEq1tgrtiir2mn0rjwFY/EvKBuNMwNnkcCYuIW37pNtFjrhCzAcEeu+jw4UfDXNg+
         4t4jA/uqGkF9TJRWSccB1tvtXrBh5EuNVLVNXXWZ60G7CAtg5ZiD3NYn0KhOZYvzHmxl
         /mrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790001170; x=1790605970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8V9qRL8QsRUF83XpiMXUfrfmmQn7slBViBa0BqoAT0o=;
        b=bwHq1vyGJAMdqngSHxnsrYJnxY0IXWfTaeE4DSSXgld7glgJMz0opPnCMv/MftSeKR
         gq14LMpvHkPyZy3Mk5Rj/5x2GtbjjtedU/Gn9i9u8Uj3t4406v6zSByZamjh6uOLjzP6
         zQiLUoRomIAPQi2IKgWQGXMyqVe7L4ogeaT/hViOy398Y42XaeWbwEj6dIE2YU4BKm4S
         CXSF/yClv6Ay+8O3L8cpIJ893ayld6/IlI4POaEVFmrD/lgIzs6hLEgJXzvYvW4iHhEb
         TguNGjS521Y1aSZbPlT6pkFJIufk5VJYWjrZvF0WJZJwWilPw8lKHTyRAdaB1bhnvI0i
         gvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790001170; x=1790605970;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8V9qRL8QsRUF83XpiMXUfrfmmQn7slBViBa0BqoAT0o=;
        b=opls38qD3BucGIIXhXED4y0Qf/AlF5r4tv5X6L0wpobTodyLrRJw0lCq2dJp8ZrDsd
         z8Oe3sJymWCGHXJUnqjOL0Q/8oAAWX7U6wzkh0UI6SOlwHQJQc/qRJ+1bcjl0xXkQnx1
         Rf60yVVULDibtnzjMA7hArOH8P68nqyzsagEeeNdmzZZW8+Z0F42yEbH9s5eXiuZ0+BP
         aHa7a4f9+BgOXVjgMn3NR9em4TdX3qtWPx3d1cX2lQN70WRIYFr99jnXrbqucJQUDpri
         tQB5ClFjm5JeR7BcwgHfpK6jhoZoEJOaaoHOjJPW3Ee9Tic07F7aX0fvGKCYmU5jMJqS
         25+Q==
X-Forwarded-Encrypted: i=1; AKwUvBy3oMNXe2HBkApKxXr4dnholp52RQqMiDVL5UP7rebhiBeuCa/WGxtz6uR3gbLlhdse54i43gUBNQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n+JpsYBPJ2OzTlozsEwBL4pcloEquFLnECW5BPMIvbLaVaofDs
	PKHZmGi79acWZqRrQGJGgw0C1apktgFXE0FTcd9WE4oOHS3e4vY20BuIEhAplWNHIWhSEyX+/7C
	W9kFKER62IUHPJF7gbLBonsf8LVWNwFAMGHbFmz1YG9N35wwQwgIWy9NHJW8JHsM4+flaPz3J4D
	rRYezVgFNFCioJMfPiA0b2FhMa8SsuYEpSNSJO
X-Gm-Gg: AYBFou3ZPQpejCf0BsFWD+AYMQ8lbuPCJ9BKewBsLuuhGVvhgMrW5LUYtcP2bUrW8+T
	uYvQqdZs3lbfhFeN5wq53xkvb6TadPSAcYUbOSz9mFS1trdM3bNhAPIbhlaX0SntkEwqvdJD9QJ
	LOWWcbpN0vp4bCtWNsEhMI2jpIP8Homm8PeiWB9nZD4lbT7MU4mF0sKYeYRQ==
X-Received: by 2002:a05:6a21:6194:b0:3cc:f008:8123 with SMTP id adf61e73a8af0-3dd8c3fe021mr18964762637.8.1790001170330;
        Mon, 21 Sep 2026 07:32:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:6194:b0:3cc:f008:8123 with SMTP id
 adf61e73a8af0-3dd8c3fe021mr18964705637.8.1790001169714; Mon, 21 Sep 2026
 07:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903092347.620060-1-joshua.yeong@starfivetech.com>
In-Reply-To: <20260903092347.620060-1-joshua.yeong@starfivetech.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:32:37 +0200
X-Gm-Features: AcwNN1WpGO3jxKAH0ED7jq5tX0NF1bkBB1T37oZy7cznqRrvJi696dq7Itctpt8
Message-ID: <CAPx+jO-3ZgVTSE2y0_TW4cy8wUYCJaogNnzgCr-WX681_H+sfw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add RISC-V RPMI device power service support
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: rahul@summations.net, anup@brainfault.org, lftan.linux@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ulfh@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfX92t2pwzdJai3
 FHAEXUvo4g+xrQHf0tKOJxPSqMtAwrvfB3bQsnhI+2pDf1hASxn0WD07sHljoZbIldxggtxOArW
 1QcbafB09HzllGKsfd7v7XNcDqxMd25f42zCSa9hzJZ0izz9w2EkhudXqS/GBB8jwOmhxAS6eaI
 xmOuLPftUbUM5JCsr+/WvQBVX56HUL1uxknKuRJPzKv6GQSWLcfdLIaZbl6oM1am3Kbum8hTGFD
 3DZ5eSYl8gxFpps6pP/vDB6SpbhcD2zRJs5vpqJRH7pQIY13Qn9kBNYTdKDIZAh6MSu12pe4QRy
 QuFm6qtTtl17I9M+ELEZSNZIgSgIkYbxO/Af9oXue05HNs8BO4sSwLH3U7rctZWOlswy+w/o/qN
 /qs0s6WxR/XcbINM46aR7hFtBLyQyBTslmgiij9Ow29LyjNastwIFrxQFo7/a5pqSjO8AyQhIj9
 6SB7IKzcBHjbMgwEjJA==
X-Proofpoint-ORIG-GUID: pnvg6X40HK9-417wBrgYwpAhAlKrixuJ
X-Proofpoint-GUID: pnvg6X40HK9-417wBrgYwpAhAlKrixuJ
X-Authority-Analysis: v=2.4 cv=dakVTnXe c=1 sm=1 tr=0 ts=6ab14012 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=Bq6zwJu1AAAA:8 a=NEAV23lmAAAA:8
 a=2HKowqdte-bNKO3h_Y0A:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfX21m7ae/q/cCB
 k6Bo3xb1FkagEWNuf1zYx7H2cy7qH+VsNfu14Y69+3bOBp9jR/pFdt6BGYnxRZLQEaPetn+0/Zw
 atqPxg4ilKJ8VlXMalVz5VDvyGqdxWo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210211

On Thu, Sep 3, 2026 at 11:24=E2=80=AFAM Joshua Yeong
<joshua.yeong@starfivetech.com> wrote:
>
> The RISC-V Platform Management Interface (RPMI) specification defines a
> modular and extensible messaging protocol between the supervisor software
> and a platform microcontroller (PuC). Among the service groups it defines
> is the device power service group (service group ID 0x00009), which allow=
s
> the supervisor to enumerate the power domains of platform devices managed
> by the PuC, query their attributes, and get/set their power state.
>
> This series adds supervisor-side support for that service group:
>
>  - DT bindings for the power domain controller exposed to the supervisor
>    ("riscv,rpmi-device-power") and for the SBI MPXY channel that the SBI
>    implementation uses to expose the service group to the supervisor
>    ("riscv,rpmi-mpxy-device-power").
>
>  - A generic power domain (genpd) provider driver under
>    drivers/pmdomain/riscv/ which talks to the PuC over an SBI MPXY
>    mailbox channel. At probe it queries GET_NUM_DOMAINS, then for each
>    domain queries GET_ATTRS for the name and transition latency and
>    GET_STATE for the initial state, and registers the whole set as a
>    onecell genpd provider. Domain power on/off is driven through
>    SET_STATE with the generic ON/OFF power state parameters, so devices
>    can simply reference a domain through the "power-domains" property.
>
> The series is based on the existing RISC-V RPMI/MPXY infrastructure
> already present in the tree (drivers/mailbox/riscv-sbi-mpxy-mbox.c and
> include/linux/mailbox/riscv-rpmi-message.h), and only adds the device
> power service group definitions on top of it.
>
> Changes in v3:
>  - Move the MAINTAINERS change into its own patch, and add a new
>    "RISC-V RPMI DEVICE POWER DRIVER" section scoped to this driver and
>    its bindings instead of adding an M: entry to the existing "RISC-V
>    RPMI AND MPXY DRIVERS" section, which covers drivers maintained by
>    others.
>  - Drop the redundant trailing "bindings" from the dt-bindings subject.
>  - Compare only the value field of the RPMI power state word. The word
>    also carries a context bit, so a full word comparison would report
>    -EIO after a successful transition, and would drop a domain at probe,
>    whenever the PuC reports context as lost.
>  - Check the pm_genpd_init() return value and leave a failed domain out
>    of the onecell array. Every failure path in pm_genpd_init() returns
>    before the genpd is linked into gpd_list, so the previous code could
>    hand a half initialised genpd to of_genpd_add_provider_onecell() and
>    then list_del() an uninitialised list head in the unwind loop.
>  - Set GENPD_FLAG_DEV_NAME_FW. The domain names come from the PuC and
>    are not guaranteed to be unique or non-empty, and were used verbatim
>    as the sysfs and debugfs names, where a duplicate fails device_add()
>    with -EEXIST and takes down the whole provider.
>
> v1: https://lore.kernel.org/r/20260829205520.1691-1-joshua.yeong@starfive=
tech.com
> v2: https://lore.kernel.org/r/20260830152812.312663-1-joshua.yeong@starfi=
vetech.com
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> The series was tested under QEMU with the RPMI device power service
> implemented in firmware.
>
> Components:
>
>  - OpenSBI: latest master branch
>    https://github.com/riscv-software-src/opensbi
>
>  - QEMU: the RPMI-enabled tree at
>    https://github.com/yeongjoshua/qemu/tree/rpmi-v11.1.0
>
> Kernel config: enable CONFIG_RISCV_RPMI_DEVICE_POWER (default y on RISC-V
> when MAILBOX is enabled) along with the SBI MPXY mailbox driver.
>
> Run with:
>
>   qemu-system-riscv64 \
>       -M virt -m 2G -smp 4 \
>       -bios fw_dynamic.bin \
>       -kernel Image \
>       -M rpmi=3Dtrue \
>       -nographic \
>       -initrd rootfs-busybox.cpio \
>       -append "root=3D/dev/ram rw console=3DttyS0,115200 no_console_suspe=
nd mem=3D2048M earlycon=3Duart8250,mmio,0x10000000"
>
> The RPMI device power domains advertised by the emulated platform
> microcontroller show up as generic power domains and can be inspected
> through /sys/kernel/debug/pm_genpd/. The series was additionally booted
> with CONFIG_PROVE_LOCKING, CONFIG_DEBUG_MUTEXES and
> CONFIG_DEBUG_ATOMIC_SLEEP enabled, with no lockdep reports.
>
> Joshua Yeong (3):
>   dt-bindings: power: Add RPMI device power service
>   pmdomain: riscv: Add RPMI device power service
>   MAINTAINERS: Add RISC-V RPMI device power driver
>
>  .../power/riscv,rpmi-device-power.yaml        |  65 +++
>  .../power/riscv,rpmi-mpxy-device-power.yaml   |  65 +++
>  MAINTAINERS                                   |   8 +
>  drivers/pmdomain/Kconfig                      |   1 +
>  drivers/pmdomain/Makefile                     |   1 +
>  drivers/pmdomain/riscv/Kconfig                |  15 +
>  drivers/pmdomain/riscv/Makefile               |   3 +
>  .../pmdomain/riscv/riscv-rpmi-device-power.c  | 485 ++++++++++++++++++
>  include/linux/mailbox/riscv-rpmi-message.h    |  11 +
>  9 files changed, 654 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/riscv,rpmi-de=
vice-power.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/riscv,rpmi-mp=
xy-device-power.yaml
>  create mode 100644 drivers/pmdomain/riscv/Kconfig
>  create mode 100644 drivers/pmdomain/riscv/Makefile
>  create mode 100644 drivers/pmdomain/riscv/riscv-rpmi-device-power.c
>
>
> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
> --
> 2.43.0

The v3 series applied for next, thanks!

Kind regards
Uffe
