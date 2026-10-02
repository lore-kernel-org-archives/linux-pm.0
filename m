Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0F311C1B
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972927; cv=none; b=GoATk16LwshUI3XYa5tPJdf7JfW3OBvu0sN/54khc6JaaET6s9kfg0mTbUnF7W3f90eY02oXkrEqQ9v4H9GigUmNaRGLv18t3e4/Qm7DnLzkBVFw8AdNI3vmR8HBudnHQuSbR0Z5Ejdl5ExJmPJwQXs8Ze1qNvwgQiAGLT10oFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972927; c=relaxed/simple;
	bh=D8X1XlYV1xq+RxSSILgm+MOm5JovS9lyKgYPVNdN+s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIWAMKSxfFFmWGast/pIBIwexud+mAceO53k4YhlTKz3WHBo7E6qzZqPjNLvZx9SS/W8enaPJODIIu56xLpo5r0r9fkiaoFZM14dvOWGugnzHhZa4cNKsqLAhxmT9iFtxBkSPVNCjDKs4jzDu/UmDSHebkEoTJzonCOKgOZtHTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO3qDnV0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO3qDnV0"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso1435655e9.3
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 13:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790972924; x=1791577724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D8X1XlYV1xq+RxSSILgm+MOm5JovS9lyKgYPVNdN+s0=;
        b=GO3qDnV0dYMmoFyyJqpNAYbapJBvvuhHH0gvbIWTIEwmvpHXI2HN4agDqg64BUU3yb
         vgVSdzmKd70AoHapXrrSwaXh7w2EvK7TWHEP8iBQyGCNdxXO18C0fN/DEkVC7a0MmZ2r
         VUGL8aUkUZPZFd/99/aHvbYLO2rN3St0FiRK/2iwyrcSjaS6BCgPR6quMz2zvCgdY92b
         Y0oso/psnb7xYyTP1lqjv2gyA0geb8d5QUD6kzSOor2IGV8suTP330FyCh77zkeOrEG6
         R8Q5sQEsp2hWYpUoCofpPeRu3cCwO5xXG76nHqe03w9OhBZlOO7F15hZqVpXPg/VdQ/x
         Iw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972924; x=1791577724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D8X1XlYV1xq+RxSSILgm+MOm5JovS9lyKgYPVNdN+s0=;
        b=peWUHrFSR46jV+nz82iAkUC/0OhZv6WIHrpBIEJ6RniQX9Q1a09LJ8RRqyGcKRX2Hu
         XNxZX5TEgZl9y6shwAnOi8K4XOIlsjhaTX97+xeprKsGS63/c8IIpu99JFOR4TElVKkp
         h5+i3w+RpfrmLAj8wLaszCxGPNlzgTSrNTx4MNdjOaJ2x9yjPchRSAsKaVmuM7dlhSS2
         JzoBTI4400LSoGBgarEGDeX7cOnqIhQsoJEcx314VL09yNzIdNy/cRdg105Y/acFlOWW
         ous3KJBOOHXu2t1iLqFl0RGVhk5To2Oj9TQdxXkLY2uayK1Rr3Q5s2+G+sDpLFg+laM5
         0JDg==
X-Forwarded-Encrypted: i=1; AKwUvBw3DYl8AbGFKlCBns7bM8im6UfwQGKqlp3CiNGBHa0vsay1yHkrqd7Dj5MvJq4Uco2995FIQQ/wwg==@vger.kernel.org
X-Gm-Message-State: AFuF++nogbgUl2tTQjIOVvynHNdOQnm95sgmgZwsi0Rm/xj8T6GXS9Zf
	JMRNuarOH8RtDwBR/kTiUxXPNsLkPo4t5MjXxypXWefIa8JeB5Yk7bUZ
X-Gm-Gg: AYBFou2TaiGZ68xUVjyfUnRJrdd6j5TY492k2TeZfpeEggQDf0AqA+V3IA7cTHz+eLX
	fOCDaosiibT+fPV4RDRPI4fzkpN88krAMsKiuCOQ3t2Rz3I1tM1NCOwwZhddBEuv2+TVzPAa511
	Tfa/TgSqRmtPaRfKZX104wgFCBUP+SBjD9u0T7gor8ginSruZnFezssiItDBdOzdnBUicx45cLa
	b/FxIFLafvfpPh0OEbxR8nR+jfxQoeXJmMvfq9nwzEpuCQI6ORl70NcnrD9C+sOCLSD3SBf0Zut
	TSfq5Fwafg6ILJyncrw7mfxLR7t8AVTzsDAO6+BeDZ53gYrfQOLRX6rCJmjoAnXhRyTAl4XatAb
	S+doGWh293vHJ7/8c3wlnwBiM7TF+O08oLJQlXcKVmYWbGHmRGwYI6R4ZYEQG18wvNBP/5rOxyZ
	ck078N8Z7DUpB8HW7QiC/CquN7UetiYiZ9qyniugc8oAViQ+PdvjgjuEv/tW803iVz5UP1+Vmo/
	6QBpxGu7CKbF7k35Nah4rP5i5zlYXXFazTPqfTvZOXwieXaIrssQGLHr+XzFYEkXN3HcSZfz7h+
	8D1Ubw==
X-Received: by 2002:a05:600c:698d:b0:49d:1842:f001 with SMTP id 5b1f17b1804b1-4a1680e5865mr7295435e9.14.1790972924299;
        Fri, 02 Oct 2026 13:28:44 -0700 (PDT)
Received: from arch ([37.142.150.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c84a9sm97832585e9.10.2026.10.02.13.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:28:43 -0700 (PDT)
From: Aviv Vaknin <vaknins33@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Bradley Morgan <brads@mainlining.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] pid_namespace: make zap_pid_ns_processes() freezable
Date: Fri,  2 Oct 2026 23:28:41 +0300
Message-ID: <20261002202841.3434087-1-vaknins33@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAJZ5v0jQgroKLxnyeKLedZvc9f7k0OLhHAwpHjvWK1E1BHDq2A@mail.gmail.com>
References: <CAJZ5v0jQgroKLxnyeKLedZvc9f7k0OLhHAwpHjvWK1E1BHDq2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 2, 2026 at 8:13 PM Rafael J. Wysocki (Intel) <rafael@kernel.org> wrote:
> Yes, it looks simpler and it should actually work.
>
> Aviv, what do you think?

Agreed, it's simpler and avoids the extra try_to_freeze(). I've sent v2
with that change and without the comments:

https://lore.kernel.org/r/20261002202820.3433318-1-vaknins33@gmail.com

Thanks Oleg and Rafael for the review.

Aviv
