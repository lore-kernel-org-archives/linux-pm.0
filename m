Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502637;
	b=wrYbeUAOBKojzFl9KwlDCIEbacYmZ9Sk6IVoffXMbTzIpIPswEtDzQN28cqSVwGPAyR/
	 Q2weHmO7WmG1NF8xWzySY8rhhODiux/vHN/U52c6F6xrTwqpdNgOw3lnTmzz7iLKuhdDM
	 a6ToOSuEWJRzVbJq/Ng+yJQypT37QJGTKoiPQNaCAe0Aj7qscgPrTY3VwFxgGkQP9T06A
	 rKulYc10550mF3oCqKUWoj6tdQqFKufmK1tdomI3uFTFpw+UMrmo0yILDH2vmzCNGuuxK
	 6WMN27jU/l6bA7Pc81/CRoK8uVCTMNEOmY/noxSV2QI/jgvNWEdtblLtyuwdPyZRPPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vOwJdBkJQT2ZZgsV9Tvx4zTJRIWa7XIIOUhJ8h1ztTI=;
	b=dY29FlMPoNDftvwirE9JkCWyykCaQ1QOa3yHABgPPeFwU+8tR5oVTH/TQQaWiZrSUzXM
	 qF/hIGTIO3k+DEaEJNgA8qno6q/l+tvpTXdng2IeeKF1aiCCDOE8HoAuS4T88rcOtY8QW
	 VAiix/E+W5AoQY6PfivdeGiMGVcfmGE9tsHErEIN2kZXbRRM4/qUFVUaJAzOBoKhMfjNk
	 yqlnW3UMULZ6eHKzunUYXNheXZ+c9H/NJNW6geO4X15o3mSVO/GfeN01VxCQVUS0+DKh2
	 gZMrHJEx2N0dIxkPBKhh87bMSyW/PaJCZfR2hVfHTyt8K9WcdGaS+5QrThlflJBg2+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hOqFBXvw;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71102606A32E
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 13:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71102606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hOqFBXvw
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso991800b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792502637; x=1793107437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vOwJdBkJQT2ZZgsV9Tvx4zTJRIWa7XIIOUhJ8h1ztTI=;
        b=hOqFBXvwIqfLxs4G+ZTGW17EGdDcEoatHHgJDFqPnmSt9WtAeYWXTUUwWWl2pcT37u
         NpnQT/lwgz37PVRADHzRQd/qQ91udzQuNswOUANj0LLj/TMwrE/v6Bs++I4N7brqkjpl
         0FBNI1KmNNmgtPLPF57K+IyXhaJFw/SS7ropGRa2lGHjofqxX7ypaOHAdT4SFm72XKNB
         Vn4DpgwHsY9SWKIY4SMaijoNIEmPrDBbFrunchSl/DsuYKVV1DHfbzk1eovQHXLKXqxE
         L/9Ry+U3/pd0bdJqDVfPTdKgpT08ARfWFHooTTv1psuIp1c8io/aJyABc9vp4MRJwfF8
         HGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502637; x=1793107437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vOwJdBkJQT2ZZgsV9Tvx4zTJRIWa7XIIOUhJ8h1ztTI=;
        b=LjExNoRjmh5fqIMBmpwYOLLDZ6G9Znfn6cVUfC7i20anPPbs8Kc5IdOpufHrZUCaZm
         SkhCHpxisOYxVh4lYNyu/53x+X59auSbwLdW3GRiaU80qWzwl6kiht2n8GbAlUjyH4rv
         gdYCIZ74pUGBE1JTFPIMKI6EJ4G58a5MwMpYtIAkTfJvS/HXSBo35qa1G77UCwTXQg0y
         Wmn1R5PAhjGT7Cy9hzcbut8K+GRB+hLQRGA+OYJ85umsKqyiLxoPlJcafWubZsagJPR9
         zpa+X9IxYF9laECgtXf/QjpBsTMrI+nkshkScY3VlwjXJ6HVsMKWo5u9bLS3CDBCm+qn
         on3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxNdqUly68XEoQSUh3BZ6+KF4dkNFUIAKJnHBUtBXBTaqzjsKbSFyqbW7E42BoPh/kGlQkJ4Bzk6g==@vger.kernel.org
X-Gm-Message-State: AFq9FYLOYVeeMOnVN+WZ8zVdTd8t1hxXNbktuwXR7dN09VrRpkDqvyKf
	7+fpaKpCHb4QpLyHX/iuk8x321sLzVaoAejh7MrGNOQz8i9JvUleImeNp4r1yVKtQqE=
X-Gm-Gg: AYBFou3rvimyJ3yoUKuVhg9y0xK4tlhggKcTZCy5YTwSK7xaE6+E7SXnZKVAaANyJEY
	b4jzpIU0f9WnN48pZnMsjXVp/gOv1mzkvLX0HEngL84knVTEAJeMOTy+wR2eaB2KOLjyobdTA1s
	xCwUf2SwM3JYxaD7Md3u0XPZ9QTvxGe+9fquQMnrsD5IAJj2e1Q/bjBaMCS8Co7YWIrZgQVrBu9
	e/kxxMUtd6e7eiCjspo2mqTwztuYNLSwrIuRTy0AbHNf6o034PmOzYArQgLZa9tyDqm38L9LyDJ
	zWGPBjQ3nftnFl5vEijZl4liJSH+HHDMt8Aj0QqrxJzR+sKHjjTbF2d+keRDf7wfZnvMHdD+WqE
	uDtZsQ5GK1sgDXmZaYA4nXVEb0GQSglQzq+Er+jwwwyj7GwAgJGmQZXYqswqWcmK7epQaUwgfSj
	n861br03bPYLZ6wPzcLLNcqpJY/qpbkfTQpNfchGXkWteDD2ZpM9f0DUXpLqINyNke88MQWPZUW
	EzjLuGhj2jACA==
X-Received: by 2002:a05:6a00:2794:b0:89f:c156:d211 with SMTP id d2e1a72fcca58-8a04caf9590mr8276728b3a.31.1792502636753;
        Tue, 20 Oct 2026 06:23:56 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f58208cc3sm4831503b3a.52.2026.10.20.06.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:23:56 -0700 (PDT)
From: joonhoekim <26rote@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Joonhoe Kim <26rote@gmail.com>,
	sre@kernel.org,
	kamal.wadhwa@oss.qualcomm.com,
	anjelique.melendez@oss.qualcomm.com,
	dhruvin.rajpura@oss.qualcomm.com,
	andersson@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: qcom_battmgr: expose the charge current limit
Date: Tue, 20 Oct 2026 22:23:48 +0900
Message-ID: <20261020132350.953-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <4ec618a6-052b-47de-8418-e0e319af10ce@oss.qualcomm.com>
References: <20261016124806.1789-1-26rote@gmail.com> <20261016124806.1789-2-26rote@gmail.com> <4ec618a6-052b-47de-8418-e0e319af10ce@oss.qualcomm.com>
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

From: Joonhoe Kim <26rote@gmail.com>

On 10/20/26 11:55 AM, Konrad Dybcio wrote:
>> +	mutex_lock(&battmgr->lock);
>
> guard(mutex)(&battmgr->lock)

Will do.

>> +	if (!ret) {
>
> LLM suggests to add:
>
> -	if (!ret) {
> +	if (!ret && !battmgr->info.charge_ctrl_limit_max)
> +		ret = -ENODATA;
> +	if (!ret) {
>
> to prevent a possible zero-maximum value coming from the FW
> from messing with us here

Agreed. This firmware reports a maximum of 12.4 A, but a zero maximum
would clamp every write to 0, and a limit of 0 stops charging here until
the end threshold is moved below the capacity and back. Returning
-ENODATA is better than that.

Both in v2. I'll wait until Jingyi has had a chance to check the sign
in 1/2, then resend the two together.

Thanks,
Joonhoe Kim
