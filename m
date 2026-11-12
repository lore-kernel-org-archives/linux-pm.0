Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492397;
	b=nBp/HEMmp2h2gEyu1uANH8q0uULs72q3Lrlyz21sxWqV77uqO05kTafq7aBrKU0XDTEs
	 FHz/GA9uF4DsLd78lJJQ+IOxxvFqC04ns1VYFawOOOiqn5DP/ToZYKrYe++nLJ/ACK2pK
	 GVvphEDerHVk0dkbeIShKw9Ax4qtvVdk2Pb5T/tSNf3L2DQLhtFYIUCb/2SQJDb/hPeEv
	 oEnvss0wrjM/0c4AaoiAarHzcEf++2rONq5ZcUJQg/wVbAjkYpXOxwb5fT0MGQHoHxqWp
	 YyaKFNsXnHdS6IDjhUICc+EMmESBYKmrkwKcIwhIUA8JReE3F8cHfmHG7uEUNfH0UMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LXIm36iFMZ8kOBujPBh4eH/qjfWvYnVfBxH0cH6iwsM=;
	b=4czsrrED8CFzlnTNctSdf82KJ76KI6VqTuA/U139oZa/2Pmxsj9oJalMSo9qj1MWzNTj
	 JP/x2CzosBsWAykaRDlZfLflcsVT/lIaHmwRZnLlQi6YoNE/O6kVMmXk27IOzjNmFWqxS
	 odGdjhFyw6bvEhdhtH/JOkwbeV/YOwSZ+UnvLZv/rq8TzeFZYIi+nXzTADePMvVREwVhF
	 Fwekf+kgDxTn+kv+2yOX8fCEPgwzsLsOshSNWCvpl5NpfW/ZyFKCPJV6aTvmPjdCOsBEw
	 0cHYUFumQ/5TeDogy/l5t9/w1/zRH+wG/CjxtWm2eCPMBwg7vsyXHaseTxve7Ry4b1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ0O8ptU;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B860A262A
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 324B860A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ0O8ptU
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c505186727fso436715966b.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794492396; x=1795097196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LXIm36iFMZ8kOBujPBh4eH/qjfWvYnVfBxH0cH6iwsM=;
        b=iJ0O8ptUFgqzUF0HS2nnVTaNoVhPcmUF74R8wDy41neP7vq8HMRXJc7K5zqFIyWN50
         OQ2Kui+CINP4jSWel6CZfma+s5yUJ+g0EH99NZ3Zvfld8OwRHv88d2jr1L/vA3RSM74J
         HPRGuwMFgZ4DHsxcYpPV1O/i31el9yT2KWGfyqtInfS9sidP7NwZ60CxiXUOCROqoaka
         Dbs35OKCAs+OEVnFzQb2wsESoXa2IW/ATT6rBkW+P+HhV76RoMgrIgmiMR5kdb1KUQN+
         fmR3iGk+RPAT7sBQAKFNlKkqseCiRLmBwx64KRd2OABz+/XaX/jJSLMVvxItD5VFNZyW
         6qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492396; x=1795097196;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LXIm36iFMZ8kOBujPBh4eH/qjfWvYnVfBxH0cH6iwsM=;
        b=vFOyV7S7uVWw3KZACqIYoYBqiufCqlGW/B6roEuW23zpiYdceeQDId1XtgT/JHHH05
         UdZfFiIlrPUpX1UvTrVtfS4VEmouVOcMohVa3Jp+4UPxjNtR5c/l9PIZ0U3XrgryuRnu
         RDZZR9H6SgabELiQJx2FVM/1vca23YJe6LgSU4BnJSNW3CsdImbBWuhMj457mIFbqC3B
         QTJ9Leroy78zZ//eLrnfnlTUMBBmA2ezlTTXxnPoBz4L24axbmgkJ0xjrPCksV9VqXS+
         +UgSUcFPPPfKgn29Rw/H1vYsSCuYrGJTi4v/TFgQ7K8fJhFBzB6hkuOFcf4jF0/agq3E
         5nSA==
X-Forwarded-Encrypted: i=1; AL+hErHqyQINEmJlf7zsY3zU8eBIRkD+f8NyCi+Z/U0TESxjhiDCf3OJAx9N8UmevU3+eoKittcOUX2Vpg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/vnWHHrbLsIXi537XpZNqN47lmOaVVGqL8tBAwUBYiABjOc9g0
	jwagNieswJRhZDodF5UsMPWsgcg54hH9TC9M8rUksuFB+7cqdj/+ty5N
X-Gm-Gg: AYBFou0VI1tmdaOX6ecMb79yfKOefX2SfIpKkpwejLQy6xSj//8nPsjRJLiVwmX2NQw
	do/qCmOWBKSqfziuHxKVtskbmzTeryh1hvaHWnxgekLrzoLiJcjbijCYI0eJizBO3oqNdT9xsfL
	CMWkKeJp69Vl7RiraTkathiblf+CmOUaEafuiEvr0tfzkJLLGDllf2mbOLyEBNqNNVhxP6zrBlT
	RZ4NbWGjhLs4aLkDEC9FHqDUFsgs+rY88dkzIKSWYxlLfFCZTNUG5jp4DLYVwZrUGJxu0KipaXf
	UoNqFdH4tKVdC3sH84c4G859MQP8/7un3LBltezHj9uW2ZTAvqDcXg5BO6EJwfgZGC6VIk82ZgN
	6OA2mrKYIms8ceh1fDMpNkrXlanTIxs6m6xNtC6QFtKtv0oHDQcUw/oiEGXqCknZ4jfCna0aWUw
	caXhmNZ0qVi/vYcMKv3oVQ05zV2yH9iw+l9lglGby8RFyUaKuX1tZc0zVyWsRjEui2ZVTyEaUuA
	SNUDsG2asZwF74pjW5i3/FcKTPyxSEH1g7Gxo4XDeEIoPbKOm41mTtHZDkvJlhLjHx6XvgUxtK0
	jHCW/DlZq5pqhjjbiftXTMFcg+qtj342vMhZ2D5zX9U7bh0JLfsd+IkMbp+1SzpCXNiVMoxLRjn
	AfwsImGSzCYIa7g5Yx7onvzFdMVfaPBj0ul4352suc79ZPYaLfP15PsN0TbBC2Z53TPYEYjfZhs
	pXix/UbYvjuBrgEum0hIXJn4OSYhXUZU+eBIOFx7nYI9g+dfJNt27mKGdayiTEt1JxjL24psa3i
	e4XjyeMQWcheQ==
X-Received: by 2002:a17:907:1b1d:b0:c4d:31c5:e30 with SMTP id a640c23a62f3a-c5066d3db13mr442488966b.49.1794492395421;
        Thu, 12 Nov 2026 06:06:35 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a593b5esm363017266b.34.2026.11.12.06.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:06:34 -0800 (PST)
Message-ID: <c1af6845-bfa6-480d-a240-7b918331234f@gmail.com>
Date: Thu, 12 Nov 2026 15:06:33 +0100
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
Subject: Re: [PATCH v2 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
To: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Ian Kent <raven@themaw.net>,
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
 Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
 autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
References: <cover.1793715774.git.krystianmkaniewski@gmail.com>
 <c943b8e768ef766b0f6563b6085e99fe@kernel.org>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <c943b8e768ef766b0f6563b6085e99fe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 16:51, Tejun Heo wrote:
> Hello, Krystian.
> 
> On Tue, Nov 03, 2026 at 03:57:41PM +0100, Krystian Kaniewski wrote:
>> Patch 1 adds SYSFS_LOOKUP and kernfs_ops->may_lookup. Writable opens of a
>> marked file refuse both splice directions. Their of->mutex and seq_file lock
>> use separate classes. Read-only opens retain splice support.
> 
> Can we be explicit and name the flag after what it does, e.g.
> SYSFS_NO_SPLICE and kernfs_ops->no_splice?
> 

Yes, that is clearer. I renamed the flag to SYSFS_NO_SPLICE and the
kernfs_ops member to no_splice in v3.

>> The new property cannot be combined with mmap or preallocated buffers.
>> Kernfs rejects those combinations for direct callers, and sysfs rejects
>> SYSFS_LOOKUP together with SYSFS_PREALLOC before selecting operations.
>> Binary attributes do not support SYSFS_LOOKUP and reject it at creation.
> 
> Can we keep the rest minimal? With /sys/power/resume the only user, I don't
> think things like the mmap and prealloc combination checks or the binary
> attribute rejections are needed.
> 
> Thanks.
> 
> --
> tejun

Agreed. I dropped the mmap and prealloc combination checks and the binary
attribute rejections. /sys/power/resume remains the only user.

I'll send v3 shortly with these changes.

Thanks,
-- 
Krystian Kaniewski
