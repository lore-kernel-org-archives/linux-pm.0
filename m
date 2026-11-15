Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794763805;
	b=IQqj2JnoS0ZsXnpYW+VFYIcCu3FRS/VmOBuXX5loLPiRZ2j7GFIPkH+Aq3CIL86Hl5nw
	 +5K/O5OjrhLKpgN2ojKA64y/HBT2Tm09H+0cg1iU+DgHzv/rW6frCxA4rk+7Hx1EoxkhQ
	 WbR3rv1+uycmcuEwEQ1qV6BEhCt9L1RmOrmkq5C8hN+3zDkBdPxMN5CYAmjO5sG+FRd+w
	 6SiMivkvccmbqNgdLjh8oVJaqdFCDmj0P2+6Dpea9x2kBlBuVi3n6idfguDXvWsdtXSBU
	 2XB+scqn8ATIj+0sDedtbNeUPTMTAt3Toyy08RiGBcTfZtrhPDpLnTCo+vN1lfVtwxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794763805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=szgcaEhdSRPZIuPAcY7l9sBqu/oTESFGpiwwqKxq15Q=;
	b=YLDN1YJSAVFfhrZbb8FriH6nKsdKaLm4Btb84yWdjT4xKehBl6IvGKk5u+jVuZUPSnBC
	 GQ5TttEAPqq8QCe4hxV/mMh+RTc7lMLUExpAwHkdLTL42rluvXIJ6N2IHASvA9JmLFs50
	 GJ3lruEsY1qYFYuGfzWFktH3l17Hq+olLPMnupYv8zwS5VSFKGxePnO94qMoluKwGI3pL
	 kPTJoW13Y5CJW+mSonzP+oDj7KqLcw8OCMqa+XR2eH4l/Cimhz2EC5cU+CfwNv5T/bbzC
	 qB4P62LAojU3FhDyPXEcdauk/NtRLhKjLtmgwJE5hweKfbe+Hq1tnK0k2B74jabrQcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CdOuHLlA;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8F606A31F
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 17:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66D8F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CdOuHLlA
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso29087765e9.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 09:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794763803; x=1795368603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=szgcaEhdSRPZIuPAcY7l9sBqu/oTESFGpiwwqKxq15Q=;
        b=CdOuHLlAakazeGhkkf2UaaseAoVmuBV09Btvp9cCTQXz3QAEUjgPCPGjPEo5gsYu5H
         22hSfetLo8AtHFBhPAg0IUM1929l/PqnVEWM4I9i/07KGYAGi3jnQWoebZbTiripLdKV
         zIkQV0ifsKtNyEHeLyhkxGSDu1A4ZP467Dh1SnnL70xh7o7jqnfWysVOuzZlMsONQ2Cy
         sUwDaRA8WxDPMXAiDr60FAS5ZrTLDFfJuXWMHHgYB3gw+StFXGUoERXM6mbGMFIhJkeb
         VURkopOesP648kw9juO02jLew8fzVTliCgpkl5P1NsHZaL/dVIRlaiTtiY0qXcdk2Ssp
         r4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794763803; x=1795368603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szgcaEhdSRPZIuPAcY7l9sBqu/oTESFGpiwwqKxq15Q=;
        b=dSH5NVqDNG77g6cDDZvyfFVQLAk1pAzfoTZlgEnHnraJN1uD4FcCch5hZcFf801DGC
         Nv4VMAATzk4RIynPUqZtAb6YkUJn+fLZUXZSg7vF1//G9yja937HCvjaEEpZvUXCpQNX
         x59ApEzipNPd9U6KD8I0o/VPbipM4VAG6uREv5eJvUnc+xh/UHkVKL3WNUYRT7qulJNt
         oTdNR9RLDistKgKvUfkq7JO+3BHB3mKW85jB5X2YEWk7PqKXZeY5BUV8JKDibJvqSep9
         nz6mva96Fyisnn0DQ7lM4OrHfp7hbyZELhSDDoys+mBuAntvFGAFAAS/L/v6H0hjW7YD
         qzJQ==
X-Forwarded-Encrypted: i=1; AL+hErHvH7sB9LrfK+2OHkcy9zNCyn6bk5Y5ib/klJlQgvmtyQ85s1x5s7PNIz3r9FITTuK0hNO9wfXGXw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ayv23OD0s1QBeCjycV3UdYncYx0kIcC401tToYhanBxrQ/sna
	LecxbDR31AI0RezXBIE765Kde4ScKML0q4TfCqZy1exMHpt9RntsSOUx
X-Gm-Gg: AYBFou3sq2I+VhLfxp3MMp52oMv3w5onn+Pxgu5T+0WsH0R3Ob9z9IgTFkaF5zvNSZI
	kxx8Bb1D6nTbciKZEBkOyunP17YMR5+Wlq7ZP7C2WRmPVfAMZHq0TueCTwzpAwG58nSxnQS8uLN
	C9XxLprDSQ3OuMBmXXkYcDxHuQC2OPaspuUs4G0kWO2NAcWQKT+fonHIAGmB+HMUMJbrb/2lIjb
	cXdLqWA1QG/uzwXcHPD2x6/ybM4qw+m4zTP19iAqFy9ZJMQr1JOvdnvd7l1fmeug7m2xKl1aUUY
	sz2qqAxgV+uL7qeVm2ggsMAzEWxbPMn8yG/XCxPBHI6MWhUfnYC/o7I9P0s4MmoEaIYBtXKloUC
	jNg4g0IQuM9jSeyAq2Dx9j2IPD/K0AbkCPr026wPNPWqIOY+Rsnj9Z8F3mK7J9UhexV9qqYBFtE
	cC97uqmdwdLOZL1Ki8MwCJQtVrARp5vdNRyV48XC+WSPmNvJDsKCoPHzL9MLKZInNUr6ntoBh6c
	/3evdgNjzy57YPSR/MZ17uJy18tOq5SHYe6J6TZBP0cmIuvxbMhGw2JN0j3F2vj0RF21hk4uiqN
	u+oyKat/IbZqUj0NUhK74UX6jZx3WSsa
X-Received: by 2002:a05:600c:8b23:b0:4bb:6f6a:1976 with SMTP id 5b1f17b1804b1-4bb6f6a1e5amr36800135e9.2.1794763802544;
        Sun, 15 Nov 2026 09:30:02 -0800 (PST)
Received: from LAPTOP-AVI.. ([147.234.100.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55acdccfsm236147315e9.8.2026.11.15.09.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 09:30:02 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: rafael@kernel.org
Cc: pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] PM: hibernate: Fix partial snapshot reads
Date: Sun, 15 Nov 2026 19:29:52 +0200
Message-ID: <20261115172951.35889-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a partial read, snapshot_read() passes the remaining page
length to simple_read_from_buffer(). The helper interprets this
length as the total buffer size and subtracts the offset again,
causing premature EOF while image data remains unread.

Pass PAGE_SIZE so the helper accounts for the offset only once.

Fixes: d3c1b24c50e8 ("PM / Hibernate: Snapshot cleanup")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 kernel/power/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 6e4f40e49319..d5e2b8d0b55b 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -154,7 +154,7 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 		if (res <= 0)
 			goto Unlock;
 	} else {
-		res = PAGE_SIZE - pg_offp;
+		res = PAGE_SIZE;
 	}
 
 	res = simple_read_from_buffer(buf, count, &pg_offp,

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

