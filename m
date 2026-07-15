Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3603C7690
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 22:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153372; cv=pass; b=VFD6v02mcwlK0w2Vgop1fQYWKqe0lSiduMny+gaga+vL3bhGJz58ghrCZf17tylHQn60vJD0LCMs+aKoExa/4hdKhdEqatNi7DUL72tCuUk2rY4BgVB1Q3EF/wVkNn3TasKE9COFzHKl+FJ6avwRPJvAl1YLJsXg3p6KMJhhD/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153372; c=relaxed/simple;
	bh=wzx6JmhxDRaZzFfT8AfeenJLvhTcVmAhhTfTPFjD+6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ek2zNIHBoBEmXDQ6rchCZ40sfeFLURzLVdThX3dHSswX3vQlsiA9NlweLZIPOSACp83FNpL3FrG+hNsIBmtfmdNSqATfSUb0a80kngmc9D/hiYav+Ua9QjOyrB5v/NRhOvhY2vVQUzxy9+EJWSpuUTyzwA6g/iZSb+e41tFERv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfUWA/IH; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfUWA/IH"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so4151502a91.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 15:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784153369; cv=none;
        d=google.com; s=arc-20260327;
        b=iUoeMKQWt0dcVaRaxQnBmGK3M2OWwodIAaV+enBVWd7zvX9PwlnjmO3/kLpGcYekHN
         6gzZBRdeI0ilRv+0YLMAcUMZRpyM78kUkZhAl9qxqPziVcuoP+lJVkiBwN7dJuQBQj3C
         8cZQucaNZFuBqFVYrgKxRpZbcXGJJvSheu6t+zlmpWMmR8lNT2suIoQg73CsOwpSyqcq
         o2UgbIoKMj7xSBX0KbXtUA+jXUxh80m8Vqq4ix8EH1sJKNjZSnbcDzNL1NsTDhKkKTr3
         2DKlNB76lBfnrTBDcGbdASWJFrOByfTPRKEoQtxhZ2kMvN9KqeSK1Ry4OdyNmYlGa/F+
         NuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AeW93jUjWuY4ANBaFz2MRTqagEoulbdLjT6w+JOvBy4=;
        fh=k1Ges62cItPzIpELwoW8s8W7TjieUOJngTEQZIwFV2E=;
        b=RkVcV6Imj1GxDqh6I8pDPe7X+R19r6CtoURC29GDfifs3AsiTUI8PHDD7JNhDyXsm9
         Ya2m7gggNaDXYWTGp2mct5PpCFdw8o+Gb8DUjYIKsblcr8itt7CaV5n55cXdYJ3HyPj0
         tTj9dFdKLMyn/Np0tAJA+fkiRvpTpcn3DQmaIbD/JQUXUvYgJfKubV5CCMvQ90Grt7fD
         +9VcxK8ZvrBmcyg3ez+bt7ecWYCPa5y2uv4Cv1s5OG2T2yB3yndhR473w/+JivoWHkMz
         /fEIVeAIiL05ETvOawU14/c29etLGs+FP+pIoVLWRBg6q7JmJV9EjgNqrYu6UESEzZWv
         9+1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784153369; x=1784758169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AeW93jUjWuY4ANBaFz2MRTqagEoulbdLjT6w+JOvBy4=;
        b=BfUWA/IHbkKn2twE6d2dcvM5EMnF9BRYW+2lpttOp0tabUs3DC38DTV7n0fs4TFRBH
         3IB+ISJ5gJFP6zAUdp3q3JZsA2W213Io4k6XuGVAJE6wSKv0Fz0YxedKUK1OOo0Kdo+j
         HwNFIQOk3IqhZsRd/jySRyK4XjPFmLrrerNwy4vWuHKjlDCL1r3K3G/ndMbqRum/KiF+
         oYt/t8njCV+oCamHQQUasx5iEXOtOl5HNiULaFVCswYX3Nrmmzu8+GLfChN1alagZJnO
         475kawRzIbeV8V43NTcCf5idQY8yjXCTdlZCOwFMHtjbbc1BShSjmd2f14yP8a3TYX1n
         1krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784153369; x=1784758169;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AeW93jUjWuY4ANBaFz2MRTqagEoulbdLjT6w+JOvBy4=;
        b=I2au/+jbIWU6gQOoNe1h53IKgus2dqVDColD6VguSGb9WlpwU5htLYvxd+dWgFEBCg
         YmZ1D5J/FfXLt5YhuBaVQcTaLYJyHZdrleR7p+5owbGagvKnx9nUFuS9Wr0bgBfMvAU4
         2ZX6dtT+CCl+f50iIHcg4dFXwqL1NiPZOlUTG7swPg05/WzWXeYN0W1+fvKU2SJsXeBI
         6kQ09dfXDQjmJTsT1YvYoJ529z03mZKTcVbcc/lNWwF+DEA9qEpQhdwf2PDFFLyZ/4kW
         j0JhJ6AzXYjbE/hTngq+Iw/jDv8eR3a6F0J0oFs62gFuytbf2MDwi46cZJWfS6q9vvUt
         HTcA==
X-Forwarded-Encrypted: i=1; AHgh+RpCRpS3igP7PEm6q0WRvJkHvAFuccSk2DTixXkfk+Crfz+tTf9G8OM9aXOpMEjvwjypJN/bNSHsGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoY3q8oU3ifKt2ACk7/rJXsX5uPZq2rKtgG8DUmeccml3BaDy
	9M89hy1A/iZ9yjn1t73U2d+IiR9GU2acxdZeHoklU3upLaaAF0H7s2sny/3IA7WzboocWnGWNNb
	2SlnPbVKESvRvKMXwMXqEqBVMsjv2xrQ=
X-Gm-Gg: AfdE7cm7INx1mZgsJtXqE1YQKRTopmhNr6atZ9l/KiBSz7WCKjk9SfIspsuDVhn2/7B
	6LNjBnYYr+Z1pOvl8eNik1YabT7Db7gP75S6CC3XZ/AcfCzZt70I94kKrHSgCbVHYwL40g9RVf3
	r7IAoearotYOBapP7N4vYhQXz4TQyA50mkx/KWDCuCENsHrU7eUCA7QJwNShUJJvTtxDxbjsyDa
	FJbQpD8/fBT5Xrs6MajZWiqOfcu1j2Iq+llS9Quvsgu0yVSEG3MnodZyGBpomRhsnUYTPIqzWnE
	DgYjiWIfqNw5Vl1VLz+AujyWn/0gH9X20Kf8rcUPHalIhhpqs5xqPslqAEhc8ON9lshSKmKECIy
	NPDM=
X-Received: by 2002:a17:90b:1f8e:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-38e2a016defmr3937407a91.10.1784153369368; Wed, 15 Jul 2026
 15:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPew1NKKWf7rr6eZXp=KooN43CKaTbcc-U9ZkKrBhcXaARTKUQ@mail.gmail.com>
 <20260714173314.GA1365789@bhelgaas>
In-Reply-To: <20260714173314.GA1365789@bhelgaas>
From: Rowan Cramer <rowan.cramer@gmail.com>
Date: Wed, 15 Jul 2026 18:09:18 -0400
X-Gm-Features: AUfX_mzejg9nIlQJfQnK5N96SKirYqn6TXuqTZNoBQArUKPl9hWf0-pIf1IdQiw
Message-ID: <CAPew1NKY-=7kQ9KBOyuZ6h2NXMZg_i7h4V2=e665mS5z2sXE8w@mail.gmail.com>
Subject: Re: NVMe MSI-X completions lost behind VMD across package C-state
 exit (even PC2) on Arrow Lake client VMD [8086:7d0b]
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, Nam Cao <namcao@linutronix.de>, 
	Zide Chen <zide.chen@intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Done:

  https://github.com/Laif-added/nvme-vmd-interrupt-loss

Contents (README.md maps each file to the specific claims in my
report):

  - logs/journal-kernel-all-boots.txt =E2=80=94 complete kernel log of ever=
y
    boot since the machine's first power-on (2026-06-26 onward, ~71k
    lines; 9 boots =E2=80=94 a 10th, 3 s aborted first-power-on boot logged
    no kernel messages), including the 3 losses in the first ~90 s
    of its life
  - logs/timeout-counts-per-boot.txt =E2=80=94 per-boot event counts with
    kernel versions (6.18.33 / 7.0.9 / 7.0.10)
  - logs/turbostat-test-*.log =E2=80=94 raw 5 s turbostat for the PC-state
    correlation and LTR-clamp arms
  - hw/lspci-vvv.txt =E2=80=94 full dump incl. the VMD domain (10000:), plu=
s
    the raw LTR register readout (0x100f100f)
  - hw/smartctl-a.txt, hw/nvme-error-log.txt =E2=80=94 0 media errors, 0
    controller error-log entries (serials redacted)
  - report/test-history.txt =E2=80=94 raw phase-by-phase results P0-P12 +
    TEST A/B
  - scripts/ =E2=80=94 the reproducer (nvme-irq-bursty.py) and every test
    driver used

One scope note: the published journals are kernel-transport only
(journalctl _TRANSPORT=3Dkernel) to keep userspace log noise and
personal data out of a public repo. The full journals are preserved
locally; I'm happy to send them to any maintainer off-list if
something beyond the kernel messages is needed.

Standing offer from the original report still applies: the
reproducer gives a decisive answer in 15 minutes, so I can turn
around any diagnostic or experimental patch (e.g. a MSI-remap
bypass attempt on 7d0b) quickly.

Thanks,
Rowan Cramer


On Tue, Jul 14, 2026 at 1:33=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc VMD, cpuidle folks]
>
> On Tue, Jul 14, 2026 at 08:57:17AM -0400, Rowan Cramer wrote:
> > Hi,
> >
> > I have what looks like a platform/VMD interrupt-delivery bug on a
> > new Arrow Lake laptop, isolated with a reliable reproducer and a
> > three-arm test matrix. Reporting here because the fault sits below
> > the NVMe driver, in the VMD interrupt path, and is invisible unless
> > the package is allowed to idle. Happy to test patches or run any
> > further diagnostics.
> >
> > Summary
> > -------
> > NVMe MSI-X completion interrupts are intermittently lost when they
> > arrive through VMD's interrupt remapper while the CPU package is in
> > (or exiting) ANY idle state deeper than C1 =E2=80=94 including plain PC=
2.
> > The drive completes the I/O correctly (the kernel's timeout handler
> > always finds the completion already in the queue: "timeout,
> > completion polled"); only the interrupt vanishes. Holding PM-QoS
> > /dev/cpu_dma_latency at 100 us (C1-only idle) eliminates the fault
> > completely; nothing else does.
> >
> > System
> > ------
> > - Dell 14 Premium / XPS 14 (DA14250), BIOS 1.11.0 (latest; Dell
> >   ships VMD force-enabled, no BIOS toggle on this model)
> > - Intel Arrow Lake; VMD controller 8086:7d0b at 0000:00:0e.0
> >   (client SKU -> VMD_FEATS_CLIENT, so MSI remapping is always on;
> >   no VMD_FEAT_CAN_BYPASS_MSI_REMAP, no module parameter)
> > - NVMe: Micron 2650 1TB (DRAM-less/HMB), FW 26500101, at
> >   10000:e1:00.0; all queues route via VMD-PCI-MSIX per
> >   /proc/interrupts
> > - Fault is kernel-independent: reproduced identically on 6.18.33
> >   (LTS), 7.0.9 and 7.0.10 (Arch builds, clean cmdline)
> > - intel_idle in ACPI mode; exposed states POLL / C1_ACPI (1 us) /
> >   C2_ACPI (127 us) / C3_ACPI (1048 us)
> >
> > Symptom
> > -------
> >   nvme nvme0: I/O tag N QID Q timeout, completion polled
> >
> > Present since the machine's very first boot (3 events in the first
> > 90 s of its life). Baseline ~125 events/day idle; 60-190/hr under
> > gaming I/O. Each event stalls the waiting I/O for io_timeout
> > seconds (we run nvme_core.io_timeout=3D10 as mitigation), which
> > manifests as multi-second system freezes. SMART is immaculate: 0
> > media errors, 0 controller error-log entries against >500 host-side
> > timeouts =E2=80=94 the device completes the I/O; the notification is lo=
st.
> >
> > Key evidence
> > ------------
> > 1. Load is NOT the trigger. ~4 TB of worst-case saturating stress
> >    (random reads at 2+ GiB/s, plus CPU, memory-bandwidth, GPU and
> >    fsync-write pressure, combined) produced ZERO events. Saturating
> >    I/O never lets the platform idle.
> >
> > 2. Idle->active transitions ARE the trigger. A trivial reproducer
> >    (bursty random reads separated by 1-8 s idle gaps, script below)
> >    produces 13-16 lost interrupts per 15 min, every run.
> >
> > 3. PM-QoS bisection puts the loss boundary exactly at C1|C2:
> >      /dev/cpu_dma_latency hold   idle allowed        events/15min
> >      none (stock)                C1+C2+C3            13-16
> >      200 us                      C1+C2               19
> >      100 us                      C1 only             0
> >      0 us                        none (poll)         0
> >
> > 4. Ruled out: drive APST (nvme set-feature 0x0c=3D0: no change), link
> >    ASPM (runtime-disabled via sysfs on the VMD-domain link: no
> >    change; note cmdline pcie_aspm=3Doff does not govern VMD-managed
> >    links, the vmd driver enables L1.1/L1.2 itself per
> >    VMD_FEAT_BIOS_PM_QUIRK), kernel version, drive health, firmware
> >    updates (none available).
> >
> > 5. turbostat correlation (5 s intervals alongside the reproducer):
> >    the package NEVER enters PC8/PC10 on this platform under bursty
> >    I/O =E2=80=94 deepest observed is PC6 =E2=80=94 and every lost inter=
rupt falls
> >    in intervals showing only PC2/PC3/PC6 residency:
> >
> >      arm (900 s each)        Pkg%pc2/pc3/pc6/pc8/pc10   events
> >      stock                   13.2 / 0.3 / 4.8 / 0 / 0     13
> >      endpoint LTR clamped    19.8 /  0  /  0  / 0 / 0     14
> >        to 102.4 us
> >      cpu_dma_latency=3D100us    ~0  /  0  /  0  / 0 / 0      0
> >
> > 6. LTR is irrelevant. Firmware sets the endpoint LTR to 15.7 ms
> >    (0x100f100f =E2=80=94 nonzero, so vmd's BIOS PM quirk never touches =
it).
> >    Clamping it to 102.4 us via setpci was demonstrably honored by
> >    the platform (PC3/PC6 residency dropped to zero) yet the loss
> >    rate was unchanged (14 vs 13). The fault does not need deep
> >    package states =E2=80=94 losses occur with nothing deeper than PC2, =
with
> >    cores in C6/C7.
> >
> > Current mitigation
> > ------------------
> > A systemd unit holding /dev/cpu_dma_latency at 100 us. Fully
> > effective (a full day of gaming: 1 event vs the prior 60-190/hr),
> > but it costs ~2.5-4 W package power versus letting the machine
> > idle properly, since it must forbid core C6/C7 and PC2 everywhere.
> >
> > Questions
> > ---------
> > 1. Is this a known Arrow Lake (or MTL-family) VMD erratum? The
> >    machine shipped this way; Windows presumably masks it via its
> >    own idle policy or is equally affected but silent.
> >
> > 2. The client feature set forces MSI remapping on 8086:7d0b. Is the
> >    VMCONFIG_MSI_REMAP bypass (as used for 28C0) architecturally
> >    possible on client VMD? I am happy to test a patch enabling
> >    bypass on 7d0b, or any other diagnostic/experimental patch =E2=80=94
> >    the reproducer gives a decisive answer in 15 minutes.
> >
> > 3. If the hardware genuinely cannot deliver remapped MSIs across
> >    package C-state exit, should vmd.c be constraining PM (PM-QoS /
> >    LTR / DMI-quirk) on affected platforms? As it stands, every
> >    affected laptop loses NVMe interrupts silently at its default
> >    idle settings.
> >
> > Full journals since the machine's first boot, lspci -vvv, SMART
> > dumps, raw turbostat logs and the complete phase-by-phase test
> > history are preserved and available on request.
>
> Can you make these available somewhere and include a URL?
>
> > Reproducer
> > ----------
> > Point ROOT at any directory with a few multi-hundred-MB files on
> > the VMD-attached NVMe, run for 900 s, and count kernel "completion
> > polled" events (nvme_core.io_timeout=3D10 makes them visible within
> > 10 s):
> >
> >   #!/usr/bin/env python3
> >   # bursty-I/O reproducer: idle gaps let the platform enter package
> >   # idle; the first read of each burst rides the wake-up.
> >   import os, sys, random, time
> >
> >   ROOT =3D os.path.expanduser("~/BG3_Game")   # adjust
> >   CHUNK =3D 65536
> >   MIN_SIZE =3D 200 * 1024 * 1024
> >
> >   files =3D []
> >   for dirpath, _, names in os.walk(ROOT, followlinks=3DTrue):
> >       for n in names:
> >           p =3D os.path.join(dirpath, n)
> >           try:
> >               s =3D os.path.getsize(p)
> >               if s >=3D MIN_SIZE:
> >                   files.append((p, s))
> >           except OSError:
> >               pass
> >   if not files:
> >       sys.exit("no large files under " + ROOT)
> >
> >   deadline =3D time.time() + int(sys.argv[1])
> >   bursts =3D 0
> >   fds =3D {}
> >   while time.time() < deadline:
> >       time.sleep(random.uniform(1.0, 8.0))
> >       for _ in range(random.randint(4, 40)):
> >           path, size =3D random.choice(files)
> >           fd =3D fds.get(path)
> >           if fd is None:
> >               fd =3D fds[path] =3D os.open(path, os.O_RDONLY)
> >           off =3D random.randrange(0, max(1, size - CHUNK)) & ~4095
> >           os.pread(fd, CHUNK, off)
> >       bursts +=3D 1
> >   print(f"bursts=3D{bursts}")
> >
> > (Drop page caches before each run =E2=80=94 echo 3 >
> > /proc/sys/vm/drop_caches =E2=80=94 or cached reads will suppress the ra=
te.)
> >
> > Thanks,
> > Rowan Cramer
