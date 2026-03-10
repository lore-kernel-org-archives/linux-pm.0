Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F143A962D
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169408; cv=none; b=MIlUF94etRI7sjtSLISt6ycBiuxAdiPdQWgubbZJUgZAPsISpNHp57OMSYHhg4XDCMmnRwfX24Q2Hh1Ez3ih0V4ZyYl7mn6A0UNlcWKCO8DJZVwnYC0H1y0bcUU59taylDmbFKgH9H58OiIHA6sEPhccT3hP4TD3+xNAV2z5H2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169408; c=relaxed/simple;
	bh=ykyzE+dbT5EyI3IVDI+RJC8wV1pdo/908cMOx9w1eJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxELtiItRyFTB3lXp2CWWNLZ9jToBUhHJN/E6r6BhxCRKr0qPBBZKmacjihZ1ckxOa8bYRQKvb+74WVFQFX9IWCYq6l0ybtp848/iRO1/AIQKpK98sBR6oiYLGtew0cUDAXNFhSoE/uj5/jSlY7c9SpVrm9EKNNZ4uHAXimc1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh41rZFX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh41rZFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E4EC2BCB0
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773169407;
	bh=ykyzE+dbT5EyI3IVDI+RJC8wV1pdo/908cMOx9w1eJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bh41rZFX0vSoHC0yaxBJokc5wT1mCWlvoLV3ohV1eBjFcSf9tmwWKGc4ow2wRyIBu
	 QOULTmWOU8NBTDVda2RGTvFI0aallZt2JdTvQGuGDdhRkkZcgYSUDT7mpA+cswQC4S
	 oOWa982QJOgFgR9FOnVGYscI5qHyu2/KBTk02eC1qhFAYNqcw2S/5v2i6yPHoTDz6O
	 v2VYyOJZWbpJPYdGvbaywFunDi1Hi/syjIXHCxW0WOrHCG2uBk0b0LpSeVUjOPucDM
	 aev36Ut9T622AMhM8eRE8in6eDUCQTeI1usu//epc9coK2e1BBYg+Kd0Faq9hDGlXw
	 6+JLis9BX6ceA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-662dc987dfdso1547220a12.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 12:03:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlzbUU8w+IyD2UD7G2u1CGU9+sOyQBNd8quyqqv+ZSz/n/MtLLp0LWykXimx9IhMQyT7xmyaoxRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6N/mHsJDLGeE4McmyInFVpt6Xf/8epQjC5DzOnzVaRXH0MpMi
	VrT6pFbZ4cxIHChOulXYeztG/RjfF3t52ksy0V1vo/gSG5um3W1NYGX3OAJrTVi5m2iOn0f9SLv
	XMdgXLUeeTDO0DCNrR424H5KsZ5f9h74=
X-Received: by 2002:a05:6402:5208:b0:65c:6d0:d9f8 with SMTP id
 4fb4d7f45d1cf-6619d4f4252mr7937276a12.25.1773169406419; Tue, 10 Mar 2026
 12:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310060201.660773-1-rui.zhang@intel.com>
In-Reply-To: <20260310060201.660773-1-rui.zhang@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 10 Mar 2026 15:03:14 -0400
X-Gmail-Original-Message-ID: <CAJvTdKn6j7fdWXfvKUmTybSV47OCp55M6GNBycgZ=xRTkznbFA@mail.gmail.com>
X-Gm-Features: AaiRm53ufSWDKEouhmyQGEEpxwLD2DJwFneRoPDiHCqiDXZAnqKn7ep1W8uWDVQ
Message-ID: <CAJvTdKn6j7fdWXfvKUmTybSV47OCp55M6GNBycgZ=xRTkznbFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/power turbostat: Fix out-of-bounds memory
 access in thread_data allocation
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Applied, thanks!

i simplified the commit log a bit:

    tools/power turbostat: Fix illegal memory access when SMT is
present and disabled

    When SMT is present and disabled, turbostat may under-size
    the thread_data array.  This can corrupt results or
    cause turbostat to exit with a segmentation fault.

    [lenb: commit message]
    Fixes: a2b4d0f8bf07 ("tools/power turbostat: Favor cpu# over core#")
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>



-- 
Len Brown, Intel Open Source Technology Center
