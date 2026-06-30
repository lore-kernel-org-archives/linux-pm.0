Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32F13B71D7
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793292; cv=none; b=uD+VDde4e8y2WMCVumLg342KOC9SC0VRYU7XkNorTil3RhnZAlxgK9gw7HBlnJGFIGy6kSNFctDbrMGujPqImJK1e4ZqLbxLfhbl5iGrWhqLV4/5oLx1mr3iL9wWU6lZNkF2IgZxPpRvsMU2bUdUMdvjkctHZvg8kYSk1MLVsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793292; c=relaxed/simple;
	bh=PE52VBt8djxbbRcTSAHyYKrmdk/gTJADpQtbrQDvd8g=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Js2QlImULKKk2IwN8reDd4hTGCDXk9VJsJ47wZRuKPdWeWKVZBSb9nE/CB3do0Er8kVtFeH97dfkRmMG/tp8a7TyD9KNZ16mtEY4Q/fN5OJnPVzd4E1Tvn7styGuWEd7WAnNlISb0oGSmJKakfkh17vqzhPG7yYhyNxm8RYYCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=XQw0zpQ1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="XQw0zpQ1"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so3400574a91.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 21:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1782793290; x=1783398090; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXUQhEyd59EFcoHyMiF1oi62h1qq3FOFA8aGEe2nBJM=;
        b=XQw0zpQ14FYkxUux84+zk8pAAXcSF9MlCmpYS7cEUWq153JBcQhjV52I7EXSc6mYg8
         fodTJCw3mgZ8Fc7g9doWky/HSuVMekBVnv2Om/q0b1bH7E2c6cz7YyHRwXm7IHisfoMw
         U7ImDBMhgSUbpLPvd0XlnZH9b0WFcku/rixQ3aX9VR2i+DeYADAfM1Zgo6xWoJ47rDTE
         7cExU2RV8B12/J+X284i41gM+770PPsbaNJUyMSif9gzNvx7mo+u//zA84J0pcv/ulMV
         BcsFFodzpaRY/SVcbeJGYHA1XiZjjhsC07YaUTdI08fxkzfVSfmo78IvOxWuHR/PAW3I
         TxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793290; x=1783398090;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXUQhEyd59EFcoHyMiF1oi62h1qq3FOFA8aGEe2nBJM=;
        b=FBa8P7iBAEhun7nMqyzu1AV5HQznRSNXargzz23fflHtuLTsb/nBtNcHue3qZdVf5m
         RZoRu7OjTEF0PfAIUtmGTj/LFJNHmIO99gXCuQdTnuTVTLdED2k0sYwjWNcAiS3B07Pa
         wbO+JEUeRmg0tP6QI8kmm/5duTpPvwmyvdpTGDDlO6RH8Vjmw4iaNR5VSYkVdyoowwi9
         AHgHCMIATQmgCAAWKN4KrvS430FLAcZ42IIuzukiIdsouOMF2FOJbDZAiewm5aZqml/A
         zARMdbgn6qcAPr7nZJVZv8HrFwAG+FvVBw7sYR3tewOq00d0OS+Th1Tg89F/iHVaGJji
         nrXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpa2/OXH2ZTAQa+q6J7V0L9Xqcr8/Z/eX8auF9QmF7mGkOM9tBdJVV0p6zboOP/DTgo+NjhZRLUOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlYXR+VlHY45bxFoCM/d/xmO9u8KkoUx33etbKaLZDVj+N3VF7
	UMoR3KK7saPIoI0n/TTL8UdqNWQUcpknqs6h00ljDmNWxlSp0cK9a/W8/g91ythPhuecqiqw0ml
	xmmP3
X-Gm-Gg: AfdE7cnax129ae8x0XPrcoUf9DYu14pBKM0Qb6mKHjHKikwFbIul0CNWXynF+KEyTyh
	4MjU4BgX1cfpFpwY0du+TkOXrE3suUt7DxDR1pgwFuHKsAzNbqQuhYWukUtPyBwKd8IckvlyQYf
	vCLRYfjZjwGOfKVlzdnJ/Fe7z6qojUXiz71RS4O70k0eot8eCsn8iQ3kl513+Ysz1W2ZEl0PFws
	BPIyq7kBLOiMBzg5vEOhdDOiv7pe8wCOJPy5QlcWgwcw99G6d8vey8Tr5LA6WuCJW/Udbm26+Hz
	NhA7pnZQPvormwfBMV1aNy8vx9I/ZsGI4TY0SK895CbhtrmSYxa3tWD7TGq/W/UZcEfX3jZS+AF
	LLpvYVWszhasMjaauUT+BBXl00EmbbD2mM7JAQPOjcuy3PDdLHhCVfTHLRJZ0k1nHhATf2ATZMn
	AhtLuYnuj8Ks3/lvBi2zuPJ657LghK290=
X-Received: by 2002:a17:90b:1a91:b0:37f:9ce1:cdae with SMTP id 98e67ed59e1d1-3805276e4efmr1513689a91.28.1782793290227;
        Mon, 29 Jun 2026 21:21:30 -0700 (PDT)
Received: from DougS18 ([66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca3828b0e7sm4590685ad.47.2026.06.29.21.21.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 21:21:29 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	"'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
	"Doug Smythies" <dsmythies@telus.net>,
	"'Linux PM'" <linux-pm@vger.kernel.org>
References: <4752842.LvFx2qVVIh@rafael.j.wysocki>
In-Reply-To: <4752842.LvFx2qVVIh@rafael.j.wysocki>
Subject: RE: [PATCH v3 0/4] cpufreq: intel_pstate: A fix and some cleanups
Date: Mon, 29 Jun 2026 21:21:32 -0700
Message-ID: <007001dd0847$ee8ab1b0$cba01510$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJYuSPWgyczOndiS3CXkG65o+iy0LVfHJ5Q

Hi Rafael,

On 2026.06.24 10:32 Rafael wrote:

> Hi,
>
> This replaces
>
> https://lore.kernel.org/linux-pm/6005456.DvuYhMxLoT@rafael.j.wysocki/
>
> and drops the most significant change in it which was making intel_pstate
> set cpuinfo_min_freq to a lower value with HWP enabled.  That change
> went too far and needs to be reconsidered.
>
> The other changes in the series, and in particular the fix in the first
> patch, are useful and will facilitate further improvements, so here
> they go.

I tested this patch set a little. It seems okay.

... Doug

>
> This series is independent of
>
> https://lore.kernel.org/linux-pm/6286434.lOV4Wx5bFT@rafael.j.wysocki/
>
> and applies to Linux 7.1.
>
> Thanks!




