Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DDA3B83E1
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981515; cv=none; b=pxS7op/9jkb5KiGTWRxkhNf1IOZwvomk7afB0/bbysaPM5B3mRFMRuO7dJjyP5+Mu7UmIp907YMN/ddxwlmj5M4XsVGS1hSqF8InudbSs+PKo9QHght0GNFb45jP2MuOuUhNI9T2Yr5dseipGa5qeASQWfbrC1Xp9C/ZJijL03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981515; c=relaxed/simple;
	bh=ZBF06lf9l3jjaPsie+l2gDKg30y0nMjdFIJaDuIFA3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGSrftaBOfD1xCHZLtN1xacIJnk/igzPXR0DoYeJFOhQzxtIpPUnrFF5NhpWYZ2eQNuvVZJp0hIT8fF4NLc9oYwNa5plMh5OAIJfDRRMexO6P7wgADuTwINB13lnd230d9dIus+iJJDBvy77gtyOB20DxzT5o7xmZXCONkvuSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etu+CXdX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etu+CXdX"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso90658605e9.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981512; x=1789586312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cQp1h+Nea1dCnGwxCQ5G9ZglVlG59gCPu/u14By/urM=;
        b=etu+CXdXiqG7CMxMVMZ0Ib1Uts6d+uEBVjXSAIeyebuRFFsfxM0kdpymrvRHCIddqo
         9LGAupoOy+rieiQghyfIu/IBd1wvHySJLSVdAl8RIwVgF/QcD5x6AdHkNZU3NmienuRd
         lbN3GQu+trQcLeOGnvAjV6oRRK32l53/tWRHhgaJp+aoRnRRECc6QEEijH9DzxgwIVOT
         MQa00FPsEuOyTnLLYpm1LcRfRGe8Fh1HnbhdIrR3bXNPunzbJ4jLRN2U/qdBQvYsUEUd
         M7DLUdsHNq139a10aVAj+QqxuT95oVYUwqr/cKU8uAwqf32QhfYkrbRYLBAwUGrBwRxW
         pJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981512; x=1789586312;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cQp1h+Nea1dCnGwxCQ5G9ZglVlG59gCPu/u14By/urM=;
        b=G1LonFmUnymHNTftp2qMLYbebJS8vjDLa42n00IGvbr0kxpI/a9PHmkF5G7jK14uri
         1gmz6dvhuym+dihOPAghY1RSig13oa8OJdy4wDw1PufLDCKzQFYp8SmTZoKsvUJWgpwe
         tX67jG6g40iOoqvHAXA3qUI6FqtZoS9OHtiq8oA/BqDP0+0nkVGTqdulw6rL5cq0Ftwa
         O0xKdO7bmJVaCrk13HLyJVfZF3a0clyQ/LqfG4H1gdBHDkIPZvsoZL68wn8+/DCTJJv+
         ghz00ar/PtNenzSswX5MqHeT+FPUL6SqjMdIMKQnPHJsEeR9xlCULZhp2sQc1XtIPh5E
         CG5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwx3AQxKUW4fCJNqZRPjlKqJdK/vSxHoRzCNt/0mOVyMIWza7elr8Mo8ubselzEECqVM7FN+wHdBw==@vger.kernel.org
X-Gm-Message-State: AFuF++nuE+dtua6gFUdlnpuoHf5r0nti5CfW+ATEGlB+Ex54mSM3KA85
	YZ1ESVsmPO6V+nM0ycktJkGcKcmPYVaaSLNFnQb2ZnACNNo7aZYBWLPw
X-Gm-Gg: AYBFou0ugkdP+X1Rq2w5BugdkhMW6quSO0uNxYUAeMvpnIGChSx3jLWDkk33rOFelIw
	VrV8Bh4wdcOY4RtBG8W5xvJ/A3BzlhScA9vJVQj9heZ+VJf6K4088xNrkCTAaub1KsVh8ZMdtID
	d05kmw+/ym6MK6/n1MTTHxmfYVIzUF4kPA+2SRT5c34+Me1emnZEM0vjjjDf345B9iVC7IYd33y
	QEeKQHhbZ3/ZB9KXX/eGfglJ+Sdf5GEOPjwLN17ivRUfo19ZBnx8m4vfHx3dwkxBT2bFtra0r1p
	ePjQN+m0swG1tCiQYf5XhKIAz3mf8uqUop4P6wnhB+OvJEjsRBxYw4VFNx6pI5MPjmINDe/eehv
	6ezalgUKpcJTZelN9tn7nPJop/mOAibCHhwffbr8nsGDa2k34MFhMQT63Q/BW6Xs2TXuAQkHiRY
	D8nZ0k9+3DPaydh4YtQTQU8DuRVhwpK02wzIpICKggzDFYOt0K2VnKxNDn2KgzmqaA4eukr1yTD
	77xAe3fsePnbEuhLjtioIv36Na5m4UCsplpWSBnhco=
X-Received: by 2002:a05:600c:628c:b0:49c:e1cd:536 with SMTP id 5b1f17b1804b1-49d17a8745bmr144560705e9.12.1788981511672;
        Wed, 09 Sep 2026 12:18:31 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm164538455e9.4.2026.09.09.12.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:18:29 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/2] arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
Date: Wed,  9 Sep 2026 21:18:16 +0200
Message-ID: <178898149654.33757.7826789084252321894@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909113625.000063be@oss.qualcomm.com>
References: <20260909113625.000063be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Good point - that reads much better than reusing scale as scratch.  Taken
for v2:

	scale = arch_scale_freq_capacity(cpu);
	freq = (scale * arch_scale_freq_ref(cpu)) >> SCHED_CAPACITY_SHIFT;

Same semantics, and it makes it obvious that both the multiply and the
shift stay in 64 bits and only the final value is narrowed - which is the
whole point of the fix.

Agreed on leaving arch_scale_freq_capacity() out of the expression too.
This file is arm64 only, so unsigned long is 64 bits and it would be safe
here, but it stops being self-evident to the reader and the cast that
would make it evident is worse than keeping the temporary.

Thanks for the review.
