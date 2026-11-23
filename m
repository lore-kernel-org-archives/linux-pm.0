Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416476;
	b=dbFgPfjG4VuUbDJP3otmICFMk41pJdWBwtC3O3+HMUO3NBZcrJyzYs4Jgf5Z8SyoL7RE
	 TdBNx5rjIdlJQ4rKbjt8tXOmb87wNv7mpFkjGTTn75P/9H6Wb0ifvGrOMGNxRR5AQ5E/Z
	 EjQ4lR+J5/7ppeY9aQWWywMNOQtGGUsq58GW669df7KshQ25AOZqtDOsAl+LxkW8NDyfL
	 Naf9+KaeFDauWi5gycaEZTPpQgyD0DdooVCCnRde2xFaPo/fC0N5i+0pIfaiukP/rFqDp
	 uGnXCMXuL6bPkOIMEbGVc7WTb7jy1VuTAb9wIIRNlLXquH198MU1qawCUpFdyc7O47g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=MpdWRQGt7FrCuyLLRBTmUxjIIESLmxZZy2MLy3uKw7k=;
	b=LmOeQdKtWl4LCJG7tsQRNKRR8t8JU7lDsqsmgHXJwSzO/mdia2wQAkPk9gbnYY+oWoSy
	 jme91S+QCJfoSB9pwZCWwKfWkEqFzwvzDHEnWFy+tUCpR8hIJptqRwFn36hvKgC56eMWR
	 I7Z61kOzTRzNqtLJVYLuAsGaq/BeOQu4lsvgGGOu5b0uEl0gTlQxTRyE+gVIucmTfJFbZ
	 +P2brBINcz0RdI7ErlDz1aySAesZrBPxaXa7oLOA4BBnBu9NABDa5jLT7iURY8qHT05We
	 /TzR9MKyawMgScDhmQM/QQLWVT71qv3fEb7zFegZT1cRq9eNGiU7T/31kKkyZ6a22qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sui00Ob7;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4DBFF606A327
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 06:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DBFF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sui00Ob7
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b271e573adso1201580b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 22:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416475; x=1796021275; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MpdWRQGt7FrCuyLLRBTmUxjIIESLmxZZy2MLy3uKw7k=;
        b=sui00Ob749YP/4E0URw2ubSzDUQP9KyBjfsmmDw9AzxIDxTYS6M49S1JibeFvPEBVc
         qxmPMlLkjqeHtjjaN7HvIH7fHwsh4z3btvPa519DONCM3a8F31p3NAmeMGSbIBAqhVXw
         5txmr4OBG91xAg91dxl180zBYNgs2sAiXvTgDE7cFJeajijmCEsby493dgeu2NU9qZIe
         AOvHl8i6VREYiO1AJs8bd9Y+u3Wd8mtajSfG6AMj9CMP8bF0uqYgd4Y9TA7w5AXW8uDK
         YQ+QuR6/yknUWT84taqMCfSyX7b6XxC7IIgRv2PGwskSgwLDtlasV+5SLJy7c7g+qSd2
         P3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416476; x=1796021276;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MpdWRQGt7FrCuyLLRBTmUxjIIESLmxZZy2MLy3uKw7k=;
        b=vozFMXw4jz5dJy6GfZ/yfUvgSkX3l+oNatPRPRc+clzLNBbL/SL57p/eumZ6mRTvds
         jniDE2BmbFH5VW9Xu6TbO1pZerIzErc5BaPlxUOV+y0BTvETIN7bthBdKP9AtyF8VK0k
         1+ccHbAuD7wYP7kH3xAt0GOPLfe3yr1l6ncDyIcYtfSIkGXYMokMZuyaznxGKb6VLQ/M
         LE37wxWuxz8yON41fupVVTQR/PghbSvD6Q17BqaxKgoWO+DN7j/lsScYQeRuPsBKs4zw
         c5LnWsm0Ce/Av2nBtb0oSihDQf0OwAhERj3i4+laqjxfJBtIho7v+0jNdk8Y2lrwhBde
         uiMg==
X-Forwarded-Encrypted: i=1; AL+hErHrLZfYA9wIiCoRiylOstUnv0N3MY3+DwCcimM2cr5qFoGPqIMm57WTx95NCPfDqNNil/ahSAOgHw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+7VunICGiAS7UjIHXiNMQ0nQdRAAL0vX/i4eWnlER7kqz5Lgk1
	DeUNcEA4M6VvhSu8qb1BTc4Mqmph9oITrCnRpU2cAZcYz5RQ2YjUPK+xFR8vAnrD
X-Gm-Gg: AZFdTZdgQkL5oFo74c4GaYqX9MpPfsuCp3aPzXcV6eWfLF0Q0Wka8I7K0Lbagvq/dnK
	7pAJwp6V4G1QaL5IY8MoBv7RuIW5mVbN2i7Oxhi+NkyfwGWp1ZFlOExjbBPK5s1j74/sJ/cfR+t
	Y+GrS12TlTrlJ9G0u74Xowee5RHF5A9z2KGR3WnEuK2sOzdp+Gpu8eU9wbtgCQqkc4IZ2hxg/Wc
	pP6t+AxPyWN7/6A1Z2J9Bp23zjO91j7JL3Ep29mHkfb/0OQOTVnjdK/z+LM568TN0MKSSI1RDii
	LBAql59IwJtLvVOYE/6Edp2TMtvg8tlj6WaBkHahnU7mb+RDhC/vsT/JYg6+T70hjlj4aJ2tqr6
	25ZeoW6TVBR+HCQdOIH8a81OfSRv+igqPP9RcuFu197AQOeR3U+s3otDUcxh+2LBNU09tSUnSBF
	+8MCw97tCQpGcJF41QC+OyK/P6iTIkXEOuzB6EUUO5+HtKlmxjDCn+xD8VY04Cn0tA/MkxSF/if
	rjWMQFl3SVzLnDAGe7Hgf6yTaO8ztzWTIkNoT+EvSZpc8JhdN+HciYZX8ItgClrfntH4DIr5vPs
	tZR3BuCLYSE5ujad95knYG/7YwdCNvHW7wr79XvVyQvaCPVvr1mrtkdqbIZK3v4NTOQ4Iw==
X-Received: by 2002:a05:6a00:2196:b0:878:3538:8f77 with SMTP id d2e1a72fcca58-8c87c6701c8mr9415691b3a.37.1795416475541;
        Sun, 22 Nov 2026 22:47:55 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077fe3fsm5152686b3a.4.2026.11.22.22.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:47:54 -0800 (PST)
Date: Sun, 22 Nov 2026 22:47:54 -0800
Message-ID: <5ec374e9acccdbb5422291d106bd9ea9@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data() prototype in writing-clients
In-Reply-To: <auo-JCn9VES7OwX5@google.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com> <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com> <auI4Qq1KUo7YYVtG@zenone.zhora.eu> <auo-JCn9VES7OwX5@google.com>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andi,

On Tue, Nov 03, 2026 at 12:04:29PM -0800, Dmitry Torokhov wrote:
> On Wed, Oct 28, 2026 at 07:00:49PM +0100, Andi Shyti wrote:
> > On Sat, Oct 24, 2026 at 07:48:42PM -0700, Dmitry Torokhov wrote:
> > > Update the prototype of i2c_smbus_read_block_data() in the SMBus
> > > protocol function table to include the length parameter.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
>
> Andi, so will you be picking up the patches affecting drivers/i2c?

Gentle ping on patches 1/8 and 2/8. Will you be applying them to the i2c
tree, or do you expect me to queue them through my tree?

Thanks.

-- 
Dmitry
