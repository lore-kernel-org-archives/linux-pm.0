Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795642870;
	b=4IVmApyn6AQaE031U9h5GBZ3HFTQcVnH1d2UJOpaX3K9JKe93yEvji1/UBCEfjN39IiH
	 FsMNN78WYkLAhF71bUBf/0Jhlt3QgJyPw/bTjpx6rFXEyPQ1dyM7zGGIQBEOtAaj5vOE/
	 LHZzI0FBEYUC/D8uUjxSvuOG26XSrOeEx1J2GOXwVCiqGf7S8QuztjC/eoOjuRrv9/Usf
	 F6TCJpV4zeAj8iKEL3SLe4kc1x0iHt0wUwYed/VULxhhyQAKirCEHAygBfC6u11P9SUE4
	 ZwIC3+zEyTht+YHw0b806YUhTnVrBt6gngNib4KaS1VCF+oTH9yxMGtivosfAQJxEoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Hs7Z4dSlPzZIU83bg2ZGfkYDjyGJ7+bM1OgNG/+I3Js=;
	b=04OzkEopYKW37ZP8NkC+4gtBe5gyxLt/c5F+dfTIazBcLTQr6iRhuoqzXQKS2DRDA4BR
	 nRjXu9AxmSiA7EX/ojFgEgpXqnkqJ7JQhZzD2flXJzBVefZ4Xetb9gYSwfB6dcFgpZ0a7
	 hTxPFEdLAJxCHFIMXWi8vvj43s5v9ZYG1SEpD1+PX2PHxRS4dQFtmv5eJ2adPweMlp4qF
	 m06wM2z+27Rab3sfSgGm7OUekK5JbpKFEn0x2Hc82nfsixav0fghCevblraoqwR0SvOQv
	 VGxKG/3E+PUoaiX345Hf0hqGmtE+KV3OsA5OXdL6SvoSm/AQIHErxEdxB4oPaQpKnSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aC3740uV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441EA606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 21:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 441EA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aC3740uV
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ba1e22ff4dso7527305a12.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 13:41:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795642869; cv=none;
        d=google.com; s=arc-20260327;
        b=MX0GSr1dSR57918D/IDjdLQLu0m8VjzLRm0x1scKAohbf4fMaTycF1hIvOLG9LXebx
         J+eZfrv/TW5ef/bRb8Y1jSN1X4eNJjxeIRlICq345VPhqrc37zJfKDOh0M+P3YFRsYrH
         EIVjYstTZBTdzxWPJBGwrNeUdoSaZOnIrtQVR35qJd4cJjkkpcAlfke47QQZj3wqqr6E
         gf+je9mUgNoNlygsgXeaUaxV0tedzSv/9K72+UhhcL5l/ivcEBxcuOYz9OAyu5GwM4rd
         7R0aDXfLVV7gMQoycNQmSX+N4khFR+zvo92tJ3LGLJ0kyCFj9WCxKqIQlz1KTRw7TfWx
         zlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Hs7Z4dSlPzZIU83bg2ZGfkYDjyGJ7+bM1OgNG/+I3Js=;
        fh=9Nm25G4LkIa3gyr7hLMXW0yALnb1cfUEbSG/xJfeeCI=;
        b=pH8h/JhY+W2veSVQte60HZqUBGgfKYRL4eBieTzea/CmKoYASGJu5s2SsaPzn5F+zj
         hRCQtB0ljM5P15fZDL+yWpClmosnqvjRu/L7GO7pL5A+WBzbANSIN7tMZNgIXh0TM7OK
         viqMoxdlTL1E0pdvJxpWOHeRnVIPuZKdLTgvYI7Kwz6YZdDeT8G2g69FBykNhOijB/6c
         gjjI07pEwcl1ELRFW3+rO6BuD54Bgvd4O/AxgfDDCFlRq79+jZJkUi9ybv3lBiBESw+5
         EeSUHwumfWt/+Gwg+Ze6SRO320VDWgEh7Cz+yQ+GskxKprK1eZhHCbj+NYdTZv6KUJFY
         Z2Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795642869; x=1796247669; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hs7Z4dSlPzZIU83bg2ZGfkYDjyGJ7+bM1OgNG/+I3Js=;
        b=aC3740uVgVcyHCk3CmmlKf829ag95gDggE1ypjdPOMt1t6KoSJzC9w+nj2Y7G/65yW
         VP8q9jwLQFzGYlwqygAFGiaNbGigY7UvHmBVFXiSTeOe3Yf0Wz0Q4m0eYWc5abftDy7+
         qOmck9n391Bqr968mTrDMAQy+FYjLFqXA9P7bcK1iIJvX73AQpI6CgMqRjo17Oc3fCH7
         dsXYnUyo62OZ4A/csv3h5hIU1vZoY4n6SCOs63e0XhDnJ6MXdIa9Q7QFo3seUIL3Q9iP
         cINpwH8wNJTAIy//DGMq4/s2l9GgDxzIbi8hdElRxqlnhPK1Dtyln6NCJTMm5BurWXyw
         SEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795642869; x=1796247669;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hs7Z4dSlPzZIU83bg2ZGfkYDjyGJ7+bM1OgNG/+I3Js=;
        b=A4cF0UGkB6y713lmvacNQtrH7cDSKEGTWO7gtbFmNwG50JPmKXxD1ULRlXBaWVwc/j
         o2CjuZRcMhOEI4XWiW+U4JV8fr29rWcmZ/S38Yc+QyDOUUILCq55g8nSW74H1ekkxr9J
         HjYvs5tIrEF08JZ++oYKrRWx56JT3a1XhT+y9U/OSxLSDClY5v9bQhTVSZHh7PWJF+Lv
         i4fr+kLWI/1J2+bLN+NBMCnOxWbFM9dNb43jwH4r6TrjgdOESuQskbzuzPu6dIGNc22t
         ixzSNVXbtFP9AFMGZS4kYDmmrdquZmHEbxwKEnui1FFo+akAsX/+/yh9oAPa2q+rlARG
         XUjQ==
X-Forwarded-Encrypted: i=1; AL+hErHvFAgAO14mbXyPtiA2HNM6q79NEauB51u2PhMTXWKmZ79s02cLBVKCc7iuISnejeDo22mc3tWUuA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9W7lgxilJOKR28yJH4RPQBnwsMNk7zU114Mq805WddEBU6mcKl
	unIEyp2WBa+hbcL6/GQJVcYL4uBn0ccsqotpmkKcCJWYsiWNqE66rEgFhFbgeWBpj+NQsBw0Tnb
	3WTCrx2bLA+cRPUaqL4I6JVI0rSfJ4/g=
X-Gm-Gg: AZFdTZenbTsQL6AYHIM3Rvqc3svUdIQs5E9X6WH/2FUKSEilpynKxZ+UwEIvlNuOuZ/
	CK+jRmygiZ33w2DWsAXC/8yALVBoLfumstZakkXFsUks4fnHn0B8jEpAW+GdELaKLtOzXyfaOsP
	bERdTPbffa1Vr13NN3BL96h7xMN/ip/+/vhEnHvIqO5/echRCIjlIurFuFX556zBslJkFNYV0vN
	XeK5YEk8fjBfBAfMA702h7zUMi5GFJBeAKWY8F0pa2Ah/5ZCURqG7TpM5L+l7hwUhP7o71d5nR6
	jCWCSI39Q3MvaYUHx2ouFP4OnfsX1Vus76VKTU4i62P5qHLdV2VXRXPkKSUK3bhO3xLIc6Waoyv
	/NhSNiSJqxNSLtIdJRyTrkCWGQtqvhDhhQYBdis45DWVZUgXVN1MxEBEBAqtLGG772r1iVz8=
X-Received: by 2002:a05:6402:13d6:b0:6ba:857e:ae83 with SMTP id
 4fb4d7f45d1cf-6ba857eb664mr9860990a12.13.1795642868334; Wed, 25 Nov 2026
 13:41:08 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Marco Sousa <marcomsousa@gmail.com>
Date: Wed, 25 Nov 2026 22:40:56 +0100
X-Gm-Features: Aa3M54qfJGFxhgD70-BdRQ7MJG0bE-l0ZUccxFIG7pX-78XZybuqjHc_9rgjpGU
Message-ID: <CAHRsBfbYF3wocif+a0FRyBBkhcL+FtKF2qm=ne0jgLCzL8cH9w@mail.gmail.com>
Subject: [BUG] AMD Strix Point USB4 (1022:150a): mid-s2idle pciehp hot-add
 causes D3cold->D0 failure and hard hang
To: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org
Cc: westeri@kernel.org, bhelgaas@google.com, lukas@wunner.de, 
	rafael@kernel.org, superm1@kernel.org, Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"

Hi all,
I filed a bug report with full sanitized dmesg logs, lspci topology,
controlled A/B test results, and a thunderbolt.dyndbg=+p boot log here:

  https://bugzilla.kernel.org/show_bug.cgi?id=222327

Short summary:
On an ASUS Zenbook S 16 UM5606WA (AMD Ryzen AI 9 HX 370 / Strix Point,
BIOS UM5606WA.321, s2idle-only) docked to an HP Thunderbolt Dock G4
(Intel Goshen Ridge 8086:0b26 + igc 8086:5502), reproduced on vanilla
6.18.65-lts and 7.2.4..7.3.6-arch1-1:

1. At boot, tb_acpi_add_link() creates the device link from 0000:00:01.1
   [1022:150a] (consumer) to 0000:c6:00.5 [1022:151c] (supplier):
     [ 5.005536] thunderbolt 0000:c6:00.5: created link from 0000:00:01.1
2. Host router reset tears down the firmware PCIe tunnel:
     [ 5.008763] thunderbolt 0000:c6:00.5: 0: resetting
     [ 5.008813] pcieport 0000:00:01.1: pciehp: Slot(0): Link Down
     [ 5.008895] pcieport 0000:00:01.1: pciehp: Slot(0): Card not present
   0000:00:01.1 then runtime-suspends into D3cold (power resource
   \_SB_.PCI0.GPP0.PWRS).
3. After dock authorization, tb_tunnel_pci() activates the PCIe tunnel
   cleanly:
     [ 9.429077] thunderbolt 0000:c6:00.5: 0:5 <-> 2:9 (PCI): activating
     [ 9.430721] thunderbolt 0000:c6:00.5: PCIe Down path activation complete
     [ 9.432080] thunderbolt 0000:c6:00.5: PCIe Up path activation complete
   Yet 0000:00:01.1 remains asleep in D3cold and never wakes to enumerate
   0000:01:00.0 / 0000:60:00.0 (igc).
4. On the first s2idle entry, pci_pm_suspend() runtime-resumes
   0000:00:01.1 mid-suspend, invoking pciehp_runtime_resume() ->
   pciehp_check_presence() concurrently with device_suspend:
     pci 0000:01:00.0: PM: parent 0000:00:01.1 should not be sleeping
     pcieport 0000:02:0x.0: Unable to change power state from D3cold
to D0, device inaccessible
     pcieport 0000:02:0x.0: pciehp: Slot #8191 ... /
pcie_do_write_cmd: no response from device
     igc 0000:60:00.0: PCIe link lost, device now detached
   Entering s2idle in this unenumerated/wedged state causes a complete
   hard hang requiring a ~30 s power-button EC reset.
5. Controlled A/B proof on 7.3.6: waking 0000:00:01.1 from D3cold once
   before suspend (power/control=on + lspci, then restoring auto) makes
   pciehp immediately see Slot(0): Card present / Link Up, enumerates
   0000:01:00.0 + igc, and makes s2idle 100% reliable with full hardware
   S0i3 residency (11-27 s, Last S0i3 Status: Success).

Also attached on Bug 222327 is a secondary drivers/thunderbolt/nhi.c:143
(ring_interrupt_active) WARNING + Call Trace seen on dock hot-unplug.

I have the hardware on my desk and am happy to write and test a patch.
Could you advise where the proper fix belongs?
- Should tb_tunnel_pci() runtime-resume the linked host PCIe root port
  when activating a PCIe tunnel?
- Should pciehp_runtime_resume() avoid hot-adding devices while system
  suspend is in progress?
- Or is 1022:150a expected to receive a hardware/ACPI wake from D3cold
  on tunnel activation?

Happy to collect any extra dumps (sudo lspci -vvnn, acpidump, amd-s2idle)
or test debug patches.

Thanks,
Marco
