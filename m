Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F39175A9A
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424496; cv=none; b=ORcT8s8OI35fR4DM+cbV1fkLfepwwZN6XEN228L+2ojDDiihWOGVdXOIFyGl8zmpR4KcLaxJFTPFp+2fDKonsUQfrFQOegth4wzprwIyqz1P/CxE95L/5bTlfjz3m/sOJ5z2lROp4XD2akLZKvEGvuEqD4VMgtV0rx18z0jNgKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424496; c=relaxed/simple;
	bh=k5dImWwas5jQ1AuAnqmiQiYq2bSoK5bY/KQludMXXKo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References; b=BTReo9mergxT2AImc1LC4x4FtJg+zn+iQ+E7uDMle3nmwf5q3RtZ+Qvcb908WWQlH6zQSHhdTPx0AGkVvNIysI05EJAhcIDk9RKkFNBCCHr2mziOHlevDW9qZGvwqF2cV8Ypv7Iy2J6SNBEurffzDd2cyxN5Xd7unijNm5JsvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWLvbLZO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWLvbLZO"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c3546924so14408515ad.3
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 01:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781424495; x=1782029295; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5dImWwas5jQ1AuAnqmiQiYq2bSoK5bY/KQludMXXKo=;
        b=WWLvbLZO/JVD6712F6u5j/PAddOFpnkk3tSSLpyVL3zZ3neIr+vzddMrHNxfk+i+Qz
         VgDL4UkYY+g/givDVdFLUaVgNQ9UEy8VqByJ3XEK+/ClE7BtFt5J1/ABjAgiJwdxJ/Xp
         PN285jdNfBJBuceVWTwreW/PmOdGWwzyrldqaACp2zJrIFc3sKL2o3GQxrsD6YO84ZnX
         PWMOSNSTiAyKpyezr/gf6Y0ABAqLeqnFIKMIPKkjHYkZMgYfWlEld7wzEbE0TL/5QHp/
         HNNmbzHCR0qDVM+liWpIIeqOPDkjchBhO1HxE2xaGpb9ODd3TLqQiFyMJKMFocpeUfCi
         B7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781424495; x=1782029295;
        h=references:in-reply-to:message-id:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5dImWwas5jQ1AuAnqmiQiYq2bSoK5bY/KQludMXXKo=;
        b=Fou/kvChwtioPoyPoyANalOSce9vDJybo/D4O+zX7OwvfFcXT7X8VJTLfWANEnHnNT
         qcz44Wzah1H/FZ8QwKxMLr+Arph3z2joDHSVBwX/bGoBoo5I6cibF5TKaRE3BGK7WGPu
         BvacFDab9zkNE9i3LMRADbNmTCuF+tX3xUJMRiKpP2XGN4pP4uEL6Ck4pivG12gSrYsd
         J0xMH2MqsGeu7VTpolisJYe3KxjnfeeBAtB/00akwKOYWKcQHd8b5wo8dA3vIgNzIjP4
         S5rH2gldKSHmmXP4fnwkBQBgBbnRn1krV1eYkhmeROeLURn3kER7Y+aDgL2qef7fF4aM
         eeOg==
X-Gm-Message-State: AOJu0YwP1fuF4BzctY4milznwZ2GulHEaB/SepnzUTjVxugp9cpc03Su
	w5UObKLYQmg18fqoDe46+KbXA596a4MMrYDboC2csiNB/tf1+mJ3ppCXp0gvx8Qgn74=
X-Gm-Gg: Acq92OEUBaaA3XovsCw78Z259GlHb7Dmd4+n5P0Ja+wHqbaY8oGOaIE8k2OvwB/XStg
	I/OR1vawEd/R/59eodhao8M4cdNtlvInKbovn5SRwqzoq0ijnBIMoroq76pNGKtUBenZP3vj/Ga
	s1zTGFa/qC/7xVoKoI9pKjMY65LKrcWUR7vQr3+rQPlPh4hd0VIlN/N7/cKuGYxkaMda5KtJzVu
	TnTiNLfGywT2rVK9WpAiiGRdcwdh9xcRlhbrvvlz1YqZ2/Dylwr4Yet156OtTBDwufkUW4MLQet
	9PwzupElzsVqg5R6z66PFqldI2pM1hTNOlpuNRLw1Zc2/5+W6aXvPQzrcnCvT+Qt1Avo2QQadx+
	YCUdH0M4rQ54IV/a51MyL+JFLDDV92L812HRRIuJ/q/MOHza0UNHiNZaae/AVqAYH3yv+EYu5ag
	zFmSvHBs0Xg7wbT4lk
X-Received: by 2002:a17:903:4405:b0:2c0:baaa:db94 with SMTP id d9443c01a7336-2c664272077mr67096295ad.22.1781424494683;
        Sun, 14 Jun 2026 01:08:14 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433369c8asm69698815ad.73.2026.06.14.01.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:08:14 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v5,1/7] thermal/drivers: airoha: fix copy paste error on clamp_t low temp
From: win847@gmail.com
To: linux-pm@vger.kernel.org
Cc: ansuelsmth@gmail.com
Date: Sun, 14 Jun 2026 16:08:10 +0800
Message-ID: <178142449074.1922847.1808471436362462841@gmail.com>
In-Reply-To: <20260520155525.22239-2-ansuelsmth@gmail.com>
References: <20260520155525.22239-2-ansuelsmth@gmail.com>

Reviewed-by for the clamp_t low temp fix

Reviewed-by: Wayen Yan <win847@gmail.com>
