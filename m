Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C41D2D12EE
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897895; cv=none; b=AR6EgkTsTd4crIkouIXwo2HHMPxdUcU7G5rX+75Nru8N77BQbeA85mAkQ8GMQmQ/Sltl1yb2SSAsyFTlravxfNWPMtkPKXFXrLoJAqK7oMdBH6PyJOmNmokMbUdPUxTBAcmCCU/ZMTCzp9DAXnK2Z4RDQTlkSnqONsG9rLA5kxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897895; c=relaxed/simple;
	bh=w138yJmKql9CsB3j6NeuLwJiWYTSGe9wiSiVMcaP8hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqRah4N4oZgSVMwcRqie8ahlBGzM4APGy7x6E1aR9tGDzmMrgJPwN8QAlH2BMj/f5Lgd0ThTWR0lFv/9AL+RLT9KlK0xXDq2RsdxDWKbncVq2o4Y1huBPcz/jaRVDc2trlqRUTxXZVEiiUPVwpxk5uQ0PK0+RfcpUqplCZJc+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAok20QT; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAok20QT"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39d654f02baso3310685a91.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 16:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790897893; x=1791502693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w138yJmKql9CsB3j6NeuLwJiWYTSGe9wiSiVMcaP8hQ=;
        b=CAok20QTcEL+UkMAo7F9++JNNsODxVrzmFiO78jNj+tx2Ds7OlJ5WwAlu/L18im028
         9o8g0p+s56nHqYw3biYEkbTOhJczii4iJtQI1cT8dfebfas8FW0G04xanps7ZDv/vLLC
         tjaLkFjXF2NFPyH99/awvT7mnD+AM6FHSPycTeIaUvD8lIG3ZPZnIt9WbhG5TJ3ln1Tx
         eUpZdU8IJSR/wPvZhwZ5NJLZegbLRC6rsotpY9cx5VsO6OgHth9+NpfZ4UWhyHskWD4Y
         nkI+x8jyg2Kaj5psP2NJT1BZY9ruiOsG3U/x1Ijf6BZZvr+ZPFf1knuyIoOAzbc/CaJj
         WAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790897893; x=1791502693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w138yJmKql9CsB3j6NeuLwJiWYTSGe9wiSiVMcaP8hQ=;
        b=DPP9dGhTjC42ggFGjSmPULDhefRK9XzQL0dtXuOWxQV1vWGQ4KZ7q4qDrCroo3vw7o
         sFgGPnN0naQt9dbmU/QsmgFEODBC7NAzFueREULZbbCZjoFj0daY0pbJzY/9qMpLGJH/
         oac0gyQDCYztJEYzYmhGyYxW/f+FX/rNcie/+iAfF9TfWwZtQbyauTPp2Qg2FdFwzzwQ
         2pHpRZezQyyqDlpJRdhrGl31XYdDpggGszIpge18RREYBGNnh8daPznzhFTMTZeunz7p
         5HIG36vbHp3ennt1VLdkLVnOwW/P+eKKy9aXr1hlWOCQJIzYvX7y1QD0HdTPgWadcEjs
         7FRA==
X-Forwarded-Encrypted: i=1; AKwUvBxjZkO1EQjjt1radDUijfwwI7v7H1UYy2zGibKIa1P0/9w7kbl3M+jb0+V1+YTcRz6pfP/HZFExxg==@vger.kernel.org
X-Gm-Message-State: AFq9FYINnKVVP94WusWrI9nnEtkrLUKQ8gJ/g0/FpFJUDLwN88ECdLPg
	rK3ePijy3wgvPp5UQsylGcKNvHSbsL6gQDWd7Sjq9BlPnRlxyy6Uq3d7
X-Gm-Gg: AYBFou3aJVFz0V7leSSKqaRetQIl2jSvzob0HqyfeiuhbI4EvYS6jiOD8znaFODtzb4
	yGsRgbInaYbDy5XL1WXhIfpQgF9/zFOu8lMfa4T6nBIVx0ir22aN8k66a0EqhpFzzR30LIW96Jc
	k1hUh9isREuFXghDAe+o5hcU5DQeOVL0lNlxeRfUPK57BS8dYwp1v7xavbhdT2T4zqz7PKtSmgh
	bRB993G9l/cEsXkm1rC+DPc2Ac0KiWbCMcv2pfluBh4h8wnTYq5qKq02xqt394tPQk8co1RppiD
	blhODk0/u9wAFfGn+/UMMPh5fOyfZJncNDatxuS5kYKb8p/fM/07ZWRqMZM55taEjS8QbH+Ut7H
	tgvzFnXHS4U2nQulSjmgFnBig0ocn0RqeLPXjKLSXqtUOqgsOLjizbjTtUeEKVZu7CAPsag1JGo
	B7OPSWSvPYGiwxXESzm84qZ0y8k6mGaxL+pcLM8olv9ife1xbKQi6KZuNRxnfN4WvILqqFTA2bn
	YnFGkVO
X-Received: by 2002:a17:90b:3a0f:b0:3a4:d476:e10c with SMTP id 98e67ed59e1d1-3a6ce79667amr848084a91.28.1790897893326;
        Thu, 01 Oct 2026 16:38:13 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6ccc92646sm1284785a91.1.2026.10.01.16.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 16:38:12 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>,
	kernel test robot <lkp@intel.com>,
	bbnpreetsingh@gmail.com
Subject: Re: [PATCH] power: supply: max17042_battery: Make the fractional LSB macros safe
Date: Thu,  1 Oct 2026 23:38:12 +0000
Message-ID: <20261001233812.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915052529.7-1-bbnpreetsingh@gmail.com>
References: <20260915052529.7-1-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sebastian,

Gentle ping on this one. It has been a little over two weeks and I could
not find it in your for-next or fixes branch, so I wanted to check
whether it needs anything from my side.

Thanks,
Babanpreet
