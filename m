Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2E2F1FEC
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581808; cv=none; b=h86prFIyg/leEVGmQgX1hb4BpXq9YWReaLtrZ2IHocyVl7PJEE7Sl1C7yJ5r9jUJkW8uy1KPt/8YxYo4nHHn2DZBFZjTvenFkYxbBbYOAtJMkl0JI2Qo1UFlfkihEX0V35g/4qcOr16B5PKi1cwt2Itc8eCP5TzXSjFLgTsARps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581808; c=relaxed/simple;
	bh=xbn7Orbzsrgd9Q/Y2/ehXdUJJE+ipSXiHDZD+/c8I00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxrD45ZCT1w4DTpTGNo6zke3Ar+aPNs2HSwqGt3yP6A924jUywSkFfRSkAO4lRjQi7rXb2w0VFz6XSCwxZL64pFbaCOdK///URLMxITq05j03AnqRLHPqNCuzTyPw3UrkOKQw8HkIKJ4fRXpMauYujKPupULeZBPFMimZBxIXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpzYHaP/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpzYHaP/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso21494435ad.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 17:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786581807; x=1787186607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbn7Orbzsrgd9Q/Y2/ehXdUJJE+ipSXiHDZD+/c8I00=;
        b=gpzYHaP/ZnDi+xvFbhM8d3yf2Xc5hRbgGMfionUVZ3nMRhzOrmNvK146Ytfo4+WuGk
         TdBcBzhOzqbJPtkc+jGE1ej1JJHIMOaYxuf68F6NbG7dM8R4oR/nQ9meuhwWLoSrLVwC
         i1Wp1PE1ginmKKkPqxzMjSIu8aifz2kJH/x9Q3gwpdKS+Y4h1k/2MFIV3bZSgvPwZXiv
         zfuQvpo6eInTamt/YO8yA086lu3uLr0bNyvT7D9xtUw1aA4sxg5/qdyjWk6IyRcwMVC/
         4O3wTXFAO8PbpVM/L76Wgugi/pNPkEAhVnqkgUXozkgdUY7kQkYQBinyB/dlxIPO4jUi
         KthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786581807; x=1787186607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbn7Orbzsrgd9Q/Y2/ehXdUJJE+ipSXiHDZD+/c8I00=;
        b=o1ZDFdCO6/gZIHGnZc7dEtMLx3WdpT6LibwYT1ZTuM4pcwf8yecnwObi/M55UsMjLn
         /Y5RrKP1np+fMCPTlCe0pey85uCyhBmJpCmXZ4wQC0/OIqN9h+oHUmVzZxartH7FroRT
         /4kDVszYX3WIv83jcj07dKqtpUUgelp1tgPTQaekC2lx4qDSMBFMnl1n1/+L8tqfdFqM
         he9to5UDzeIG8ZFhWPnBSmZZYaRwhcDAmdKRo6rhLjI7iF3VuNQaxSpIKAR8sfhfCZX/
         E1OnGRSBkFyePMmUA/7lCrHFW/a+sU56e+AphsusJzM4iyZuLR4vsqxntZuGnHvjS2bN
         RJ0g==
X-Gm-Message-State: AOJu0YwMmLnmnOmFoleHEQiE/55y8yJ3Vm/tKZ43w2joX++JLRRKQVw8
	uxyIda61b6NU31St+5Jtq8Pia9rNLT7uZ72RRAY+Vi4KG3xdBbsU4Oc4
X-Gm-Gg: AR+sD10zTwzx1CJ4udy9Fq37ixjTsCA6OHCDxG3GKNqZ+onQgw/2xJbuF5R9AH5XnwK
	EYe2R+8K6czd8R2ag2ZF/x060jt0iodVlNQ7yHNwK5amEJhvxfGa/ohAQSM0tOPN/bIYsIB0Rmy
	bf2tsNDMvdnKITBz0dbbO0qqErGY7TnVlC2w+Mm+YG3JzQldBEbAVWnW8DBkCmP1hXdT0mE1G+N
	Nb2N6prRVEpybk71hBzQg+O2jhnhHa2r18knr/l2wWfw9exusFEvFP5CTo0m9qtSaTciHuLahCK
	pDsPF374O6b72Q7LRFaYmWTWPhLj5WqxOeCpTGKmTMJlTWDo2Tl27aBUeZSlBRONrtEk3H4DWN/
	NKT4gMHRYkCFxOjmEd2JPjVKetjeudf9Fn+lo8Sn86A4tPtn2tZGL3IEUEnpOIVyjVEEXWdK8qH
	QE08Xvw24WqbWdMZlK0kLsONvOn9fVNzc0bcdVxNUsn5k5ngjOkGfYIZqMqvv2x4kJA7iIKjCWr
	6T6Pr9qbeLovPBgrGhnJ0CNr5jK71VXAIKMplseQjFxF5vciHNuPYGEKD4y
X-Received: by 2002:a17:90b:268c:b0:37f:a915:1c29 with SMTP id 98e67ed59e1d1-3931e27b831mr2599587a91.19.1786581806681;
        Wed, 12 Aug 2026 17:43:26 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::6868])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931efaaae5sm762570a91.0.2026.08.12.17.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 17:43:26 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: fix spelling mistakes in comments across the subsystem
Date: Wed, 12 Aug 2026 18:43:13 -0600
Message-ID: <20260813004313.31000-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813004113.29943-2-skunkolee@gmail.com>
References: <20260813004113.29943-2-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apologies! This was sent to you by mistake due to a stale patch
file left in my outgoing queue. It's unrelated to the ds2760 series
and already correctly merged via a separate thread with Krzysztof
Kozlowski. Please disregard!

ivy
