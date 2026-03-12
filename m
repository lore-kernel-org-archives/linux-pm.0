Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F33CAE68
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327957; cv=none; b=Uxxn6D3gkxjzxEffLBdltrBqIJ4haJ6uZ508daElyEIqYrIi/1aeRHeKyd8qkJFQIUOrlsS1k5J73TeMwIbTgUmz+CvihJT5GO1FknAqdc0MPByxAfKUo5bebLhwSXYOC7z/a+IZsREU7SL70RCfWfw7cbW1fZzDjs1ipsjbQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327957; c=relaxed/simple;
	bh=gX9HruxmlZYlkDGpy63m43c4O3drvYXyRfbnYeF1G/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU50gaL1LjudYoyFFwqym+Xe5vt+Iz1Eyfvf5p2Gc293/yoe8NvDG2YjRptw8yfZj811HMnbTFk55xQ/vH5aAAiTtvH4VaKKPka+eLhGU6b5XyvGgcaDHaQjSnFwXjmYKN/Cv3DdX9xG5utTG48yfR614otBI9QM6wev6cyOzg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=ONE0YndH; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="ONE0YndH"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-463f00cda04so720889b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327955; x=1773932755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eLdAjWqLkV68ejMBa/WmrgRe56JAh9Yt/CFnE5wNAI=;
        b=ONE0YndHHmoHQeJ/hSb03jI33jzb9LTf0AeZ1D2tGi27r0lP7FN0jGMf88KLbFNvQb
         +5pEkOlq6kC1JCa9ZJOktDZuITsoOvA4rIUuF8BM4Z7NvhGhkzcer3gUYS3UG/it3pPW
         2AKx4w7kgfd/SI0FHVL7XA9lDDKdHx9XVXhgzwkG2S7lLvUjaDDT2S/+r9m+pTxiUm2L
         kApJp/QjwBGlTX7fYU7IIVrKeGj9AdE4dTjZBo72fykU1kdUDpz2tn/FkQCoVR8KmjgW
         sFlT0zbx2Ls81WIYfa96shPxx6FKvBkBWkhqQJm9qlGUyHDi6S32K1ZCCfYEz5x8EI34
         cb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327955; x=1773932755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7eLdAjWqLkV68ejMBa/WmrgRe56JAh9Yt/CFnE5wNAI=;
        b=AgH4fMvo6mXfE+fnKny/5c9jhXfKPoNHwhWxMQhifGu7VE+5cZ0BUiwtXfBw8IUYeR
         lxUGjUJtuFX4pPzig8JSXOrQtpmRSBmb9k/EWUEKkvh9tBFYu1xg7Yhf2+gICafCDDuP
         xyfd3kx0qkNbXyX2PnL7YLP0907a9ntWPDYoAnP4r9lnKzSopd9dwfhHi2znzJVNbF0V
         XVdrlgUaGTfV8wMyaoCfgQS2GgKYmu4Z6ciioIUoZdw5qHA7Gh8UPHswVXfwuIpoU0Tu
         0H7gaehntxx4aXA65FrhxEpqzFYVkhnkgKHRzUYf8oS7IVdIviSNtDAYS3zrToM45ocO
         vUhA==
X-Forwarded-Encrypted: i=1; AJvYcCVTnEMski3xG0CLrCBcD6NFHlN5hIjjslY9VTbirPguP5TWcAMPdO6ZuYQ6AN0mWF0z1jgICZgiJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMXk51FpfqET8QtAlDWb7wtCvzNHyUlV1KYzorxEhaDTi3y6e
	zkNZz+RBq3HPssuJ2wYGcCTZ5+ykjSXQelJ9J0v+iierMQN0FdA1LDUlA/vWL3S0qek=
X-Gm-Gg: ATEYQzyTdXF526eifvlChjbSg5zh5IrAWh2BhS69rNxgL+iTqIT/cUfhkEyLjdQUo3N
	Hj2A3YVCbTSkxS0JO5QwxbxetFwqqd+19k0SzWzhMJ9NwMFeDQedg/bVvHbAW6pBzeN/eVMllqU
	4KVSrh7z4es45SyCZbqbWFajqUBzEyMWWm5anWalTU6Yutmppssdw0V7kY0Al/7V/5CtLaXpySZ
	bGXoR3zE4Yspkjuz7UOIdy2I0tYHAUszWq8o6e9vuy5cxmGjBcHEPnMudfHFCXqahnM4ntWwFdT
	6IQNyeUkKszWVKXbbfpMUUIlK80xzxkKLbQICSHCo3EAgk0S0vi0AMPyFUSKr2Vd0N9emBHMIct
	2N39Y609ZFlLvP4ZdJjycq5KVYGg5FfuyZ7m9UOmbWo8txhtMPXWuGzDhBj0Xcifp5XcR6erEfN
	1a4Z4RMnDU+TaqplRxeqL0QUAeh6jidwD2pf7UVTfCNlclZ/EU8tX7EIku5O2SadIU6w==
X-Received: by 2002:a05:6808:1304:b0:467:2a6e:ada8 with SMTP id 5614622812f47-4673343a783mr3569173b6e.25.1773327954966;
        Thu, 12 Mar 2026 08:05:54 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:54 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 07/15] devfreq: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:02 -0400
Message-ID: <20260312150523.2054552-8-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c0a74091b9041..42278449d4b27 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -370,7 +370,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	 * change order of between devfreq device and passive devfreq device.
 	 */
 	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
-		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
+		trace_invoke_devfreq_frequency(devfreq, new_freq, cur_freq);
 
 	freqs.new = new_freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
-- 
2.53.0

