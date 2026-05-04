Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828F21257E
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860049; cv=none; b=gKoq4W1uhWgH3tMRrE66IWmJ1M8/fAtRSUtrECeJgQ7hpFLSxmwgeHDb+BLbnQSeCnnDl9KyFDYCENbHlOQ0ZUFgWCBMRlwybQrByqFXw6lwELvQUi9YF4CX69wgNb7vLfngewVIVn/S1aoqgTiP0rBxWH8uXn58clc/Hnqt9Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860049; c=relaxed/simple;
	bh=AHtii8CCYTSf7q4I3jdtrAotYIqQ0VVWNFC+K8e3w80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZAS85urj4gn1iDbaxEfTQbYQkRLROKa4DGr5FV/FPg/27LMJoqqJocc91l2WQRXgH1ZgfksZQhR+HD8rOeK2Dj65dRqlrIYQGXqfVXhQT1uoMoC7Px8NTG6KjA6f5kuXDJBs/ueY93oN1GEA+otbUu0TWpnKZ0rEsehsrieFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=epzMTcmT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="epzMTcmT"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44da2de25f3so304204f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860046; x=1778464846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0yO3jZLN26FeBlMUZI82K9kgV7+1GCeVfAvlBcPEuc=;
        b=epzMTcmTYbUZK0dosqL40FsPbipbGK34qdyNMO8YrV6hp0WTJOUfxRIFWSF2JMpe01
         yqUkZTAlSK62mdej6X9k+Jzo5Ay3qOVuiFY6QoU/CgU4FgQSi5U3phk45v9BxE1+0UnV
         M+paL4pSBFYExFT2Hm3qTadY+ZvCLEsUiypFDArI7zhtRhnQ18L6lHA0PhZlQghOErHe
         11YFSfq7QNsDUCIyCXZcqJdK2ZrTWDtV5MClbhFRsCGR5pecofU+7S3ahnTbsGIW/dA9
         XQeE9iw/9CARojhhTAH5sbXRJS8Ytm1wftIR/TtoB762lFvxGy1VyX2RQa0AYTdnhIFZ
         15xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860046; x=1778464846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z0yO3jZLN26FeBlMUZI82K9kgV7+1GCeVfAvlBcPEuc=;
        b=m2qqnO0yj5dUhNUyDsv5dXxzFdNtCyPquzklTkB+XfRK9gJFNM9368DZFAxIMeC+3/
         ms1bdIXIqjjFWEwf9D9rWrCd70XAtEKjH1mGvS8TpsOWyZUAhw32V0KTU9RVYxWBileB
         LDXrcKqi34iwifH11uY7+miE69h/amDwKl1F5/o5gZN6YbFp7NlDK5KnO4SnFOuInP4x
         x8kf1Ipd7b+BGb3O+PyMqCwfWzM+fZN0newT2CeUedE8kOKRK27nRAsIB/PKzfCB6C8U
         PhyrbEV4Mp4C0xuitX9ejuIeVK8yBAOkTxIXU8KK4KLjHhIETfAYgXTNEO0jKZI10DIE
         /5OA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZNP24ggH4x5vvbepOB3Btoy9/qYOUZ7Q2W5hOcaS9vQ8dwOFe983RTCX0LrPl3MQGFid+IzIb0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxV42D6BuQkOJgNPc/ufLs6lj8yiH/goLPBye+qVeafztCjG/FT
	wyvJBZCbEvy25kBPdHvt/fIMxhAKSGcDtWQqbPsWb+/IgJwtI/URsMy/O4ZcNCEYnX0=
X-Gm-Gg: AeBDiesW3SA36Nz5sFDrnZweHJuKDcOzvJRlai2T+BglZd9w/OWmxtQIdKTaQdwCcTK
	ZJySEuk3chxk2TglaMPi7tEdEctfjQLnoyXKgumUTytj1GE34PrqvTf2PXcmvQNBQWAhcWmU2Iv
	SBfuUjdAcxXrb2+xyP3Dg2jo1dRKea9JPmakY8BvIt9VImLweLG6o0fUE1u4TptwJnMb2lIpM/H
	m5ieakC+7ZdeGqvVtYLEc67fUOajcOdRpCOIWxn0HM9iO19yQJuld70sNda0wmRw5PH04dWddjL
	QXcc7VmME4nuvdXBf84lx+WcQZzl5IVw1DefF1HL2xbsB4gv4NK8KaZ7iCtBJQwdW5Rz2+38507
	7HvWQ5kmO0uTdD3Fgeuy3LIZOzXpicXwKpmGNaQSDBOezao9sa85BaqWzb/iSjeBg3eerx9xOzh
	hTGeIkVK/7oxaTC50H7AnS3JyAYwWwWgg=
X-Received: by 2002:a05:600c:698d:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-48d09ccfee0mr27181505e9.26.1777860046115;
        Sun, 03 May 2026 19:00:46 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:44 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 RFC 13/13] sched/pelt: Always allow load updates
Date: Mon,  4 May 2026 03:00:03 +0100
Message-Id: <20260504020003.71306-14-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504020003.71306-1-qyousef@layalina.io>
References: <20260504020003.71306-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

1024us period can cause a problem at dequeue if the last udpate (due to
tick) has happened less than this period. Running a periodic task I can
see the dequeued util_avg changing by 15-20 points due to this variation
- which on HMP system with small cores can mean a big jump in freqs.

Before

                                         periodic-2977 util_avg
     ┌┬─────────┬─────────┬──────────┬─────────┬─────────┬─────────┬──────────┬─────────┬─────────┬┐
140.0┼┼─▐▀▛▜─▄▄▄▖─────────┼──────────┼─────────┼────────▄▄──▗▄▄▄──▗▄▄▄────────┼─────────┼─────────┼┤
     ││ ▐ ▌▐ ▌▐ ▌  ▛▜▄   ▄▟▜▄▖  ▐▜▛▌ │▗▄       │        ▌▐  ▐ ▌▐  ▐│▌▐ ▛▙▄    ▗▄    ▐▜  │ ▗▄      ││
     │▀▙▟ ▌▐ ▌▐ ▌  ▌▐▐ ▐▜▌█▐▌█▜▛█▐▌▌ │▐▐       │  ▛▜▀▛▜▀▌▐▀▙▟ ▌▐  ▐│▌▐ ▌█▐ ▗▄▛█▐▛█▜▄▟▐  │ ▐▐▀▌▗▄▖ ││
     ││▌▐ ▌▐▄▌▐ ▌  ▌▐▐ ▐▐▌█▐▌█▐▌█▐▌▌ │▐▐  ▐▀▙▄ ▛▜▄▌▐ ▌▐ ▌▐ ▌▐ ▌▐▄▖▐│▌▐ ▌█▐ ▐▐▌█▐▌█▐▌█▐▛▙▄ ▐▐ ▌▐ ▛▜││
129.5┼┼▌▐─▌▐─▌▐─▌──▌▐▐─▐▐▌█▐▌█▐▌█▐▌▙▄▄▟▐──▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▛▜┼▌▐─▌█▐─▐▐▌█▐▌█▐▌█▐▌▌▐─▐▐─▌▐─▌▐┼┤
     ││▌▐ ▌▐ ▌▐ ▛▜▀▌▐▐ ▐▐▌█▐▌█▐▌█▐▌█▐│▛▐  ▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐▄▌█▐ ▐▐▌█▐▌█▐▌█▐▌▌▐▀▛▐ ▌▐ ▌▐││
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐ ▐▐▌█▐▌█▐▌█▐▌█▐│▌▐▀▙▟ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌█▐ ▐▐▌█▐▌█▐▌█▐▌▌▐ ▌▐ ▙▟ ▌▐││
119.0┼┼▌▐─▌▐─▌▐─▌▐─▌▐▐▛█▐▌█▐▌█▐▌█▐▌█▐┼▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐┼▌▐─▌█▐▄▟▐▌█▐▌█▐▌█▐▌▌▐─▌▐─▌▐─▌▐┼┤
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌█▐▌█▐▌█▐▌█▐│▌▐ ▌▐ ▌▐▄▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌█▐▌█▐▌█▐▌█▐▌█▐▌▌▐ ▌▐ ▌▐ ▌▐▀│
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌█▐▌▛▐▘█▐▌█▐│▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌█▐▌█▐▌█▐▌▛▐▘█▐▌▌▐ ▌▐ ▌▐ ▌▐││
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌█▐▌▌▐ █▐▘█▐│▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌█▐▌█▐▌█▐▌▌▐ █▐▘▌▐ ▌▐ ▌▐ ▌▐││
108.5┼┼▌▐─▌▐─▌▐─▌▐─▌▐▐▌█▐▌█▐▌▌▐─█▐─▌▐┼▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐┼▌▐─▌█▐▌█▐▌█▐▌▌▐─█▐─▌▐─▌▐─▌▐─▌▐┼┤
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌█▐▌▌▐ █▐ ▌▐│▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌█▐▌█▐▌█▐▌▌▐ █▐ ▌▐ ▌▐ ▌▐ ▌▐││
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌█▐▌▌▐ █▐ ▌▐│▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌█▐▌█▐▌█▐▌▌▐ █▐ ▌▐ ▌▐ ▌▐ ▌▐││
     ││         │   ▝ ▘█▐▌█▝▘▘▝ ▀▝ ▘▝│▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▘▝  │         │    ▝▐▌█▐▌█▝▘▘▝ ▀▝ ▘▝ ▘▐ ▌▐ ▌▐││
 98.0┼┼─────────┼───────▝▘┼──────────┼───▘▝─▌▐─▌▐─▌──────┼─────────┼───────▀▝▘┼─────────┼────▘▝─▘▝┼┤
     └┼─────────┼─────────┼──────────┼─────────┼─────────┼─────────┼──────────┼─────────┼─────────┼┘
    2.00      2.11      2.22       2.33      2.44      2.56      2.67       2.78      2.89     3.00

After

                                         periodic-2968 util_avg
     ┌┬─────────┬─────────┬──────────┬─────────┬─────────┬─────────┬──────────┬─────────┬─────────┬┐
139.0┼▄▖──▄▄▄▄▄▄▖─────────┼──────────┼─────────┼──────▗▄▄▟▀▛▜▀▛▜▄▖─┼──────────┼─────────┼─────────┼┤
     ││▛▜▀▌▐ ▌▐ ▛▜▀▙▄    ▄▟▀▛▜▄      │         │   ▐▀▛▜ ▌▐ ▌▐ ▌▐ ▛▜▀▙▄        │         │         ││
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐▀▙▟▀▌▐ ▌▐▐▛█▜▛█▜▛█▜▛▙▄    │ ▄▞▜ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐▀▛▜    ▄▄▄▄▟▜▛█▜▛█▜▛█▜▛█▜▄▄▄││
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌█▐▌█▐▌█▐▛█▜▛█▜▌▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌▐▀▛▜▀▌▐ ▌█▐▌█▐▌█▐▌█▐▌█▐▌█▐▛│
128.2┼┼▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐▐▌█▐▌█▐▌█▐▌█▐▌█▐▌█▐▌▌▐─▌▐─▌▐─▌▐─▌▐─▌▐┼▌▐─▌▐─▌▐─▌▐─▌█▐▌█▐▌█▐▌█▐▌█▐▌█▐▌┤
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌█▐▌█▐▌█▐▌█▐▌█▐▌▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌▐ ▌▐ ▌▐ ▌█▐▌█▐▌█▐▌█▐▌█▐▌█▐▌│
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌█▐▌█▐▌█▐▌█▐▌█▐▌▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌▐ ▌▐ ▌▐ ▌█▐▌█▐▌█▐▌█▐▌█▐▌█▐▌│
117.5┼┼▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐▐▌█▐▌█▐▌█▐▌█▐▌█▐▌█▐▌▌▐─▌▐─▌▐─▌▐─▌▐─▌▐┼▌▐─▌▐─▌▐─▌▐─▌█▐▌█▐▌█▐▌█▐▌▛▐▘█▐▌┤
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌█▐▌█▐▌█▐ ▛▐▌█▐▌▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌▐ ▌▐ ▌▐ ▌█▐▌█▐▌█▐▌█▐▌▌▐ ▛▐▌│
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌█▐▌█▐▌█▐ ▌▐ ▛▐▌▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌▐ ▌▐ ▌▐ ▌█▐▌█▐▌█▐▌█▐▌▌▐ ▌▐││
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌█▐▌█▐▌█▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌▐ ▌▐ ▌▐ ▌█▐▌█▐▌█▐▌█▐▌▌▐ ▌▐││
106.8┼┼▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐▐▌█▐▌▛▐▌█▐▌█▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐─▌▐┼▌▐─▌▐─▌▐─▌▐─▌█▐▌█▐▌▛▐▌█▐▌▌▐─▌▐┼┤
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌▌▐│▌▐▌█▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐│▌▐ ▌▐ ▌▐ ▌▐ ▌█▐▌█▐▌▌▐ ▌▐▘▌▐ ▌▐││
     ││▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐▐▌█▐▌▌▐│▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▌▐ ▘▝ ▘   ▝ ▌▐│▌▐ ▌▐ ▌▐ ▌▐ ▌█▐▌█▐▌▌▐ ▌▐ ▌▐ ▌▐││
     ││         │   ▝ ▘▐ ▘│    ▘▀▝▘▘▝│▌▐ ▌▐ ▌▐ ▌▐ ▌▝     │         │ ▝ ▘▝ ▌▐ ▌▐ ▌▜▐▌█▐▌▘▝ ▘▝ ▘▐ ▌▐││
 96.0┼┼─────────┼──────▝──┼──────────┼────▝─▘▝─▘▐─▘──────┼─────────┼──────▘▐─▘▝─▘───────┼───────▘─┼┤
     └┼─────────┼─────────┼──────────┼─────────┼─────────┼─────────┼──────────┼─────────┼─────────┼┘
    2.00      2.11      2.22       2.33      2.44      2.56      2.67       2.78      2.89     3.00

Also the new util_est periodic detection logic can be thrown off by this
variation. With this fix it now stabilizes pretty well.

Before

                                 periodic-2977 util_est.enqueued running
     ┌─────────────────────────────────────────────────────────────────────────────────────────────┐
157.0┤               ▙▄ ▗▄  ▗▄▄▄ ▗▄  ▗▄▄▄▗▄▄  ▗▄▄▖ ▄   ▄▄▄   ▄  ▄▖▖  ▄▄▄▄▄▖▖▝▙▄▄▄▄▄▄▖ ▗▄           │
119.5┤             ▗▄▌▘▀▀ ▀▀▀ ▝▀▀▘▝▀▀▀ ▝▀▘ ▝▀▀▘ ▀▝▀▘▀▀▀▘▝▀▀▀▀▀▀▀▘▝▝▀▀ ▀   ▝▝▀  ▀   ▀▀▀▀            │
 82.0┤             ▟                                                                               │
     │             ▌                                                                               │
 44.5┤             ▌                                                                               │
  7.0┤      ▗   ▗▖ ▌                                                                               │
     └┬─────────┬─────────┬──────────┬─────────┬─────────┬─────────┬──────────┬─────────┬─────────┬┘
    0.00      0.65      1.30       1.95      2.60      3.25      3.90       4.56      5.21     5.86

After

                                 periodic-2968 util_est.enqueued running
     ┌─────────────────────────────────────────────────────────────────────────────────────────────┐
139.0┤              ▗▟▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀    │
106.5┤             ▐▛                                                                              │
 74.0┤             ▟                                                                               │
     │             ▌                                                                               │
 41.5┤             ▌                                                                               │
  9.0┤        ▗▖  ▗▌                                                                               │
     └┬─────────┬─────────┬──────────┬─────────┬─────────┬─────────┬──────────┬─────────┬─────────┬┘
    0.00      0.65      1.30       1.95      2.60      3.25      3.90       4.55      5.20     5.85

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---

I tried to do the update every 256us intead of every period, but this didn't
help to flatten util_est.

If doing the update always is too much, AND, I didn't miss something else that
could be contributing to this problem, would another sched feature to allow
those who want accuracy vs those who want minimal overhead take their pick?

 kernel/sched/pelt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index dbd450798b03..64f9e60023a9 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -224,8 +224,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * Step 1: accumulate *_sum since last_update_time. If we haven't
 	 * crossed period boundaries, finish.
 	 */
-	if (!accumulate_sum(delta, sa, load, runnable, running))
-		return 0;
+	accumulate_sum(delta, sa, load, runnable, running);
 
 	return 1;
 }
-- 
2.34.1

