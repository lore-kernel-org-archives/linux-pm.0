Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DED3A75A2
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320104; cv=none; b=kEJJf0BMAa0LKy/Fqvtbs7XAgDJpuR6ac88A7cKDaLtuGfK7wZ4ztLsDwu55huu3XF8xBu8izKRkSlrvjskSMm9dDlcrbro86UcWV/fp3OjmxFxjTlNuyyylMyEDD9I1Bp6P5RBzzzV8gqmz/uWeoxP/gS/V/A0T954G3+tSaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320104; c=relaxed/simple;
	bh=qa4TKRv3TXnxrHdPXwxXTL4dL+dy0zr0l8qW1aVi8vY=;
	h=MIME-Version:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Date:Content-Type; b=Juy08BJN7B6NPdFGQT/1hDH9NGEd87GKcSqp8DIZssR7U6qGj6cCgKrVxM56Kyv/bq6upy9zKQ3ygFd9hQgxyG9TMF9tgQ3Apv8nqm+27Aq4s3R63J+VzyYu0zTXdRQ3HOPV9iXfWnoKVDP2SKAR5+ZcgAdarG2CXN+o1CQNA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqQ5M9Yf; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqQ5M9Yf"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-307263ad0cbso727108eec.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 06:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780320100; x=1780924900; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:references:in-reply-to
         :subject:cc:to:from:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUevwfcMW+V4MGFN1yutWjL1gpN3zpA2KbwhpG7X+kg=;
        b=MqQ5M9Yfo1zB2wDiZ1lIt5U+BCYJOPd3k4G2WC2dfSlB6iSR1452/9JE6Z1YPnKpNu
         aQhvr8rTyyB70KLFF518rTSO8kKAP10Tzfwj1VtuYwW0XMOe+rM7ovOm86bOioRrtL5m
         p4tBiWskU9xaASiPq4dQ4FCxDmi+EQnBpi2Tg6XAQTU0p8ynta2uYnqdPCzII4qMIHeX
         5MMGva8TisR9ooi/PFpOhGOIfAUGcFvTUKTuEjWUpKqU6isiHUrVketLDYDpnu6DpJpF
         8sk2MCCEUYU9uUljTW4fbtD/04GUYBNGS/KDBn3yo2M8Hdz0NK30yNFFnv6N15TRj7y9
         QROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780320100; x=1780924900;
        h=content-transfer-encoding:date:message-id:references:in-reply-to
         :subject:cc:to:from:mime-version:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WUevwfcMW+V4MGFN1yutWjL1gpN3zpA2KbwhpG7X+kg=;
        b=UsBMrTFUHw8JuWIP9qp+R+mlU/+rOm0KbioBDaYf/yj/loOI7/D45MoHf2V5jkymmO
         hK5T/0PBcdakDuoqGILso6oWwB25Q8P30pd8GQNTvy0KnXkds4o/mdazVkhuZHhQd9Jo
         znuZMe7+Q53nXcXNpVsind+LLVIRUtf+J4bJOXM5xo7celLl4rT43sx217rSE0wHKiPj
         nKAWh10yaRdh/tRJE6T229VvNVP3ip0vZOQaU0nIdk8wShPBIDmX6whtHm9H5/LEmmce
         ztep96qIg42fIUpv9Dd5VVebIaKBPSyh1jR3AeRKA1uUyPp2ErxNewIfYQqSyz6adfGV
         C7LQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zVL7dX0Rfy0vsUIQoZ0ghCKt8YhgEiHdi4LoSos4ae6xaumKWgeGpZWii6prKQSUTHBtcz4V3Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAAY//0lSq+Y2p9pBa096ZMg0oyixnnYdQc57zXqZ7LbYlUHcA
	ZO5E2NRfrELQb9SBo0nu9CHc0p6dHATLGb+B1jOvkia+gfXsNMjCKIht
X-Gm-Gg: Acq92OHoOp9CZpNGfMfIGl/w4Q//ral7bWKIoETaY18vZ59PZvovPVssnZP5ZQJuoDX
	Ztx1it3Hs+uz7troareAT+bwny5pPDXAW0hzdyz5l6EdHnTtQkKfZGaKsxZp4mxrEsYTePHs5X0
	vW0008UenvKr5ZiRGzYpooembpZDD7L9A+ax7etvGnpqh5Z6SWx3hHX3+jJUiFpoBY9OzHtK5ur
	7Tov3U8YafpvnPeOdvaPG6/La29mx/RVBn8dagdRmkMOnXSIICzXc9xDMd/wVF/NbPZHumgKq1e
	pGp0ftxLZdpvFrWs8d0eg6DPtI6YHRY0Q07bQvryUco31q5Y8PhJ21e0VFn6ECOU3kDZTyNOBbR
	YKgjoFOincRdEKO0hZKoy+wj89SB9q7qxgoDzdM1UbPOn7UcR5mFFw0awItlSnWOMZ29j3f+umf
	Az7DLLnLjbknff6iOcjMSiYI6fwHmzmEfOwKwA
X-Received: by 2002:a05:7022:221e:b0:12c:2cf8:2f30 with SMTP id a92af1059eb24-137d4142031mr4571986c88.15.1780320100174;
        Mon, 01 Jun 2026 06:21:40 -0700 (PDT)
Received: from GordonMsi ([24.249.245.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3d8f839sm6307274c88.15.2026.06.01.06.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Gordon Chen" <chengordon326@gmail.com>
To: "Mathias Nyman" <mathias.nyman@linux.intel.com>, 
	"Mario Limonciello" <mario.limonciello@amd.com>, 
	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
Cc: <linux-usb@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, 
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Mathias Nyman" <mathias.nyman@intel.com>
Subject: Re: USB-audio isochronous Missed Service Errors on AMD Zen5 client (Fire
	 Range) -- Data Fabric idle C-state? No OS-level knob found
In-Reply-To: <78ebe71f-85a8-4675-aa0e-6011353dee39@linux.intel.com>
References: 18b4e4f7089aa4f1.da8dbe994ae3bb77.445e21b98b0b205b@GordonMsi 78ebe71f-85a8-4675-aa0e-6011353dee39@linux.intel.com
Message-ID: <18b4f7b23ba6392f.e25301f473da0264.54f7bc72d1817dd4@GordonMsi>
Date: Mon, 1 Jun 2026 13:21:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Mathias, and Mario / Shyam,

Thanks Mathias -- the LTR/LTC angle is very helpful. It points at exactly
the kind of "tell the fabric to stay awake for this stream" mechanism I was
looking for, without having to burn memory bandwidth.

Following your pointer I read the capability registers via debugfs (reg-cap)
on the controller the device sits behind (0000:6b:00.3):

    HCCPARAMS1 = 0x0120ffc5   ->  bit 6 (LTC) = 1

So this xHC does advertise the Latency Tolerance Messaging Capability.

One constraint rules out the first path you described, though: the device
(Behringer Flow 8) is a USB 2.0 high-speed device -- speed = 480 Mbps,
bcdUSB 2.00, no BOS descriptor and no LTM support advertised. It therefore
never emits USB3 LTM messages, so there is nothing for the xHC to aggregate
from the device side, and I'd expect it to forward a permissive (large)
tolerance upstream by default -- which would let the fabric idle freely.

That leaves the second path you mentioned: the driver injecting a custom
latency value that the xHC factors into the shortest-tolerated-latency it
forwards. Since the xhci driver doesn't implement that yet, a few questions
before I hack a PoC together:

  - Which mechanism in the spec does this map to (4.13.x)? Is it a value the
    driver writes to a register / context that the xHC then uses for its
    upstream LTR, or is it per-device / per-endpoint? A pointer to the exact
    field would save me a lot of guessing.

  - Is there any in-tree precedent or WIP I should base the PoC on?

I'm happy to write and test it -- I have a 1:1 reproducer (count short OUT
URBs while playing audio), so I can tell immediately whether forcing a small
tolerance makes the missed-service events disappear.

And for Mario / Shyam, the other half of the chain: assuming the xHC does
forward a small latency tolerance upstream as a PCIe LTR message, does the
AMD client SoC's Data Fabric honor PCIe LTR to constrain its idle / DF
C-state entry? Or is DF idle gating independent of PCIe LTR on these parts?
That determines whether the whole approach can work at all -- the xHCI side
can express the requirement, but only if the fabric acts on it.

(As a lighter-weight variant I'm also looking at whether writing an
aggressive LTR value directly at the PCIe layer for the xHC function has any
effect -- but that hinges on the same does-DF-honor-LTR question.)

Thanks again,
Gordon Chen
