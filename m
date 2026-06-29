Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24F937DAA6
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747258; cv=none; b=JUS08ndQzsoLHnz/rijgXYvjhrRqhZih9VnAbeSRPZKM31rpb1qF59cnVt9v27HdoEKl9oqDWFA8rKiBvOTWbojNZri0ME2AScpMdXtdLzyPJn1Us2kyOvPgWYbHXlMxaTxzFc4ZtZh9TAi0gU6orQjxO3GRuNdlbWL/hBh2gVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747258; c=relaxed/simple;
	bh=Sy6JGeil4deLnMSvof8VqxcsucaS49cWaMJykRuqdh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRla+QagrTF6M5MX4evyxI34//HnyCYovwN02QIS0Z+KQO/AoElo4IYeQQiVS5+jwTcYEQCFTS2kxYrtQAI1xI1emd6sZT8dCbU15RLHkCqxLy6tbLUiD+Nf55LB+5METq57LMmQ8YrPlRFP15oZvI5ixvqXh9YWj/AOKDpybkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAYXxvfN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/WBv65m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAYXxvfN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/WBv65m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782747255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jyH6F/rzycE55igieO5QcOyc46xwfU6NRg+LIEtIXp0=;
	b=JAYXxvfNjhyV/xUDTAWQdmOyWOgaM63xzWzXXmGFLm7hlqLcR8LUgMTATdh7OX82Vofrro
	jL1v/Y/wAeQgrGukOQ891bjP197B3IOQEkBXni9v8u/apEt4pk09iT+qI9xKwSuCYApLyP
	pqg8WxJTmL/N18KA4isJzGnxX6n6H44=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-Rx00KGbiNVWG13Hx2dd2dQ-1; Mon, 29 Jun 2026 11:34:14 -0400
X-MC-Unique: Rx00KGbiNVWG13Hx2dd2dQ-1
X-Mimecast-MFC-AGG-ID: Rx00KGbiNVWG13Hx2dd2dQ_1782747254
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9674fae89e9so1043499241.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782747254; x=1783352054; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyH6F/rzycE55igieO5QcOyc46xwfU6NRg+LIEtIXp0=;
        b=M/WBv65mw8+Ab3Z6LZaPLTIutifdE0W0Qk6OaZYwkKf2a1oCIUKz4cSTQFHoDIDV/I
         B7W0I1qygRcsznmPy1MMB8SHE5JxvxTezob3YXVtebSkHg5JN1c2yndGhFyq75ge3gxk
         1m/Af86Jznsj1MxhaV2rCKYfZf1NMInBFFBX2ZGbNcGd2I8pBpuzuTYgQouU7yw76rd2
         CEpU3mq22Zi1BX1PUON1DP0Yy36D8FyXw20u44lCGtHUzZEsxVsM1h8hfW0TVRFxfpC5
         dMp9oKju8BO3u2NKGX5JmFidhNzTrJdIE1rzwNGpX9muhoFORheiGJz5p8ksnUBmctbE
         PGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747254; x=1783352054;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jyH6F/rzycE55igieO5QcOyc46xwfU6NRg+LIEtIXp0=;
        b=JYYaKs6ti6sFe2YbMEZbKyGgnE2szpjintrc+yOefAOfzdo4UfuCOa5mec9NyzqezO
         69Y0CJ7nyP85gFBR11P3ioN2DJC0fnvA4ySt2aYGfklN6vbubhEh4/Vl+x4PjxrfxQ38
         0n6dvfCP+sxz94rj7fjf9oxz8RxudK8BIxPopFGQt9yKC8GxZa5Y99QYJqMCe5mHB8JF
         Bsmg9BhAngZ2D9DeoJSOOI62aqtfY2A5nbqKyhRRqn082FH68+sYH3oxsABKCb+g1sDO
         zGtbSDCkpgpUHj+o+AODYPkUFISwMCV3OLXXEK54tzTjz1L4p3pKHtn1k5rnxN4DbhdV
         Tbzg==
X-Forwarded-Encrypted: i=1; AHgh+RrW2eup3Uwzqsbby1sGAGiwfIjPznew0WA5rmKdJe/5DyiBz2SP7Y1BPOu/4XIo3u4GhsPlJMP+Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwruSnZnkCbMjmndp3ubF2MgyEac33AW5xddlUFaBwiwFa5p+R9
	kbnuBn5X2oChOPBGOA8NGDb5m8MuRpX2ct4Milri3Jm16DSzeU3gnT+mS2hgh6WmheneuWcmGdg
	AIomTM+t8CRrRGzkuCq3o8StZRR7f4i2u+2yOQ/pRVIN5cwu8Do7CWhBQCeHS
X-Gm-Gg: AfdE7cknuYf8Es/jUUoVsNmRxktvZnE/pZMBOFcFS8MeEyLcXx38fZng0C6UV0x3Sah
	Dpb1KZQw6K8TxZlvMDPQCsKdrz4Scl95hg0AxZuxNyE4Qh2OpJMUqLZqwjb5xwaBVi9OG+0zYm9
	eMbVZMwd+xMVoSCI+eC8A+5lFEmbt8DAKYez52yhPnbjQSRkjXC2sRjs0akeai4cZat1iuliuP5
	s4FNP7UZtjFNm3oW5WKpkiT8fFvVHGCU0Od6BboPwoiyeJoxXoTJFameTFwIbEK1Hxufg6fFI9f
	HHPbJITEy0Q940tJ3s/7PJP+xei2/vNRv4e6nWcTLiD/f5WNIrNm/ESfkSKMT//QQb34dqYYSz2
	J050lOoMGYFQfVK03iV6FfJ1Q3XOuvhwensFgT/ys4o4fyw==
X-Received: by 2002:a05:6102:4187:b0:738:9bf0:f80c with SMTP id ada2fe7eead31-73a366f5f9bmr155583137.9.1782747253699;
        Mon, 29 Jun 2026 08:34:13 -0700 (PDT)
X-Received: by 2002:a05:6102:4187:b0:738:9bf0:f80c with SMTP id ada2fe7eead31-73a366f5f9bmr155536137.9.1782747253174;
        Mon, 29 Jun 2026 08:34:13 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a3580949sm1005826d6.21.2026.06.29.08.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:34:12 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:34:10 -0400
From: Brian Masney <bmasney@redhat.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Xuyang Dong <dongxuyang@eswincomputing.com>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Maxime Ripard <mripard@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/4] clk: implement sync_state support
Message-ID: <akKQciC87HxiwZPj@redhat.com>
References: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
 <bfacf381-8112-4c12-b87c-46cab7d7f284@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfacf381-8112-4c12-b87c-46cab7d7f284@oss.qualcomm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)

On Mon, Jun 29, 2026 at 12:06:19PM +0200, Konrad Dybcio wrote:
> On 6/26/26 6:32 PM, Brian Masney wrote:
> > The existing support for disabling unused clks runs in the late initcall
> > stage, and it has been known for a long time that this is broken since
> > it runs too early in the boot up process. It doesn't work for kernel
> > modules, and it also doesn't work if all of the consumers haven't fully
> > probed yet. Folks have long recommended to boot certain platforms with
> > clk_ignore_unused to work around issues with disabling unused clks.
> > 
> > This series fixes this by adding support for sync_state to the clk
> > subsystem.
> > 
> > Changes in v3:
> 
> The version tag is missing from the subjects of the patches you sent
> By the trailers, it seems like you used b4.. did you play with
> prep --force-revision by chance?

Oops, yea that was my bad. I mistakenly got too aggressive with rebasing
my branch, and I dropped the commit that had the cover letter / b4
metadata the previous day. I didn't know the old SHA, so I had to
start over with a new b4 managed branch, and cherry pick my patches on
top. I forgot to run b4 prep --force-revision to force it to v3.

Brian

