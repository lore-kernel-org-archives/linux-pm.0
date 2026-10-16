Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288B44BC87
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140209; cv=none; b=HJ7sIvPZD42bOQfF0A+vboJDKUa4u+GezDQ6bSz38J2MK9QFgT6PKA7O5HL7fFCDz0GavZ3rCpOwKyTUJuoJ6S7w7b2zCkdURvqEvPoBSck58KtVO/Iz+R/aqunx6Az4OkTY5XzSfKPaDGBit0RsZqmBzRyNcsiws4+QD+iNTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140209; c=relaxed/simple;
	bh=9ytjh5h9nCKW6lRtRba8cDTN0tvYqToRzL6rsiKLUvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6L1hBC6FS0a5Tuu/rxY57eiA/GYsFtId1DZK0NloxNVx1FV9IC5cRsM74/j7UvGk4UJZEZF53nJpEt5J1lutSKif1re15wE+oN8KqhrUuu4c4ObsxGlClbe4J0GJkinB34e3lWjIVfnFVBQF6UwopyfRUx0xSxcjR6kqTb2yVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdgMeqJb; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdgMeqJb"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-14a51c8ea7fso121100c88.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792140206; x=1792745006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ytjh5h9nCKW6lRtRba8cDTN0tvYqToRzL6rsiKLUvQ=;
        b=UdgMeqJbSyAnx9bLBdu2kQDFZCh6iKG+GtIzs9ycPlZ5yj0Kg/VyeCvPxSRm2URWXx
         bWUg23QM/+8KfjBxWDe/H+AMcj/0vJN5vo2MHwrMA2rhjNvqcwe2GaFW/XKdWu92iIV+
         vk0Bf/8mPSFXVbXXCKUDFP01ZclE9pDcWZDfDArdHnBAjxEixhMPyNOBVGyPr5M9IfD5
         Z4ihYbbAho/u3jgiW5tkVS91RwCvTqMk7JuntNeABXh6NCHCmepjO5atHTusRdTc/MAx
         REFvvH7Z4J1/QHZxS1GnX2/k0tJ28yrgV2R/8kvEEnkmUMUrO7h0ZzDKi5GKHretWIhd
         Kdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140206; x=1792745006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ytjh5h9nCKW6lRtRba8cDTN0tvYqToRzL6rsiKLUvQ=;
        b=C7gBwisdUrVWazaxzayeBSOo4mULuAPNeCm7wfk/IB8v3RFSaD9Vp5l5iCQB6FMzpc
         7puzDElZ4jB+P53SGdLVoypnSZDO5/5AtsfSsTKH1fhbeNFF+aA6VaP6dkieJxJkPA3e
         0jPnrn54wXnx9gh6fiNaXjbX6VRdbBkN1UZY0EGF3tJReOjCiRJI4dDFLt0hbuYg6t6Z
         wa8xrDt8o9VP7fbQJD2hkk3on8xdHf7RHO2CQDI1lbsWPRVtbhyCnZLho8KQIy9kVpWG
         uKA15gDxGhp4CuEr8ZuudofgFBculWVce0SGx2VmuUHO1jupa6dbN8BAYJWPd7F0rWGK
         kyog==
X-Forwarded-Encrypted: i=1; AKwUvBy0YoBAq9xEE5V0wRHfw3boWkrBvtp0BhvRERcYnrkH/RqJrw5dXokDfPjpEaXoO1jA2euT8Gsg5g==@vger.kernel.org
X-Gm-Message-State: AFq9FYL6cpBshyI8RZTdgxcTmUwqLJorQBCPh6hppoFN7F28XPnRw4n2
	O+ECJZJcTK49P+QkJCLFIbeayTVrRzD7z/9VbHUneLBv7QjAo8+3avHU
X-Gm-Gg: AYBFou16ZkZhHy/foVtFYDQo46+H3YwPziUGzNpGJVRycxDqfwbxrbqsLl08z4+bG8H
	YFlshDUtHNfPThZ2MyoVEM4fkquj6WJkHu93CeeIz2dgjNd2Az7VoJCirO+y6PjZ9V/+HxMcg0N
	xw8R2842sI1IRNVMM5APTkGybJEYm/z6Nh6fVSs256WJBrDLFjsQE7udCQ3a9Z+kLvNK9/C9hdA
	9/e357hUPe/Dh46ilLyxoHL2PxP5FMO7LOZlFdUP4ITY+4ahob+sz7/dZpTgpNXz/7evEqh9c9S
	uqqU1xpYGslFng6afvnw+IPIq23FizqKW398sO57lK08MCaZjRn+DHuN9sY9DVBeq80Gf00yblN
	UsZ2tXL7raNvL9oZj1SfOW5G2x//b0iiFIFoB78tcLoPgSIvPAwNJlZFKXxn65o5Cc01+MFygNJ
	gaWloUvZTb3Hq31OdqZjJD8zPzmNZUPVQaVAN71IGCXqef8brUl9l5v1d8MiTTzXhNCEKNNfk4W
	frtTmcqNDSpiMH2/Q+a2B/9rEI3Y3KFU72dRS82q2Q/jcnq4u9kWXcz7WJcYumC2DJ9yOHlifiB
	mfhy08HQuFYkrLvuZmrohWImw22s1Mfz0g==
X-Received: by 2002:a05:7023:a5b:10b0:147:d430:7322 with SMTP id a92af1059eb24-16a5bc5bd84mr42237796c88.1.1792140205626;
        Fri, 16 Oct 2026 01:43:25 -0700 (PDT)
Received: from cachyos-aura ([2409:40f2:311e:5e21:4c93:81a8:d3d8:4d1c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm5793636c88.16.2026.10.16.01.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:43:25 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Skip the suspend_noirq config save if runtime-suspended
Date: Fri, 16 Oct 2026 14:13:16 +0530
Message-ID: <20261016084316.22761-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260923022511.24932-1-navonjohnlukose@gmail.com>
References: <20260923022511.24932-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bjorn,

Gentle ping. The patch still applies to pci/pm on top of Mario's
pci_pm_suspend_noirq_common() split, since the !pm branch it touches is
unchanged there.

Thanks,
Navon
