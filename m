Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD713BD658
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219654; cv=none; b=PT31RXWdu7d5twryWxHNhLTGeXXcvoi3CUz18HObtCbGuiOdB7dX9E3Fc9SmETxWvQp2pqpSQ1PBfXeZCi5s+0TJXujI2HHwtKVuL8KzFahJFmScHK1Yi+KFssieCUg702eIrVpiSjfmHDdE1akp+AGkN9HLrah4KqbT6aHPV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219654; c=relaxed/simple;
	bh=6HsPxrCY7egdIWe+0rl0iMBC5KKZb48lefsD5AZVvUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOkx3T6o0oEZdyNuhYR0MEcAHR4fiVNZfKL+FyZV296kfwXRcGqhOd2Q/JW8AtcRzsgu9l4MOuowMQE3nX3V4Gl+ooTsq1TG4M8BVxUQ+IAyorFpEl2a/rQORlxXHM05ZS7l1KPPW3slgrRSKlWD/smIo6kgTpadNDHhsGtI7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqQbIErx; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqQbIErx"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38a2f92fab4so68832821fa.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 02:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773219646; x=1773824446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XpW3VggzjAQK5uftzOhf8IhiEOSo+b7VbPq0oxkQKU=;
        b=dqQbIErxt7NOGxtFfFLeGPS/eQxl+ak+l066w8Bw6G7uk8+xnDbkInifbDP/wKntuY
         E1m7LSAHF2ZSQJQh8mXNKhusbP+CNVwW3gwpj9kWTHFL0nbhdL2IKDYuNjEwOJBB/+iw
         3PWjk9ss0l4cmXgAlT3ziyhmZ1d3s0CeIwUj0jqWUfe+mJM4BQlyG1pssr1kanazMThh
         yLLUoYh7RyS+3pkEXmHWMgu5htV4SyaKcqE0GR6C8+Nb9FE3nzbup3C46vIs6zjlci25
         gOFmPHoaZNrwqAZIy9zOi3bMoPkKEeDKT1QOvnXC3YHsCq2FvESO+mMActNjuH8PyWN4
         zSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219646; x=1773824446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XpW3VggzjAQK5uftzOhf8IhiEOSo+b7VbPq0oxkQKU=;
        b=LwTME0hpri1FjImXFG4ib+Z14tZ11ggFAqkqQZ4gOdOZY58lDpmqU/quZalJJtB/Cj
         ZMEfpFQfiWEOSsv3ZpCyIbtjydH5dNWo3opEngGnGvY108HKnhghN9ZH1Hzdjeflzhq3
         2WD7Nh3V4QKEj9UvYzN41yJk4Kz6deqayxvmNnqneflie3OlAsTDSyPfURyAYyhAcLan
         bL6T6kIur5Gt/G5eQEIMUIyjSi55Wu8e+Ey1mfgCzqDGkVBbcq9JBvBVPhftp86n49Z7
         dd+lz5TxMo2Wz5h2u6ijWwPAHx+yHLOqX5FINLhbd6i3OmEU7iC8NvxLrnPtw1KTu2z4
         pT5A==
X-Gm-Message-State: AOJu0YxtlDwlhNSmhsTxbag+4UcW7AruleYxYjvIeBah9XSw0b4hTyj0
	zQylaMngRnMoLrFEldpJL7QwqmFlm54ZO0JxJTliWq8ndnngLCjDYG09CvOL3P9i
X-Gm-Gg: ATEYQzy1Z34onw+vtJoRlLjxtkmF0Wnmp4KzzXal6HmjvIhrJug/MS8pgXMr9sfaNrM
	MaXosfckQR9carVYmOqFPUcoOskjXIP6VG9FUoUp5E++/Q2W6QSgnzW1+HOCX1lVBH/Y7BYRhLo
	6aDgISqGTHbOxZvkeGoLBzGmhKNn9VYjn/4E2aaEQ/wLDIM9wvbf0L4T746yDj5rF7qkCj77Stm
	un3ob/7HtcRXJvbQ++TPwotjKJ3VuNOmR2JTxOUy9zA+YdUzdyt4O3Zv1IQoV/bPQBwyhG+5iEE
	o2Y4MRKYcUMgqcxXcQivOlkb4D2ENprjYcQUkxiNsfJCPm/MVsHFyR4BjhfBgB7r2/6M48O8zJC
	kswSpxXGXMab2NeaBuRQJ5xAyzrUtLBv7W1NMOQ6Hf3iQAnJjIaWNFd5XhJHISU1QRaatddJ7Dx
	jBytUyBqHCfS9DSLns8R1e1VlvaXAt9SivlLwmgrMFXL21pV3D/0VRWJzCd2jf
X-Received: by 2002:a2e:b8d0:0:b0:383:2663:eb5f with SMTP id 38308e7fff4ca-38a67e7b894mr7381011fa.35.1773219645102;
        Wed, 11 Mar 2026 02:00:45 -0700 (PDT)
Received: from abityuts-desk (176-93-227-108.bb.dnainternet.fi. [176.93.227.108])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ed41sm2645041fa.25.2026.03.11.02.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:00:44 -0700 (PDT)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Len Brown <lenb@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 0/6] tools/power turbostat: Fixes and cleanups
Date: Wed, 11 Mar 2026 11:00:30 +0200
Message-ID: <20260311090035.169539-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This series fixes the following bugs:
- Using incorrect format variable for perf counters.
- --show/--hide not working with individual cpuidle counters
- Missing delimiters causing columns to merge together

There are also consistency improvements and cleanups.

Based on commit
867ea3a786e19 ("tools/power/turbostat: Fix microcode patch level output for AMD/Hygon")
in Len Brown's tree:
https://github.com/lenb/linux.git turbostat

Artem Bityutskiy (5):
  tools/power turbostat: add missing print_float_value()
  tools/power turbostat: fix incorrect format variable
  tools/power turbostat: fix --show/--hide for individual cpuidle
    counters
  tools/power turbostat: fix delimiter bug in print functions
  tools/power turbostat: cleanup print helper functions

 tools/power/x86/turbostat/turbostat.c | 64 ++++++++++++++++-----------
 1 file changed, 39 insertions(+), 25 deletions(-)
