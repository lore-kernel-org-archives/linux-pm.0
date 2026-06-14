Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37B175A9A
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424480; cv=none; b=cmXeqpHbeIHB/a5e4e5lidgIz6ShG7A7FZRjW+RGRYi1juBr3gO5Hu8mdnb7MClko9Pu+zHGyCuVM1lUq8ts/VTsgcF3Fc1c8MGVw7O7EQgYMY8PmeuZ33KelDl7q9w5uZSguuzElMyoyYnmXuJq4Ugy4yb5s7+ly0XAxpb3458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424480; c=relaxed/simple;
	bh=wmKYk6Gjs0lS3A7hVsKyP1CjAZLe8xpw+OSbXMLpST8=;
	h=Content-Type:MIME-Version:Subject:From:To:Date:Message-ID:
	 In-Reply-To:References; b=PiqVtrJiyl6Sw35a7mtsmr+3M1n+9HHa16GBd0waS5vaxtwEcPpNgAwhehwuMjIlZh9S9AkJnhzSXw9+1jQUK+D9z/PeakUGschcj+MGva9j/OMnaZAmoGMvYJQQcYIoMSma/2Rje2ZP2HUISbdIYPFtsupUll+5ZacknTh/6Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVxhY8f9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVxhY8f9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0b9328c4aso17337975ad.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781424478; x=1782029278; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nGDkPVWuAg4BEC+mUEhFq949e3TXYLS9/GEqxI7MmU=;
        b=rVxhY8f99113lwUZYhpef198gsY6fa69e2P//BkoIMuf5eMipU4PY7B9SqojNop1dP
         SasNG7/hRmczYzr3VGGOfoZ7twfxqd5sQGa2SJqyYi4MoPdSdUjp88B8E+SOkoqe0/oY
         5ZP7lCsz+NpbPcNFiC11ONRhJdTAy+fawnXJbCdCh2kOV7Y9rRj99TahIhs1I2C2ODId
         c8JuvgbGnmVe953KWa+4/E3SoC2AY2FSw35fGRlrK7P8IHR8nDCoSzppiDwwfgBG3wnS
         6gNBA6kNppFEMNAQbl+zX1v8X4R8f/CrxK4B451YT5lDIsKdSsz5HD8mKe+lL3D2JZ5D
         peIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781424478; x=1782029278;
        h=references:in-reply-to:message-id:date:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nGDkPVWuAg4BEC+mUEhFq949e3TXYLS9/GEqxI7MmU=;
        b=FkjPoVtOSbw+3BLi2pS0SfR9DFSKfE+4652nQ0aedIk9rOaxDsz1NNhEaFF1tzBoAc
         5ThPNTp/48JJ2MrTHNZrjPq8+ImL5POYTx40TBBa6cw0mMuQuCcJq2dFWspWfBjgbudA
         iqkQ+0CvzaQbv10wbTknNr1c9IBnvDBSWpaX59QbiKrRiquiEC2FaHXtJvBX6+T/u7rF
         klUW6ZFzd+7HjbgLVT7f20WX/9Rj55319nbHMJ/3q4pje/H48yBpoqI3PUocfne/nfCp
         PBnhDwdK+ykSItZsddWqs1mXD94N+AtAjIS2kBY1Zcj6Q59bFWMBn5kb34+2z1ZoV/mF
         Ojeg==
X-Gm-Message-State: AOJu0YzDWujHkrA57F94KVn1tYQWNTcvIpdPfVlsdlFV/ir+wao4sq+b
	0BBJFdmWnE82WYCeZ8hIYpYDvxrzmdm90bCoTFNeU0LzVLNAdFH4LKfX2tC3opG1yZA=
X-Gm-Gg: Acq92OFFQVc6viUX5FBXFuYHqld6gQf8OK46rjItoml/O8A41/HSERSVWlr7UMgv+EZ
	e7JNe0MQrWHJRS3npvIV5Gzk2LsJQgJF4LWjIe+DanbFTdk56srVxnqfnlKVUZ0pTKExJd+Hvu8
	1gnCQEHR2ZfytEXG4AdTqqYR3q7129xeJvkjGoopIKKCKR53txogdHacUvvYQqsTcY/3PyVhdvZ
	AdV1lNrhHgli9IiO6Mk4aDGINlDgggtLZtPD7bXaVNmeNtqX/+m+wAwjGHHMaxgywXTE93xMHtd
	T4exCVVr1CHqTTRXhHZo0tA9VQpxrrsVHx0wn2DZOAXhUc2Qk5IbXRWk4GebDabxCMeYdDjOTd2
	PyjA2RqfgB0IQqc5tICdvdugRDCry19cOJ32tVFoTIEvkfutba5UDj2uCiOhrQcD76q5TOYq9K5
	uJ4l4jcgXkNwdTkhU6
X-Received: by 2002:a05:6300:2285:b0:3b4:813d:dc1 with SMTP id adf61e73a8af0-3b783fc43c8mr9883737637.31.1781424478297;
        Sun, 14 Jun 2026 01:07:58 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866325d156sm5956987a12.13.2026.06.14.01.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:07:57 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v5,2/7] thermal/drivers: airoha: fix copy paste error for sen internal
From: win847@gmail.com
To: linux-pm@vger.kernel.org, ansuelsmth@gmail.com
Date: Sun, 14 Jun 2026 16:07:54 +0800
Message-ID: <178142447404.1922841.4997580458209352509@gmail.com>
In-Reply-To: <20260612000000.2@example.com>
References: <20260612000000.2@example.com>

On [v5,2/7] thermal/drivers: airoha: fix copy paste error for sen internal, Christian Marangi wrote:
> fix copy paste error for sen internal
> 
> [patch content]

Reviewed-by: Wayen Yan <win847@gmail.com>

The fix is correct and matches the expected behavior. The clamp_t should
use 'low' not 'high' for the low trip temperature validation.

This is the same bug I independently identified and submitted as a
separate patch. Happy to review and support this series to get the
fix merged upstream.
