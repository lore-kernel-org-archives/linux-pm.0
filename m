Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686568;
	b=v1QUFbL3JjyC8BmHHERV1YwlgtATEI0d9lBMTAUq5Azzec3+eRQ4keudqtKM+CgNPV54
	 hliBqi2PX+OqLEEftgXkhhr7oBveUJTvxrZ9z4qCB4DQYLL5/ntjWNhIb+tqNB8P8je1W
	 zJZqeA/zJCNnolJktcIpbtCYA5ZbAyJfh5qYsLDg8O8DaE+e3qjLHMvMpQeUDTIezAp6L
	 tAWAQYOHiNtaRAOwM1d9XDEQlzB1CV35daAVn0rfHr+7ypjDkGukOewbaWgykUr/SWvqr
	 xfg54kg0cMCUmJGvsecN9IVopbMAF3inuxvVejdFAnZnKWOneMuinwpFksFRc36PwmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZqUBB7PtSXKumcEYR4tzRgEekrPzVWK1PQaLCTI55E4=;
	b=BzBvL4k4ncgTMtgyKE7VZH5fS/VqZIls1JR6Ct0vfEJhTbzUOq/tz/TMauGpXWbxZzBn
	 piVzFg4hBdWwf4pk95ImMeMPfcVQlOdJmn7asNnCbRnJ3iQNuTemlGSPZimOQBwj4M8tr
	 5XcbxUkG3WSKVlAkXJYy97y1lMpgrjgiA7Ev4cuqtLwYljDj8wIqpzkfqf+CONF0y6j9X
	 4YdHrr6Gn8qdXMzCjneOqMuSll8z7YvVE8BrFIoJ0geKXRl08tTu/2H9XPN1Ap7L8K0Fn
	 EQkFMtW0JFVduk5p8UcGoY7t/yAxQJ/eQ9hztWFBtwpBiQw1eqlT5odmnjg9oA2UnJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mt3u5A7q;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6C606A329
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 06:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60A6C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mt3u5A7q
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso2605066f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 22:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793686566; x=1794291366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZqUBB7PtSXKumcEYR4tzRgEekrPzVWK1PQaLCTI55E4=;
        b=mt3u5A7q2n6Lz0rX+xpoR6nrNWLRpmZjcm+IxMmCFEIL9W+I93gV7pXcsRNBWlFuyv
         b/0G10Wtjf1PROs8GpnjK/5YDP72QakyvPwOAQOlWSNEOfEZjjO1xx2gmEAm0tXDama3
         9zSvaxXxp2OPVM1XD5g/i7Rdpsu72X/tpma+Fg2Tze9in2uHm0ifWg8prPTpljPy0oKI
         /omTZ6zlBkauyq3SBtZBR4OKxUjqMXlrjcyJGYWMHhxx5IGX9ki6LKXtZW+keOKRfBmB
         D0rywTUlm6VBp5m6vM6Q6PyNflws5icUZAYT2/dpwNJ5f+z9iMwOnmK+mkXO1qUtvWnn
         EgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793686566; x=1794291366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZqUBB7PtSXKumcEYR4tzRgEekrPzVWK1PQaLCTI55E4=;
        b=jnikZl+Jg2mcKOMNONMNhZThAZuYARpMnhLgzWoA1wg5ZvXfUsoHvw7SnXVG6DT2aV
         HI/ScMrdwlIe4y39b6OjiZ1RxBZCaA6/fZZ2FiqFy/8nOIS8w8iufAGu/utwQkwbzMXu
         rLFIaZ/WRH8YWmIQT8/BEf1KZV67YhkTqPOyaICzLgHaK2VDvCnQSH3MAmjz786UfInp
         tpATs2qABofayueqZ5n7rVgXSZXcNqbCXxbacqF7jEfVw4mGGVCMoLdBGEFR5Nsmv5BO
         SDYBMKQknFo6ZKdD+0iSPFrGsxuJtnFUIysnjjTgMBpAB6kBATAtwQzo6GwI+OaLR5Aj
         Gsjg==
X-Gm-Message-State: APuU4Z/pnDFJ4J4da9nqK8xKFhNFdJpD28VqfHR6Z7KoC9Oze5XHt8WY
	Yb5GSd6nn40/I7PnxX5orfDztG40SDtiiElMm9ZK7goyGPLKpxUZjk0917UKFg==
X-Gm-Gg: AYBFou3ery1GZFJhVGchH0mDSvJ/Vn/wuKI38wcTm6ThnK85rjokXBWP9JBZ9B3/nlw
	j6VUV3bv2tI/S4+u1TEjiYVk6LrEAM8YkMh21FuhBkVu+evzqIz377P1Q8DvAbmKSvO60qS5SZF
	eoxz2tisO8Xfh++OCuRcSbTiia4LJ6WcTT3F6yR31UZpMwt1CEp3oHe8SWQGGTgT3XCrujWIqfq
	7+jDLp0knkOEHWuTXh3R3A/jeUZVnV03f+uOt61kA7t6lDerlK9Au68IXHkNExQrv2CI7Mvvb4u
	J3dAeABisodBJ2N0Ac/j9U2YbPqDqmjTkDRtSDGPeC0dOn6ltqde6EkmmqutYuvEJZfzahymLtO
	TCqx4SMVAhAkr8NhsmIwibWpXdFE6gnGLK3q8BaucPERruWQC8SlZusVEyHqUfkv7+VoSK4pQ9X
	kV5u/oyIsVhurNNtf1AAVF/bhaOfISieHXt8gzUWnlUR15YaTvMK6YOhS/7oYFc0MxlncZNV87r
	byI1C0LRSdxagxlGqbxMlJ5VQfA/E3QhIKCBPJWQBIuWdaRJJkiFBWmIv+ncnAgrdL/e3WIxvai
	XkmacyuMpdWx8iJy9P04uS4lqxMZGe2d
X-Received: by 2002:a5d:64a7:0:b0:48e:5e1f:9a36 with SMTP id ffacd0b85a97d-48e6e50191cmr20614162f8f.42.1793686565592;
        Mon, 02 Nov 2026 22:16:05 -0800 (PST)
Received: from thinkpad.lan ([2a06:c701:4745:6c00:243c:3b07:905:b6b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm23853708f8f.30.2026.11.02.22.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:16:05 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] cpufreq: schedutil: Skip busy-CPU hold when NOHZ is disabled
Date: Tue,  3 Nov 2026 08:15:57 +0200
Message-ID: <20261103061557.1235129-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.53.0
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

With nohz=off, tick_nohz_idle_stop_tick() can return without
incrementing idle_calls. sugov_hold_freq() then treats an unchanged
counter as continuous CPU activity and can prevent frequency reductions
even after the CPU has been idle.

Skip the busy-CPU hold heuristic when NOHZ is disabled.

Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 kernel/sched/cpufreq_schedutil.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 14405a614991..111582876954 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -397,6 +397,9 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
 	if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
 		return false;
 
+	if (!tick_nohz_enabled)
+		return false;
+
 	/*
 	 * Maintain the frequency if the CPU has not been idle recently, as
 	 * reduction is likely to be premature.

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

