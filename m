Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794732789;
	b=YwD1j3/zk7mXcn1b0JH1iEj9QRE0JhHha/SVrdlskTRFqlOWI0CtMN0wZfXyN9WlKKg3
	 1ijpzWmySe0zNep7DN8N8tFawiXMuC3CTuHcnVIMUit1SzCQgslR6alzfsY+1c4/bWPAR
	 Msb7O8yWp4aCUgbiDHt//NGFYNHWnh82A9frpv8C5Dl9X9vuKTQd1n3z9SMmfWpdoSJEO
	 U5jql2cWbKtXUBAKLRD2PXP9GQIYLHRzBLXe72ew5ApHDt5qEfip1/DN75k4Orx+g2m+f
	 NlQHJIdwtRyIyFArQvrnnnIY5nsx+ocr3bZcsRw/qsBZLAyqoXOuxDLq2fXmxTECzTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794732789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wNHsMSnqXLNqxHaUvaHElX48eJyvQ5UchZoPNPKizhU=;
	b=AFBKv/r0/5fChIhfwOlUl2J4mA2GZ0iKcLqfS0Afvr2qS/YioEzqrbD8zDbgueKcJfTm
	 dlhLE1m6B46kYkwa2Hd70kTyGanI1jfEQxxiyVNDyVwhzabsLHjc3IPdc3xFRjNtb7ecY
	 NN2e3xebFX2eM1vRpL+A7ApZmYdHVxrZojVYRUvehhMTtM5F7OGEfLRWfY5ELHfgPqIi5
	 W0mzG32xML8gWgSViTt4Jt6R+njsgm2CcGf5rp4Kj9lGXBy0jlnRU6q/ApvYCpusqdKt1
	 rat/MDncBoaxhbGiMP0JNQ31dElWjWZ86HoNisqMscrTZhKXAWVpighlKdbTJgXlaeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QuNZbqws;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E099606A327
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 08:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E099606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QuNZbqws
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-49134c8509fso2512007f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 00:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794732788; x=1795337588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNHsMSnqXLNqxHaUvaHElX48eJyvQ5UchZoPNPKizhU=;
        b=QuNZbqwsBNxNnipsn4hLIE9NyeFCT6idEXbwgrzgEnYTHXbw73p6jGLvh/aQmuBd2Y
         XaOxgSrfRJwL4Xu3A7HbpjXc8fVo63nWtteDG48RgGTBE3oLu/8g55GsggyMUwox2XVF
         9mEeCpnEzAcVwR7gg/oIgdD4UETZVqz54cDW6oS0OGpD/JuxBQ8HcNcWZHxtkXvBzQRD
         /WsCHS7+dkzaTZa8PdFiosc41ct7scbG071Y8M7V/SxuNb4J/uxyoJl/432pHWd1antS
         FgMHSc4ONoEpAzxUZG/emyrTgJRh12Xgfkc/FCYrpC8FWyuODcgdPYiIfSVlGesSoGoB
         6w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794732788; x=1795337588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wNHsMSnqXLNqxHaUvaHElX48eJyvQ5UchZoPNPKizhU=;
        b=zd+DtSzKpyD6IlvRSkZBIK7Aq8QKrA3SY90UmnTSk2A0SuwOVEpx+XHqSF5Qww3ysc
         eeqRCsImOk4pxQRf3nPu07tUgDVkcOAuzzrhBDBkGs3LPqnaWVFtNCkXguq3RQsfne+5
         ln/JEYDYOwHbYIC6+5nykAksrj+kaoWGeNmVETHB/uhNdUA29YkcU8jblkHigeki+K1f
         5QTqcfUi9YRr1Gd7zMTyLO+50z1lyGXTJYWcgs3ZbYKUhCWK8k5AbV418Ag5VEonREuh
         4s2T64us/CpQ652wIwdWCJzudCz3/qVL+twqUOcQMxQnALp82jmidP8K1aipRzVNAQrK
         o14w==
X-Forwarded-Encrypted: i=1; AL+hErG1J3XEfF9xWu1lS9R2StPIEadyKuV5isHUOVupcnjDoK3fsYuAnqLHebT9/PDjx1c8GYkhneGenQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z94MXqDVNtlxow13xl3FAIchVpN/LV8Q3IEiBm99vUv2VAbj3kV
	ywv7Faob/fnG6UhVoxdkebXAPY5XKP9P/vzEfNq5bcfrCf13th+Q6fcz
X-Gm-Gg: AYBFou0NkL5mwdWvU2SdR0sydAXwyynPA27eQViM9Wx3sFhnFRt21pSxq3nTFMjq1PJ
	hCc4dvEChb0QWbeOIH6US2ZxGhO3RapaUOHUedT2cE/PMXyva3fso9VazazTxGq0Dl6QOH5iWzT
	CkDwT4JuF87QxNaxDxhME7aBQ2rwJsfO5saLB0Im1EUZsMNyvleD73qMSLrO32w9yTj15Apcg2E
	x8jDZc7BQ0DswDdIhCU2hSIRqLyBOodS5zrGGzfWytGswM5xaYGi2eUqo9nWAdGf4JMlAnYBF0s
	3K0jI25AHiN67xZsPmPy8sz5UAQbHf5Bp3my2O3Jz/2eCmKBgj0VD8V1SvpF30OnC+fW5mmLVaH
	3REGI/Lnrra51eJvpGZMdPS85IuiC9dlqGaMj+5cLdPg//lJiVq5WGTSwyUdWOKwAGFrH+amPcr
	DyWhmFYAIc4IlmvSA2IL+VTTyIWP2UAmfLfEulvhVYD6Ga9Q1VyArkftFcJ9UJykz7O648DREg4
	0pUYnoVdHA5V1BRZHXn/jbYBVnkkF5LlbgcQjcaJwdZQFm5O26w2jBa+vHNuud04ZfOT6WxNNH0
	IcaH9xCI3p/+Xn87JJPeG8X53c6B5h7d6w7F77iB6JV/tJsRBvU3EKao6yWuvfr8
X-Received: by 2002:a5d:5f09:0:b0:48d:f730:bda8 with SMTP id ffacd0b85a97d-49c733510e7mr14372013f8f.50.1794732787542;
        Sun, 15 Nov 2026 00:53:07 -0800 (PST)
Received: from localhost.localdomain ([2001:8f8:1161:9f6:2001:1fcb:a25d:8f2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5fe370f8sm13886168f8f.27.2026.11.15.00.53.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 00:53:07 -0800 (PST)
From: Ximing Zhang <xzhangjr@gmail.com>
To: Hugo Sales <hugo@hsal.es>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] cpufreq: intel_pstate: Refresh cpuinfo.max_freq when a CPU goes online
Date: Sun, 15 Nov 2026 12:52:26 +0400
Message-ID: <20261115085234.40661-1-xzhangjr@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114-intel-pstate-online-max-freq-v1-1-1bbdae2b4986@hsal.es>
References: <20261114-intel-pstate-online-max-freq-v1-1-1bbdae2b4986@hsal.es>
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

On Sat, Nov 14, 2026, Hugo Sales wrote:
> I have no HWP machine, so the HWP capability path is untested

The patch fixed the stale cpuinfo_max_freq on my Core i7-10510U with
intel_pstate in active mode and HWP enabled.

The test changed no_turbo while CPU 7 was offline, then brought CPU 7
back online. These are policy7/cpuinfo_max_freq readings in kHz:

  Turbo change   Unpatched   Patched
  off to on        1800000   4900000
  on to off        4900000   1800000

Both patched readings matched CPU 7's reference with all CPUs online.
CPU 0 stayed online and reported the expected maximum in both cases.

Tested-by: Ximing Zhang <xzhangjr@gmail.com>

Thanks,
Ximing
