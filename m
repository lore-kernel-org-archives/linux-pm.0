Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2837B3F7
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790835906; cv=none; b=on/rlHa2PHEyWvvjChGQ8wt3dAlOzpWe7SMYb4qKMkB5Jm1hQNfzcK2Qp/l/Y96NIccTvRG9uoy5/HK63VPuUflZwXCO1D5ZH46DZ7dyuJ82/GQrKPFslXZBWlYIQsLWq5Jk93P+0oQYW+/C/itSDIiKeCT4ZHq2uzhBI7DfoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790835906; c=relaxed/simple;
	bh=CuIdV5VrftBCONiR2VTHvhJ7dRW+tausNZFIdyCd3HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkXBxHttsAn6YIMe1eQ4kYZrSGiR+GGmHafDJYA2y9N6dhqg8oJmBQGRsPjw8bCtlRWnbCVpW9uG6VDCQSdSlpYoy83KeF0nRT3iTYa/jyUymBeMrMH1smjlwFJ9+tB39quUTLBt0pzMWgr/IUmd4aucdmNyVZn/3Zu8FC4YdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d0ZJE6hL; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0ZJE6hL"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd046b87so4722146c88.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790835904; x=1791440704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MWianhRz6JmVZ+t3LJGj+9gNABxqIeJX31Clh5irBFc=;
        b=d0ZJE6hLlYbQhWiYykk+skL1mtK05Yn911sIN6RJPck4KZ06U+nM1DeDwtIHhZ4uc+
         IzDWGDtT5/FTj8LeSY3HJgW/Fm2NXm0doaAeU9tr5D/OBknvMQJA8RjTuXVSsyoJn6dk
         WmwEBZotJr/P24mcigPhBqqtrJUyptd56QLvlfBMt/NBLCDxu1xAEWd+SDHfuNXd7mtC
         g53aRwX39nlUHE66E7K3OMyGXh40ek9EDZGFKoS53MjoaOm3f6hhHRMP6vwtjYhyVK3B
         o0EqodMzU0XMw24/c+Z2wcnsLNThKQ/uVcPwrnejfmB2KMHNYJWxiDEAmwmtm6o0SUP2
         o4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790835904; x=1791440704;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MWianhRz6JmVZ+t3LJGj+9gNABxqIeJX31Clh5irBFc=;
        b=nBeRkY//9C3RonF4DOKviemkBxqbCYIYRSJoaNQTVdYzZTH5mSW4wW1Qfe0/HZ0k+d
         SqD1ugFQoM26s3KYwZGn6VGzelIqikCq0p2YIHGEbmM3vTeueNC/yi5S+9XmprbnLgNV
         8PVyagCstzorflIatahZEnoqpqpoAaxJvpW4xBzFBpKRQ73/4cRm/LDziUHrxOGQhAA0
         BugfKKXZjS/giVjLDWGAgllqYJtQHf29VL9FjoTXLcTDw4ffpuJPfwZu1eoCpm0L0UfT
         G9YVuVwpLmg+59XlYDJyzQFm9sxVE7tYfMfW0/sZijpN0ZdvrPVD9EIRf3BptcRLBda3
         2sMg==
X-Forwarded-Encrypted: i=1; AKwUvBx7B23V2eyOzIY+n9FVHJ0QBeDZsf3NIph9AIBHFSWZy48rGYwlaR+yw94MM1cQo9hPZ3BlPxWv8Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mnnxKYwSeEZFzYdyCR9nuam4JEF3X9ZY/saHK4j88NTcKajPtj
	HrQhW3247GCJag/9fSDKv6AqjNjFqHGZrNYYt6p7Kh1hHIthSpeYWvY64uUM7vcXKjE=
X-Gm-Gg: AYBFou2UGES8OfwkAuv6AkkHiV1t792RAndZwhSj/eS0fcotcbJoYnfVU28gK4QlCYg
	BBIqAgeE5Z7CoC53mg+6FeDjOzMBV1d3baDQwbPxIvXARM2vFCu90yPAqODyaywI5TrodTcEBNB
	Xiczx22kPbFDnVZbqD4/oSi4n2xlPR9aCjqqnQYsBa6QqgKH8XoZBuBS0/t4jsuFkxgvUM+u9xb
	uBDfyFhhEUrmvVaY9VRj/FU0Sjvy7yBffV4tn7f/pLaCVb0mnpMm3wVyjGhJd9WRY+ikfHPUy7x
	I2Cd1NXmRK8ibvU1EI2uuLegWb7A+TNsjBu1L97eiVfumS9W9omD8QXDAQ77oQgh+VDyxSi8Zvm
	dAf0C7rc5KB6ANeGxqcf0CXetjSplAU2eFEHNhgGwgV7vcEpzqURsdntF7fV5oJYKH0xJ4l8Vsh
	BvSAvWhYRF1fMMvbZ7tpquWfCQFPZpzeqG6bed9cbsmeUJsEuGcgGRGfLGFo/Zi05GiX+P7KNhR
	w==
X-Received: by 2002:a05:7022:299:10b0:14d:baf5:c40e with SMTP id a92af1059eb24-14dbaf5c56amr1838510c88.8.1790835903723;
        Wed, 30 Sep 2026 23:25:03 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14df359ee25sm5135037c88.5.2026.09.30.23.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:25:02 -0700 (PDT)
Date: Thu, 1 Oct 2026 11:55:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: spidermana <xuyiwen14@gmail.com>
Cc: miguel.ojeda.sandonis@gmail.com, a.hindborg@kernel.org,
	acourbot@nvidia.com, aliceryhl@google.com, bjorn3_gh@protonmail.com,
	boqun@kernel.org, dakr@kernel.org, daniel.almeida@collabora.com,
	gary@garyguo.net, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, lossin@kernel.org,
	mehmet.mkoseoglu@gmail.com, ojeda@kernel.org, rafael@kernel.org,
	rust-for-linux@vger.kernel.org, tamird@kernel.org,
	tmgross@umich.edu, work@onurozkan.dev
Subject: Re: [PATCH v3] rust: cpufreq: reject NULL from cpufreq_cpu_get()
Message-ID: <ar38vCqqekY7T3SZ@vireshk-B250M-D3H>
References: <CANiq72ki8M1KmxhO4vSkMUfLcuqOMvZtuTNdDpS-UcJy8rqWpA@mail.gmail.com>
 <20260929095539.1398671-1-xuyiwen14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929095539.1398671-1-xuyiwen14@gmail.com>

On 29-09-26, 11:55, spidermana wrote:
> On Mon, 28 Sep 2026 19:17:08 +0200, Miguel Ojeda wrote:
> > The From: doesn't seem to match the email of the tag, is that intended?
> 
> Oops, no, thanks for noticing! Please disregard the tag in my
> previous reply. the correct one is:
> 
> Reviewed-by: spidermana <xuyiwen14@gmail.com>

Please resend the patch with all the fixes / tags / improvements. Thanks.

-- 
viresh
