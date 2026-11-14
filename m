Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665480;
	b=evT1ekdRUcuQ2jfFKJoxx+2lC9Q4ApLMHhIZ4G+ibTU4lGN1g10CVHcmgYY0CQKdTPWc
	 Yekp4hc0aWbQqwebalKXn82f6MDYr4bOz6koK3U9+fi2G8dMLJiq0+4zbwMgMHMNXry4z
	 7Qo6uvmUumRAp76IVU+FuEdbpESNle3Y2KTwkXwk9XYwWBC9Z1U/4C4BJLUcOtAMPF+U/
	 JHfccU0aIC8Q1zHOZb++9a85wWVBhskvM3RcpjUsb+4K5pekuMV2V8ACZXVC7aOHaVxA3
	 uwfdOzQy+FCh/5FY/v8lPtWTit1HBCgYdGx2f/EtKbA8jDoiyaIQScURlUqlhLXl9bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=X1aNKxDcC9Su/sKRcb+fwZwTfaJYdtOu8vWxOSG4H9Q=;
	b=1oEIjL0QGiDFbffqo+UyCHnQ7SeDbe+DprYfF6zoGlFMtYXU2vlSWkQ7VgvjChdpFkFS
	 OMusmSopAA0GOZJn1ZT7grJZSpuQwt3hmsZmvmxnPBVAQQjtEvSdg8DziujoNr9hiUADQ
	 NKmeobz6whZDHZugHgs3FTF9o/MCs86zFenDVCltXCfL+RpxV7LvVcgQd22v9EYY9GO6F
	 tO9Ky/Vbhb0NSLjb1E0f5qg9SkIgRx4/OsjCkWkzh6PVCxHgPm2QODAVdZFc7x+vHkkV/
	 oMJpASdoaGsxTNZ+xcOgYpXd25xEc6AfOhak2oEZqopKdSMMVuhZstX40+MhdSkCfkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIuTSlCz;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8E606A334
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 14:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C8E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIuTSlCz
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b904d10882so754669b3a.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 06:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794665479; x=1795270279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X1aNKxDcC9Su/sKRcb+fwZwTfaJYdtOu8vWxOSG4H9Q=;
        b=VIuTSlCzI5+jZy6lhUJ3NdFy8QfvKvOumfxqXf/KsHSm7q7qnrtm0TQKMxcAu58t9e
         lgjYrX7X+fgOz0yW7XFscKcImqrdxA74UWS9CrBbqZFuQT5Xjd5qBFmUFrQGTROrNBmo
         j3HbrMQ9X6q0EiaKeeaJowpKByG3xCk7OAAinrnWahFvw3jTJfK6+Arw7kgFbveE7bcn
         cWEdrRwRmJsazex6ce+lvFzkV6lLEguXk6GoJ8/v93AWykNVZdy1xFS6PSwqBHVADnKn
         cowtQuqrBknj2KZWxJU5/xk+xdXxpzhtDkAlhXlKc/iEhax4HpKwerl5PO0Bnrx0eFp0
         sXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794665479; x=1795270279;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X1aNKxDcC9Su/sKRcb+fwZwTfaJYdtOu8vWxOSG4H9Q=;
        b=dL8XMU07Y42uRf8Qqmu34YfikByRcM3Cl54lBL5OC6DforfQzCkPQEzG7QQiFojEUN
         Fyaw+J1cr4yVq/BT1WL6KQ5wwts4ZQOput/EK64zovIZ7E2nbjLbT1ygMXiBObXfrNPX
         MHdEs+PCDFv06nYEKVlxCkDAP4OU9mqje56t3ZhKZrw/uRXRWBM/FB8LR45dFwmSVniN
         6jPOR1jwnbq+Qd1zmRm8MXkbvXLMvKJnuXZ7uVwDBP6faw+gbD9HtQWMWBL/SwvVxH8K
         K7VATFqDbMNfJfV2t4dMRwv1jzD8zd8jUjMyO3G+JbK0LZqvr6H6cFWFl4bCQ/Q9uSTQ
         lq2w==
X-Forwarded-Encrypted: i=1; AL+hErGlBpIZir2wrxtlBYPDdyqO8dQ5We9p5/eo79COxQVmDtHfklP/OLOvKO9RBz0OjOPHwpPpO1Fxqw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9aWSMIMgpxTl7icUhecHu9sA2sp7xGuismYN97OHXZ2BnJG0rh
	rmRiW/kdskA9CIz4y7nEwOIei0Otvjc5a8rThUtFZwYBKQNkj3HnK+zx
X-Gm-Gg: AYBFou3crdvk7iNrA7hWqrkH2rNXnJbMjL8EXWSuJkZnhCxZr1nI/5mUcnMP8dMC1kF
	TUHnGtZx3QBZQpzOZut1+Y6xwItfJkGMkraGzBQfVnh7qfFLYfKQL9IzziAGT86xBhXHyQTNsJO
	n/dlKySTrHBYfsEN0dW0a0/Qojkgjh24pE+AaHWn0qmWL3M5Y9fUwgJdXJMte38BCGb9Vbifslo
	lkF4LDM5dP1ZR7quItPXFhJoCZKsCxrCHePXqe2VT9tB88rYqW53DDKUdR6gPAy3yP7mWQUe6t+
	1BT8BVUwqsY1znDWsMu12sTxxzzNTG95/NvwX0pQEvP6lMDPjrsyQKb4kEt+21PprdGT+i2ac9S
	HjVIDw66rZpUxHY8gIhEjN1pdwmTq6eYp28gKLTNVnlBOuPFUze/YHCxXlgwYnu6xVhjAIpYj4I
	HzlvQNlhvQ56Z2DN0ukN6j4HnlccVPhr0Vp6BZwPFMjKU64pb6CvdM4f7PJDYqBCgIfDoc642L4
	Ky2F1h08x8og0kaa6ftpEAuFH1S1ruzn4ZMtANjlafrLkh9GPVPnOiT53DuIo3uwuHg3Ok9sNwP
	0bfPyY6yIAbmMJisUs7FJq/CxWDn3fGYzI+5WkH+QtGnNOtArLj/vIL6x/oNh1heL0A=
X-Received: by 2002:a05:6a21:118e:b0:3eb:b103:6ec0 with SMTP id adf61e73a8af0-3f7a72ba2e9mr5274932637.14.1794665479089;
        Sat, 14 Nov 2026 06:11:19 -0800 (PST)
Received: from [192.168.35.40] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18b4e68sm2442814a12.25.2026.11.14.06.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 06:11:17 -0800 (PST)
Message-ID: <2d8dbfaf-46d3-4d05-b052-5e8a8670931e@gmail.com>
Date: Sat, 14 Nov 2026 23:11:05 +0900
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
Subject: Re: [PATCH 3/9] devfreq: Use trace_call__##name() at guarded
 tracepoint call sites
Content-Language: ko
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Peter Zijlstra <peterz@infradead.org>, Aaron Conole <aconole@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alexei Starovoitov
 <ast@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Chanwoo Choi <cw00.choi@samsung.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Danilo Krummrich <dakr@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eelco Chaudron
 <echaudro@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Ilya Maximets
 <i.maximets@ovn.org>, Ingo Molnar <mingo@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 "Martin K. Petersen" <mkp@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Oded Gabbay <ogabbay@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Gleixner <tglx@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 tipc-discussion@lists.sourceforge.net,
 Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
 Xin Long <lucien.xin@gmail.com>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org, dev@openvswitch.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org
References: <20261027153658.703730257@kernel.org>
 <20261027154413.039021489@kernel.org>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20261027154413.039021489@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/2026 12:37 AM, Steven Rostedt wrote:
> From: Vineeth Pillai <vineeth@bitbyteword.org>
> 
> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Original v2 series:
> https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/
> 
> Parts of the original v2 series have already been merged in mainline.
> This patch is being reposted as a follow-up cleanup for the remaining
> unmerged pieces.
> 
> Link: https://patch.msgid.link/20260515135920.2238808-1-vineeth@bitbyteword.org
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 82dd9a43dc62..9f71d9dc4a70 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -370,7 +370,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>  	 * change order of between devfreq device and passive devfreq device.
>  	 */
>  	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
> -		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
> +		trace_call__devfreq_frequency(devfreq, new_freq, cur_freq);
>  
>  	freqs.new = new_freq;
>  	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);

Applied it.

Thanks,
Chanwoo Choi
