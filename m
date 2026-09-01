Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B43AFCFE
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226468; cv=pass; b=iA3LlhjaotxA6vmjVEclCzjqNI+nVuoPZx3MnKf69KKXeph9o8doNATWgwgUit/Oq/CPfXP7Nn86FqgcTvXz7l2M+Gg1DnNTaWxmNAh+VHvS+xfpZL1KLpmsSm86wF+hDViqUt2Pd5IFpown6ZFjr6/HlomDRkoqEbdvsYPhamI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226468; c=relaxed/simple;
	bh=aUEs5vxH9jF9nJCwZv5RTXkU9Sge3nUc5EckvCSY/FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjKPZQZ9MM9EcSE2P0dgQAkmyS/bs0hT1bTjN4w5p8GQNwsCLgV+XV3j6uToRhA5KJ7ecK7MpVhzdaWHyeoS6RP6+WK+bSwJUhXAsoVSwmk/Yy9lqoTyVRCKI9swIef5a+SlDtysXCN4kjcg/27PQ1jyWvDm2M6N5VowSZSFV14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5qUVcIC; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5qUVcIC"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52faa58bff5so127501cf.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 18:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788226465; cv=none;
        d=google.com; s=arc-20260327;
        b=B50EJQJgjQj2LCuUP7bOl/3VK4vycBr7gDdZ2umHbUAWrN0YL+Z4yuJzDj8hcQzdRm
         43ZItrs9UnjOjQgzrKWlF36Tw0Gwt6cUuMlYDSEFhgeN1fpYOMSOOj/RCWIhWEPe/Cv6
         7bnkcmwlkrjm7ivGe1JfqPzl7OHLIkVWb9QqJ5pBbNP3qYLK6fhTqa4hbEC5mbwTcSaL
         EbHEVth+CTtfP2E3ddAZDP9RILwIiR9Pc8B/a6gu9t0mYy2ZkOBcf18Xpsq3SM3g7VXA
         +VYw87zdruzbbashlGPKJaJ3+68iYuDIpY0MswLpCviw6wyTblCT2FX+qnqMu0AcsqY+
         tEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VounH2TLCX+icK8ohtB74w58kkdgdhvjkS5XdKNJR7k=;
        fh=nHOlUoqTGhww2jgOpBpOr/pvcgGj8yz6yJp6g6iZUpY=;
        b=nnRkm0g7pCl7hZSvDafZY2QJk4RyADtCkX2aYnOn3ZVHcBJsSrQKi8Hk/6yp0A+e64
         ALyw9KXkcQGsm+lO9aaPFUmxP56d1c2LcWT4JAgSOLCm6PjzWOewGOLCp06okcAl3jsb
         MXxumXgjhqZ/WJhIoNjgWC6V0FyDHwhJoeajxciq8mk8H/W/Owio3uH8OHeZfwcBdRmp
         ln3EyqjgrOIqtjQrikolJY3nhxxB13zBTgPC0FMpupvELRb3y5LaaVWKHEFiMVJ0/nkt
         Y1y+vWsGkX+o3RQFfXpCmd3C9SLxHzrAVcIKw7NxGbemwkVFuAhdqu24ml9YZfeioJgs
         sQ5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788226465; x=1788831265; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VounH2TLCX+icK8ohtB74w58kkdgdhvjkS5XdKNJR7k=;
        b=d5qUVcICWnFtxMFQtrpeF5zHkErGJIKPjeIs3PU7Uzti1/fUQWWZxTiuOM6KfvOCEt
         ymf7tMqdg4ZMhZ98hqUJtnpnsLYxwnEe11rHW7WGUWO0zNH1nWyhelbFZFkCnDXkp16y
         RkhaGlGCqnemDbzc/scNrxHRyeKBPhZL5AN7YvQD3nLJ+inVtqRYiyOutVRiUJ5nFGtA
         nUWb9eg84wCm3q6PmL+QrKoA92I4AROyKtrSOK8BiE64u78tWHmffUKUxnnZ4Ya6c53v
         jzRhDhjWIyTyljXz2iMT/mDQUvYUPPMDCUtQ0gohhbvW/8j/PS+uZIqzSR4lCnd53o6/
         fe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788226465; x=1788831265;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VounH2TLCX+icK8ohtB74w58kkdgdhvjkS5XdKNJR7k=;
        b=dZL77NNBB/AAkec+GYyiVEaYWWDCLN7PNX8zf7h9bceXnUdQ/f1Ufq5Ja9QA3BlQIv
         Q9nM7rEIhlHGtjEHynrNEEIPnSudsfmijhhkPZlYXbb2Frci5UKir9JXRYDJPvwNLSJE
         PXnt7a+95N91lZODIry7u03jngcR9wHTMxxCnRzw2I1qPb2bUr3Iq4asoY3G3bkOWeW6
         r6S8g6KT4nNyYeeXq4NaDLcmdXc9FALSXqkOdw1WSNBFXG4esn8ddpRmhdNgyah1RTww
         V4puLXFU4+q/n3sNUhF4xsgM7el3atBj8pOAqmjGk1fSomLBNylVCe/W8yvomlPyO5xM
         7GqQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKB1NuzrAXyvhGnvpNAZNjAE5ttPFE8vz2XfvBBYCBNTH+X7b4ZumIb1iSvYXrJJbMFFjlD4BN0g==@vger.kernel.org
X-Gm-Message-State: AFuF++kRXiQ9WRS2Nj6Od8OSYkYbf3zSIU8PpuwnZjQmOHfirQwhQ8Ug
	rXAF5WUttW3genCOzXzn+3XNaz/bCtjJeymY/YRNKX4AEFyBp+k0I7ivKh9RXl2t57LEnfiycLj
	Fux8rd9Q1/mCTUzDZYIr0O9yKiPamoTNrlVdKOwkn
X-Gm-Gg: AR+sD12U6As+H+SyW0LT6F5JfOx5KWTvNLMSrKl2wifgTGFR3bAbJWwq6Zyoje1cqnk
	MXnzDLBhk5TLZWencvKfmSC2O58xqdovjtEf825qw09i8S8cQjn0FW1LTABe8zBIR8F1gZ3h0GC
	kryuCd/rrDiQx+kxtnJvApYC/v0efDkPq5z4UHSjW4k/70BI/8iYPs/9TKur3oEgHjAQzLf0agp
	PE1cHoomzjsyHlkMBHJ5yV+/FCX7MNpGrfiqAeqm/A5bwZyN5jDwNqehdsBo5bkLCBP185sKmtS
	cd0KrHwVNiyengWwY1rIqhq7OHOVunTbYkqZrwsX/HidkhdPnnDcZZSQMXxjb+7kG24n22kVj3j
	LZ148AsxRZA==
X-Received: by 2002:a05:622a:2593:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-530274756b0mr5249191cf.1.1788226464562; Mon, 31 Aug 2026
 18:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831130129.3979454-1-beanhuo@iokpp.de> <20260831130129.3979454-4-beanhuo@iokpp.de>
In-Reply-To: <20260831130129.3979454-4-beanhuo@iokpp.de>
From: Stanley Jhu <stanleyjhu@google.com>
Date: Tue, 1 Sep 2026 09:33:47 +0800
X-Gm-Features: AcwNN1UR0AZpDFzuH5KotfUNB6xie5KyQVQlfhTBFVnUWK0vU3xxZdDP2DIKgiM
Message-ID: <CAE14pddCf1VhLVC_H-Nv30C4BzK_UO4Eknd27g72d1nAjdBdpA@mail.gmail.com>
Subject: Re: [PATCH 3/3] scsi: ufs: core: Report the current clock frequency
 to devfreq
To: Bean Huo <beanhuo@iokpp.de>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	"Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@sandisk.com>, 
	Bart Van Assche <bvanassche@acm.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Aug 2026 15:01:29 +0200, Bean Huo wrote:
> +     /*
> +      * target_freq stays 0 until something scales the controller for the
> +      * first time. Report nothing rather than 0 so devfreq falls back to
> +      * the frequency it last set.
> +      */
> +     if (!cur_freq)
> +             return -EINVAL;

If ufshcd_devfreq_get_cur_freq() returns -EINVAL here, devfreq falls back
to devfreq->previous_freq. However, because UFS does not set
devfreq_profile.initial_freq, previous_freq is also 0 at boot. On platforms
with use_pm_opp=true, the initial sysfs read or the first transition before
scaling still ends up seeing 0 Hz.

Would it be cleaner to initialize hba->clk_scaling.target_freq and
devfreq_profile.initial_freq to the max frequency in ufshcd_devfreq_init()?
That way, cur_freq is valid from the start and we wouldn't need to handle
the !cur_freq case here.

Thanks,
Stanley Jhu
