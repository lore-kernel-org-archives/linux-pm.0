Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E548D41D62C
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791244317; cv=pass; b=dKu1EqMuQD+aNiMUWGX1ZeIbU2NZR1Z24S06XEadY2kLx9eS41VhALrgzunBTQMtvg9h6dHbizD+PDzOWEajsoWb6pGnYnMxIx/xIKjTT6HRP1CkBTFef2p8AQhLZK91Xdbuhf4FdAUWWfUEIiyrH3dkFD8UY9btqckfbBzAGdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791244317; c=relaxed/simple;
	bh=nyDp+1ApeI5wi6DcLZIDQVHhSQiPQ/FBwW9Pktuu1Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVS+jeP+qZjDXzmek81Z+5tmojwByE07J9dEryoNMcEDIJkyM9f8KorYBDSJu0/7BuS26GKEItP5z2UZhdrdqYoWkBGVanwycl0/uBDPs/Q+Qtkhuk5OCbbzUXYv4dWEwbqijqtX19CqcpKh1ldq6S5OScr++SQn6nPp85GPQ1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0R6sE/i; arc=pass smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0R6sE/i"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3510b42f4e3so2400766eec.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 16:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791244314; cv=none;
        d=google.com; s=arc-20260327;
        b=qbcB8AoT56M+DyvuxQZq0V9TLjnhDQceY6NjO9fI3y9DBR5rs478fxCoSBYbUdXdTF
         At8ibOZTYjO7w9aiocsvJDbGZ0DDFzVi80Pjt5l81mDOBA4tEwWmGZJfvDZ79OJ71fa+
         ghK+D8gdG0+NyWDKcBME7D0lEaK4At9uifX+ZTYPAGlZEJ2aXYLbC9KREusDWKZ+TdP1
         MvvIyyoo6V5YVrSeZv/yxmp8GrpYvdRbk0vH45N/44X41TM8PxTqhqbq0zwZtgVCc3Lk
         K8wFLknMZxiUyOZoPbtod1mP4u7dgwlexJ+UWO0OENk1ma6g/xsYqMhnTGBh10PWwUDK
         21iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ebxkckus4SoJ9SY/+EfYZcfaC4btVU9QwtZLBx86cuA=;
        fh=2Mp7SpNISovM2ex6zJZElJfc1SomXB3tvQGvJ6ReIfY=;
        b=CyE7Gonij8AaOPWTPUcWdU1UZ0bLt63EwDkhlt2B1ETBUI+Vld7W/9UheanmndEEUl
         sBYZaWp07B53F+iTTcQZiG+Iq5JEsizM5RGT5XFzrEe+oDrOt6dgvw93edkkCTUsSgk2
         d6Ju+EUd86SjoG0lKTRmO4pSA834iTVNzj9/mglobSBbXKf2m44Goe6kXwPnspMUjQL1
         piRfCAjodywSzUIdVHlHCUQ1CogWDhBPicTd8iW/QwBWFD854h1jh5Hmy5nAWrDVhVSP
         UYsTzZrxTGK6mAHVQGKopZhFH7Ec82L2XxSiGlcqSgsttkluJIVKsgB08HYrDU1OlgTp
         //aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791244314; x=1791849114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ebxkckus4SoJ9SY/+EfYZcfaC4btVU9QwtZLBx86cuA=;
        b=F0R6sE/ii6VSlWVokZLye1c/v4sGJNgFQcqIFIxEanMtmPBDKLpKbNVA6+B12sSL5l
         sG/rDcB0eFOKeB8JH5ovjUgm7eMGW+Vi7WGCJrked7vbgaU0kiirbRn5VEWX8Me4SglW
         3uUXY0kxth+AYb0eNs7217HjbdZP0Fdu6wy4pbogxHlJiI8Dqtvhsb6HXRvoLEpkxrBm
         hYDBoEYZKehcvfqSSsHDDgS8KEDmLvBBEkPqYwNX3W5Rtg0ejfIaMQQjuyQ3uekm+aZy
         1Nvl2Gz0OXDlHEHKQ9eNg9sAFiLP73WUxpfHRfCMO9cRURu0yaUftWkqRKL4s+Z31+4j
         ebpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791244314; x=1791849114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ebxkckus4SoJ9SY/+EfYZcfaC4btVU9QwtZLBx86cuA=;
        b=mB3z+FJ3UNJDC+0FN7pZLJ7jbr+U75/CmCzi/k650+q19B+lDTR1L5bSQ5eQ6AGqcs
         275fVd1z/TUOe11hgk6hjaqmZYE4jL8ogs8MSniAxYvnNi4xQfhF+YGkUzBdH4fa0Gni
         O8PA/jBh0CKARBtF7vxFgnFnkzeb38z28lfD3VWWwxuV5xhQb2+pCsJqt9Wi6d4w4XGM
         rSAG/xyhhVOd1i493QVQsnKeEmInoOKAw2UbQuJYSof0dlTspwXW3paACU+rNmwZ5oVj
         IhDmk9lgd+8tqJ7GggMRvzwWlC/sKSnNqs1g8fMvPfnFaI1WLTYs5Zp5Hls1AEWZfXMd
         tXGg==
X-Gm-Message-State: AFuF++meVaghmLeWQzjPZUyQ7RABhMCOGKneBEKTV57y6OU4DdCXgYbL
	JFXIfJZ9wazONCHXzS0KXFSfIjKVfzojgF1v3m4kEHmPXHRwNH7H9dsVcnkqtvGWLA/zIcMhv9E
	gm/W7SjNRAY6b3hn7FRMFk4UX9JimA48+sstk8WajSQ==
X-Gm-Gg: AYBFou2TVfMd5fTy8x1eWi06MC84W5UOIHDYyWB1KnFcZ9WfCqQVAuHE/+RELLeTq7i
	BtjJa6gDjl7n4NuTbrbpZkiwWvCoWdUFVAJxxXqRhY+U9JkYy79zGTywL62Xu9Yt4wIhHoGn/+3
	SEwg/Xm7zH6y5+HWO05SkMEql05bYETBiZkkgjolmbMrr4v3BQP4ujAVfRfFK2VAKb+h08A/Y08
	BkEeGpEw4dpMnS7gSEyOGJWVq2JsRe8EvPJunHeyVi5RiKKrgk/6mJ+CLE+uK8iPuoB5cQqnhyn
	i51DQpvLY1X+jpKQHodBuEHgNs32VsuROO4oMAH5dvk73fLWn+z1q3gTOhhfMT3hN5CpRNbfhQo
	/4D1V7GL3vjGn2qDLm1XGicbp/WxCI8H+hLSuz6DLvC5ceM4B2YObWh9jle/HdmdNT3F0r82TDL
	B3O+Q=
X-Received: by 2002:a05:7300:e5c2:b0:341:3ca2:de2d with SMTP id
 5a478bee46e88-34f15077edfmr14853912eec.6.1791244313787; Mon, 05 Oct 2026
 16:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACiNov445=gavzZY=Yz74HNMUgd2BKoYoazWFDRRsz9uhA_rfA@mail.gmail.com>
In-Reply-To: <CACiNov445=gavzZY=Yz74HNMUgd2BKoYoazWFDRRsz9uhA_rfA@mail.gmail.com>
From: Angel <angellindo@gmail.com>
Date: Mon, 5 Oct 2026 18:51:16 -0500
X-Gm-Features: AclHuK-GqWmUZhpqnL1jubDmX5Hw_DlLPiAed4QMWX1gEvgQXKjozYhgmnoZhqc
Message-ID: <CACiNov6n4Sr4nkAnTXJ9ZmMz022KebfAM8Hf2JV_EZ+KVa9THg@mail.gmail.com>
Subject: Re: [REPORT] Kaby Lake-H (MacBookPro14,3): package C-state stuck at
 PC3 on Linux, macOS reaches PC10
To: linux-pm@vger.kernel.org, rafael@kernel.org, 
	artem.bityutskiy@linux.intel.com
Cc: rajneesh bhardwaj <irenic.rajneesh@gmail.com>, xi.pardee@linux.intel.com, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One more data point and two clarifications after sending.

PCIe L1 substates
-----------------
- The Wi-Fi root port 00:1c.0 has its L1 PM Substates capability
  hidden by firmware: a stale block at 0x200 with a null header and
  the support bits cleared, not linked from the capability chain.
  00:1b.0 (NVMe) links it and has L1.1/L1.2 enabled on both ends.
- The OS has no ASPM control here (FADT), so Linux cannot enable it.
- Per Apple's IOPCIFamily source, pci-aspm-default =3D 0x102 on the
  Wi-Fi is ASPM L1 + Clock PM, which Linux already sets, and
  IOPCIFamily only enables L1SS when both ends expose it.
So missing Wi-Fi L1SS is probably not the cause. This is an
inference: I have no config space dump of that port from macOS.

Clarifications to the questions
-------------------------------
- Q1/Q2: the stock module (CNP map) exposes neither pll_status nor
  the MPHY gating file on this machine, and the SPT code has no deny
  reason register. Is there an SPT-H equivalent of CNP's SLP_S0_DBG,
  or ModPHY/PLL gating registers worth reading on SPT?
- Q3: in the SPT PPFEAR map bits 13 and 21 are RSVD (SPD/SPE in the
  CNP map). On SPT-H, do they correspond to the extra PCIe
  controllers? Which IPs must be power gated to reach PC10?

See also: https://github.com/Dunedan/mbp-2016-linux/issues/24
(MacBookPro13,x users reported higher idle power on Linux than on
macOS).

Thanks

On Mon, Oct 5, 2026 at 4:23=E2=80=AFPM Angel <angellindo@gmail.com> wrote:
>
> Hi,
>
> On a MacBookPro14,3 the package never goes deeper than PC3 on Linux,
> while macOS on the same unit and the same firmware reaches PC10. I have
> ruled out the usual suspects and would like advice on what else can
> keep the package out of PC6 on KBL-H / SPT-H.
>
> Hardware and software
> ---------------------
> - MacBookPro14,3, i7-7820HQ (Kaby Lake-H), HD 630 + Radeon Pro 560
> - PCH: 100-series PCH-H (SPT-H), PMC 8086:a121
> - Apple EFI 529.140.2.0.0, SMC 2.45f5, Thunderbolt NVM 41.5
> - Linux 7.2.5 (distro kernel), intel_idle (native tables,
>   use_acpi=3DN), intel_pstate with HWP
> - gmux switched to the iGPU; the Radeon is unpowered by the gmux
>   (or unbound with its root port in D3hot, see below)
>
> A/B: macOS vs Linux, same machine, same firmware
> ------------------------------------------------
> macOS 13.7.8, idle, display on, "powermetrics --samplers
> cpu_power,gpu_power", 6 x 10 s (means):
>   PC10 80.8 %, PC6 2.5 %, PC3 0.06 %, i915 DC6 97 %, PSR 99 %,
>   package 0.19 W (powermetrics energy-model estimate, not RAPL)
>
> Linux, idle, turbostat, 10 s samples:
>   awake, display on:      PC3 58-71 %, PC6..PC10 0, PkgWatt 4.0-4.2 W
>   s2idle (5 min sleeps):  PC3 98.5-98.8 %, PC6..PC10 0
>
> Residencies are comparable; the macOS wattage is only an estimate.
> With the display off, macOS still reaches PC7-PC10, and with a USB
> disk active on the Thunderbolt xHCI (PEG link up, no ASPM) it still
> reaches PC6/PC7. So firmware does not forbid deep package states.
>
> What was ruled out (PC6..PC10 stayed at 0 in every case)
> --------------------------------------------------------
> - i915: eDP pipe disabled, no display power domain references left
>   (i915_power_domain_info). DC5 is entered (~1/s), DC6 never.
>   My guess, not verified: DC6 =3D 0 is a consequence of the package
>   veto, not its cause. Also 0 with DPMS off.
> - Radeon: unpowered via gmux (iGPU mode), or amdgpu unbound with
>   runtime PM so that the PEG0 root port is in D3hot; measured awake
>   and in s2idle.
> - Thunderbolt: both root ports' devices removed, root ports in D3hot;
>   awake and in s2idle. Forcing L1 on the PEG/TB links did nothing.
> - LTR: LTR_IGNORE =3D 0x1fbdf written to PMC PWRM+0x30C (all IPs
>   ignored), awake and during s2idle, restored afterwards.
> - Combined: Radeon off, TB removed, T1/xHCI idle, DPMS off, rfkill,
>   LTR_IGNORE, all at once. SMBus unbound in s2idle: no change.
> - IRTL (MSR 0x60B-0x60D, 0x633-0x635): lowering them only removes
>   states (with all IRTLs below 61 us even PC3 disappears), so the
>   factory values are not the limit.
> - MSR 0xE2 =3D 0x40000008 on all CPUs: package limit C10, lock bit
>   clear.
> - intel_idle without _CST (use_acpi=3DN); cpuidle shows C10 (MWAIT
>   0x60) taking most of the core idle time.
> - acpi_osi=3DDarwin: no change.
> - apple_set_os: the EFI stub already calls it on MacBookPro14,3
>   (declares "Mac OS X 10.9"), so that path is already taken.
>
> PMC
> ---
> intel_pmc_core picks the Cannon Point map on SPT-H; I sent a patch
> that adds a121 to the Sunrise Point list:
> https://lore.kernel.org/r/20261005-intel-pmc-spt-h-v1-1-78c98e4f4620@gmai=
l.com
>
> With it, pch_ip_power_gating_status at idle shows PMC, OPI-DMI,
> SPI/eSPI, XHCI, LPSS, LPC, SMB, P2SB and FUSE not power gated; SPA-SPC,
> GBE, SATA, HDA, ISH and CSME are gated. Unbinding the Bluetooth UART
> gates LPSS, but PC6 and SLP_S0 residency stay at 0. XHCI stays on
> because the Apple T1 (internal USB) is kept active. I have not
> verified that the SPT-LP PPFEAR layout is correct for SPT-H.
>
> Questions
> ---------
> 1. On KBL-H + SPT-H, besides LTR and IRTL, which platform conditions
>    make the package stop at PC3 while all cores sit in C10? Is there
>    a readable deny reason or status register for this?
> 2. What should I read next: PMC registers beyond PPFEAR (ModPHY/PLL
>    or MPHY power gating status), System Agent / uncore state, or the
>    PEG link power state (L1 vs L2/L3)? Any debug tool that works on
>    a production part?
> 3. Is the SPT-LP PPFEAR map valid for SPT-H (bits 13/21 are reserved
>    in the SPT map but SPD/SPE in the CNP map; root port 17 is the
>    NVMe here)? Which of the IPs above are expected to stay on in
>    an S0 idle that reaches PC10?
> 4. Are there known Apple firmware settings that only macOS undoes
>    (or that Linux needs to program) for PC6 on these machines?
>
> I can run tests on this machine and share the raw turbostat and
> powermetrics output and register dumps.
>
> I used AI analysis tools to help organize the measurements and draft
> this text; all measurements were run and checked by me.
>
> It's my first time collaborating, hopefully this info is of service
> for any correction.
>
> Thanks,
>
> --
> Ing. Angel Lindo
> Director de Operaciones @ Ultratech
> +507 6326-1581
> LinkedIn



--=20
Ing. Angel Lindo
Director de Operaciones @ Ultratech
+507 6326-1581
LinkedIn
