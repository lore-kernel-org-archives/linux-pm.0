Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794194744;
	b=gDP4qGinMwKAZ38ZYEl7d2sL0rU0G5vuAjAiwsxdQyEZ6j+l3uNKlTQNlAIPveWsFGzc
	 ZZSA7qI+yorXzHGHhMMsl9ucnxIRAZaFhUUUmB55guZjpXduRGK2VcZ5DVr+axbNB1jZD
	 SUqgplonorHXZCNDE1vbFPidiG1fY07+i3WIndnx2mO1F1EnHwAauF3oRwDiljaexImY7
	 x5Sa/AhPnt/D14iHZYU5vAF5c05QvDbtOCDR2wM36ywRDL+/orNMyLSB/Q6RH1yISOXdi
	 DO6zr1ql0zHU1G9IaPVYaW+Tq8UU3GA41ejMHlMBD75c5jQqfgf70JlVpiUWw1br8Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3BOYLiWEUrEf2ebxgH6DsBUeZfhcIwN9G1AOhCz5Av8=;
	b=jhzmBh55MNw6CswVHWRpUks7sjotkyXUGKWLPhD6qEuUmUB6XEDIjXVEmKX+VSmu9fgp
	 XMpuLnvIrOTIG+JIR8yE/0GYHFK+q+oiWqI6LG8bMF4JWyUhq2OdwnYWrwRp1qmNQPaXu
	 PvUz10Q9kvig7REAurWXtiCRN+pXIzxCFkZSVj1tRiBcijcCeJW5/deq2Pt2OKfG8EDjf
	 +OcHOXcfPqd8mxLKHSR0c+F8SuSwM0tLU+FpxyiAziTnL5FmW+OUm7dKCUWmHYH9EXAKd
	 m8mlJ+IrfTZIYWPxHrJllBF8MftkLoBdMiUUE93kp9qprEOFGcnRUF1LsOsjMGh3Pdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aRQvyvLR;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA6606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 03:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CA6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aRQvyvLR
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b083afebe4so38780a91.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 19:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794194743; x=1794799543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3BOYLiWEUrEf2ebxgH6DsBUeZfhcIwN9G1AOhCz5Av8=;
        b=aRQvyvLRRvgaZQa0PIw6WWK2WJV78y0sTZ8U30aA/bX96OL50P52LidJ41STOKIGXL
         Oi0a4/AdQ86Jb62TGmlr/V3eOtY8z8vK7Z/+wFVoVKzg4Gk01F6bq0qGwhI0Ov/LM/9F
         ODBi7ll5D+AWLsW6zWYW08A72AxoYmbfbZ9UMRIUsTIhNg7RutJUzKuQQIdfvGmyC8TB
         9/ZYTPSkCDqKy9rnOhGjsxhOcMPbuBgWk50Zh13ryUZ/HeIj+h1xGjJrzyggK/Fv85tX
         ZyYEUqvRRc2ST2VKvoy5MCZv9lMP9JuDUnEc3VK9BqB4VNa6YE/+abDrHaQuX6m4lRtF
         hW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794194743; x=1794799543;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BOYLiWEUrEf2ebxgH6DsBUeZfhcIwN9G1AOhCz5Av8=;
        b=nuOho3Va4ZDSqzkCMfqQ/ux1s7vZUCks1TadeevihU1QKLLG1bvrPZtf0tmiV8cDhM
         xuodkk0jitEuTuSC12pwRhpaAq5Z8yjD59IdiA5KYFcpt0U0Z5KolacF6GOhzg6uxDrg
         vXQntPsAxqoogghG4avmynbOKhV5V2dET93kDe1DdwPT4pbz3Rsmn1T6kmN/rpBPw5ou
         9gtHVFUkoI0IIwx8kuiHX+uR6HLUYEaXTa9b/8W/HbOeoQWvxB5EWOA8U+D4Vul45tfd
         uu/JstZEB9X6g/H74XTxwP+CjBVXfxXeQH+VADDOnP1tAP7RmctjbA+Bm94GZvKDtkzy
         8WeA==
X-Gm-Message-State: APuU4Z/b5kapUgoqxURoVDrqDEcN3q+HcX/vV7N4GNORJ6JlG9C0ClG3
	JVJVwM33+oFgiG+GY32pfG4kTSp/qrNMuPHNQCDhkkBdzgiYZ+lMz11k
X-Gm-Gg: AYBFou0D4+YX7ecGBr6Vkt1tJcosKBVCk1lEjA2pe5d9DoSbe8psYcaae8GeQ2pZvIk
	IT6Ay/s6DLT7sUeKVXOz3ET86O3cCyma85RTkvPUIVP5jjFJHl2SuJ3NpSkrZrEa0bHwl7pUyrC
	6hOlAHzmbypWJ64ohkUkRaw41E0shg/Y3YfalI+9OUTgJAfxsDZKK9AJc+Jp4vaMLxVQfOUAiqD
	Xz6wP928v0IwFJdOkHEICt8lFZ1+SDx1ctJAu0dOsm4tEhY3mzbzfpPTxRbopRyyshVuzMXcZB0
	uljKKJJkGBgjFJVehhDgkloXr/bb/FuBYZACDx/XX/k9j+AlAb28IphYfFlks+J0HkyEBOUdkmc
	T0GQBoUWmurve/cX+mfDtac8Uq/uQ/chsqjMgNEmRLG9LlG9WueAw9ealZQS9d7cMEX8QL7DJJv
	1yzitV3Ai/fl4KF540Nt5IsQ0fMrHVWLUwT5EUTCigxVKptnLKysEfPJvkqGx79e+j+AmwB4RfC
	GNkdI89mt7c9UJE0k0HA/bF+tBahjKiB8rNRUpOfLA4cdAVi32AssfX+0DIACCcgeu6KCoFrow/
	W+NzcenBZX0WnsDoLfaZPOXdeyBMUWsq936ck/KsrNkClblwPBqM+b0=
X-Received: by 2002:a17:90b:4b01:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3b12d14c701mr4664426a91.2.1794194743429;
        Sun, 08 Nov 2026 19:25:43 -0800 (PST)
Received: from [10.188.246.87] ([61.171.219.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb96815a08sm1146067a12.10.2026.11.08.19.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:25:41 -0800 (PST)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: core: clear states after freeing them
Date: Mon, 09 Nov 2026 11:25:39 +0800
Message-ID: <179419473985.45704.13570579264108151328@gmail.com>
In-Reply-To: <179259111932.19580.13027750156272888992@gmail.com>
References: <179259111932.19580.13027750156272888992@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Ulf,

Friendly ping on this one. Patchwork marks it as "handled elsewhere", but I
checked the tips of your linux-pm next (6d318db9f) and fixes (4c66c4235), and
genpd_free_data() is still unchanged there as well as in mainline. Could you
confirm whether it's queued somewhere, or should I resend?

Thanks,
Anfernee
