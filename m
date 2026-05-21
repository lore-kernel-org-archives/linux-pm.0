Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E663815DE
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381999; cv=none; b=DXpQ506GWR+O5wQyyBilj1z2ee3EvrOboRC1s7QLdvXieCnnr7ldVG4K3yvNYhDNeZswFpE6fX4vwcTIjmK8pKX/orrBKSbjYWALVz3cfW9XVzcUV4g9Io5CUG7UMzRu6nHtmWHXAbncF0w+H5s7TDwRkkEItmaVEE+1sgj9IzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381999; c=relaxed/simple;
	bh=55HpdrZ1XWqM3uwC+a47+vakAvshOA/Toys7NpGVJzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Num88/U3hTEavpzEraO4amto78Q9+7OgCwDNon4YQS3dP0dAYGbwYmHapJlq6YxUdkUhrFZEczzgLT00TOiR67zaLApKFFnPDaIdRZNZW19q2IIQPnjvRjnvci2I7FUKtH74P+QBOxJHpKp1DYoHHdBd1w8LhVyxrgJTwGcjIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAiFXflX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAiFXflX"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so9530755e9.2
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779381995; x=1779986795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA/nM16UoxaTsk3A7SWQL7q3HkgK647mNtY2rDcRyyc=;
        b=hAiFXflXTEbRl6U5Air/vBGryJ1P7DUwv5y5hFcBfrvyOOjvwLAPWk6boHEMfrP+03
         djrSF/MmhRRc4oKAARffcHojm9lrMfH/yxDwEmaCsT4BFCL3flmfjoZXGq6TFSC3TeHl
         JsiTufiR6et1mz+pI8XV2U+9x+ymMfxMCAW0bX+y+95+67AVxLZvt8B0iLXkU9d/aiqe
         9TLZTYgekPiyf54s88p+J1C3j1Lc4MyofWrYIv5jQC1MQsWTxKDTJulTH9sW3bkKM6Er
         8ENfEnS8Rye+RBlr7U5dk7H7qISkWK2Sz6IRcVfJFcdljcS2gaAHhL/dDTECxI2slWnI
         yang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779381995; x=1779986795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NA/nM16UoxaTsk3A7SWQL7q3HkgK647mNtY2rDcRyyc=;
        b=agpXBWYIgk3xhfVOBfJJtWds7F5QNqRexdj1ER5XyH2Rq80Qv6KH1n2WtwGuLPPe6z
         z4gm9WnJvvc9+7SSwte1sKfYt9gcuR/7aTep7SDm3gGJNtRJzU/KYEO77W/uc4A5XuZq
         +735tqLj3m77veyNhScKPRkg5cPRPMRgL1kg0RKF7z1m8oxHkKueVkZSpmkpmrfF81gX
         PvzoIoMigRkDEzrCzt0Fycf+W1jN1vpxlYtjM/UiA/L6cGi6E9mY6QU2Gy2SUCggEISk
         BtmeUUxKpiqWh3nJxBe4u2tiTu6U23aXeMkX0FVFZ+DMj6BWAlGmd++mG4qMF1R1CUJ8
         EC1A==
X-Forwarded-Encrypted: i=1; AFNElJ9GtAQkTymrHhf6prVl/nvvCtvCV7b9HQ1ZqcDjIitLPscvXszhSBGf854m2b9UP6F8ZAGlL4aWLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWscPvHWEAYJ22y4EF1KmbLl3IXQZgNhjeG7+uUYmTNcW+ssye
	K8ivWEmWzwD9L4VoZny7RE+ZFQzq99hQJXfgJKLTPzJTVuyUq8fnhCV7
X-Gm-Gg: Acq92OFXjIER0qyUfasIreGWNzcGa9+mYgBw5H65C/ansAs0I+abQ6fnbWobnHhyIlD
	3aIdTGnvFAjJ/FhiN3CNJgykaG5ljqPlpPccw8q+3eUfmiAtcVY30wbGoKTn7ZDwRlzAMD+RLs4
	vjzJs13M7SCcx9vlzHE9KJkk80LvyRhJZxzO/Kx4TQpjTYsEDkyZ4EnOOQVKB4gzLs7/osdzzZb
	W/lREq21wuRpXrrr14OH+m2WaiI0RpaNA/Ss2AB9PPfJrMQD2NARRgCTbPT2l4GDJgLfsVITnFm
	jxwxOWIyKGMfYGJewuIzODtnpcCt4XoE3MuIM4H5D+Y82LnJ6v6Nu+r5R1kLTTpHHXjrTKpssAM
	LWNgjZnLdmHtg8C51+THpgsv2Nedap2QeeildwX/ufU3Ia6ema64quUBptT+dEGSM+tiNo2S85G
	HB3pOVdmlCTFslKk8vrOQYfLxJ5FWOX5bhuDNB7XPMl5EUFBNFT90jOvjxKL1Iykpr
X-Received: by 2002:a05:600c:45c6:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-49036033502mr53623425e9.5.1779381994891;
        Thu, 21 May 2026 09:46:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035ecac15sm31613075e9.6.2026.05.21.09.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:46:34 -0700 (PDT)
Date: Thu, 21 May 2026 17:46:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, stable@vger.kernel.org, Petr Pavlu
 <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, Gabriel Somlo
 <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede
 <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jason Baron
 <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, Tiwei Bie
 <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, "David E. Box"
 <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Alexander
 Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry
 Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 01/11] params: bound array element output to the
 caller's page buffer
Message-ID: <20260521174631.71a06440@pumpkin>
In-Reply-To: <20260521133326.2465264-1-kees@kernel.org>
References: <20260521133315.work.845-kees@kernel.org>
	<20260521133326.2465264-1-kees@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 06:33:14 -0700
Kees Cook <kees@kernel.org> wrote:

> From: Pengpeng Hou <pengpeng@iscas.ac.cn>
> 
> param_array_get() appends each element's string representation into the
> shared sysfs page buffer by passing buffer + off to the element getter.
> 
> That works for getters that only write a small bounded string, but
> param_get_charp() and similar helpers format against PAGE_SIZE from the
> pointer they receive. Once off is non-zero, an element getter can
> therefore write past the end of the original sysfs page buffer.
> 
> Collect each element into a temporary PAGE_SIZE buffer first and then
> copy only the remaining space into the caller's page buffer.

Should this be using a 4k buffer on all architectures?
Initially perhaps just using a different name for the constant until
all the associated PAGE_SIZE limits have been removed.

-- David

> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  kernel/params.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 74d620bc2521..752721922a15 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -475,22 +475,36 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
>  static int param_array_get(char *buffer, const struct kernel_param *kp)
>  {
>  	int i, off, ret;
> +	char *elem_buf;
>  	const struct kparam_array *arr = kp->arr;
>  	struct kernel_param p = *kp;
>  
> +	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!elem_buf)
> +		return -ENOMEM;
> +
>  	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
> -		/* Replace \n with comma */
> -		if (i)
> -			buffer[off - 1] = ',';
>  		p.arg = arr->elem + arr->elemsize * i;
>  		check_kparam_locked(p.mod);
> -		ret = arr->ops->get(buffer + off, &p);
> +		ret = arr->ops->get(elem_buf, &p);
>  		if (ret < 0)
> -			return ret;
> +			goto out;
> +		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
> +		if (!ret)
> +			break;
> +		/* Replace the previous element's trailing newline with a comma. */
> +		if (i)
> +			buffer[off - 1] = ',';
> +		memcpy(buffer + off, elem_buf, ret);
>  		off += ret;
> +		if (off == PAGE_SIZE - 1)
> +			break;
>  	}
>  	buffer[off] = '\0';
> -	return off;
> +	ret = off;
> +out:
> +	kfree(elem_buf);
> +	return ret;
>  }
>  
>  static void param_array_free(void *arg)

