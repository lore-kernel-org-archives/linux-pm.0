Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E838F935
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424500; cv=none; b=qNgWlkHw39IC26w1SnYjD+cANzaHUj5wi1ldVMBvLkE1t75FEx+vX9GOf9gjn6ZG25mmPVLqdtt01CwYL1eibgovV/DwC7GVqYP/GStrL3eX5LefTyYx3FC00GFKIH6tladWd51O/EhHep5mtvv9QnPpL65+82axvwjxF/XOGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424500; c=relaxed/simple;
	bh=hiezlM3Qifb6SLYYD5FZ6lSHsH7cmu/+dQpgXX355bM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References; b=Wna1GTbWNb6oi4zRbrnk0rndm/5CvIbQTPrlZ9lNhJeTEbxLgouxbGUsi5beYd50nFBgdz8DHwXVN9UzSYF8eGTgOMEZXBdfWCPfHY/IYnZO4Ka4sbZqTiQ5GgEXYVRyIYiq54BpexPTr+NJbM5I90fTsM3npOHlLSzy1vbR75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQkseziu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQkseziu"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84229481d44so1117867b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781424499; x=1782029299; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiezlM3Qifb6SLYYD5FZ6lSHsH7cmu/+dQpgXX355bM=;
        b=hQkseziuxMY3pei1ORkw/Q2SL+V9ZoDpKuUHzty0YwFjTnJDhliH+CMun6FrTXxldv
         sE6xQpXeIAWzgPO6gtylvNVc4mXJIQ9HHaB6ObkLnrofqfj2Hs83O+S1wIIcjuCA9QWJ
         vDFOAlBMICMZMEGYvJsyYI7KQFG6d72OfjX/FvaPixVSNPeVe9ciqlAxhNB5ZQsAB+6Z
         fw9gSNs6uNmaj13GOdwDhbdHXkic0uUCf63ipzYR6C1dLkBrcnB/WmT3sHPqxZbH1UMJ
         7OKJe/wbdcwEYpDEzx5cNjzjuUsuJF4rEwIq69qwlxPu5QmJ8PQ4uCYbnodu4mq5nDOd
         WnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781424499; x=1782029299;
        h=references:in-reply-to:message-id:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hiezlM3Qifb6SLYYD5FZ6lSHsH7cmu/+dQpgXX355bM=;
        b=KlPzNCb9UpCkKHiejLef2WYqOVWIuMTYhi0Y7fyLBzOln6wiJ5tlFqI9iJQY3pJQu9
         aA349xz5RURXdZrGhaNMYfsDr4oQm0QbGGLCefwuaJt9bae2rfLYvveYCZ2iBdeHzStR
         Y6/lgtGHp+Bw2n7RguYaYpY4n98D8SwRXUKNRK5S5hR1KNkKxHe0unfc/jnHtyEv30Vr
         GoFGxwcDhYrTg3HWRxMXmgvc7buRNb5wntXv4xQ1paD32Bra0eh9B7tML5BoXX4d+Dk/
         JjdyJ6aVV4FSawW4C3Wot22dOGRCnI+8WUZWyu5PK045GvDVg5kVRmsOX0lOVpyL/t0v
         Dqcg==
X-Gm-Message-State: AOJu0YwKoD4TxdiCrLGhl7mXcgDJDs3GrkNpQI1M7ICO99q6glW2TBRb
	gyOCL7HhbnMRNbrKTupvrXpj5FHVeGPkZo1xSmb7lHFUWNPN6q/wBIfRgzyWywpe8vc=
X-Gm-Gg: Acq92OGqlMO9q2PifW0xMPtQ+Z7UaKugUF5qgxRzCQtEw5wwngLic0sSlqwyGFwnl+a
	AxKJnAIwPfjt3ECDw/UjVUuJeQYXBA13TxWsgZ0xwOwH7/O3D9fxsc/5lNDVBwFPYtjgb+bBw0K
	Lx5uaFy5KPBarFM8NQLslEd74F469ASbfEtoejKAFVk52Qt1xvXQ8DMPNzT3AWFiy7Q8SwH3J57
	syN2+XmViGwaSobnfXZh6pmg+IPRwGam0e0aXWkjVfhObiw1pfwd36tGOSOSPXuFPM0+LUSlO+Q
	DmIoGUXWO6p82RB2K9JmLzuFdDiJLa6ff+VBtBGrnv6NnFjypPMpay4bi6YJwdvISAbLvtJEhI5
	8PPUQQw4QRFbq1cdZBBFaMe+xQJLLD5E6gCMsbOIs6dZXVgIYbdrjTsHIyhwG624EJ14L68Gi74
	v7yn91sxSzb2TSwv53
X-Received: by 2002:a05:6a00:4399:b0:842:2419:6c0b with SMTP id d2e1a72fcca58-844e19676f0mr6762762b3a.10.1781424499049;
        Sun, 14 Jun 2026 01:08:19 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm6592999b3a.53.2026.06.14.01.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:08:18 -0700 (PDT)
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
To: linux-pm@vger.kernel.org
Cc: ansuelsmth@gmail.com
Date: Sun, 14 Jun 2026 16:08:15 +0800
Message-ID: <178142449524.1922847.7321439604208885926@gmail.com>
In-Reply-To: <20260520155525.22239-3-ansuelsmth@gmail.com>
References: <20260520155525.22239-3-ansuelsmth@gmail.com>

Reviewed-by for the SEN_INTERVAL fix

Reviewed-by: Wayen Yan <win847@gmail.com>
