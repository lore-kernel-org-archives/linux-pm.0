Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599219;
	b=5lEHfFKOGZlfPGgrld4nMIgorAtiecrWB/UpGz0XThl7ocRgPQKKrx/vnk/LeW6BCl6G
	 fGBoLPhHyaoYIe6vPCxL3l2jPebnMbgEzFOgxcDj+ORNp8cqlgMiE1rSJKJHgw41RQgx7
	 KkLeuGcSzQthhos24ajkP5bHoKRZtvEbpF9xEVJyM6E1EN+lPmRxA0SI438XU1SbaGb+Z
	 UzMvRkFBFKwlVQTii9DR1zE/MjIQ+CYHxooOYU8q4GNaSurgGrTbZGhAb/kC3gRFs0gs7
	 AFltnSoa73EVSV4XL7E/g5PHkFYWHHETqbyq0Eq2gKE5qfx2zRXX+wafyY/OOGvVj8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dyq7CXm4eP3CnlrPx8cI2jgz3Z98ATLqm3BZ7cAURRk=;
	b=keQHolwfeDST845pNRZwvid5t/Ye+eHaHxQAEfVfhZ8mz0e4Io0zG+MK54xtKyQw08Rt
	 CYrD9sH1hpk3cgjw3M1O39KUfPPk0bBQsdT89pTaDe7QelEXzHoJNWcqO51SAr7t2RiYr
	 urMPSYK+K3tas1RwOvMsmJQnZnlFXSstjXeIOjIVrnV/ZZLcjRokfxn0WA1AiRBE1LF2G
	 Yfzp36JHTuoZfcXbpRS6BQc9TenOA34SkQQ2fqilsNAY0V75cnx4mKoD6lpXvKa40jZDt
	 ZqUNYmIUncvt/HnN8kxr2AJqlOXt5I1zGS6JoeMkW5C8BD+JSOBTCMPFwOV1x78P1Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYl0To9h;
	arc=none smtp.remote-ip=74.125.231.133
Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C73606A330
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 19:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08C73606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYl0To9h
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-86203d56413so137195a34.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 11:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794599218; x=1795204018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dyq7CXm4eP3CnlrPx8cI2jgz3Z98ATLqm3BZ7cAURRk=;
        b=uYl0To9hjmL0Iv4ih6unVMewjNXsAQ0Q/B/w1GtCmtBTkPa/Jzq1VcWdXML3/xLbdD
         z9KTOryLFjWWGZs2LyuQUQKCL1e5CwKsIA1EUQ2d+j2dL4WZgIq03txDobSZQA7+cVFP
         7r5XywegOQBHmbfg8Kq/1AhI472mzkE8r0CKPJM+tN2L96ffWJ84JqfhK5L3ZppCVfj/
         PO0eyrhmS1iS/Zv9pGJoyFobw7YwrS8tQ/06HhaQcy56PIXgDkTIpmQaLsLWeHuDwwiy
         cDxVk8rg/HtzYpxTJ2Giu4JjV2rPeKjRVaXoqvqAvwF+pFEzM8xh9KKs43PXYYS99guw
         QV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599218; x=1795204018;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dyq7CXm4eP3CnlrPx8cI2jgz3Z98ATLqm3BZ7cAURRk=;
        b=F15xia/4VStIxlTvXNwKMXhC4ip+qmIe1NqlyU1ZVLiNUqd+MiFAyeVDQaGgD5Mf+h
         7G0FGmYMh0HHEn+eC3MHIRbi8+8MdP190vRiLu9uhVL0t5aCs33KOEaMfHkOtxxX1Fpj
         CLMu6TWaWFlsfmTR8dyz15NusTi5YvxiA03tZ5Dq/Zx+YD1pV5Ndo+kjB5CEN8D/v/fS
         O0fRyF98/Uvdf2mcBOrlGUKm7V4LwSGWGsA9q25LMApGcRa6kkFOXrw5N8TEKFHKwkQP
         lC0Ukzd9PmrR6yfXZyH6n3K8/EWtK8F4fhoLilwmNZHe67Kh/Gp2uLrW3svzkgJ5VKMc
         egtg==
X-Forwarded-Encrypted: i=1; AL+hErGYQmK1MWIp5dEZX2370bmI48+g5KG6NIWRQcaRpuXBpLBh+thnKk5S3llgQe4yNOnETyLR0CvyEg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+1kFcrTcHIWcArs8y+tS2UPLG7+mp33I5n0JuuS3NahUpX9aGD
	VHrFm3IxWrDSomFza0f1LcZHNL8tVJkMQyshnZrFc/WbBzVRnBNyM/N5
X-Gm-Gg: AYBFou2/yW1QjGwKQ/YlTQdBklU94nNP4yqaatcxJB+5X6U389OLrZuQlmBWgMHS6ai
	XWnqF9MWHPAnUoGqvQ+iddBnl1qZSN3QGp4LJAlXrwPsw8aai1Hjjbyb25QbKA4OliLsWcPpboV
	iN9dV2HlIhtK6QW5CJKJcEDXld6l2S4qx4zb84XAnhljn/dJk+sfSCEoHEBEkhDwp0LfJCKP5iu
	HrZ97fqekT5LjJYLXargP6h279/xTb+vJUl+VqyDcbH/EMESeIbLOt8ivw3SmD4sgAb4QaJKRvO
	vPviPZuaeWnD/GG8hMlJyBjXq2fVm4bpKk6hddqh9xbpELOMTvlGAyf5K4b21kddHGMhxepwmW0
	Vj7sMqIhcf5bTyT8z6dGAolI6jckbaNpF+UBFGwhxa7JrUh+g9OqHkhajvcii8POoJjvmKAOGcC
	cBH5OHv+O8zUCPfzr43P1GvdJB1jPGw9izI96sZL3PZrgjy019fvUoIXIFf6TOXvc88JqmFZmPQ
	6sBj4Ty3Op/3cqg35awx2enIIWTDTOi9QdcPm0EExjfdvLuPY/+bUyaMGB6iutMjqKNqpmJUKzg
	IB4s0BgzScu1jNw7fJ3H5iw0ShU8xsl975kI1FwNUWWvaPTU+ZdJxgYmfeCH1GqhHpJSH2JESpM
	hiYFqL0Z+8/NZ14HDgH5j
X-Received: by 2002:a05:6830:4421:b0:862:a0ce:f55d with SMTP id 46e09a7af769-862a0cefa5emr249700a34.21.1794599217866;
        Fri, 13 Nov 2026 11:46:57 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8629d280975sm811328a34.21.2026.11.13.11.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 11:46:57 -0800 (PST)
Message-ID: <9fd550c5-292b-4974-a667-9a6f33f2528a@gmail.com>
Date: Fri, 13 Nov 2026 13:46:56 -0600
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
Subject: Re: [PATCH] pmdomain: mediatek: Don't power cycle domains on probe
 deferral
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Matthias Brugger <mbrugger@suse.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20261101-rbrue-suez-upstreaming-mtk-pmdomain-defer-v1-1-b4c41cf3935f@gmail.com>
 <CAPx+jO94U8b_PNJbbuzzFtF2HFeM7sYaT+oZoLJUfvThXkFYjA@mail.gmail.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <CAPx+jO94U8b_PNJbbuzzFtF2HFeM7sYaT+oZoLJUfvThXkFYjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 11:48 AM, Ulf Hansson wrote:
> This looks good to me. However, the patch no longer applies to my
> fixes branch, due to other related patches being queued.
>
> Please rebase and resubmit a new version.
>
> Kind regards
> Uffe

Hi Uffe,

I have a v2 already out at [1]. v2 should apply cleanly, but let me know 
if you'd like me to resend v2!

[1] 
https://lore.kernel.org/all/20261110-rbrue-suez-upstreaming-mtk-pmdomain-defer-v2-1-3ad9ad0cc67c@gmail.com/

Best Regards,
Ryan Brue
