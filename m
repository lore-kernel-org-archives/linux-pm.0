Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795253832;
	b=SPnc1e4PwvxdyvfJPjW7i8tpu7TEyBA/nu03Qjvc2+oWNAZu8ORYftoNCBm1C1UBaNpi
	 lGjNh1mO5ah76x+KfbE+IUp6KfHG97uzc/WVGJRpWqoPLSsk4RX5DdJdVPzgaSeeslXtg
	 WnE1qJVkwRBCmkkk/O9WVaL9VXNUCbai+X9ob8VP3vJ6Tv4OegX3sgXOJA2NpVHWEDqRp
	 LMXJf/NJOYyjGQbAea72Cq5wOekABsBzjnrfrTYcPTE3hHvr9Mjd7nSqZ5VpdPjpYnecG
	 joKFbg5NG48fxiPlafLnthVH3YasRm9FXeY8CRgi1NUyXcwn6UErHAs09tt1lk0ZfmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795253832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZuSymGZ4BXaXBXcW5O68ed8bMUtsN8ja2SYO3J1EHJc=;
	b=uBsG4EdGgCajwQs0VRxfLFUpRdhxhHucEFImwAGRQYErzS+9SwzLYC1SQuSnlzvWnfAp
	 lxTBUBbrCfhoBhiVHWy7NV1Q0Ob6/0ocGSgCGeDS1aS95klDVhQg6ldQD8M58VlqGNWr5
	 S+6wo9wBWrwJ3khU+Lcr8iGbB3mJP5Vu8sIJEn90iHY8JwrlublCSFMrSihpDVW8WRLfO
	 05ASbe9VlxwsZVkrpzadUFYgYgX6Vzh3JojN8dILaapYbV9jHkWxK25vlZWuJ8HbofDaP
	 aRBJdFTEgwUp+l9O4Or1hcdGvUF7LFNqPWwNA33Z96a9LZ3Bg0jYtIJW1GxSaPQNLIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wUf5VfrK;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AF606A32A
	for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 09:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 516AF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wUf5VfrK
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso17441705e9.3
        for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 01:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795253830; x=1795858630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZuSymGZ4BXaXBXcW5O68ed8bMUtsN8ja2SYO3J1EHJc=;
        b=wUf5VfrKUaALiMDFWECJZVwwO8uOhGSA8wHRTh31ht5ubpXd4KSGvNl7BhKcF0eFsW
         h7m69WfERS3XHnuKLe+oUOhZZ6xrInEWOi4vOd+x5uxMNdhlz744hlPZrMJ3BNelduuW
         /PuTMloYC+HUXFarUxZV7OKsxI9P88SGbwgK9fA4GJz1sbZxJADci3RPHa5k6u8TkYiB
         YEV1ip8vglYzBy01t7Noo/VZ+4r4xMisItO+B5J/kFNSOMGdj2etXBq24D4mV1gxdPk8
         v7fdgT+AZlPDBGhAbv+FER6Xu4eEZHfTQKQrzfwemCEx9fhz+7wRWEOnda0Dkt0l5eqW
         tI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795253830; x=1795858630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZuSymGZ4BXaXBXcW5O68ed8bMUtsN8ja2SYO3J1EHJc=;
        b=ZaVGB6bkaVy1Dhe1LAaTzRgJOq0PEKz32Tlqzwsh65w364OS/jQ0TA4wySRoCqG/Bv
         fGYLUpjsCUE0GZMRU913by8kerXZ5jMyKcDsMjP6nsL7VIx+9NMziHECr6abU48xlKsa
         qum0hvE8Qivur6Wikb65mgCVPmxNJVxHNfZzZmvitgiBjDBipO1O3wcMlnkoBGXwVMge
         cRN8cFS/VK93ZKXdTE6LjAi3rtjfCYx1l3XKi4Pvo6h3KSPN2lH952DZYh0SO6yrkIt7
         LmO5AQnfs1Bfk7f7Oi5YCbk8CZ7Jw5couGdylqSzixfyv0fhHQmAcLspalSr8+gEinhT
         oNYA==
X-Forwarded-Encrypted: i=1; AL+hErEJz38Q7clL7n5xlvhF/+aWMkE29ZYLmPWCBmObbHEj3UKyM98SIwWQlyWRaPvGiO9FhXyhL93fbQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z98xVNn9ITeGj4jDV7O+SMhX7ho1lIkhhzjWFMjpzwB2sgoKFjz
	51EqQEr00erNTSqFEbX/2GzK5boqizquq9EHeTsm7r8CXBxL8h8vVcGf
X-Gm-Gg: AZFdTZf2SqRwF3VVP9ljE/I7F5QuxDEQR7uD6yA0eB4xOQf9xem3Ym7Vt+Y0iaFiVF/
	Lh70rceY/mFMQZdIwdjc+Ofr/t0d1eviXuyjjLYIA3cSJAihkYNcarNiaIlmGhpXYkbe/jdQf22
	AR0w5JOQ3U/uJr6OdQbNzErMUR1xQ+Tr/eNoThEVJa34fHmqofcWMW+EXl6MPyBoNLJ+aXFQkHu
	6F4Qa7kMJ8o2S+kp/4aVRLXUAGvUT6E1n7W9mGRoCqo4f/0S2Sg4M/fHBhDsUDUqCYlsqh5V29Z
	5M4j/BbxD911YuOnkKoK8ATiRNTrkikGJH+f98O6LVa2CAWVtOp0IjnvZGlKjqwqigoU6bjzNAT
	tPXLLCcB0tiLVRsH1GQOVLR7Y5nMcqaernJaSzkUmENuf44tFPdVkfDsXzdt27vnhze8yY4RP68
	xhIoSZZs7Ty9LaRm7iIlWwatNQhfrX2ChgzywUIFIV/5kuv2qh/K/MrgzS98a32sbmCDYwFnlbe
	XrQjqoceo8K/v2wJ89OsHcuzB53RclAktUzpWR+uILRwZGCLPn2xp7UcJNYvvgmeIl5Mb9fTq6z
	xP9tkiTShVlRK2ZuQgXLoE9ITac7biZbkWT4/Rs8fAX/o0X6vPc6CX9MfxvVzsXsGpJcNJ0nMoT
	g4zhBL/3f+W/5LMVF40t8J1Q8rbo=
X-Received: by 2002:a05:600c:1d29:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4bb88804d4dmr137546885e9.7.1795253830173;
        Sat, 21 Nov 2026 01:37:10 -0800 (PST)
Received: from archlinux.fritz.box ([178.197.200.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm238322245e9.0.2026.11.21.01.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 01:37:09 -0800 (PST)
From: Tobias Predel <tobias.predel@gmail.com>
To: linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: Re: [BUG] HP Dragonfly G4: AML deadlock (ECMX vs. Serialized GBAP) between EC _Q08/_Q18 and int3400_notify() -> ODVP
Date: Sat, 21 Nov 2026 10:37:08 +0100
Message-ID: <20261121093708.5097-1-tobias.predel@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120191423.10876-1-tobias.predel@gmail.com>
References: <20261120191423.10876-1-tobias.predel@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A short follow-up: it happened again today (2026-11-21), now on
7.3.5-arch1-1, same BIOS 01.13.01, and despite booting with
acpi.ec_max_queries=1 (/sys/module/acpi/parameters/ec_max_queries reads 1).

This time no int3400/ODVP worker was involved. It was the EC-only variant
I suspected in my first mail: two kec_query workers deadlocked against each
other, about 67 minutes after boot.

  - kworker/10:1 waits in acpi_ds_begin_method_execution(), i.e. on the
    sync mutex of a Serialized method. This matches _Q09 holding ECMX
    and calling GBAP.
  - kworker/9:1 waits in an explicit Acquire. This matches _Q08/_Q18
    inside GBAP waiting for ECMX.

hung_task reports each one as waiting on what the other holds (excerpt
below). Behind them: six more kec_query workers, thermald
(int340x_thermal_get_zone_temp), and upowerd (acpi_battery_get_state). Every
read of .../power_supply/BAT0/uevent hung in acpi_battery_get_property().
A kworker in i915_flip was also stuck in D state, but I rebooted before
anything else happened.

Why ec_max_queries=1 did not help, as far as I can tell: the stuck workers
are per-CPU kworkers (kworker/10:1, kworker/9:1, kworker/3:0, ...), so
kec_query looks like a bound workqueue. There, max_active limits
concurrency per CPU, not globally. On this 12-thread CPU that still
allows several _Qxx methods to run at the same time. I haven't checked
this against the source, so please correct me if I'm misreading it.

If that is right:
1. Is ec_max_queries=1 meant to fully serialize EC queries? If so, would
   you take a patch that makes kec_query unbound (or ordered when
   ec_max_queries == 1)? I can write and test it.
2. Until the firmware is fixed, is there another way to fully serialize
   _Qxx evaluation on this machine?

Excerpt (unreliable frames and scheduler frames removed):

  INFO: task kworker/10:1:94 blocked for more than 122 seconds.
        Tainted: G           OE       7.3.5-arch1-1 #1
  task:kworker/10:1    state:D stack:0     pid:94    tgid:94    ppid:2      task_flags:0x4208060 flags:0x00080000
  Workqueue: kec_query acpi_ec_event_processor
   acpi_os_wait_semaphore+0x76/0x1d0
   acpi_ex_system_wait_mutex+0xb6/0x110
   acpi_ds_begin_method_execution+0xb3/0x420
   acpi_ds_call_control_method+0xae/0x490
   acpi_ps_parse_aml+0x3f2/0x610
   acpi_ps_execute_method+0x185/0x430
   acpi_ns_evaluate+0x196/0x5d0
   acpi_evaluate_object+0x1f4/0x470
   acpi_ec_event_processor+0xe5/0x130
  INFO: task kworker/10:1:94 blocked on a semaphore likely last held by task kworker/9:1:14859
  INFO: task kworker/9:1:14859 blocked for more than 122 seconds.
        Tainted: G           OE       7.3.5-arch1-1 #1
  task:kworker/9:1     state:D stack:0     pid:14859 tgid:14859 ppid:2      task_flags:0x4208060 flags:0x00080000
  Workqueue: kec_query acpi_ec_event_processor
   acpi_os_wait_semaphore+0x76/0x1d0
   acpi_ex_system_wait_mutex+0xb6/0x110
   acpi_ex_acquire_mutex_object+0x61/0x150
   acpi_ex_acquire_mutex+0x8a/0x2a0
   acpi_ex_opcode_2A_0T_1R+0x163/0x1e0
   acpi_ds_exec_end_op+0x204/0x890
   acpi_ps_parse_loop+0x13d/0xb80
   acpi_ps_parse_aml+0x419/0x610
   acpi_ps_execute_method+0x185/0x430
   acpi_ns_evaluate+0x196/0x5d0
   acpi_evaluate_object+0x1f4/0x470
   acpi_ec_event_processor+0xe5/0x130
  INFO: task kworker/9:1:14859 blocked on a semaphore likely last held by task kworker/10:1:94

The full hung_task output (10 tasks) and the acpidump are available on
request.

Thanks,
Tobias Predel
