Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8734F3D75A6
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786679908; cv=none; b=p0ohdfQ/nJdUdF21Q8vH3m7ymBbi9Zs0uOSywNDML7MXDwT2D59+k/UHYevSWEmTp1cb2qvJh8l6r1RH81gDPF3+omoyHEPDy1qQdl8SjSxmVVh7v1TkuUZeDg1FLCeDIbqErs6lCQSSNk2EP2JX9bOrHEoQYBhAVA/pJt7dNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786679908; c=relaxed/simple;
	bh=jCDeqn4a8Ajp0kh2tsCXXZkBx+232A5pSG4wDAub0yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gf0R8AxG0KWSUB4Ge3vOCdgknDNlyBCdmyikh+RK9xhHJ9NV3Nx0FGCsmIbmPjlLNYTfGlh6m7UW5HFVfDitp1KduTPQUMZGlKQqegd420sUGR1mhCZNUQpMHjpFg7LfUHG7c88bNQSg6E6YR1SElz/NW2oDoYn+ckDTv3lwPJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0lzIaJd; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0lzIaJd"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66825847b2cso674411d50.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 20:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786679906; x=1787284706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jCDeqn4a8Ajp0kh2tsCXXZkBx+232A5pSG4wDAub0yE=;
        b=R0lzIaJdlO3Jab2pXxCSZwE5m2OKlkaOnngfAt26LuyYrnL/NHjap/HCiizGY3zxLv
         nCzbBW0UeVbOVqw9oxgirvxajPMeNKrWTkr/bBJgwiVUN2LbXq3BC8Y5Dgp2SS+AKJgu
         d4v5IkB4tPUiQyk6O1Vw7ApJqT1jM3Z2NK3b8/yYdR+2sobJg2ulGRHgMhYwey+IwBWq
         5VJZrMEYCiwu9DfUF47SbKmFfl43Qami5JPAnXkUUebdWlnBjKywDH530VlmKtP2BrVH
         pe8x4x5bXDTbiNgpWRPXrnEtJnCRlqxjyUB6oer4m12ymPq3QlZMao92tmDkKbLmm0Bw
         PXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786679906; x=1787284706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jCDeqn4a8Ajp0kh2tsCXXZkBx+232A5pSG4wDAub0yE=;
        b=Cn1A/n+dQ7De4oTovWqqE8s8WrVgT4o/fxmWLmxhHSt7gD3/GfMZxg3l+WUKwaQQZ1
         fRZH/MUokFYvL7AHE2xp52idfuctSlgROvF8ys4ze1AXLF3+JwYv/zXs+DeUW68hK2SX
         E9l/52/qfk3ExH4tMwKidqCeF70WECEyP442n/XPC32pon/EBY+GZBjPRlx5FDUnzSa+
         Z0l9g+TxONJA9cLtS2vIMJBEqKjiI5/X7luuwmgyEg1acdW89rS/Rzapv7Y3RjUM8ZM9
         YZ5xMrVZ0rlRBrUXpvYrwipRa0H1hdzRqWNJjTn9vXX/dJLBxDryzoUCBl3S61rS6ZGV
         2qiw==
X-Forwarded-Encrypted: i=1; AHgh+RqqB1/2Xy5r8YJmpu0c+Xl/eQy3xuw/ouU+ET+W3kgVepple/c1w72B0faT23vAoRqLpHvKAT38wg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8LiEFwx/c3JvSpatKV98ClVhxTvkqinpft0gCwxyKlG+7m/3
	z72xkxspqbxYsaL590NdpgWKbcUa4Niwv7lGyMXpehjdV2kE/o7PCAft
X-Gm-Gg: AR+sD11kgpt1SF54AkEOnVdFvoBxF4aLNkT0W2mQFuiLciBNxVpp8QZOcrwANWvYOQ6
	TRrYJstlVv2iAIF/qs5VFMpuCsHuGjZI8RmEmdzNsBN1TTvR77iWTJxe0X20gZhZobSDLvRpLj+
	mxRxaQuYYnAu1QdWK8VEUNjSy58Y9hf9NJvrA+KwHiDmu8JiDWZjOBbjOm+S5N1FLQ+E408NR6W
	W6q7xLTmK8YDEeC6z4Jx9ffeviq9ov9vpWOsiopC4S5f5C74yVC9TwMWiDI1TXQIHHhk5n75lzh
	qUd0MxT97Q75qHH8M3H2lTFi8JIejs91XeLDzkZdiQVbetqidXRwLXALNjMTGuImgnwDIluXzMS
	/IZNLcTVm0s3OM4mqIEO5Tc51ZKBiVWtI9yNWTK0TdtI/pKN8fWaOQHpOXRsHZ3w8JtyHmjF/dy
	bMk77upIAfUybrvzaQXA3w7y5IOT3v3EvMQERT3zghC30CjFeqfUg/kI8=
X-Received: by 2002:a05:690e:418e:b0:66c:4937:d319 with SMTP id 956f58d0204a3-66c72d2ec6bmr1419743d50.46.1786679906536;
        Thu, 13 Aug 2026 20:58:26 -0700 (PDT)
Received: from Gentoo ([191.96.150.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c7934cf98sm303070d50.16.2026.08.13.20.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 20:58:25 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: ray.huang@amd.com,
	mario.limonciello@amd.com,
	perry.yuan@amd.com,
	kprateek.nayak@amd.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] Doc: admin-guide: pm:  Removed unnecessary backticks
Date: Fri, 14 Aug 2026 09:22:07 +0530
Message-ID: <20260814035753.1978031-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed the superfluous backticks in the sentence.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index c7bf7cc2db87..a37a51c8b042 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -471,7 +471,7 @@ update the core ranking and set the cpu's priority.
 Kernel Parameters
 -----------------

-``amd-pstate`` peferred core`` has two states: enable and disable.
+``amd-pstate`` peferred core has two states: enable and disable.
 Enable/disable states can be chosen by different kernel parameters.
 Default enable ``amd-pstate`` preferred core.

--
2.54.0

