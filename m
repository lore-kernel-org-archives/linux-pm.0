Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1242D0606
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610802; cv=none; b=LEl6O6YMrRmsgNvEeEygkURgFmgVMSSxibdttlT2cvdBu6nt+SxIfgvSdfBI4KM9mSl0TRaunL9ISbsd5byEi8wnXCqnZkMYCzR4asMK3MPhpT3JR2T9xi0j7jXTioWTuCBmYE7isssRQDd/KM3n4dSNlYkBwt3gEFeOUzAD8dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610802; c=relaxed/simple;
	bh=rPBgT6zICytJjVXVoxD3lPyWMwSc+0d1+060L/nNI1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJeDUoxzELeZoeaZk/LzxbItKCZ7nU9kI5uFDIGFgbZrhzfeVwasatIFE18JyG80II3OdPL4W/V2f3Ur3Pz/aa0Gja2VVEjO5HA+QnfVyTqVhKoBjZYolbppULpXdZceKiRbcw39LtG+aznzZ7osH9q7JhEelazgj6cMljZ69C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECmAIY5v; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECmAIY5v"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f30a4601bbso6309027eec.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778610800; x=1779215600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HS4Zrl6GAlNhNQKYM3MZ1UClFI+aLaMtRMq5Dn7VS4c=;
        b=ECmAIY5viaskWIatkOLp32o9I8IHgYODDXUVoMEtpZw/abGgZWq+6i10PE0yNk2Mcg
         22js+WRJiXN1qeMjSgRtU4sNDnzXsNutyQPBRhrlgVSD/f3h6dMT344Kj33I0MSJVJ2d
         z6OldcQpKlVkUmLYc5qdFe6TcEWxwYxkG+qoJ5bvT42Lkc/2i9cCMqSLtUJbr4vUJZ61
         mis1W+8WfMIXtz/JfozLeTcUaWnaNYLSc617mqJI53Ug0pSVU86W5RWa7/Ex0VT48W/O
         QuAt+h19fqwYS4Y6M9m2z8w3Yeceocja0QXVxFV2Zcbqs3LLb2mC8wEyo7tYQxD/jeEd
         M0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610800; x=1779215600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HS4Zrl6GAlNhNQKYM3MZ1UClFI+aLaMtRMq5Dn7VS4c=;
        b=JrMwLYneg1PM86YTxCYEakkDA63k/I2NsYYsPEqHw3D+M+0/pILoVS+FZVB1BrKaTa
         UOmEUKt9ILggcU/I4XPK0jjuzgj9YVI3m9I0C8cQfwBTZdCrRFiwcZEyOxGUOa7aLKKV
         jCbpmYkinNTeaVMn1r3kds4APqiMmzn5D/zXxI+mHvpIjcTJrXXPp9I0qSBUGBwqcvRS
         Nc8ytt4F2XQN4dVX74U/QT5N7lXN6NmyiEB9dGtAbvs2ogLZY6lbwnxMpWt0mnqTeVgW
         UkyBNliH1r4O5ObiOk9A8N33j+U9tAkcu4QkEV9vyG/2G4EOfvb4zijkJa7Bkeq3ahNT
         XgHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nWL3AhKXSfM0SuW3XmL88O0flRFtH0lrO7Y0Oz6Eh8AuWsGStyVm1fToRbhM0ol/edBB1Bi5HSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YztiT36gXY+q/C2liEZPGdd9zck4XiufSUYRsmnW9CuVSFD+Bq2
	q/p9PaqR6fDrM7isi0kfTuXAnNrvoBS/l/sFPf35SGX00oaC8ejlRIkLzSDZbQ==
X-Gm-Gg: Acq92OGh3pG/6cq/0SnJDUZGWyKmogPj6kgFPrxKC0nn6wK8fqj4gCTFlWb0U3AVjvo
	GOF9leaC1D/AqXDLeTRI0V/HRzPY0r1cAmvwHFp/toUa6OLlc15YZuXPUXAe4bGJk9tsj63rJTN
	gs2vv0ImQuV7dq/p+AoaeR0ZopcRq5zuy+z/+LOO9wkGKSutUohmb/vop3wl66Snvr6VsOYyhfH
	pLaEXSPX4ZFAiofv5Plb1K3xEXyIdwYd098oNgU4DUVSd7ezCQmSvpuk+IS0CcVT5wnZrMk21/H
	OIAG8jWjhHu5vuzYPbmOHMiAaFyUOoSP8xA3IR8jn1fqvv+Cy1BD6TGYsZnPQmUmCuchYl+1L4V
	PC+Bov9WXTnzTjQEHKwdJmJuW19KW7Sy5SxjRXvOIaZowy3qIVnzMUuPj8r3dSiYpxs8wCvOc0g
	jQPJXUAKXXydhfVRfBfG8Rl+S+1/ibOky6izENIM62uWLesSE=
X-Received: by 2002:a05:693c:2b16:b0:2f2:6dde:df50 with SMTP id 5a478bee46e88-3011a26becbmr141449eec.17.1778610800355;
        Tue, 12 May 2026 11:33:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm19526286eec.2.2026.05.12.11.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:33:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 12 May 2026 11:33:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [PATCH v1] hwmon: (asus_atk0110) Check ACPI_COMPANION() against
 NULL
Message-ID: <e03e617a-d748-45f6-acb3-ef4f75fa17a6@roeck-us.net>
References: <2261594.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2261594.irdbgypaU6@rafael.j.wysocki>

On Mon, May 11, 2026 at 09:56:14PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_HANDLE() check against NULL to the
> asus_atk0110 hwmon driver.
> 
> Fixes: ee1752590733 ("hwmon: (asus_atk0110) Convert ACPI driver to a platform one")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied.

Thanks,
Guenter
