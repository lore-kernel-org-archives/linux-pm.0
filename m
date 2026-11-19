Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795086861;
	b=PKl1aRGYylrTmcTrQ5V50rbeu4RXzoLRonhEtBD12my7eXzK6IAY11zDqWnqaHjx8KBu
	 Bqto8qnb9Dhijfk4GBnUSmrOauohxd8lNuON/iVoIcIgAJDv35ij7McBlprFvZW3UPqY3
	 N1VQtC0/RBBUGUnFMi3fC7AfgwNZUACcE6In0fSyu+UQK/AI67qQ21E8Gh4RVOlwM/lRn
	 +6uzTwZHylRlTWlzcIPVhketfjcEWQG5nZgz95FnmsuGKymqFHgRSUMUt8xI+xOyM7H5R
	 uPpa5h+BMe2EShJ6T/jTYQ3MsOxk/TbXe/lFbmrN7tgPbZT4ciu3lqbrCf5g6IWQw0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086861;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=gdl4ZwMsFppyGc+IZDtPmhYKKcOVSIQ1Mm6hg1JYybg=;
	b=tODuvgivSiiFlpuNGzGeMD0z0NNSo2KetQQco7OuEpnQBdISAvOKeTM4aIICCQVSgXUT
	 Kqzg5GGrrFKuLILCdCsnOgjoNl8L8fDP4+k+oXuizMjYM70u4lo/1Qk3XnXzrld6MC7aH
	 J5lR5IyGyZj1LBNo4UdxScWLfeLqLoqpitGmxfWPFlTDsiG1wWo39WjVwCCz5ueGdMz+F
	 jgrGmTnqZGrgmaefLmcBCjjjKFtNLFTCi7sEoDUgG1bcPQzGDGlZ7BOqyKBCxiHL2X9xp
	 QWUiDJD4epa1B4VFSEpfbVEDnJeFWjYc7/5Hz/ybCH5Ggw7F8rwngP5CleGcyA5Ji0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=fail header.from=fc.jpn.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF210606A324
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF210606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fc.jpn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b4cc793704so16577107b3.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 03:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795086860; cv=none;
        d=google.com; s=arc-20260327;
        b=PEMFVZjj+4F+GQscn08RhNo4pOgbQcX1kaqCPaVo85+PdOjCXHvqOVqAJ/HIqL9RcT
         QrO2j7GF90/V7HFIOhsnqPq6JCh/VO6aQh8VWSIW4ZtQyAra1MdRUuip3Nl1GFpb0WCm
         UXvgNUkNLpyGQwqrFIJaWXJMEqyr3NbiAVkxHBS2oLSAIqNKrw5iXrVSqOaNbKKK7Tn8
         mE34/q1I/PMtzO6vD7vphBtNJu4iyb7cLaPUvTzwHPmkH/3CMpUvG7HpUbJzu8xFYeX5
         VysJrKyUXFa29nDKz17QEVG3+Hor4+cTIxYEviMkbwcXR75WAktRwvr4eO899ySZABiK
         PqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version;
        bh=gdl4ZwMsFppyGc+IZDtPmhYKKcOVSIQ1Mm6hg1JYybg=;
        fh=KZccbOARQzhIHD1nDW8mM7pbxVwjLoRfUkr98XtWiwg=;
        b=sQgrBkkWHhGltogkV7u7zpugC5IZiqQhdIfyHRbX0ZJMwgx7lG0kGkVs0FoUKAmWLj
         TwDPPpM5BvUfoSENrutoApCdkprn5ga6sddv3gt+Quo/nDeQtWCg9qdPHrWovV8rCeop
         j6Hn9jT1w9/kbZZLRFeWQRb3V3hd7eqiTJ+XuwqvJTOUZTBLQbh7mrnGM3IbA5OOZort
         kGFXJ9qZt3S9qCUKEsyMqjuNFOayVyAv6yfNP33EXhxdQy4JWdY9F6GC4Zdwn/YxMR8e
         52SIrzxJDa3YCSWQlCFvqyq1Rh43CeoYODMhgzvZ4AZVVPr0vdi2HKgiRQJeG5PZpeUn
         NOZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795086860; x=1795691660;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gdl4ZwMsFppyGc+IZDtPmhYKKcOVSIQ1Mm6hg1JYybg=;
        b=d1vHbtjXCR1aoW96fMiC70sbEVhdiX2gvn9kaOBwSeqrD558iBDx4PShNbphkJIGlm
         TOqZK6Kh3O+ITow45DdoJxiYVTL4ocshqOyk7VyDtXlWZXtguouN+YXYJ7H6egBLGxIQ
         RiKC4rUt66+uGB6zEdTfP6ptOolurlW1tegdjk7MuYn3hQJ2lgd4ZCmD9n9jkB/aBS7d
         MSjfq2CGB7MKkLQQY+2xb8GUTIn24Jwf/jlonRDH4A/UuZVtxWxLebiiPIQQNnckS/H6
         I/gxAwOBpkhfK1NF+EYCKtEZJJ61WuAOYBDjq2HqpOeqz/ctS5XS8yuEL48btMvMCz5u
         rtFQ==
X-Forwarded-Encrypted: i=1; AL+hErHnJQgLpXXwbxnayFm+7kbF5lh2jy1miV8OskzvE2RCwUgsxdZLdVSQ1fvT8BrTnDVBpSuC54fI8g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OjS8Hn+o0VwV30pOVVQJ8hbSzRqq7A+GkzcE/vNREwgttDhZD
	PoIPu60I0UOVpuGxnsvp19UM5vyZ1cmygcpWo8YLpI7/B7Ew/3LGEAFma96jGtpUH4n2ugMWxoX
	+rGTlPsSpXrCCnicu5ipme8rz3Pw8rdY=
X-Gm-Gg: AZFdTZdcQ3BE674q3hxYGiHWb5QQYLqkbJWQ8YsU1gmVXmCcZwCejun0Ih3sIdLoQ+h
	ncCjoTSeUn+nycddmAXtH53dCpPwEvwGlqygvg9hKutsgLkW0OL60ZEEgIhW1foVylrIVmxcWFr
	HLWLynBt2FLQXJaZnyPydtMVPgpEybuRYnPVe1Fts78eS0cdPw1wCQROoU61eYP6Ee4V6HG+4ML
	10/WELxtiCiSnCpsuqhXuxSjlkMtxaSrkiNmvwgTxINWqFPFvsCCxxwHQPFPfGd3WTqnW98zciD
	xbSc6FafUg57J9rjS1C5Lwod2wehuNp2yGmD8NAG/iXQf4hqRTy9C5n/Rc2Pk0tmKv5S3zevue6
	ABns8+GbR+rmihMa+NB4pf6TELZJKghakb+LRfh1N0VQenxJipZMaaXjFExF58oFRJJlBMs8PRf
	C/5Fo28QroA40egiqbYPiuSkl0L/QyC+s65VW/G6A=
X-Received: by 2002:a05:690c:44a:b0:8b3:2e4f:6c06 with SMTP id
 00721157ae682-8b4fed6f8c2mr19300117b3.47.1795086859463; Thu, 19 Nov 2026
 03:14:19 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Kazunori Ando <ando@fc.jpn.org>
Date: Thu, 19 Nov 2026 20:14:07 +0900
X-Gm-Features: Aa3M54qH87R4r-pJ1ObKkvFZ7ORk-7hIS0GY3zxihV_ERs9C13QvuiQcSH1M0Jc
Message-ID: <CAKPbQspktkzF-GH9728aG0mAiQGG9NQxbO15ruvcyaQGTm2y=w@mail.gmail.com>
Subject: [BUG] x86/hibernate: Intermittent resume failure due to a 4 KiB
 EFI/E820 memory map change on MacBookAir5,1
To: rafael@kernel.org
Cc: pavel@kernel.org, linux-pm@vger.kernel.org, x86@kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I have been investigating intermittent hibernation resume failures on an
Apple MacBook Air (11-inch, Mid 2012, model identifier MacBookAir5,1)
running Void Linux.

The system occasionally performs a normal boot instead of resuming from
hibernation because the EFI/E820 memory map changes the classification
of a single 4 KiB physical memory page between usable RAM and ACPI
Reclaim Memory.

I have reproduced the issue without GRUB and without the proprietary
Broadcom wl driver, with a kernel taint value of 0.

1. System information

- Hardware: Apple MacBook Air (11-inch, Mid 2012)
- DMI product name: MacBookAir5,1
- Firmware: Apple EFI 429.0.0.0.0 (2022-03-18)
- Architecture: x86_64, 64-bit UEFI
- RAM: 8 GiB
- Distribution: Void Linux (musl)
- Affected kernel versions: 6.18.62 and 6.18.63
- Tested kernel: 6.18.63_2 (Void Linux package revision)
- Swap: 16 GiB swap file
- Hibernation mode: shutdown
- Boot methods: GRUB and direct Linux EFI stub boot

The tested 6.18.63 kernel includes a small diagnostic patch that prints
the saved and current E820 CRC32 values. The patch does not modify the
integrity check or the resume behavior.

2. Steps to reproduce

1. Boot the system with hibernation configured.
2. Collect the EFI and E820 memory maps with efi=debug enabled.
3. Hibernate the system using shutdown mode.
4. Power on the machine.
5. Repeat until the system performs a normal boot instead of resuming.

The issue is intermittent. Multiple consecutive successful resumes are
possible.

3. Observed error

A failed resume produces the following kernel messages:

    Hibernate E820: saved CRC32=1eebf10d, current CRC32=f70aedce
    Hibernate inconsistent memory map detected!
    PM: hibernation: Image mismatch: architecture specific data
    PM: hibernation: resume failed (-1)

The failure occurs during the E820 checksum comparison in
arch_hibernation_header_restore() in arch/x86/power/hibernate.c.

4. E820 memory map comparison

I identified two recurring E820 memory map layouts.

Layout A:

    0x8ad53000-0x8ad64fff usable
    0x8ad65000-0x8ad8efff ACPI data

Layout B:

    0x8ad53000-0x8ad63fff usable
    0x8ad64000-0x8ad8efff ACPI data

The only difference between these two E820 layouts is the classification
of the following 4 KiB page:

    0x8ad64000-0x8ad64fff

I independently reconstructed the E820 tables from the boot logs and
calculated the following CRC32 values:

    Layout A: f70aedce
    Layout B: 1eebf10d

These values match the checksums printed by the diagnostic patch.

5. EFI memory map comparison

With efi=debug enabled, I confirmed that the corresponding change is
already present in the EFI memory map.

Layout A:

    0x8ad53000-0x8ad64fff Conventional
    0x8ad65000-0x8ad8efff ACPI Reclaim

Layout B:

    0x8ad53000-0x8ad63fff Conventional
    0x8ad64000-0x8ad8efff ACPI Reclaim

Thus, the difference is present in the EFI memory map available to the
kernel and is not merely an artifact of the E820 conversion.

The physical addresses of the ACPI tables reported in the boot logs,
including RSDP, XSDT, FACP, DSDT, FACS, DMAR and SSDTs, remained
unchanged.

No ACPI table reported in the boot logs occupies the affected 4 KiB
page. However, I cannot establish whether that page contains other
firmware data.

6. Reproduction without GRUB

To investigate whether GRUB contributes to the memory map variation, I
configured the same kernel and initramfs to boot directly through the
Linux EFI stub.

All initial warm and cold boot tests through the EFI stub produced
layout A.

However, the first hibernation resume attempt through the EFI stub
failed with the following checksum transition:

    Hibernate E820: saved CRC32=f70aedce, current CRC32=1eebf10d
    Hibernate inconsistent memory map detected!

The EFI memory map changed the affected page from Conventional Memory to
ACPI Reclaim Memory.

The kernel command lines before and after the failed resume were
identical and contained the EFI stub-specific initrd path.

This establishes that GRUB is not necessary to reproduce the issue.

7. Reproduction without the proprietary Broadcom wl driver

I repeated the hibernation tests using direct EFI stub boot with the
following additional kernel parameter:

    module_blacklist=wl

I verified that the wl module was not loaded and that
/proc/sys/kernel/tainted was 0.

The same hibernation resume failure was reproduced, and both directions
of the E820 checksum transition were observed:

    f70aedce -> 1eebf10d
    1eebf10d -> f70aedce

Therefore, the problem is reproducible without GRUB, without the
proprietary Broadcom wl driver, and with an untainted kernel.

8. Related discussion

I found the following related patch proposal:

[PATCH v2 0/4] PM: hibernate: Add relaxed_memmap option for x86 E820
integrity check

https://lists.openwall.net/linux-kernel/2026/06/23/1726

However, the proposed RAM-only checksum comparison would not appear to
address this particular case, because the usable RAM boundary itself
changes by 4 KiB.

I understand that ignoring the E820 checksum mismatch could be unsafe,
particularly when a page classified as usable RAM during image creation
is classified as ACPI Reclaim Memory during resume.

9. Questions

- Is there a recommended way to investigate why the firmware memory map
  changes the classification of this particular page?
- Would additional EFI or ACPI diagnostics be useful?
- Could a platform-specific workaround safely handle this type of
  memory map variation, for example by consistently reserving the
  affected page before it can be used as normal RAM?

I have not yet tested the latest unmodified mainline kernel, and I have
not established whether this is a regression.

Representative before/after logs, EFI and E820 memory maps, kernel
configuration, hardware information, module and taint information,
and the diagnostic patch are available at:

https://github.com/andokazunori/macbook-air-hibernate-debug

I would appreciate any suggestions for further investigation.

Thank you for your time.

Best regards,
Kazunori Ando
