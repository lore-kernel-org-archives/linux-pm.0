Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FF53A8B2
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000265; cv=none; b=WijuvJHfAa3PnWcSjg7OAyB9dfcePFeOb2JKZq8YibACZmqVUDod4+6U7XuXNbiQMiEyINhadUHF6FvXgR4Rur6Bb665ggTUjaZOodka7V6/UgOCUoL949hXiRWes+zaM0itH3DZwiNB7UmKmRwhVkkH/HsAVFIt/vMCfPOtj9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000265; c=relaxed/simple;
	bh=7FybBtKkUJP7s4rvraMKZTmRuih5TFYoczkSbYOKvTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a58YhVgEGliRz2GGUkQKlZmGEcExzs+ZH6xhIeUzNlPk/Jx3D1QXmSfCfJTo0xcTQKG3zOar4tcGmMuYQvdHj6SgQGzxNaLocvwdojeQoslC9aRVBBZ28SPYZVKGDO3r/qbr8voLu496YWEwHMISwnJbnnA2qkw72VwFIWVKkzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hl83wpqf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl83wpqf"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so38218245e9.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792000262; x=1792605062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7FybBtKkUJP7s4rvraMKZTmRuih5TFYoczkSbYOKvTw=;
        b=hl83wpqfFtescdilSPZilWRgziTrwVU5BshAl1DmmMQlzl6+ktaK/z9pqmlWiR7JNS
         3TBBKbJxpCgougio0yObiwcbrc6FDSubXVM6XqSObHtCC0SBOcB7AtHFy1eIdxGm2Rpl
         Xd4kUZy5WP1W4vwyMixPkoh0qG3aNsqg2huPyrgItSQJqafppvRp9q6QK8E2op5ViQCP
         2wJJam8fJAn1u92fpM1Wc8P0EgITci6sxFtmzVnJtzcV6oqf1DBU8uNK12yRct6DnwbY
         zRrdSHX18H/3ZfZ84Be2GP47k2Phvp+UMDA3un9uV9T85TmvI7wb0E5XFWjeZ5ZKqEOX
         gRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792000262; x=1792605062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7FybBtKkUJP7s4rvraMKZTmRuih5TFYoczkSbYOKvTw=;
        b=11sVpN6F2jNdvVHQslMrTmdcIQdA/oD8ZtqeCpFfaPUj82zZ5D99FNdrhOqZhe2gSq
         jOjy30kg+bJJcA+ze1SmgjPJO3Es1+5hDB8LeeqagDgKNItBGjqc2I4mmU8r6of1WNTv
         a04yHtlTINPxTSa7ZJzjjHxFPdP/Jn8Ry8NG8qoPnKRAQPKUC9lrng/TVxxGp8UmlQ1C
         Qi8WtMye3L9uZ7iWraVAeuJnzkFhPXBiB/FYHa0CEhUnHyLd6+r57IdCy/daXjCOA5fU
         kxh7WXh1mWAV5V1tjPVmobBnTs9zpQjcNFGNiFa7/J2M1O0AdCAP8lF1EqNERdGrJVTr
         O7RQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcLFtzQTvtuRVBqqnWbRGmSEqa2GqFSPHYVSJ6dNO+tNmKBVjJWJhkriVVWUJWK0yjatHKUusdcQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKtxKfK9c4V/rrhNmj94TYg7+ZFEJDuOKIJPd08KDgZhNzvmxae
	265Z6z4ttMux3T8/y9BjIGLKXQ9QMtoeD+U1vWtPeBN/ujgrmywk2oc9
X-Gm-Gg: AYBFou3nbwcMfJqnX6DeKr0TQ6LsNn6/LJDMGZ8irQERBPSZnznj5nVYJC5TH2lHECh
	H+0lYU/8H1EuOc+2OHRql9u89In7jFYSYknNV8r9nCof4a4TGR7RbABsaUd9sfH193hDv8j2H+N
	LeHU64R8ROrMZN9qVd/zyEOvPqTiab5UNtIIwIYRCa94tZhAYS5nJeXg29KaRLwXAcQHJPSgSBN
	JbC+5Mb+DKoGPFYiKH4OR+bPL8YfIqs6VRBcVQpZ6QlxXAd9fg6eWPvVHlLvLh2MmLT0vDxxbXf
	eMO7PHZ1EETTvHWm/xuTEi6QTWUJ+VAT8I1EaWuDYRpl7wCe3pnNl/IM+xHq/dD17XyxZj4VkYT
	hCL+B8sRtVBekAESyo6DsxvNY9InxQieyiWcNx3wf6j+kRyUdckUEgot9XfMxdrtXVjuEEf2bAZ
	ajA9wmepDdu6MUCteQ85OyJkHfDtcsMRiKj5bYAr660rNXj3tOYm7uNuznTAzLSz3+ety8wegOS
	m4fgpMUZ+kwUakpU3Lij8r3Ww==
X-Received: by 2002:a05:6000:29c3:b0:48c:58d5:30fb with SMTP id ffacd0b85a97d-48dba7876bemr21587335f8f.5.1792000261965;
        Wed, 14 Oct 2026 10:51:01 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac37acsm13258365f8f.34.2026.10.14.10.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:51:01 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Birk Skyum <birk.skyum@pm.me>
Cc: Vladyslav Tymoshchuk <tvlad744@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_qca: Reset the in-band sleep state on power off
Date: Wed, 14 Oct 2026 20:50:49 +0300
Message-ID: <20261014175050.21982-1-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <179199941686.68860.2209253288195283916@pm.me>
References: <179163212446.46972.2306254853726299632@pm.me> <20261014162025.3733-1-tvlad744@gmail.com> <179199941686.68860.2209253288195283916@pm.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Birk,

On Wed, 14 Oct 2026 17:36:59 +0000, Birk Skyum wrote:
> v2 takes your code, describes the AWAKE trigger next to the WAKING one,
> and carries Fixes: 3e4be65eb82c and Cc: stable. The code is yours, so I
> will add you as Co-developed-by, which needs your Signed-off-by. Reply
> with it and it goes in above mine.

Thanks for running the power cycle on the Yoga. It is good to know the
stale state shows up there as well.

Co-developed-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
Signed-off-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>

I wrote my version with the help of an AI assistant (Claude), so please
also carry an Assisted-by line for it, as described in
Documentation/process/coding-assistants.rst:

Assisted-by: Claude:claude-opus-5-5

When v2 is out I will run it on the Pad 3 (power on within 2 s of the
power off, and boots without local-bd-address) and report back in the
v2 thread.

Thanks,
Vladyslav
