Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C4175A9A
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424561; cv=none; b=A8XpF0ErHIVZS8w93n5uT45MLx2jsLY8Rb5Y/fmrOo//uZKYe/TnXQPFwItLqZTrC/zSr2CCwcJAT1PTneJeXCYE8LsuRwHEjCfa58FxzsAszgd5M1pUHHluvVfuIr+mH6yIDasZUYeXV0IWpG6b49zfdZjXEK3kAixzpq2013g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424561; c=relaxed/simple;
	bh=aA3VIuX6BOzmmpiRVrc3KrcxVmbodMVV6bDPEZ71N+M=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References; b=Ruvc05l3YXwkwVUfByyGeODUX5G+UUekVNF0Gq9tmMmfGYRPt1XIMCdreHN6gJcIhvZ4NB29K5hnxIHPkMw20iNWqQAqLeIdszwkxfgWm0ZCAi9/siTzIHo8pa1kjjCFPp1o3rlppZhtDKp2vWnsKr/xuu3dnXtIkQScdErV0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sb5veBpD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sb5veBpD"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8423f626a65so1047880b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 01:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781424560; x=1782029360; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jotXFPC9WjIw7ToHYuo4aMTV4jRchVzBk3P9AAxsxM=;
        b=sb5veBpDP9sZnau30BSLwiUI2+oNyh3Ok/LCsEiCbij5yuK3Zs+rljuZLDdpyWwMEO
         SxurYDuqvGv9A8n5WzVlITSjW00tW8xCbAldSvnPq9xcQ1hQQdw4wxUN91baUW69PXtY
         zYXTtreF9Z/94NIr80gPl8zfp38TJhE2/+bVDcl0mQM5OXMpwmKw25B+lZcxv/d6ILRk
         9FS4akmMsKvTR4lsgkkwsmPcHrRuHmOnfudsNCS5Vp8h8sR5UtlAudxiJ4drN6DqsGjh
         rcHS/qWJugoX1/sRI7PrhHgZJGlv6DIoLw3Vt3Khc1uYl5eSKgyQ4YBgkiGtIuia+MxG
         01FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781424560; x=1782029360;
        h=references:in-reply-to:message-id:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jotXFPC9WjIw7ToHYuo4aMTV4jRchVzBk3P9AAxsxM=;
        b=DrElPcmVoCxDUT25TNSEmUxcEfdifCQQ0XF9Uz//LBk65uDSgnkywrzZJpArjdmiHL
         IO+lFVrCqTsjyliAKBLBde8jd9Mc2v9gZfv7OEYcM58MBDNJG6zEmomEX6R85BTpiRZB
         T9tGg3UVWJ2DC6YvGsXkJWmiwv1WSQeEzc6qT7hwjKChyX+AZwqxankLxC7Yi740Dddk
         +Rim2vhjfzQ5Oru9GgJunvjaYsun3pJ4Bp7gbcQJwU+LG9viWjoWfbUxP7SHzHvRTYqZ
         GEvmt96adEC5h6qrSPiiK3wgahiaDn0c3HlY9gUJRgwamcbOvrZpGYg9PKaxMzT8x1ni
         /j2Q==
X-Gm-Message-State: AOJu0YyRFh15mW31EiukrDhgftUue/Zkdpo3HP1u2Yg/koJ/A2/TwBk0
	mK5hUp3+UvtGBcVcxIz7VSikhrmvRCGCvbyEq5jsYZJk7HTxUzbNxC8CvRZa3D3RjjM=
X-Gm-Gg: Acq92OGROEmuJj7VHTrJWx+xiPWxVG7YefExl5j2594gQbhZBIhkxMsqdXBlztqEsCb
	CUh7Djw3vWgoBNoT3ehwcETTEwhJIZ4rr/9lU1tU0J5sGX+4u+Zp00u6RmxWUsh6JnXHImMDWTw
	x7SErj1pttw1j9x7xWrDRXCliTtmocNcLu55MY6Bwe3jcC0og+D0oOT+IVb0uHoV/crZjxO7a0V
	NoIq3OEfpNdRgqbCQdgP60XYsfeWuEmn4sQXo0eceTiRpophWIpTPbnMrMYg/Y1wQvODpYlvitU
	2OLJIfMw/Rtt+V9aqTkXCsqz9IQjcn8c6eo4thoMQVzbXVro/If36WdiaZcdUTnCktOMHtQxaoT
	UY6yUuiWxtDj1pgX4+ZV33Gz8KMGlEhwhcSEwu3iiO1rmaljcBwLTbGZIE6pqk2oP1sEas3JcKn
	JVgX3veFy6xBXXVbFj
X-Received: by 2002:a05:6a00:4b55:b0:842:6fec:12aa with SMTP id d2e1a72fcca58-8434cb0ab17mr10442677b3a.8.1781424559751;
        Sun, 14 Jun 2026 01:09:19 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9dc87sm6241236b3a.4.2026.06.14.01.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:09:19 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: thermal/drivers/airoha: Fix FIELD_PREP using wrong mask for sensor interval
From: win847@gmail.com
To: linux-pm@vger.kernel.org
Cc: ansuelsmth@gmail.com
Date: Sun, 14 Jun 2026 16:09:15 +0800
Message-ID: <178142455566.1922887.5580162599683885676@gmail.com>
In-Reply-To: <6a2df293.6b2684af.263065.81b4@mx.google.com>
References: <6a2df293.6b2684af.263065.81b4@mx.google.com>

Christian Marangi has submitted the same fix in his AN7583 thermal
series v5 [1/7] and [2/7]:

  https://lore.kernel.org/linux-pm/20260520155525.22239-2-ansuelsmth@gmail.com/
  https://lore.kernel.org/linux-pm/20260520155525.22239-3-ansuelsmth@gmail.com/

I have reviewed his patches and provided Reviewed-by tags. Since his
series includes these fixes along with additional AN7583 support,
please merge his series instead. This patch can be marked as
superseded.

Reviewed-by: Wayen Yan <win847@gmail.com> (for the matching fix in the AN7583 series)
