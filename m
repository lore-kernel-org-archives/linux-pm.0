Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690095;
	b=yIXrQEgfWB8wLIWKVvv0q+9huAeNDHIMaoS6bf6d9PljwxPRDpZ5qJ5yZYZuu4juGHI6
	 ek9My/Hg9vC+FVv2pHkuhENINk9mD9C3RikZf8sV19JFS1MDQG7gDAob6czjZvGNWPdLr
	 OUPbxyPxgPKazLQirpAyBrgiG/199b6bOb8Q0yuSHg9wEcOOBmR8+SVKsSjPZYLF2ahCh
	 hG276Q8VFwu3lmZRK9nnsOLXCz+/Jp54WKposMPXwWZuNxRizXAe3taiZPhiztBB58xTq
	 w4qGOaM3DiK+KfENomOn73PwiPDif1smvloJpxTzCm6tnQnYk6F0ErO87pqY+pjlXsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=k9VZrmA+nYPJRqi+O77R/xIbSJFEg9+dWsju/kOou8k=;
	b=xF5yksm3tlqefdD1ByvDpGkxk3gyvPzSmjIBHcgZIGC31N/9ZFZQtupJRc+mM3DtPqHB
	 eX8ZmCQdGoEDYroQA9+8A0erA7omtVje/Bv1vQ3irB332o9yEaHFe6LUAM6BuLyVDOcXF
	 tcYv6Gd385+XaEKQ45Zvfw88XRmh3rfWXgPFMux379mVZOthrInSetq7k32SovZ7aM3/x
	 Q3uzpwmO7PNkJW5RG87nKlD4ekCsWRX36ZFF/08B6LZugRBHlkYmAMcLPMpXmqzJYrlDl
	 BiCxPCCTta6bkFC+MZhjpc6lZA7FDdy7AMhiTXnKxGcS0wpu/sznanaFRyMxdDwzGHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fok9Pegh;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004CB606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 07:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 004CB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fok9Pegh
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so7257535eec.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 23:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793690094; x=1794294894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k9VZrmA+nYPJRqi+O77R/xIbSJFEg9+dWsju/kOou8k=;
        b=fok9Peghmx+OcH0yHsqzP0LmEvPt0KHlQ9YPVj27Z22z/SUawT1ChxHqzONV1yuLbP
         jztDS+k4l9O60/R5AvI5wg6cYOzMLyVGWBUj3AYtVumrVI/D3iVGS1wzPK3P+muWCBXI
         ptcHRFCStdeBVWsR8C1zEFDETPdnY+M/rkLOQn3BVEpUxgmoJvhguwa4S0NJYshNhZwF
         C+ssj6DN/7HAadgJ4wnW3/WKSIt/0eDYPhf9k7pFicB9mbDtS1/sRhlU3+yfmgP1z18D
         Z4MJsztpbsib7a7zG4c5rpWj7sB1Pq+LSb4ggqMEMvLVPEeaxoO0XW8hUIw/GlH6FWxL
         8Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690094; x=1794294894;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k9VZrmA+nYPJRqi+O77R/xIbSJFEg9+dWsju/kOou8k=;
        b=nqg1wqHQ25y/J9P5sy19EiM00g7d7EDxz569zan3DRLQIgScHHpolk+uInld6jDzWd
         HE8D/HCv3/hDZufOboCMeR7CyUmZlRVUliBChNiHwTdftUWGgPE1oI5md22rKOMefaOw
         PUBKS9H/e2XxIcp2ZL29CZQdQl+x8oh/m/DT//33j2hIY/4v1qglDbPJouv176ioo4oh
         ccpcBtNIWCm9s4T6QSAeLgMZnPGrtCfZqjKDjenLAY1Wq1fjB1icNBZG7Gmd3VSwfSJ5
         zxqCj6iMrRLOROJuwykJ+iCHWghYwRFmTpdf4ORJv1tEBj0+dMpsKyTAuHWmcGsKADOy
         NEFg==
X-Gm-Message-State: APuU4Z/j/hqUDPT6Oqn22wjJHiCEwr8qKn7jGH30uczDmSfnanJlRf7V
	mKyb6es1w2tZvo8v0cVT1fujRJ3BoPSjXwciaocINb4wfBEZPSGvEc3tgOjk8ksQofg=
X-Gm-Gg: AYBFou3JxFIwHTKxvFR2aaMUDkNJr1seYezUH5URuifRswawqjy1sJAdC6Gn32g84t6
	Vy8OAMqms+VEd3jhEFkVgXps1Y2jjNtMuB54rcJ+TgF9abZRISFpJYv+Hm0zhyHJ6wpm/MBT7nA
	EdMesr3sZcT3PskQ/oZ9wLZu53NyI2PfppYcdB4CnbvDYbJsijLQvwgVlN//ycI2XQ+qnAKjLwA
	VgouK5gDMG9B8a2LVeM1LogWh9+0ALy5lcxMSxyrQfFoFVv9aDXrWiC7xzkDi/JwD+HHJJUpAw5
	VoAZl+ZmWnujZX91X564uYg1CqG6nOrIsOMY79tAo+RfjBRa9usjPwrg6FXvaTibKlNYgDVJy3z
	453BPrk8sSFf0pkrdRddXhC28/754Zt6+pNNfRt4aOSMaOjN8bN73nfo8Ygb/frphvpVNzGIyxY
	eFYvUj7z89xEN1yiRqA84oWUDsVGNGJXSbRUN2Vsl7SIJo7siVqABGxg+G5ZlQVLWjaHDdPsLOH
	ySHmTVZawpYhcBMoQpLS03Qwh8aViiz+vBFryY9UYJcJwjkae8QsIWxXUNU7FmjGd82uwc7WHLH
	I9kZzToNc/QMEvz3TKFnneZ0+OUc1IlLufswvqiPEZy1f5fzGz4=
X-Received: by 2002:a05:693c:8951:10b0:36a:32ac:ad89 with SMTP id 5a478bee46e88-36a42225807mr18563054eec.2.1793690093633;
        Mon, 02 Nov 2026 23:14:53 -0800 (PST)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428aed76sm46158477eec.9.2026.11.02.23.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:14:52 -0800 (PST)
Date: Tue, 3 Nov 2026 12:44:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Doug Smythies <dsmythies@telus.net>,
	Zak <zakbrightonknight@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v1 0/4] cpufreq: Fix synchronization with system
 suspend/resume
Message-ID: <aumJ6AmowyjSUecq@vireshk-B250M-D3H>
References: <5162355.31r3eYUQgx@rafael.j.wysocki>
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
In-Reply-To: <5162355.31r3eYUQgx@rafael.j.wysocki>

On 02-11-26, 20:48, Rafael J. Wysocki wrote:
> Hi,
> 
> This series fixes issues related to the synchronization between cpufreq
> and the intel_pstate driver with system suspend/resume mentioned here:
> 
> https://lore.kernel.org/linux-pm/CAJZ5v0hT6aoX4tuJM+rO_5iequFc_7rEXCoaFnHoJBaH3JP4KA@mail.gmail.com/
> 
> The first patch actually prevents governor operations from being
> carried out on suspended cpufreq policies.
> 
> The second one forces the driver callback to be invoked on the
> first frequency update after cpufreq policy resume.
> 
> The third one causes intel_pstate to invalidate the cached last
> P-state value during suspend.
> 
> The last one is a cleanup on top of the previous three.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
