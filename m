Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793765995;
	b=f8XcdKFKA4VC1r2yE6UV9m3+rJxGGfQ+2AhMg3AGJ+y9sOrqmUBcv1uZj6zxYM9MQ2C2
	 fXoCHDonJosRSlX4RsghgyE0/q6hJGb/RSNW/KX2jzJ2CmA8xEMboJyAMHNDZ43mmQWLV
	 l42BXe/o9Im4YXMs2YJI82CpxvJc96wgTtb3tehp0oIYsaI/fLdeBCgJBo4N9/aMjLKBs
	 FBDAIv1/aA0oKgsr2a4rfAptp5wFPgDy1nbSACJKybvyyk7VRfLX+kbBtipYEqbIFk55b
	 SQjtJ5awM/ut7FvD9cpm8X6wsihUDDWA+o4WmwG/1zfcoVzHGa0ZN1xkHnTCeQuokWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=PT0e+PTyBEN1VG3qVuAJc4oy4ZLGkPD3ZvM6HW+xHAw=;
	b=0JOf9Xm7yxSSIertEj+3VuY80dBF9Cg6y3RtJr0xf/gbQ2h+qWGqO0QAXUmkm91w8CET
	 mAnxpebXjOqpGn3oaua/tZvsZ1GAHZFKwiTTSity4XnjV4cM/0cq9oQ1zHPgaDi1Xs57Z
	 cd7QkLFrCcLo4+cuXysWsJLbaam7yUDyUvMZwZ1w8tVaFVlaSwjZaBIHB+GMw4KyXeZ9I
	 RnpYbjneWScepJqGIUUJ4R1d7ROdG1aZJUFIxV7rZ+VgRUjLU+qyRgYY5Jsz6+NGgP3G3
	 zQhwfy91gLzDYFuRaJ54KnsNKtmPiegCPLz6KyEq+GAmWoMPx8ywcERxCKA0Xt1ZGLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xs9qUelZ;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F321606A31B
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 04:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F321606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xs9qUelZ
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so1070517c88.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 20:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793765994; x=1794370794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PT0e+PTyBEN1VG3qVuAJc4oy4ZLGkPD3ZvM6HW+xHAw=;
        b=xs9qUelZMOugN75mdPXva5IfTomKOXmeaDSeaMoFsd6D8LpLa8rJKZJj0vjXU9zHsB
         UcfarUSxHf19AQ/y1Bcx70Kokpfhz+8J2Ubq2pMAvXL5pJAWjCe7twyLlLxrsAc2CuqM
         IXLrDw/2UMTuYUQP2KQSjvPRKSLRN9DpGyYXayWtdRfFj2DBVUw568HfWMtWqG2Xz3e2
         kDY1KgojPjeMuPxwZ/K7+fYjr5VM9svH52fVQc70baUGgoTd4QvnBVnzH6TbnT+fFzLG
         GavPu9k+cSV+YhvfVaq9WbFH1l26ZKBXHJIVbbB4eLcUjAImWtCZ2AnLHKhYfQ4YlD1V
         mEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793765994; x=1794370794;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PT0e+PTyBEN1VG3qVuAJc4oy4ZLGkPD3ZvM6HW+xHAw=;
        b=dujegWcf0GJFVaRP2AtKg//W2IrZAGUPP/txt4DqOAWxHtJ7hmiO8H5UMmmpuZg37o
         LxJ9nkmylzOZEt0XA6meTbWruEx5by7p6haLhOU8rslDVjc9/vxxUK9TtAISoPyELc6+
         cutVE3FA0CxydVUFGdJSRwwl2e4+vVXOstHgIJDM5rEHQZuCfXnhCsB0a0dn/QcAF+Ri
         jovwRh94aI3TiFF0UuVp0H5ivAXJkmzHjwFTB2CiowCm4kLpdCe8S3yAJkFC9ziWygfT
         4zK0iin2OWy+TmssTyTzV6iTUMgHw9ds4S0JJp7xFZCpFR9tZGa2jDdXDzfTBtsU7q3J
         IFmQ==
X-Gm-Message-State: APuU4Z+w2PJftW69cbLehhBS4ujeDsj6nJ9vldqLnfRbl8pyv5aATZAa
	EUaJGZvnw4gSxI7PGhbrrhp9RGZR/UQy/mn+OK6V3i0fn3h6BiOX7/I45B/Py9TM9Nk=
X-Gm-Gg: AYBFou3HDQJSxDWs6QT2D6VGBN4TeVKIAAf5yhzV2nTPOrBeP+LLNde8JfkKSgienTR
	UkOja+lVY1XZXnvZ+vACIf4bLpwYRgQ1u0yTOvxZ/Dg+mkkF9AcLlEWB5dt8QXek9+FL5eJyKNb
	d9a4AfrpvIyQjCxKKsQVeFZ50HQFHE2hpBOA6ZaqTkSGtap9XY5zeYMIDjmIO5Gxam0+EKxIVGN
	cpBlaN3Ylw8oRJlX1L0Y0dN+pOwKxqcSYbGdg1dq9qMKUnjbufK78AirP/ghzejhgrqVdq8UH0K
	A2ZAQnwmtU/9R+geKs6Z/MrdcZ6p91JbkdIjlyz7oS8xxafl6CeAv/CJKNR1MY5dZ7c5LX8VdzJ
	yATypw+ycHCBfk2lOP2+0zB4a6t7XgE12h0PYh7mTwH49WUpPBkUDDDKMlAO+5CdMhSQdYo/9m9
	Mn+vPtytrvnVq7JEoPyAaJ4EWwRePmDKsowmifZ5T6Wd+jdAm5M7i/56YAw49+qgZ7PEnrNUvqb
	Y+vSL7XOGVR05CUvDRrG9BWIiwrexVGRE8t8O4zAIzEngvV34Sr8cEwTOwA+LAJs3NyFDqfMFN3
	349TRfzJOSbOUF6w1dKyNTnWa6Y/LtpqPQlnjbWtRtBm8hvDyi4=
X-Received: by 2002:a05:701b:42d2:20b0:1aa:6c3f:2f7b with SMTP id a92af1059eb24-1ac5b3fdef6mr24220697c88.24.1793765993726;
        Tue, 03 Nov 2026 20:19:53 -0800 (PST)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c283sm3821837c88.4.2026.11.03.20.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 20:19:52 -0800 (PST)
Date: Wed, 4 Nov 2026 09:49:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Doug Smythies <dsmythies@telus.net>,
	Zak <zakbrightonknight@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v2 0/3] cpufreq: Fix synchronization with system
 suspend/resume
Message-ID: <auqyZqqZBVjt_Nhn@vireshk-B250M-D3H>
References: <6065833.DvuYhMxLoT@rafael.j.wysocki>
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
In-Reply-To: <6065833.DvuYhMxLoT@rafael.j.wysocki>

On 03-11-26, 20:42, Rafael J. Wysocki wrote:
> Hi,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-pm/5162355.31r3eYUQgx@rafael.j.wysocki/
> 
> that modifies the first two patches in the series (to address Sashiko
> findings) and drops the last one.
> 
> This series fixes issues related to the synchronization between cpufreq
> and the intel_pstate driver with system suspend/resume mentioned here:
> 
> https://lore.kernel.org/linux-pm/CAJZ5v0hT6aoX4tuJM+rO_5iequFc_7rEXCoaFnHoJBaH3JP4KA@mail.gmail.com/
> 
> The first patch actually prevents governor operations from being
> carried out on suspended cpufreq policies.
> 
> The second one forces the driver .target() callback to be invoked on
> the first frequency update after cpufreq policy resume.
> 
> The third one causes intel_pstate to invalidate the cached last
> P-state value during suspend.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
