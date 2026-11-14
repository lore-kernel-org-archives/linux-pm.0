Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794700462;
	b=lrn/Tipwv9RQLGrpZ3zGSO9sG43LmfzmCjmg4+4Qy/+jrZyGC3ial1VZ5AJkho0l9CsA
	 G8MylmEHFVeZxv24OVfK5aEfDllylS5g6b0ih2khx5+1wJPhU0C8UAKzlytJI9BY9kTI7
	 Yt/M/MhkaBw2f6XCs6O1YK46W3EMi1x3OA2k0tuaq+XKnvXoTUkHjCDObacYjhY4ayVlx
	 H6LFYJysSQbVxThdYdzYo9TO3qs9ar8j8DH1NVDTMFNyMJdff90+XWdj0MH8DBvZpUl5E
	 2SoqR6HFXYApGpjAF7SJnK8BVOZM9pvvDzLNL6PCqjog3baOhgd22gRPPmHhZpVpLiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IufCbieA6Qd8N+6xo9KKOPiazDCkVPjgFR48LE6emEs=;
	b=wNmDlwbJtUHEeovPNZUb1gTKMOj+NUIpukIlhFKNlENGAhT7ECltlaR9ZCeaGPVujuSQ
	 o+koZRtVePfg+wdoK+E2kpBNgNkvrnWAh3oN1tHQnAItmiNCvQTYbfk4aCS+EI3qdLvqR
	 o57xK/rMLrM1P/WjRcCtkbDvCA6V5zi5tYlbyMo9mnIM+PdtEPWu9HvCvznGccNaUp/3E
	 QWgIC8s2JlNu0TylD0LvcU0ePYGX7/2+A/fc7AfUcmxs8ObyC+z7zzQT2gpNo+0jrbVT9
	 SU47oLVZX1Ab1J0MGNX5aDZT6ldyrwywhR+WGfOa/zFt92zAw96N9vtJq3gOroRlAtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AcwcReT+;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE15606A329
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 23:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CE15606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AcwcReT+
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-37d424f1ae8so436066eec.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 15:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794700461; x=1795305261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IufCbieA6Qd8N+6xo9KKOPiazDCkVPjgFR48LE6emEs=;
        b=AcwcReT+QC044IPHT6exIOLUEgeeK49xIuqeNAggMyZFbImm4qBXyiu6GnzPTnzF0O
         LyIgtMrKl1ZmN5XjVs6vL7C8ALbllys6YBCjcALl19AjHF8kZgB1gaDggpQyV9VrU9zD
         Syo17s9Vq08yv2z9WuwKPD8uw8rACx16MuX7r7bj7/9DH99+LefTGqCCMB9A23z2HZzR
         NWFuOGadUVdkAKILcwFUnEClxLZ/UQG5X4y1k43QRdgGsC8Sskrl/RDLXBMgJBxzkKIE
         75LEOqBwq0+MFF9sGjLZOZiDzItFi9AM+cK2i747T2pMvMN6mbeU3OG5qAdFEuGCGk81
         +vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794700461; x=1795305261;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IufCbieA6Qd8N+6xo9KKOPiazDCkVPjgFR48LE6emEs=;
        b=ntU29ksblF4OGCbxapF2txQI0BgFDq3sKggjElfoyzVi35d/shg+/VU+Vadsv+YFl3
         oBTzNEtrnDiAbYwiBQ00+G2plEUdlkJsg0oWZBjpRHxdyZvg8URgZ273ozMm1w6EsLoY
         XtyP69s1CHgE/skkxKJC5TqwlWRNrIkpRm0c095TgPndeTMEQQPLcGKwtVM1fJ6F2Vva
         /LkXFH8FGmpf1eK+Bkut1rjmCbye1y4w/rlsrPfVokiVXjkgKQyw2YiiQwtHBfb9vwRY
         Ws0ledgPT51CPMWyuIx4ChLzFG1qWunsn01cr6Od5tC87hj5veWr/3e8l9XqflHEYiOv
         oNLQ==
X-Forwarded-Encrypted: i=1; AL+hErF6mHDwqfMmE8GP3fmxgJ6HEYYN67ZCl/nWQDy5+4tiq6qQwmrzIRsEI4U/HNx1MFNBCTuIZL2BTw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/wAyU6d2ZT4zcRzysff2LMM0igO+D362DR/Mq6qGtpttRmqtXg
	I15XBurrKv5vf0fxttIS/iEt8T//0tLMlxPaTCPo4Z+htAGcl8x9+xXyNw+KUgLJsw4=
X-Gm-Gg: AYBFou1jSqsdehape0Nid4ZbG0WoF7MZyDXsr54JvwI96jxlfu1hV2tvyW/71cc7fab
	CStXpMEwmg0gO88UP9snVluBV4+EnYoPbZbFD/XWoeKsnXz/m1y5CUUOH7TqCQxo+k+bAI7bfBa
	TVaoYFo7/7Y0x1OND/W5BTx+QGU6H9j/5ZHKP2ssnLMbjPcnoQl9p6bhby5i3SNTIsgNbBZGNo2
	vjJDZTPWGzxoLXV24OOAHIG1B3HQg4WfDhtfNQdUWcDy+XhxL4X002nD9jPJj7V4fRIti4uG6c6
	GXtfUB73Q9QFLTmQq/krmcsVD4KWVc/p8fwqHKy7/xj6b2hEQ85z4oyBhFrxAN8x0RTvjV4gpq4
	Trt+jUgthF07/djNqYxclDaD4NTuHPOEjlgdBtfGHE1iDTBhiO5yzh3UliRJ7/Vku9A8kFK2zqL
	FV5YXU4zATL7iCwkWQ4R2Hm12uoxnxZdBSbX8RtyjdpioCsaK8ZoKsvqyzlVjOPy0rpFPseZ+VM
	t4kGc141DOymdt2TCJpU/1TLo8xyXojVWQdW8nqs3mNw+/6/c3mh+0abNCqS1nqq98hJq9JkUZf
	Amh1268QB/4m6ovHhjU8uawrEk4WWNOEAfjEXq6p2JVS6q/aAXw9zcJXaHJq7N1LQnE=
X-Received: by 2002:a05:7022:f116:b0:1b3:af3a:e793 with SMTP id a92af1059eb24-1b502fe37c6mr6384471c88.0.1794700460496;
        Sat, 14 Nov 2026 15:54:20 -0800 (PST)
Received: from [192.168.35.43] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d8f5sm29226208c88.3.2026.11.14.15.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 15:54:19 -0800 (PST)
Message-ID: <4b8a7510-808b-40fc-a6c5-551e7d88d5e4@gmail.com>
Date: Sun, 15 Nov 2026 08:54:17 +0900
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
Reply-To: chanwoo@kernel.org
Subject: Re: [PATCH v2 0/2] PM / devfreq: add Airoha SoC Subsystem scale
 support
Content-Language: ko
To: Christian Marangi <ansuelsmth@gmail.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009073330.18175-1-ansuelsmth@gmail.com>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20261009073330.18175-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/2026 4:33 PM, Christian Marangi wrote:
> Airoha SoC contains multiple subsystem that are scaled to a
> specific OPP taking the CPU clock as reference. Such sybsystem
> can enter idle or performance state based on the system load
> and power consumption conditions.
> 
> Example of such subsystem are GSW (Gigabit Switch), NPU (Custom
> Risc Co-Processor for Network acceleration), SOE (Crypto Module) BUS...
> 
> Changes v2:
> - Rename to a more symbolic name
> - Address some sashiko bot warning
> - Better describe the use of this devfreq driver
> 
> Christian Marangi (2):
>   dt-bindings: devfreq: Document support for Airoha Subsystem Scale
>   PM / devfreq: add Airoha SoC Subsystem devfreq driver
> 
>  .../devfreq/airoha,subsystem-scale.yaml       | 114 ++++++++++++++++++
>  drivers/devfreq/Kconfig                       |  10 ++
>  drivers/devfreq/Makefile                      |   1 +
>  drivers/devfreq/airoha-subsystem-devfreq.c    | 100 +++++++++++++++
>  4 files changed, 225 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/airoha,subsystem-scale.yaml
>  create mode 100644 drivers/devfreq/airoha-subsystem-devfreq.c
> 

Hi,

The devicetree contains ths only clock information for scaling without any parent device
information even if this drier has used the passive governor as default.
I think that you better to use 'userspace' governor.

Also, are there any connected device to provide the utilization?

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
