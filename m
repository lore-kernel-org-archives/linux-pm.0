Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F2948C8A3
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046315; cv=none; b=cmhJzPTvIyC8+dNToKaywRz/iuYe6sV4tX3ru+egC8r5td5zrp4nexd6RuZew2NfTcfj2iSoagg0ZxvnTzykL5Q3o5qryWKx6HOqMY3YO4308K89hTszkLuy42aIjx7Wzcx4Zfr2YcmyNPpcLlUrrUWvOiA86FlOTa2zImhtFu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046315; c=relaxed/simple;
	bh=2ZU5XnuWVZNV4TaTBao5LDMLi4fITpXzxDhh9qTnuo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSilGoBEKe5ekrEgLwsQyYs6XVqTbc/Sn9HdPfc33drGvoUHYtEeWCRepryVvGFoP/gJMt9cuJgGEnd+jXHmNAzKmAQjEu08ucSoOearcGtIjfPpOJxXrShmkbHEc1GVAthkPlz+Kt5UwLls8mKO1Q8jqn2Eiv+D3PMH5J6cW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vALr9KV1; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vALr9KV1"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd6185db7so20190295e9.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789046311; x=1789651111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SFrncxg8AQQiuXDWK0QdricKiYQ4QF6k7OcXsKbqExE=;
        b=vALr9KV1jLbNewQmrzK3kHzIy3tjMKD6K5ZY/u34nmQ+8gEDtJsfSeWXhI/55mJi74
         RftAHANoO12sNEwq4X6edepa4L95taPYMLYcLpI+RoKXkzUIHVJdRoKH+rangZl9YliX
         2GZvKvfw1jkN+8kcbHJHuiVLo/SxQoKyCmkrsD8lv7p+QHcRo2p9dtbxvjNlCtEcBjxb
         fhCJCOc7mtzYJM/WBj5xFEhJZUp85nIK9LnjmCJFhDwOkuKNJLbIBnGMsl9t/sWw0Z06
         YXDooUmSrc/QswBvXXsolH3dbLzu7ArF0nIRD5Rahm9rwS5zOGfPYqP+cBAQT8AsLWlR
         yEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789046311; x=1789651111;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SFrncxg8AQQiuXDWK0QdricKiYQ4QF6k7OcXsKbqExE=;
        b=ag5EkQctjo1pZ+SZ6Lsr7dtnGJ7r3O2WwKoF45NttIpMkHlENk1oixMrno275CPWwG
         E7pdaFFppGZeqAw7/kKWfVDaoEWrWgBuKhSiVwPfh6Yx5hxcomebrjt26zTug9QoXIIE
         yW5SMdQkczFZDSwxsfOv4xmb5QKyDOyC3SPJINYIeRbIXsrE9CQ+KZzGGjJFtL+npTrZ
         KzVJI/AQitBXfKV9/ip4ZbidX9qzA35dmixbJJbzCsrDX9kmXCCmHNVXXj6YhhIQkgHi
         z9PvDaCRLbBJzZXV8VB+OdjskRFO+ph5QOinA8mE53cIyE8e6nVvdN8yswcL0wBD9Zgn
         v1DA==
X-Forwarded-Encrypted: i=1; AKwUvBx+F1GU54BUjyuUK3HZD+lFdSbAA9T8na92iKVQDRH76xWA6jiuBJzSPScUYMN9yxJtgcsD9c6H3g==@vger.kernel.org
X-Gm-Message-State: AFuF++lA+pRlm0rZHEXj8dkfn7Y/q3vJiXyc2Muaf52AlJsfEB/uysxr
	TIoqcD8jKoVqM2Q3/+RNYiCIQrm+sdfaV6nm8aargdsgRFFLpOi268GR77vDyTpO7qc=
X-Gm-Gg: AYBFou3vFnCCOMw9svopFOYdWUyzk7mZlDXtyKNXuj5Er9fV3wHXR8Lg7yzRGMkmIZ8
	4oBw8fU/FClPFXMkHLeq1k8X7dEmUugUMuLGcRGbc0fK01zdJU/Uy22GpYQAjmnaXVL5nXQg45o
	IhQXYK9SwusTQA/3/neKQtDqA96nnUZfXERs/j8lVEtl5JHZs382uaTDYPmUul61TEyX4Ka/jPv
	2ciJKB+C0cTfKwIFlJF599lGecKqa9znRikl+qRHxIPjWh8c5tCDJsputay9tCWfVb5o+VysA2w
	5qM71tl3qLqHON1dSz2qOj/ceXUUnlryqqYOYGHEMb+qCZmIdQ3yiYjcZ0hlY2bR+jvSt9UCsjO
	zTiwxwK0J1f9wc+AHgbnAkigH2RRKbsLJCyo3gVNBbx8/jAbahLNm1KPcAffc0oIBhhNokPmqD/
	bUlCTdqGPzrNyNTlmEs+c7JuZey/m+hR77wwu9p0hg9253YD7t0B4y1FtQyoZwXyPILUT8nqySZ
	8tq+tw=
X-Received: by 2002:a05:600c:4712:b0:49d:2705:7030 with SMTP id 5b1f17b1804b1-49d270571ecmr45811495e9.7.1789046311143;
        Thu, 10 Sep 2026 06:18:31 -0700 (PDT)
Received: from [10.11.12.110] ([79.115.63.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5fbda49asm9602715e9.3.2026.09.10.06.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 06:18:30 -0700 (PDT)
Message-ID: <f80d4081-d585-44c1-bb82-3d7f83462d1c@linaro.org>
Date: Thu, 10 Sep 2026 16:18:27 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] firmware: samsung: acpm: add fire-and-forget xfer
 support
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Juan Yescas <jyescas@google.com>,
 dianders@chromium.org
References: <20260612-acpm-fast-xfer-v1-0-1aa6cd2268ba@linaro.org>
 <20260612-acpm-fast-xfer-v1-1-1aa6cd2268ba@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260612-acpm-fast-xfer-v1-1-1aa6cd2268ba@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Alexey,

Sorry for the delay.

And thanks for the series. Improving frequency transition latency by
giving schedutil an atomic ->fast_switch() path is definitely a
worthwhile goal.

On 6/12/26 7:34 AM, Alexey Klimov wrote:
> The current ACPM IPC protocol relies on synchronous polling
> (acpm_dequeue_by_polling) to process mailbox responses.
> For CPU DVFS, cpufreqs schedutil governor requires ->fast_switch() to
> execute in an atomic context. Waiting for firmware acknowledgments
> in a loop in such case also using udelay(20) under spinlock doesn't
> make a lot of sense. Experiemnts on Exynos850 showed that even with
> removed udelay() or with it significantly decreased, the firmware
> processing takes 15us...250us.
> 
> Introduce acpm_do_xfer_fast(), which implements a fire-and-forget
> asynchronous path:
>  - utilizes spin_trylock() to exit without sleeping if the channel
>    is busy;
>  - adds/sends the message and kicks the mailbox doorbell;
>  - exits immediately, allowing fast_switch to complete quickly.
> 
> To prevent the unread asynchronous responses from permanently exhausting
> the 63-slot sequence ring buffer, implement an acpm_drain_stale_rx().
> This drains the RX queue during the fast path:
>  - copies payloads and sets completion flags for sleeping
>    synchronous users;
>  - explicitly acks 'is_async' messages.

Answering your core question directly: the fire-and-forget approach
over the existing ACPM command queue (acpm_do_xfer_fast) won't fly.

The ACPM IPC protocol is fundamentally a half-duplex, synchronous
request-response mechanism over SRAM ring buffers.

Even if the host sets response = false, the ACPM firmware does not have
a concept of fire-and-forget on standard command queues. It executes the
transition and still pushes a completion entry into the SRAM RX queue,
advancing rx.front.

Draining stale RX entries opportunistically on the next xfer via
acpm_drain_stale_rx() is fragile:
1. If frequency transitions stop (e.g. CPU hits target frequency and
   stays there), rx.rear is never advanced, leaving stale responses in
   SRAM indefinitely.
2. Queue lengths (qlen) in ACPM SRAM are small. If schedutil issues a
   burst of frequency changes faster than the firmware completes them,
   the RX queue fills up. When rx.front == rx.rear the firmware panics.
3. If spin_trylock(&achan->rx_lock) fails, acpm_drain_stale_rx()
   silently aborts, and sequence numbers in achan->bitmap_seqnum leak
   until the pool is exhausted (-EBUSY).

For addressing fast switch, I see downstream that the firmware defines
a dedicated channel of type TYPE_BUFFER (async_dvfs). Frequency changes
simply write the frequency into the SRAM cell and ring a direct MMIO
doorbell:
(https://android.googlesource.com/kernel/google-modules/soc/gs/+/refs/heads/android-gs-raviole-6.1-android16/drivers/soc/google/cal-if/acpm_dvfs.c#97)
        async_dvfs_set_requested_freq(id, rate); /* 32-bit SRAM write */
        acpm_ipc_ring_doorbell(async_ch_num);    /* MMIO doorbell */

There are no ring buffers, no sequence numbers, no polling, and no
RX responses to drain. This is essentially an SCMI FastChannel-style
interface.

Is e850 supporting this?

Cheers,
ta
