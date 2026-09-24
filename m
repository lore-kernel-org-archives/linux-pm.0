Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E317E4078D4
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238580; cv=none; b=K1jA9L/sQkdAkco9RZOYSSxgkQaY3ctzJ31DBqZicZTDHS3BPfMrtZ4JC3ZKXgKwDfYldOP0yLNGC7kKljD7kdZbxoxVy6NSJol14i+8nk7Yt/5vEpIdtAB0bOxJa9o07q/cjz8+qZA++01JTW37LzsmV2SRANRPcj0hCnKRxiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238580; c=relaxed/simple;
	bh=zlBXKls+F/WVyUupqY3wSg0zZR5jLPtlUo39nbMOMgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0Zo9XAm1myCejDASQGtStU+KkPho5VjylOlMrpsGmRiscCl0eL0pZ4O37GVGszCzyUuQYvCQ8yig5Rk2xVCf3fdbym9YfT2+A7eBOxrVOC6Eql9bxPkdCEyVj8j8xnKhkG1zfJ28Uc+DgA04vX0IB6WFqzLs1xZSQHSirSstiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4h5B7YP; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4h5B7YP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso12834585e9.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238575; x=1790843375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zlBXKls+F/WVyUupqY3wSg0zZR5jLPtlUo39nbMOMgs=;
        b=F4h5B7YPJWT4iJVsoW/hQbxq5Wq05bPYkaLCICQJ3DLJ1/gZxdl63gJpEGgf6NxBIG
         ZI6X7ZxV3soQqnU4ub9F3o5VcTUJY7wsFciw5SvpCyAsHXzjIZTooOuPucoH3YTo6WiB
         v5AqxSbeYOngN4HBWxRidOzkeX5KYKTHSdxBRD6rIVeIdFceGhQhivQZYVkZhVfHHRXd
         8fq+yr/sVwseQ22MGnHlo46nLxLQRnZGcvQNEoni3N8DWSWg2JBVbRkIWVdhE/Yi0/cy
         X4OkWI8RiyeR/GqxuHFdriDU7ZEzwi+62rP/qivJHTYSrqitYBmOpn+tYwg0n6yUXfL7
         O+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238575; x=1790843375;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlBXKls+F/WVyUupqY3wSg0zZR5jLPtlUo39nbMOMgs=;
        b=UJxKH326CkM6W4Egg1nbLwDK58VY59VB3G4hYJpqSVYT7gJFjxE2InaacdUgjTNSQp
         T2O3JO1xYXuAnuYJCJfVBJ/xvVGtqVJaXwTsojYfigVrcNQ8ots9bOhiRR39FjGcNde7
         4STrziGpGdxS/f4nwia/i6Gu/hMwGVebspfCDGXdfGXGATfq97iqH2T2gAF4pn+zhyVL
         u6jbSk15u47hmw1WS3/tTCSnCnKNdbURzVNEKmCZi4UXXHsYWxXw2RTSd5n9EXRy2OM+
         kypl66S5ek9iXXqABGY8NQfXNfcIqSyQ39cj9zBpc9ZeiAbtCgtokSponowzoO5HF9Kz
         F94Q==
X-Forwarded-Encrypted: i=1; AKwUvByyxTU0SomIMSBsY/g0gHcYOcSWb0wPRVQIA0t6OLsBAp9Nhf4E95W0wa+WVzFGHJARJtXgmDiQpw==@vger.kernel.org
X-Gm-Message-State: AFuF++mh0Mj8eEfNojLxvGu6cr+5mOM7nhWBIH+24yHzZU4sdWDFT6rw
	b+qfyeNmEEnMLSGyTV3fY1iy7grIPdRRvFqK+pKf0iPkzcTdACIqw353
X-Gm-Gg: AYBFou1ncRTYV+sqQ++EaSP1c/DczwzbpPf0q3ysXA+Pvm1qz2WiKyAIHhWtyHFjEG2
	nfJ5SaQTu21c75ZqW4Jyku3MLNvBuq78M1ocVpkpoHT6Z16gRz9PbEgoFIBJ/tfVK2TDgyAZfs7
	Ya85n9hUsduUgnxNt7858Zd108UOrIauiDrX7zh8rQ8lHPF4LnGrtgaPN6go1ATknCypotJShl4
	y/xmw1j99ZauXRbfdg3AxWjsMYxCqTpBtzrBGg81t05dYYR6ODTnim06vSdU+t12dsPD8ClcE7L
	EGdcbjSG8BlxYzyZwbAGaWCJqLVJogzBdmGSkR8HGlhIaeke1bIcOupxkL0IoAzmepYmJfCwcqa
	3NcbYWyt3t4ujnUyLlb2LhqHAjV7fJN09rmaW0qvS+DYu9JWJg1eGNtkfMuAd14xjDyxes8K449
	Shv5SCHYXIjwJWVg0mQYq+HGifskl0x2zgBkzp6HrrP3RN1tfG8fnI53hlgXkQKz9znKAEg9KJS
	Z62wYLEdurBvb6UOA==
X-Received: by 2002:a05:600c:628b:b0:499:900c:9c69 with SMTP id 5b1f17b1804b1-49fe66d1134mr25718035e9.9.1790238575219;
        Thu, 24 Sep 2026 01:29:35 -0700 (PDT)
Received: from localhost.localdomain ([94.252.74.168])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49fe0c4b51bsm99926925e9.4.2026.09.24.01.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:29:34 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ananthu C V <ananthu.cv@oss.qualcomm.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6] arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
Date: Thu, 24 Sep 2026 10:29:28 +0200
Message-ID: <179023856877.183607.17352008232359942762@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arPmhnU-pkGpaD4-@arm.com>
References: <arPmhnU-pkGpaD4-@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Catalin,

On Wed, Sep 23, 2026, Catalin Marinas wrote:
> I assume Dietmar and Will's acks still stand. I can add them from v5
> (let me know if you disagree).

No objection from me, thanks.

Oleg
