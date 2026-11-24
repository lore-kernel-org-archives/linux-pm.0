Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543415;
	b=HTMio03RBIhq+2X9CpJMJgAHwOj5nJoKKcy1CIfMmP8EVjhOjC4MegWsBEPtNv6k06HO
	 9MJqquS3fLf5nauUig8gRx0Vppj2zudY5Rj5o9gTbN0DmVFRSCzKveoGCtaHxOJuQ072D
	 zlQa19GbRNveiDaLrPztkFdwjYgVX3pvB02tlHFU/ARmSXvZ+9woe3ZYmPyfjIItbTh9l
	 Gp5UqDM4+fLBxoVt5oPzNaaIQqTgZYGCk0Idw6RpcjsaoHckcpDXYtzoG87GSrXU1SSgT
	 pKx0rjs+/B0KNDceHeO1wBxJ0RLDp+LO84DvYQBHz1XmiAcAFavYgk7rPoQJsihJgkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NhTEfKWb6DbluRd1mldD3BYSLbGgDbbN8zaDAjpM6uw=;
	b=EgJJS329o5tqgnqddkX/f2y4b6OowBJPaurdpo+xcoUQiCwp5bayb55CBYW8IsHbDy4R
	 2MgHMToztdgr+FlgwuyMVffRXYmrzP0tLo49tfMyL+zfhNXRGDXgOkzxvqeTeovWh8KZj
	 Z0eLKHtJ7RdSRmnZNNN6zcDpqa3hS1Dt39mkHmgTY98YTTqtPCp5HKytaGH7NMEINXLF1
	 1c0c/Vyk/PHt4YcjVhmEc7tp0IsvOEsMVYbNnapCnx7WfMq3lYb/UjQFALfCQEG7zQyHH
	 VysGDK9MKqt8PsSoxEjrENeR03mfx02uBqRtCKMkIycYElAGLy0kUOMb0+pZ0Cis+pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GXt9pweE;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31E3606A32C
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 18:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B31E3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GXt9pweE
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so1865484c88.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 10:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795543414; x=1796148214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NhTEfKWb6DbluRd1mldD3BYSLbGgDbbN8zaDAjpM6uw=;
        b=GXt9pweEPAJJHo5VoQvosmFkJydGL3VA34kCHm/avM89lGpZmzCsuYk7R1FPu5xdza
         QfhkJSmj6huQqj/YKAJOINZarD5ZfQw25Vs8Ll0jPx5mp/xrQNByp9LZVjCo2SYDCA3j
         Q51JSF7KA0OGfARLL1AcqUPNJIUU/7bVZEjKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543414; x=1796148214;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NhTEfKWb6DbluRd1mldD3BYSLbGgDbbN8zaDAjpM6uw=;
        b=oTOhiISM33M2isL0b2Tmw0fRyPQJcXdNQHQPKIhmMcFcHjp5wmweP5KL++rIyI3Mqw
         utqzPTSG7Uv8UqitNXTmgNm9iY/Mb4umt1imKQGestJUVup+u1vDD5JQWFXIkXYEIvGf
         2R+E53kfY8GGaBGMTosxRvnirQ+H1Z3CJyCFwdJwUq0cEUd1dvnpibSK6nhctDW1snmQ
         uEOaas7m2YC+6N9aEucK6GfmFlO8BHGmQx0Ha+Mk2X3CNQ+kRQ3BGaFAUvGY8Dm36I0e
         ix/D+0CXhRs0JckBSSqu//Nr+m6l2L8OrhDSWHfNE2T5ieVBVLifIK36kZ68jfnD74CU
         3hfQ==
X-Gm-Message-State: APuU4Z/aS59Xai8z8IUzkecc8oBS4gVqkUIEqH6oW12iFVuwllVnpl7u
	esQY2NlDVrNvPAIV8My5RYD82Vmw2ZJ6w99Na7ye9bxsBNRfQam8hSO5bS63kxqxuA==
X-Gm-Gg: AZFdTZfBLrR1hCfKPumbjk4K8Ej5/01irR1t/x3cHrLlYHiDaXrIWGyaRXV5WavDuNp
	1DQpTc6iZ1c8Nty3bWi2oBPskCr2E9kR/DdrzRbqb+YzZOxsxGHvGuZ/BWf0Rj73G7jsDoYv/vr
	YIsJ0a83S2AoNt4P+hHA3TBE7yRDSK+8Tmc8BpHtqEVC7/U3ZkOqFAd1YS6m/rxqQgOK4iBb/wQ
	qaEQ6yR6oCGwObbLEZJBIP+2dAKFIs6Inl8Rnxbf2rv1MhHLwwFenU95MSR0KOmb1v175e90Ghr
	xA8RFEcD29HXpWorx/mTG7ntHsly/LlEQbPgDj6qg/+gPPobDv6KpqhdDc+NDFTrC/xCxx3C3mV
	7SqVemV5l5jHfLXhhUGxCIVDNydioInMQeBCAxz7dn2r+ajAzh9ja1Bw6kBePZk9DRrK74G6J9q
	Uk/k/UCjKY7ieLuJNLzrzJpqhYMuDG+vgp5fz3rRYZMGOa+XvEGfEqF7IO9Q8iICXHSHqXvzodK
	nLrHiD6QsdeozAEKHPlXM0UWijYbjFDj7NnNQIe/7YQAvKrXd7OixIr+x2f2AQF8VtGIbnKHGta
	1WJYBrb40MrNtU/yR004ngMfhsp5BeyH6aViVl3cJPnyaFi5L2qzq3KFbyCXIr+AxZlXD40FCRv
	Hucpzfg0rYbhqiQ==
X-Received: by 2002:a05:7023:a41:b0:1b2:649d:dc23 with SMTP id a92af1059eb24-1b556901b95mr16214334c88.35.1795543413661;
        Tue, 24 Nov 2026 10:03:33 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:6ad2:8ba0:aedd:5a84])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-385666e99fdsm58381434eec.5.2026.11.24.10.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 10:03:33 -0800 (PST)
Date: Tue, 24 Nov 2026 10:03:31 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Linux Driver Core Development <driver-core@lists.linux.dev>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v1] PM: runtime: Eliminate __pm_runtime_put_autosuspend()
Message-ID: <awXRc5mqhe6h6MGi@google.com>
References: <13014755.O9o76ZdvQC@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13014755.O9o76ZdvQC@rafael.j.wysocki>

On Tue, Nov 24, 2026 at 05:36:41PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> There are two users of __pm_runtime_put_autosuspend(),
> pm_runtime_put_autosuspend() and arm_smmu_rpm_put(), but
> the latter duplicates the code from the former.
> 
> Fold __pm_runtime_put_autosuspend() into pm_runtime_put_autosuspend()
> and make arm_smmu_rpm_put() call the latter.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Ah, it's about time. I was thinking Prakash's patches would handle this
semi-naturally eventually, but they seem to be stalling.

Reviewed-by: Brian Norris <briannorris@chromium.org>
