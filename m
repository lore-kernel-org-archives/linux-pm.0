Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792851240;
	b=Wr9sWvqHVL91+FmmFaEo0hiS27asrwweIcAkzK3GOElddUArT9groPBy4MpGUgElizjp
	 /mXcrMwgLdPH9uYqvMrH+qx87tgPY8hlJixpVX20rc7Y+gbfxuD2svUTlVRvM2UXVMOjb
	 f08yYwkiaKBJ4BYwUkZaQuul5w4pqH0H1Bdb/sdO+c6zOaZw0VVdpbhQRwtiK5LZTWKX9
	 15IPjYLgA+c5b+ehnP0kwKh8QTH3qE5NIy/iaxpnMBq+ECJkrhmhBTjwYXHxxvyUL6FFY
	 MONibqqyde3yeg7RYrzqTt1zC8RK9ZOHe+CzWECsbb8WS2iGlSzWxRrGd2mpzUWDVTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=b97bMXvzGRIjznY7MGqSzwOhOEqCJ6AU/b6pGdoAGpE=;
	b=5fvXVWi9NfND2wqQHGkHUs6KGkAcuPcBf50xh97IXpR4Z60ly2O2XIPea7QcJA9FEtVY
	 DNr7/Z/XDmGSRsXBwMQ6ZkIbRlX7ozCE16g8L9UGkLLD55OmMuuObQfWaaAyMFSttuX2D
	 B/T8dZnJkLo3yqWtTTOQaJkrvOsMvpEjPYyMAP4Jhpj4D5iPXHw5ubdLhm5TdOdQL6hme
	 U6rdP0OeaFtbx5DslOz84V/wCZhTbxGa1M5xzsCuupS3XPcXnR5bWEIdnOpepprBjvL0D
	 /YWBGVi9FC8s5kVLWooOz+thJ6PIHjip+b+4UAJxqHFfD8jJ/PwCt6Su47TwkwrdY/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ezdj4S4x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6EA606A31E
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 14:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E6EA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ezdj4S4x
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be47aa555cso1890754e87.3
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 07:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792851238; cv=none;
        d=google.com; s=arc-20260327;
        b=dL5Zpo22oqk0E4eDvqFRaYr9salMneMVZNsHHvC/uJChszMW24tbYIwHXJubyBp9uL
         2hIb+G5MxJ838uEOqTvdGPT4wqt42VJnl7N9d/9N7tlUxsSBlo/XUfwauW/dLZfkHzjl
         PdeiUihf7NHGTSg08UYgrpsZa1oMQP8wYuODshtpli1HvMeKX5Djgg34HP4GXrtOL1eo
         87hUpEgyKyttXfarIAXPvhNW0lbhFhNxQ3YxV8fQie03P/4cjGANZYz3dbZ7X8NyB92L
         5rv9CxMirFH5mJhH7twRyQW8s6s4j71Fg/VPnPFaUychlYk7bxFw0oi8r+x9pXjxBUJH
         Zcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=b97bMXvzGRIjznY7MGqSzwOhOEqCJ6AU/b6pGdoAGpE=;
        fh=tZzc/utmHXZtni63fbKSCRlMEGf5YrXtGMYkV38NC+M=;
        b=X255e/MFaDEok3MtFtAounuj2tr7RTeddZtEuqXfknKxgHWkFo8bVrYX+SNerSRVC0
         pEJyUEcxxDMf0/YjoiPv2Au9p/ISpg1PE8P7HOpzsdQRSiRbrvNzfFZgZ4g6WxN6c1Pa
         1LqMUH8qsPnQHxY3iK4UQJyhOQg3XNN4ZmDI64n8XE/p11lJ6HGhJc32YUgRG8S+8fOV
         sjDKRdlUG1y1gsFW72NdNm7bdw57qzeEDG4+bYAVjrDUpCUlTn72iPEOyO+Nmm2VRPGU
         okzUztnpcgbqTcaRN+1+MY/tpgDG0OARspQaw7In0AotNAqMNI47LMFcQL0mfXzQpnBW
         gNrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792851238; x=1793456038; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b97bMXvzGRIjznY7MGqSzwOhOEqCJ6AU/b6pGdoAGpE=;
        b=Ezdj4S4xEB8h7gxc03c2uOcj/ii601I7+Cd4LQAP+csNZtwqaMJrX7yHnV/QRvc3eh
         cy5B9dqUS+Oz/fwYJJhrVqldoR3wqQnjxlmUmztY2taoA9FuiP+qznCrX4ahYkiZVZJu
         +CK4AGKWWOPfbp1ZMEtLRjpXJCu/Oz2kFxxBB2dsvUX6X0yHqRvjodQCXe61EgiHfvYY
         hMbpHMr9o/zG1nWClTKTYPQD2wyuXpHLbF10wB2AhOCIIO7GJyBE+Z/eYGPJ7wju5eYo
         fMZQIwZIRn2RVGmTi2WIrciOEUSxYeriB/lDGzOvior6snXECURFiS0d8YdclVa7uPK8
         4vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851238; x=1793456038;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b97bMXvzGRIjznY7MGqSzwOhOEqCJ6AU/b6pGdoAGpE=;
        b=srqfVoC8lS0yQnIqjxmKl80JdOM/IOxY9YXcTWC/Kusbdf6Jf5krT4Sb88op12IBFi
         v+bAuSawuAX5erGwDQz7UuEQeTNyp0hQ2nX1n+7y036O+N9N6OFpa/w3IgfPYcvb2/Fk
         6pDXGuuwZfoFrtu1J6ML7A5HJ698LDgFnqBi3jsoYu2Fj113yWZ99u4gyLDm/7rv/BDy
         UvzCr2/wFsImGmpU/jLw7Hu0H9y3FiFtDDvlovrMi9qGEN6EFsxXSyzu5SQ6buG6jpgP
         2FygYVOjdPhm3/z1tr1djzDh0IV8a3r10X98Rw8lgWhv5iT6PvVQnbxJTYU3CEeEZuj6
         5AJg==
X-Forwarded-Encrypted: i=1; AKwUvBwEqsvdDPrEvY5cS9BK8XRVt00jl4G01aTgfzG9atAdid7AJWcqJ/+TVxeZAEAmnks8M3zdPBdiHQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJZO1Kl977jNazCbTiUWRd3N0Fl1eiRhHUne7jcUg+6pah//FE9
	7smNYFIuismE3BGjwjNxe/ssS1GmRx0RxKQVPV2g7rJZLNX2slz7Ax3cV47UNxjMUpqMB7yfEYg
	SfmxiqQLIqI460Yq2CIzFrvr92SSYTpY=
X-Gm-Gg: AYBFou3CTmyU/zH26sZG4xJR8re387tjPfm9XwchIRHCcZA8vki6bRBVM5Cmzp/lrjW
	nFX8NNG27fgtKUErKqIyuWRPx1VQTuIk/hBGgwvNlq3yiSkN8HZjKrK+Fid4ty2XG4qX0uaphPc
	d+cSbyb1QmOWxYio9PanbnK6Ow5EL9Nnh2BdjgjvBKBAcS4YgMBb/1t3bZFcDndFkqBhuP5GxWY
	eZW1zKII2RgoFKf72Bi+1p60a6rwzJ3vYzlGbNFTElz8P3br5CQI+25Ydzg5OCL6CIV1MZYZjS+
	pxR/EGr2b9pV1o1YhSQG716i7D2wHDR5HRii9z3RYFcKBL3Qd2uI2NYmXRw+0yfHMVftn2KBusJ
	NIzEkl/8y1nY0pakBZ1H0SK3+mpMxvW+1cp3nkA==
X-Received: by 2002:a05:6512:a83:b0:5bf:ae8e:ef5f with SMTP id
 2adb3069b0e04-5bfb7170240mr682770e87.5.1792851238053; Sat, 24 Oct 2026
 07:13:58 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Andrea Santin <asantin36@gmail.com>
Date: Sat, 24 Oct 2026 16:13:46 +0200
X-Gm-Features: AclHuK8rSSexd6wbySxEH-6RWmgS6VGKifIVY5kw2Vlwh1mO1AHs7PtfFqEvVSg
Message-ID: <CAG3xgg_10jdDiT3iSSQmm+hHDWmgdaSe8=DW=ddC6cE7rE_MNw@mail.gmail.com>
Subject: ACPI / HID: Lenovo Yoga 7 14AHP9 wakes immediately from s2idle via
 GPIO 12 (WACF2200)
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Subject: ACPI / HID: Lenovo Yoga 7 14AHP9 wakes immediately from
s2idle via GPIO 12 (WACF2200)

Hello,

I would like to report an unexpected wakeup from suspend-to-idle on a
Lenovo Yoga 7 2-in-1 14AHP9 (machine type 83DK).

Hardware:
- Model: LENOVO 83DK / LNVNB161216
- CPU: AMD Ryzen 5 8640HS
- BIOS: Lenovo P9CN33WW, version 1.33, dated 2026-03-27
- Distribution: Arch Linux
- Kernel: 7.2.11-arch1-1
- Suspend mode: s2idle

Problem:
When closing the lid, the system enters s2idle but wakes up almost
immediately. This causes the lid-close suspend behavior to fail
intermittently.

With the default wakeup configuration, the kernel log contains:
- "PM: suspend entry (s2idle)"
- "Setting wake for GPIO 12 to enable"
- "PM: Triggering wakeup from IRQ 7"
- "ACPI: PM: Wakeup unrelated to ACPI SCI"
- Repeated "GPIO 12 is active" messages

IRQ 7 is handled by pinctrl_amd.

ACPI investigation:
The DSDT declares the device \\_SB.I2CC.TPNL with HID "WACF2200".
Linux binds it to the i2c_hid_acpi driver. Its ACPI _CRS declares a
GPIO interrupt on pin 0x000C (GPIO 12), Level, ActiveLow,
SharedAndWake. The device power/wakeup attribute is enabled by
default.

Workaround and test results:
Disabling wakeup for this device with:

  echo disabled | sudo tee /sys/bus/i2c/devices/i2c-WACF2200:00/power/wakeup

prevents the immediate wakeup in my tests, while the touchscreen
continues to work during normal operation. With this setting, the
laptop remains suspended until I reopen the lid. In the captured log,
timekeeping remained suspended for 43.838 seconds; the subsequent
wakeup was associated with IRQ 9, an ACPI EC GPE, and a notification
for LID0.

I repeated the test several times with the same result. I also created
a udev rule to apply the workaround at boot.

Could you advise whether this should be addressed with a
model-specific wakeup quirk for the Lenovo 83DK, or whether the
ACPI/GPIO wakeup handling should be fixed more generally? I have not
established the precise underlying cause, so I would appreciate
guidance on the appropriate subsystem and possible fix.

I can provide the relevant kernel logs and ACPI table excerpts if needed.

To solve the problem, I used AI during the troubleshooting phase,
since I don't have the necessary skills to do it myself.

Best regards,
Andrea
