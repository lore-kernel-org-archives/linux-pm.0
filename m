Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FEB36B910
	for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2026 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389977; cv=pass; b=L2BmePbBJ7vfZMax4iTsogMIEPpGPaCEdzguEV2teWhWO8c21Dwjt+C9cLCSy9zBdCdKr2ozU8JOUikotr4O9I3RTAZJMODKsLJkYDWtUppRel/RYHKG6AGq/6Rbz/y0Ljvs+sJeUakBxto18z+uNPeyGepqFMZcmlh9A6XMto4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389977; c=relaxed/simple;
	bh=2MwHIoHjfQgFOXH1q3c7Fke9NA/pcypshND1SuBjvCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1Cgz3i/ldtW4iXFjh9P6tZvTWDKC0XMSaol6+iYcN1BkMW3HiICnufUaEyG+ZvZl3ynoEOQe/NlsnATxdMSN52GL+FMKKxoD0qsH1PESKjcjh4k0sPY8EQBYcZXs4Gun4P0VojXwuvX1qira7SjI9vIOAXuodL7escuF6akGmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Td5S6gB1; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Td5S6gB1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d53197d8b5so18910085ad.3
        for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2026 02:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787389976; cv=none;
        d=google.com; s=arc-20260327;
        b=VtrrfN3ZAG4Fq8g9n2n9WK+ndHbCjLj9Sgi2hR8o1XqA2UdenzhooqDxH4fL5CEXfz
         c9GQ42m7a5Hw5Tov0Dy/yzBkiJJqB19aCCNXDklxMiP5jdCf+8njMwrMSSfWdwkIb7Ee
         EfQwhf+BQrr6FUxIhCYv/B2HrWOBoGYLVkNG9dhmKCalod2ibFlKk14Ie4P4otVKOJUU
         qBMzltF8RB7R0QqCKVk1Sp+MIsWjzS9TZpZV7aMUSpsIm0MYiPVjDxjSTQYp/+uTCIFA
         pKtwXmOkDhDJ0CJdn+GEA7Rk5ScmatkYWL1e1RRd+XRaJrjYHLNlR82L/D+F/+aSXR38
         aVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2MwHIoHjfQgFOXH1q3c7Fke9NA/pcypshND1SuBjvCA=;
        fh=6xRaco8UPQa6n0lGETcjuzUy4waksngIOTOCW7o/y8E=;
        b=YBn59YqzT3FMDDVhqVxaDuL6vryyNuEias7ML+dzRO43zVnDp0ejQM45fcaQr8Lo6r
         /IpInvD9kuj9Q7wcrgHb5r0+yIf3ohacpOmSxYiiLmB8BuJik9lojKEXKtCAVEWn6DB2
         qURKq/wio0jy1p7Yug5oTNUXd2qaBa3wYGQA7hlVhiK1W31Pkj262yEih0DFt8OTv+Lv
         bdnpY/x6JFkjerub3lsB4Dt2tGhEx6XPAs4bz+GwmMSA6Koff76xfoB2rHv/9A9Z1sxw
         3XWrlN+4VbAqux3/b9d9eu6x8ASUWCqEbdhvmTLJeQK1szL0KsWU/slE4jxMHuzkoGqV
         Ho0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787389976; x=1787994776; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2MwHIoHjfQgFOXH1q3c7Fke9NA/pcypshND1SuBjvCA=;
        b=Td5S6gB1its1QHuLe38gfny8OwhP1U1Bdx/7Dv9rbzYSDynpQlnVeRyBMLKxHjZJdu
         oUk4BuBTVJqUXWhdDtUnJLm2Sy37Nldn+UFTm6LSGCa8eCrklesC1uh4vycE7WeRKigp
         5QTH5kMvimTYdn1rL+vGYB4dSRkv4E1xbg39SSDLJd0wHHfaxmVpFTuSNwtm/CFHRqcX
         m8EIJagb2/hnp+kFPLLcJSbqwzakLRHKt+g4Mv+5yjx07zfXZUBg95/L16fpPQKUnRpe
         YgV6zJHgmCizclxxQhF/jJw2O+vjqSAGcDS13U4GgtE3xGE870+z4rdVWUy81TXXy8nV
         mkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787389976; x=1787994776;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2MwHIoHjfQgFOXH1q3c7Fke9NA/pcypshND1SuBjvCA=;
        b=Tjql/KZCEWhlDDYc6MwOm3bD29aL1Tr6WVvKGEtWdUgC4g/mFBEQ0SrI0ODrj5GGrm
         WYZSHIbaQsll7r8KxWPuGXW9tUtGrkuypJKICt57agRQlO4Ke1FMRzjrWY6pIrY2RWrl
         tYVNrv1nOYVoS+7Rd7oK4JzvFxonnER6qkfxWv3skAbWe7e2UH/Bku8yml4xfR6SB7kU
         bTj+xCwMj7u9ZJq1XqOa0pez0i9G5cBdwO8Y6Ve2DhDGaFXPWhaKAspiU/wfBIu+IvS4
         FgEzhAFiiUcG0yKMkxa75MM0rEVVGC+ZASlj/XDTBkSduBPquarpPhLKe+5Ibr4NbTRt
         x1FA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7QoQ1hNX0MPzhc3LpO7LzPHJU5c5SmrxtgWtlzRad9ktYQadHAGdWGL60aQK3JodFEGv6yh3Ajg==@vger.kernel.org
X-Gm-Message-State: AFuF++mPVZL4hxJecMTrgtuoXBjR/FOc/10inTnu3F5WYe6VjLHTMfpg
	VB2LmRYCsurcsNJ31E/WWDhNgm+Mf0agqe8kLyNjADYjiqoSUC1IVGbM+tq8WJIbzOabIRhOZfJ
	Ol1VoJX2hWFGyCUE9keSf60P6XzE7FLs=
X-Gm-Gg: AR+sD11Vylh5D0tUZpqJWuNZvBAS7xKq/1LWQLFbJqYE09Msol+9jGlrDnE4EcnnoOE
	usgl22UGw9amev3z84XSxs9/Xr1of8C0V7u/uDKyVWu6e1rjZV1eEgxb66BmaCDJBP3OwKvqzV9
	HVWwFY++yQF6GmXZ+++vtdHS9ifcBnKyX1snRqGxLa7nrEAmFUVLMQtQLM5kdC21W7+7LrjQwgs
	j/nzVnRuKJDHrkmEY2Yc+Fqm9t0TLj38jokPqpCjgHos02qmYayv45ZiQOc9ASzGEts6vjSagxh
	auQnp2dZRpaebFjb/EqvlAQufUzQYfkep+qjwdZ7TNYfG21jonsr/WKAlMXiohujiQuDbq9L+jw
	G2t6cCJwhl5L5xSBZxFF5EDQr8XnZWz390DtlGhvjGKwnvBimNkSN7KJ4XOZtC333pHaiJMZ3wh
	m8KaN8/yg8iWFfhg==
X-Received: by 2002:a17:903:354b:b0:2d3:2e86:647a with SMTP id
 d9443c01a7336-2d64af6f896mr239987105ad.5.1787389975945; Sat, 22 Aug 2026
 02:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812042842.15209-1-phucduc.bui@gmail.com> <20260812042842.15209-2-phucduc.bui@gmail.com>
 <d62e3e3d-9639-4f11-a9f1-460d300c2ac0@oss.qualcomm.com>
In-Reply-To: <d62e3e3d-9639-4f11-a9f1-460d300c2ac0@oss.qualcomm.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sat, 22 Aug 2026 16:12:44 +0700
X-Gm-Features: AcwNN1WymSu3M-4thaXX2g8igzJ8ORKE90IN_Y9QZEBt6T109X5SSm7wsMyE3vI
Message-ID: <CAABR9nHGbJ3iNvMZFG2bKV029OWWLQnJSNt3+Da3EgTraT0WhQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: hwmon: Remove redundant OOM message
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, rafael@kernel.org, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rafael and Daniel,

Thanks for your reviews and Acks.

Best regards,
Phuc
