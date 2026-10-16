Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09957335564
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158611; cv=none; b=Sg4n4DaH8OIKjzDhYRS7qy7jTfhct12PwyfFvDPMr3nWA5aM+roKKMs0dG5zkyL8dWv0nHJwglWt22lRvhw8/ZVoTmQzEw0kQhwr6pSuvxp772WzHkD2OQpjhXtT8j28PIufQ10XiNEzHYFoLiMaGuV+R9q2Z7441Ut9pLO8kkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158611; c=relaxed/simple;
	bh=g7n5KSyB9dHuwa9DCb0qOHcMvX3fr1aRdEPuf9O8HZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KX13hvAASDkDdCJw/8e1gBolrE/FZojgQ1BU3nW7aHzVitRIzRSHlztyOOje5+9A6pgs7yWRkMqOEhoO0TL0lITRAAYPSBpRNauyh4dUi/3rtgjsad3ztFLntg9GMdnQ0yUlNYhBJK1oF06EL13AojOoqSC0uHZ8vTG11iXtnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCZPubhC; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCZPubhC"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so2409073a12.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792158609; x=1792763409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g7n5KSyB9dHuwa9DCb0qOHcMvX3fr1aRdEPuf9O8HZw=;
        b=sCZPubhCeOlv/2DS7gdZSmF21zPP7UFQ/DWzqGypU/ZJc6n4MNrLVK+MbKMC7AEVB0
         lfirfod0qavHSpmCh8V2DIJ2LLpl0o6Xke8rBdnnNpbnk3Hq9/jfa5593wmGsjlk+u3F
         36ckpoFeIWLj8Z1CMv+QmvoXGWAlxgLvUXBFn1ngFsoDKMWcJr11szevXa5nqsIG6HfZ
         avIw8ehCmjeMOnUb7Cx6nxc3f2xZh0reYpDYU24Hbc9kjF8460tv0uQ7A6GkCmVVeFqR
         nPoeFkEnRyIZgJ9e/v9OzTEyJj558iHHGdivOmekOrvXvpLTpFNcoBfEErqruObIrFaq
         4DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158609; x=1792763409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g7n5KSyB9dHuwa9DCb0qOHcMvX3fr1aRdEPuf9O8HZw=;
        b=h5GpnPxav7OCVcGK0OkgQqToBYlzTMZ1siI7g9ffMVCQOOaq7miZpsr+Bmbp28gvkg
         uMsYOuZhT4f1UYBJXJRYvbxbn1L4/5uTQM9DFzS2LeVnRQIhEeHzBe4TMOn660fmwr7a
         /ow/j7cD2zpagM3xA38c5ZYEu7ivsdp/5ar4T4KieJBEa3l1odXGyoILnNstdlhrPkNR
         8NEyVfYAteWi1/umWOVDZp2YClFlTKmAgu/4Kw7TwG8KFsfWn0MAY1aFbqTbn1EBwHiw
         m3sF+tPd/zlGAM9dkLPeWx5VNJXFk4jpWHtkFuKlf3z1yZCKmDaXw+5SDgE6JOhRJ9SH
         cshg==
X-Gm-Message-State: AFq9FYLlPfwHp1tpyas8mtkkuVEpyyGCtLn8IYsH5wC6vVnDrOVW8RY5
	ZxJZWBwZKkUjokBXzaEUE0BNHrWEWzMUP1ZZJwEFbzy6OoVgcnYhecm537SfAoTjvuX7SQ==
X-Gm-Gg: AYBFou2aTmf9RTTywepOqCAKE9BL710swsX6C/g7uw43Wu20v25kgoc+WYd50+TNwYe
	Y0hywteO87NUU5zTqqYqZ+Tj1cV6rKi7Y/uqUt7wuCqD2d/aeZ3jjrbpLLEXhUT2Lag8q4N8Kj1
	79v+Sd4m+dEo6sV/yK6O494erRQXz1ZnPnDKtvCSVLCDhYe2nZTmQ0xoh1mlk6vImcOB2oIUeQw
	Lyd/vfBVIfl79mCzs1l1vWP0fkMIUXaPoEn038qlzR/zr8wroKpYU9eI6bZpzPdrB7VbMccT9nn
	ULuFAfBnsTwAovApEb2B2YZ5IRNLt5DkMFWdZ5dI7eTiXgClshoiywWizIQ+LYFwIAfwsmQ7u02
	9sgaX9GcWJjvu8bFxISV35DEDWXLDKBlpLPyDagpvK+YnSrO85dV95kmqQcTtEzQjj10b1vWukn
	K8bwCDxlwbDLF0kxvY6jmGiX0o6FHr6r2/gCvAFc39Fpl/avnX0shs0jzmz7uyAjJNiBNi+Kifr
	8V6j9QChw39czQOX3k2eGkZJbyZAFai1oAuvj3h0OMzjRabnTN6VP7m6IztKRD27WFH60k3
X-Received: by 2002:a05:6a21:7d0c:b0:3e2:ea7:618 with SMTP id adf61e73a8af0-3e20ea744ebmr1597797637.18.1792158609291;
        Fri, 16 Oct 2026 06:50:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:1467:1666:71b7:b993])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65484fe24sm1161715a12.3.2026.10.16.06.50.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 06:50:08 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: sgm41542: Use secs_to_jiffies()
Date: Fri, 16 Oct 2026 19:19:42 +0530
Message-ID: <20261016135002.35172-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261016101521.14140-1-sinha.aryan03@gmail.com>
References: <20261016101521.14140-1-sinha.aryan03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an accidental resend of a patch I already posted on 12 Oct, with
nothing changed between the two:

https://lore.kernel.org/all/20261012154614.42203-1-sinha.aryan03@gmail.com/

Please drop this copy and use the original. Sorry for the duplication.

Aryan
