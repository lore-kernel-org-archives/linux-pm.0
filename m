Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736388;
	b=utc3hdv6Ja/lG/xJrWWZetMRj+MIuYr7fYrUofg8dHLeOEkKOJGkyaeh4vpHI2oxvu2T
	 epnd9QYHfKTw8y+VZvtWbymo1J/z9Wo+9J8SU9FjhY0W1x8b/idKcMcH4krPIGOJUiOVC
	 rWl01mvyOPj1spEJRg/ixBvhlz5cqoPIrft2FJfw4S/9+ddrtPNIrId4B9G8DQCnVPHQe
	 IkYV0Ou0H8pinFH09eV9wIqjPufnAaFye01fJUMTDWbB8uBqcCBp+cZWwn8cgSbtxji02
	 eCvdq90zF14GZ9tmgqCVyoJRE56HpdwE6NSahLM1IbIOcK5FQm4rc744YJIwwWTjh0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736388;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=hssDwEe1rOKRZStCD3pdhScZWrDFQx9Kmg4KZWjcIYA=;
	b=VjmEDJQ3mDpn15KoKJyyoSXukZPHIdc8k/NbPCB51zXLGhmyhVZF6KoAj/fss3kxXH8p
	 92GPNa0yupWd2jBlR2vDe8V/W5JKEcoI/ECvHedRijVNhqL+EvYhlMm+cUIhFaeqBZejB
	 fz+ubTpERox8r+077CF9VccxjA48xNLuJRfTwLQQVwCuxyj7lCAwuPj2mBMxcL+YL6+uV
	 0WFWDDVj45WG7xeOXkmSVXLTWHY/T66IIErEUwlG5cXztARq+SaYL7XPxBayRvWiEsye9
	 f4FLf8dh0eq4xVR9vjducNUBvL6mRNg+k+yXf+CmvmeAtjYfaGXHGiA4190iM6gCXpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4CHFTdT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1750F606D830
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4CHFTdT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBC21F00A02;
	Tue,  3 Nov 2026 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793736387;
	bh=hssDwEe1rOKRZStCD3pdhScZWrDFQx9Kmg4KZWjcIYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R4CHFTdTuMOuS7jt7JoKUFbf1I+E+14sEWMa2d2DlooiqmSAFNy032FRirgX0epot
	 lqZUFtgI+nUanCKc8Faxvl0QqnC6I4yIWsboKjm8O3zd89YvV2U3mPWGsohQ7cd5p6
	 +pdSGVt8/jYjD+kFooIQh7S+poyX+v5kObtfgOqjhkQSrge3KFm2/UzD8v7VN/Gkvb
	 BV/7DOyc6xfXgJdH+2a9W0hYczGoFpSsK45Ljh3thr8nkCpV7cFbn+rDBwbqj9vtyG
	 R860xW2WJ57PZlk5U5QP4zsbk81dekcrZmPWmeJ+eeqEzKzdAif4Or5qrZSFLVXpQa
	 V7yq2i1Z7weQg==
Message-ID: <d57d491b-a18f-4c54-a12e-b1d3bf85ff46@kernel.org>
Date: Tue, 3 Nov 2026 14:06:25 -0600
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] cpufreq: Fix synchronization with system
 suspend/resume
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <6065833.DvuYhMxLoT@rafael.j.wysocki>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <6065833.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/26 13:42, Rafael J. Wysocki wrote:
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
> 
> Thanks!

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
