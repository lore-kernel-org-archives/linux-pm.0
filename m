Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF03939D0
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753103; cv=none; b=cpQoh/T2hu9qxbYZ7wuhyEPbJwjlzdXM0zHTYaqXF74XWucKXGgePN0uT2FAyV9KleApgwjlVEaJWx8XdAWSwixg7iFm0fYUXZufCchC5dRCHAhtiw1eJaf0OMpuHzm/n+Ecx5rXqeYZOzjIBURPyE5VV/N94bZ6otlcOxIHg2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753103; c=relaxed/simple;
	bh=3nG/sDKEXby/WIrLfH86wORGS+f2incixoM/JnZ1iJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUBbI7a+zaCDoE2QDaaZOBvNapFwT6gTFVR6ru0pbGImHgL2L4KLI2/TZ3O32Z+4PaKWSTXt+q6Mbp9xa5BINF4vioMulBmfm8ZO3wEiqGl7V3fQSsRkMAiFPF+IBxXmIO2bMZCC63LsNzYYAgZhh7bVy+cmW2hLVY0I/x4VhXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inAmJie9; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inAmJie9"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01c41135so151050f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790753100; x=1791357900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAd6nfAO22oQbqKamKmwvUK9RC63ufUS5aB+67o1X1Q=;
        b=inAmJie9Vl9FlWO2TXS8afcevZQYRiCqQ2D1blJ3gQRcwjecBwmKmScYrPtZVPK+xy
         F9sAbwXUtk0oHtn+UzCLXDi8RYpRt3Hm4hCthH5jVFi8CDeU/YogY3t2U+JfWz6DCP7n
         /Jwo92Cdmgr1caNq0Txieb5/1FT3jdTCB5jgNe3iTmsF3MleVLyqeY9kg1lkHmkI29Tt
         sA0N0QGpNxSLz2ZAD9omxq5Z7BDga+3jnDt3zvfKpW7qilFs5qv8Btpo0hxd4buAi/uA
         gkpop/yH754SAZ9Q4jspnDMcSS+vndFfhaZ9xh4+Ix+oeu3DGlC/fiE7B8EkjZVm//eU
         t1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790753100; x=1791357900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAd6nfAO22oQbqKamKmwvUK9RC63ufUS5aB+67o1X1Q=;
        b=EL5tg6kA8ejyhF502hGupjhJQKn69QW1rlFGbmjEehLt8htPl8PI4TGME523rQVFd5
         TDpJVF7rynqdljU+Ek5NHFRGW+KshVCqzqrV7lfsatySY0n/v/+uBVGfpYYrZJHeusPF
         9/rqvzbz+fsw1BXK0SdWqCiUN+4vea6Eu0VuatAxiXoysGED+zdr6kaW0qUQ3HitHhrW
         hc5ApiG1iPfvrLuUGaCHclw3oKhMdrJ79SifP4OJQDr1avy0NkRS+knAX0EjQ3ysT32Y
         Ihc2Wb++X2QDezgtsVd+l4fhbMJjjMeGlvQdSPbYm0Oy+YJAfnYp6liuWNxKrJLF8nKx
         x1Ew==
X-Gm-Message-State: AFq9FYKR9jO95YT7aPXdgsW0Ge34I3h6VENSDtKPUWw2sh1pgtNUXERS
	eLb5oRWUgv+bCFKZEeyUbrC3ixVM0k6p2NsIECdU7vcpRVzVckMlzABD
X-Gm-Gg: AYBFou366TbdhnGhioCIybJg32yBf3aYHnImL3YYMkfUq8QL5kwDhz7cw0GtcqVuqj5
	0bgQgjZd6ewVzQIVgwutlCupI+F6In18wcQv9crFJvkzTUqsTzPa4N6EfjIYLjt7juCTDR0lD+V
	yhVNXcejEcVjZhVllB14EZ+2zmvgluc8HJwOu1EPA1wdWglH7gvYsqwbe+PGKt35NIFif+VlxW0
	UoPotHfdRkg4X1iB9FJBY83Owvn3E8VBu9nBklqwlHXXkT2uAWEiPvUzAPzu7taz3ULIsYfuB9D
	aoO/ATTOZf1uUzwae2MuLcrQ6Xwczgx6uTfhTG5cH8G8Zk9k0JS1aaa/VP6B3aQo6SfUxP2EFNa
	BJpberVd1WR1AREsda+7ClTsF52ZcubIE1rdiiMiLuyS7agYL42S/tNTh9UVg8N4xl8PqFWy1Ny
	UiOSovhnnBYhJrcEVDAfYIGtqvjVOz9CvJP6XX1MOMQsstincugGnQmvLvpFrfYdSCe2me/bnru
	tgplI2GbRrdDmLKa1k=
X-Received: by 2002:a05:6000:400f:b0:48a:f26d:18b3 with SMTP id ffacd0b85a97d-48b02535074mr1142441f8f.42.1790753100479;
        Wed, 30 Sep 2026 00:25:00 -0700 (PDT)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b029fc420sm1267411f8f.28.2026.09.30.00.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:24:59 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] dt-bindings: power: supply: maxim,max8903: Document MAX8922L and RT9524
Date: Wed, 30 Sep 2026 10:24:49 +0300
Message-ID: <20260930072450.61836-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document MAX8922L and RT9524, which use a similar charging control pattern
to the MAX8903. The MAX8903 is set as a fallback for both chips. No driver
changes are required.

Svyatoslav Ryhel (1):
  dt-bindings: power: supply: maxim,max8903: Document MAX8922L and
    RT9524

 .../bindings/power/supply/maxim,max8903.yaml           | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.53.0

