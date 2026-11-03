Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736275;
	b=R2RXlaThddvm9muMXZBtI+EjbLvo7832EFwCvhlCGATX1YsFiK61t4iY7+LrqhAWnxdR
	 Kl6eMfDKqD5WXnGuaZbPr/MxFBUu2wncrT8DFjGbSwWilU/Sv4lIEvAgU6jRo+fKnSZSz
	 cjgKYVGTejZZZAlX3kLTN4DJ+Dmk+CYqBVRw67zO5H5j3TZvkOh6KRg/ZRO5WnzwNbc4x
	 0MfZIeLxhFFTF0Lb7upuo3tk9tAMyESTD6TAcaozZw7YS/txdXJ2OKgt1UiOYSNogAgv+
	 afYkB6sKJlMBwNz5tpqPAYbMfx8wvCBWft8OMPAHtYARIafiEanXMgMDJdXkT/7fP9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=go4AIpvhBkoC7ZGd8wKwZdjhT/BPEGzJrSrX2YZDWhc=;
	b=x21K2bZXzZKb+dMlDPbuAjVDOmFxaQgg8Qab5ed9rLXHsVDEx0uxWR1btkcSzQY5UWwT
	 VhUClDtANdWAOv/pRq9Ior7gOhLCX1UjZ2zS5EI5Tjg1KQXRB2Qc+vBPsZr7FFyEizfgn
	 Vx9MeckrGCgI2nBwkX9HLBd57DBxNnkD/olyID93orWKanTXUzVFzPX0IktuSE6n5wDUp
	 guWWJI3tlY2UwTA+SaDAzHLl8mhecTzQdbQdXl8yzn2Co1/MPon9HpXiNsKCGzZvNu4pJ
	 cH2u50o67wOu+wxF2RsVEqIYngLYlcN3bbbeXhJTPJkNnHVSQ/5R8p3mFbrV6iiVURg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MY3vc6Gb;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB1606A330
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 20:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30EB1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MY3vc6Gb
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a18fc7a38so8824256eec.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 12:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793736274; x=1794341074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=go4AIpvhBkoC7ZGd8wKwZdjhT/BPEGzJrSrX2YZDWhc=;
        b=MY3vc6Gbvvfq42ubgxn7ZiALrft/xLB+7RdNtGFpyhdTAWULvE/ASxqtUVijeZaLAG
         pFKwTl7Old40mDX8hTr504VOvLwRmf6WVo0XKxWHImHyLsyuvO5cI1YC7tyUOb9E2Ov4
         ZupY/VOPLYTmU/TSmjc5sIO5R0nqbRrhc3gWtc1PAW4PGvUZRAa5TTXXr/Ol/wguGV04
         /NyrkwL8H+JcKuFKPUwQu2sHRwhVoxKd3+a7lgDpWBVwlzlTOj+u8qnjv3odQL7LHfl6
         id4GY7sKuMug1ts1LrY+1VLRHv5zI9HugBWlvGhAGFXapCIpnKpd9Sz4vKeVcJt7nGUP
         lk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736274; x=1794341074;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=go4AIpvhBkoC7ZGd8wKwZdjhT/BPEGzJrSrX2YZDWhc=;
        b=fte93KmlzU5KuakbJyGKmbmWPV1R1NstfiYxTCtfpABjQx9TQgyg/S+zpQU/H1ekSq
         iaqXCsi5e/vUT/5ZCCXDw48a/aUbxPPPtjBp7M8JSkDLTvHzEyOGT0OnKp+GhLJbhmTN
         4CDsaR0abFGuGAXSNtIu6cQ16MfoJUeKvL523M+kfnjxlEcu523a/3WjdGSe4tr/gLiA
         +Jnm/4+/W+kcHxWoiNgAJFvpANMj98DKvgteHyIhqsfmGZglDFDEc18oqHKrw2gzdjdp
         FtRSMc/30dTEhpTXDgLs3Yaa4978DTGt0+34WlKIqejgAeLDvPWakw7ttVFmA30nBS+A
         TNFg==
X-Forwarded-Encrypted: i=1; AKwUvBwduKih6cbFm+dxDA15hFM5raDBMcGbhg+n+LPL0D55k7TXlXou/KXS1VAbiK0lOsIEi0Izxw2o7g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8J0kiJTzTeeTatx/9CEqCbtDMoYAXmo8jB1+TlULk6uKWNZw1P
	8lpCcgXcCEUgZ15Fh4p4hva8ckNvO8GiGiCWGvDO3W0bcCOCcx3fw2TB
X-Gm-Gg: AYBFou0WW8quWIqD/1jlrba835QWW1adRO1F0uh67ZCzJctLfW7yPPak+9ccVVaMXUf
	u7W+bQWd1OdMvjI3kc9VsBXk/RkMlw77jaRN103GvrYCLWAWfLdBPEjREY21QWefAOMt81RZgHA
	RH9faDNifJ1Ngibih5OJqMuWoUoLu73WcVsIboTEMhCQ2CHbzMyg5RnDITEafyR3ZDHLLcSZihw
	keXxktZdx9UgLNFeeavE1yliwOX/dLbGziYP6++c50j7wDnqiduFVUcOQjmZgDD2V0D3HLkC0XD
	aNH+e7XNMBSaZXZ9oYXJVWJBz+hQTLCNjpzMSzTsFt3vqwjbowURbJApqxD1+JFON+eFyZVvJA5
	2iXsESAcplwAYFz/HIthdg6fenEYW8FjgMF3hqi8eRA1VB4W0P+bn8eFmfYInnW6pDfzr2F/YYA
	ZJZmHKEXhNMZrCumFUmd1oUXhsiK7Sd+HkpkXnY4EJi7iTGlpS//nNpjo5xrfllp9PvqUvK5vrO
	6w1vxYBf2XGoRluLPWl1B+5YSJbAwT7X8DYMhrF4v3qzrVo1EyghLOOLkwseORt1ydQA8y8qWgV
	5BXVRrLwh1lfmSqwM5AN3xrsy1ZulQ3aGaCFFjD2hTomsBgaYCvd8sqJTQs6Ynb83bVS
X-Received: by 2002:a05:7300:824b:b0:36a:1c75:8ca3 with SMTP id 5a478bee46e88-36a4221b3b9mr19658147eec.1.1793736274072;
        Tue, 03 Nov 2026 12:04:34 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm368905eec.9.2026.11.03.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:04:33 -0800 (PST)
Date: Tue, 3 Nov 2026 12:04:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>, 
	Corey Minyard <corey@minyard.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data()
 prototype in writing-clients
Message-ID: <auo-JCn9VES7OwX5@google.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
 <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com>
 <auI4Qq1KUo7YYVtG@zenone.zhora.eu>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auI4Qq1KUo7YYVtG@zenone.zhora.eu>

On Wed, Oct 28, 2026 at 07:00:49PM +0100, Andi Shyti wrote:
> Hi Dmitry,
> 
> On Sat, Oct 24, 2026 at 07:48:42PM -0700, Dmitry Torokhov wrote:
> > Update the prototype of i2c_smbus_read_block_data() in the SMBus
> > protocol function table to include the length parameter.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi, so will you be picking up the patches affecting drivers/i2c?

Thanks.

-- 
Dmitry
