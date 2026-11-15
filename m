Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702318;
	b=HmtMh1PBMkKykGEMM5lrsbBCoZP9E+zKUpzpa7Ra72adWPC18apDZlO3yicbrxRVVMWP
	 tClqlDuOht0x9V6zAOb2Gj/vq9fg1NJBylJ+ScW4NoiLSre/dVHgRdUVfY9QuV9Rm2kYz
	 e5Hb/UKF51FPJU32XaSiIbbdBfz/RBY6I9nHhJHsbupmKMqUxuP5HpJgUOchVST+yW+6Y
	 3LsfxfJsQXd6z6dIWoPGxwATn5cZjsjN38+LP2PeEl15v+b4sgc6d+YNLHrM4a5o8dKrp
	 5g8ONVm+t5Uluy2IKMpu+vJ2Hn8t95//cHPGqG0zNe7h199xCZ4YEJTxx1+Wq1Q+BzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QBU+JY0LIvKeNHjcy5gTbrjwDNu63TsOHh29cK8nd4o=;
	b=1I+xs5+JTu84CRxj/yOphSN5AS8VKiiYc5nUi6y+qTvOe5RfM0Iz+zGvV52F8lFZ9Nvu
	 2Q8ZYav55B8nSZxQHqwg7Q033LaDTTZPAmD8EmwqOVi2H/3gGazu5W2KH4VMfgGb3rk1h
	 aJCHO8uW8T5v5V+USjCP0lsUW/iCSUAoxrfLN2o5dRZTqCH6De63JN9wRoyXE4I0ffrw6
	 YknUAUZ0kzttLZlsbJuY4b/acQt5qQoCri85VX6PlpgBHCMk7ea+8WehfiDlUCf1eH27q
	 IzFoVlEkupLU/hThjN9kR7CHhbhS+WT30Zm99UKBjNK4eAF2oSszjWUiYQTG3ISkTDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ols/R6zM";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4F606A323
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 00:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DA4F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ols/R6zM
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36e795af1d4so1648401eec.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702317; x=1795307117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QBU+JY0LIvKeNHjcy5gTbrjwDNu63TsOHh29cK8nd4o=;
        b=Ols/R6zMu1kix52YL4gO5G6t2l7MiCVboq6QHsHUlZh2C3x/yzt3IZrAH3frath6cD
         IHSwWZ8L9+AL+FuxJygZaWikHgFGc2CAl8pnkoeHXpjyjqFfP19Bo7uRxdluOcabnYNR
         zRii8/9UJcgRqZslD4goexaigmszzwT6TkqlMK75b8yS5cah+Td2FSI5WVGuH5+o8iE1
         0ilIhNSyE5ctI9aBg86g4QPNsrczsn6Z3ByBpMl0F9bGyNZbmWIHictoqeUQ0xWr/jWx
         6lij1GXYh6GTlCxmrMgDcbfX8DzpHAsFDNAxjNjpcpFY94Pe8U15mqheTpYJiwX6Phe4
         jtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702317; x=1795307117;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBU+JY0LIvKeNHjcy5gTbrjwDNu63TsOHh29cK8nd4o=;
        b=i3UchHXsO1+Cw3AlnmK24FXtjjk9uYBOkmyQ3acsm+IASWEKLK8A3tWA+3akOZso52
         MSxWThFY811Blrzikxq+r9wIVrZf5A1Hxcvj0+YBID9lt9mLiWGHpIvDuZVjE3JWGdiZ
         8VKtpjqwDHklWoJT7BfsxBOVcjkr4MKHk9aBwpgTVoOOAO0im2m+5HAY3iFdbCvHPSnl
         ln0o8kC5PK6wBt7Gy3Itt1vlgClhvIDfOb4g6722RexSlBnlsQxBXARvZh5K7gTsCzsU
         cwEhc5kAj9QtIF3++c8Imlty/OisuamhKYpbpCIO4slbW3+HX4lvYkTwHwRIfZ6viUn9
         Ywng==
X-Forwarded-Encrypted: i=1; AL+hErFwdld+YvVEqIHvaq4rG4zgA7rZGjhsXVgFnnZfIZbVlK+QAmemMbkj1kpA76LdM01X8n3McLoBow==@vger.kernel.org
X-Gm-Message-State: APuU4Z+QXKiSF46QcZ2vj7dTvl3TNey6JHLQ8vmM5hnL1hgo8UTlwgTZ
	B8bjes+0ECIEAdoiARQCmLV9QCBkHS4dyZWwTULJvRlfi25tmTN4FsdF
X-Gm-Gg: AYBFou1+LeHMROAfVhLG7euT8rdgxafV58D3+pkGd4MRpt91C+B0YcZ9cvEh8rl1Hga
	Md2DbZNg9f5dDnDEyXWvXhAFv4jlhNjrv/AB64dg4fG9F1iO3spGRvoiBENinJtHYq8uexNZFIm
	bNZclv4KEf0qXRQK1q6YSbp7QmHIRN87AvA7xLGa2FTLGKbJTOtasnvor+HLKL8qWiroI5kL9bp
	GZdEXR6EMk6FyzNn9ikfrkIN+1RNp59bMakXdclb+dfEBg0GRql4GA9JIuoYtotL7h4dBNUTzGX
	HAnpzHqVEgwxclYpLVemZU91fOilyUfrk4IoeQQnf6J44IW34FMuOvTp9dT5h3dChj1pACk3XUn
	d/2rDKqvCyjyNSEN2cB+eHKS97LJ7TEr2beYxMjqJQhcgupcvYIxziPG5FmwR+CaZ3QQ3MXAOgc
	O+SDfQfo+d665odlAf9xp8tiB3NtFj/b7OombyOL1dY4lmyMmE/NGtETYp+8OWW9GzvmDZkpaz4
	2Si9ynagh25SoGmNFDskC5Ow0u3SFItK+IgK66G40Q2OWEujrEUFpZ+oC3VSd/w+aGS6fOtF/6U
	oPwihoCG5jqm1zmbpuLs15eI910FWkJ0Za7eQw2c9yHYcE3yFt0xqQVUpqMBM/lBoUQ=
X-Received: by 2002:a05:7301:1509:b0:369:f3a3:fad6 with SMTP id 5a478bee46e88-379658c798fmr6036337eec.4.1794702317178;
        Sat, 14 Nov 2026 16:25:17 -0800 (PST)
Received: from [192.168.35.43] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f01d68sm19708520eec.17.2026.11.14.16.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 16:25:16 -0800 (PST)
Message-ID: <a813b1ea-6971-4fde-b310-659a03963fba@gmail.com>
Date: Sun, 15 Nov 2026 09:25:12 +0900
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
Subject: Re: [PATCH v2 1/4] PM / devfreq: Fall back to previous_freq when
 get_cur_freq() fails
Content-Language: ko
To: Bean Huo <beanhuo@iokpp.de>, linux-pm@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, "Martin K . Petersen"
 <mkp@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Avri Altman <avri.altman@sandisk.com>, Bart Van Assche <bvanassche@acm.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Stanley Jhu <stanleyjhu@google.com>,
 Bean Huo <beanhuo@micron.com>
References: <20260907192140.2701755-1-beanhuo@iokpp.de>
 <20260907192140.2701755-2-beanhuo@iokpp.de>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260907192140.2701755-2-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/2026 4:21 AM, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> devfreq_set_target() calls the optional ->get_cur_freq() callback to get
> the frequency that is passed as freqs.old to the DEVFREQ_PRECHANGE and
> DEVFREQ_POSTCHANGE notifiers, but it does not check the return value. If
> the callback fails without setting @freq, cur_freq is never assigned, and
> an uninitialized stack value is passed to the notifiers.
> 
> hisi_uncore_get_cur_freq() can hit this. It returns -ENODEV without
> setting @freq when its PCC channel is missing. On the mailbox error path
> it sets @freq to 0 instead, so that the core does not read a random
> value.
> 
> The other two callers, cur_freq_show() and devfreq_monitor_resume(),
> already check the return value and use devfreq->previous_freq when the
> callback fails. Do the same in devfreq_set_target().
> 
> This does not seem to cause a visible problem today. The passive governor
> is the only DEVFREQ_TRANSITION_NOTIFIER user in the tree, and it only
> reads freqs.new. So this patch is not marked for stable.
> 
> Fixes: 0fe3a66410a3 ("PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER notifier")
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Reviewed-by: Avri Altman <avri.altman@sandisk.com>
> ---
>  drivers/devfreq/devfreq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index f08fc6966eae..f20d9a660779 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -348,9 +348,8 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>  	unsigned long cur_freq;
>  	int err = 0;
>  
> -	if (devfreq->profile->get_cur_freq)
> -		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
> -	else
> +	if (!devfreq->profile->get_cur_freq ||
> +	    devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq))
>  		cur_freq = devfreq->previous_freq;
>  
>  	freqs.old = cur_freq;

I agree this patch.
But, I don't recommend to execute to function on if statement.
In order to improve the readability, could you please update it as following:

        unsigned long cur_freq = devfreq->previous_freq;
	unsigned long freq;
	...
	if (devfreq->profile->get_cur_freq) {
		err = devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq);
		if (!err)
			cur_freq = freq;
	}

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
