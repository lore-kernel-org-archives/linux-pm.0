Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702453;
	b=XM/xjQc/y2LJW6uCDbHJsGyVx6l66W6YQXVFbEYxtDRV0wwjHs83mlDw0hJqA2cv/WGo
	 DrsbzmjVdsvgfZBacidqMO2ZlsLrkAAHf4QUjvzUwWSiV2S8uAhy0iTEHIfZmpDXjMM/6
	 Kj9WR+UzZZbfAkfKwr47DZX13hqZAEXPxwnfbRwZhhK3CwAjUeKomKuOhGx/lHvfCmZep
	 jGnuB8lnww7Gxj2VBApnjwqn6cNQq0lBGnEN3hWlRHR1cVCshGL4i1LqTaHdmWnZIIbtR
	 oMOEuO0K2Z2JejsUjjtnmxBBvd4hnQKv2+k4XnON+FZHwKKxR6fqw/I5XSAl/1NF+vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=u9+e/eGHjR73QRvGijIdIOH0R/G/DJBbLevQ8HFggAw=;
	b=XX5DxALQP6ekCRN6RMXnlvwNGjIeSvgHvE74hIwKF2ApLMSthdwSbiL0qfCzyaKSVtqQ
	 oDqqzZtiteaUM/QXSq78Z3z2IYrjEUrC/TSFsNEywU7n9CII7IE3CONJvyhHOCZvF7/4v
	 Nme233AFTV8XwycTXNcQDK53Znd7o+uIdyFI0Tf4oWRLZ5YVEUbSaz+pLQ7aB7Wlhb4Rz
	 UhJWe5216Jd5pd6bYCN6TgxF85uoCJdtOkL8oW8fZ6P/3bvGAjikat2F9D/2JHgQjFVHu
	 1Abx7/aeCMFokYyBqssmbHF0nuKYn/CRiOa20KLNpl4tniFaeCvhqMm3aKo+iZQ/AVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mnISHfT1;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E202D606A327
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 00:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E202D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mnISHfT1
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2761c69fbso2420311c88.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702452; x=1795307252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9+e/eGHjR73QRvGijIdIOH0R/G/DJBbLevQ8HFggAw=;
        b=mnISHfT1ZwT0S7pwLXfYK1XT8B5W1NMnt3+b8uJOvqsR3PYKLTCSH9RRGvexEqN1lW
         nbT/vGpIItUzSDwYG9pODU/ijNVun87sN2/1zYWxWPAQR0dOFnbm9C00imDKHW4ZtKHG
         bv/JRjQ71fdigYHckXAvtGV/BMvLaKO3g2V8uwu1On8416qhMLS6szR2NYAnUHmT39ec
         +d/MOVCbzYoH9+yslnPNfgKNYHlady3TvmJn4VQ0D4hRRs4lUlBEunWSWJyzKMJKAt/t
         k6lufnxWNXtDyiC/LTVudEaspBO7HW+slPZ5ROwqH5+wIzx2sZF4Wtgr0A64iLWj2avV
         XVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702452; x=1795307252;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9+e/eGHjR73QRvGijIdIOH0R/G/DJBbLevQ8HFggAw=;
        b=SZInQP9eHAjT9VYGNln/+svMEMr6CltbZggL9tkAgO4/9RapNO5uixqd/rmd/ZiHsZ
         chIVQOjicOi8eEpJjm0K+x/7AJvmDdhu14evvU4u8biHHLQQCgPg98xOREv/a//Ue87V
         8tEMpfJXqdZeJo5eXELQMnY36X+RHj2rPqTV7LFevGDxsBGQITulaPrm2EXsPcIBx6UN
         8vde2MQA3QfFlOVe2a6C1lmxgo5ZP8K9vpcK27zm7RQkYwzdkcpExt72t9aa40tKGoR6
         mwiDh0Iu0hjTV/bqtmQV0MY//zqy3iYZLOr46fiDtkyxAZ9Q4mqWil3nvpzEFmjMS6Q4
         Swsg==
X-Forwarded-Encrypted: i=1; AL+hErEerDqUj4cWSA53Vg/8sJgSfBPsfmz0CiAtHpUWBRVBikkDs+9omBxK4BsS3+ys6bRXHwvWWi88HQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+/v4pmic0WBj/SpJPEDLGz2UwGgoXzG+7vdMt/Op5XZdtIZo8y
	NJgBvrOzxHtCLkCqQh0LVihMYxbPrZ5yqkahyUtqd8GbqSIbWjTQpxsr
X-Gm-Gg: AYBFou3pulo2pnPSCD6J+MLvJ/og57RzqHpBLuVS5HsKaNRv1p/xDyrK0qGDec/Z0nT
	jH2L1g9Yln++MOHPEp1znqOBo1TVHiKKqyN+/OUVS1imc3w+inSL7bAOvG8vQCFhekt7Tt0y4j8
	0SqmovVZ7CROm9NNueZpfHAXZAphS3Eu82yed4KQYzFDvQPW6HIN4Klva583HpSDbLtz94L26E4
	rmFtr9B4tCqNSWINebEg0jGXA2kVb/y4LTOFPM/DuWrqs4lCu1A1jd62hXFKf0xaMVifQr3Y5Rw
	L9nez0BKAusZL4P0Toz5h0KLsBWP6sGLVFfvp8xtVGUC3d3HL8sfv0HIukEvhJLLWCyLsJ9VpDJ
	o5ZTgKEXhrYtyOFTtM3R3lUUGI53mLRNOw7QiRGzu6NJzi07KOhk18jxiLwC84LcD0x+GUFqWJO
	kQ4id6DA+LyDYHK90kPgX5IdKq7Hrlz4hIRf6bD6vV884P7u9dB25TXN2n8ywRfrmQBVpb3i4Cm
	O2x43ZDQimuC0IJ44NdWq9KvP5quzeR2rfG+VJCsSp2INOJiycazBzXiFXmp6ffbWUjsp0BvZ9g
	whS6BI4QWhOB3J2epD3kNYv7AcMoPFTO4n/tCeqjZKK8gETYuk0pwewOHn5jIx3kalU=
X-Received: by 2002:a05:7022:2529:b0:1b4:fa58:9d8 with SMTP id a92af1059eb24-1b5031759b2mr9369895c88.20.1794702451866;
        Sat, 14 Nov 2026 16:27:31 -0800 (PST)
Received: from [192.168.35.43] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b2b5sm16613754c88.1.2026.11.14.16.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 16:27:31 -0800 (PST)
Message-ID: <2771f4fa-5c55-40f2-8105-0d72a715ee3c@gmail.com>
Date: Sun, 15 Nov 2026 09:27:27 +0900
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
Subject: Re: [PATCH v2 2/4] PM / devfreq: Add more details to the
 get_cur_freq() comment
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
 <20260907192140.2701755-3-beanhuo@iokpp.de>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260907192140.2701755-3-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/2026 4:21 AM, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> The comment for ->get_cur_freq() only says that the device should
> provide the frequency at which it is operating. It does not tell the
> driver author which unit to use, what the return value means, or that
> the frequency should be one of @freq_table. These have to be found by
> reading the devfreq core.
> 
> Add these details to the comment.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Reviewed-by: Avri Altman <avri.altman@sandisk.com>
> ---
>  include/linux/devfreq.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index dc1075dc3446..809ef29b9af5 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -90,8 +90,11 @@ struct devfreq_dev_status {
>   *			use this directly. Instead, governors are recommended
>   *			to use devfreq_update_stats() along with
>   *			devfreq.last_status.
> - * @get_cur_freq:	The device should provide the current frequency
> - *			at which it is operating.
> + * @get_cur_freq:	The device should provide the frequency, in Hz, at
> + *			which it is currently operating, and return 0, or a
> + *			negative errno on failure. The frequency should be one
> + *			of @freq_table, as it is used for the transition
> + *			statistics.
>   * @exit:		An optional callback that is called when devfreq
>   *			is removing the devfreq object due to error or
>   *			from devfreq_remove_device() call. If the user

Acked-by: Chanwoo Choi <cw00.choi@samsug.com>

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
