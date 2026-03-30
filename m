Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB633E0C7B
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897776; cv=none; b=isOoBNqvhooXvQ/Nlws4Tu8UfTaDO6JRZOvRcDqjpXI8q5FOm9JLIz1Xb9RSN+7DZrZVXkKa0kyKW2I+SvBRReKbZlGNU6CxVaYBKEjeuJud96+j5krO1VHfHMQw+iQIkOp0T3OQmhm58k1qN95c8iNOBKvGmEI+O6lBHaOBBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897776; c=relaxed/simple;
	bh=JURd8oj8DauAOeeakbsA/2V+Ea+i6xYudkXoGU2USzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPLjuXXrBo2v5hCd6FO/JBCm7ZDggM4OihAZDL+FsS+lvhEk73SKli1u+xuNtAwDA4eHkcCcfNLiZe9PD82a5t8dah1i/CjDu2svHrNQ+98jjkvsElcY4M8pfcspld4/wVohvQr5wR9tjtnYPcjSPe1EO4ePlxisfWrsTRZcRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSW1bxsJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSW1bxsJ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so1849684a91.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774897773; x=1775502573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8gc5QmwcguW7JLhuX/dVskz9qyMueuGcZu2XFmLV1Lc=;
        b=FSW1bxsJokgcGeQXlEoV9n0X2LykP91ice6Czw57YA9Aqfx2mpWQkbTbYlx+K0td9I
         sngzhQiw+z1/gqzw5rpqNnN5+CiLraKPKGNVvXpxICtL2UDgw26nZ70mpTkedk624m1m
         szItatlYYH/APypFV8Db8TO/knhJpMgx5PhBF+p6Dta+386epiua70VQe7RgIJS/LbrN
         2MOwTjM/+vB5l8eEBX9jIyW1vvi3I0cJ90QO1yBSrNLK2NnuGJpVwzj1qMrSyap02Wa/
         ohpeldl0uHwiwBndfv935ysHvSfFRUv45IVNB03vjp9iIsK1ePNfrOjUIiTzWwiW+IM6
         zPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774897773; x=1775502573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gc5QmwcguW7JLhuX/dVskz9qyMueuGcZu2XFmLV1Lc=;
        b=KkAEnOTg9eRkb1XvXjPJSVWUqycgfNC/5XGn4rjhELnX482nNv852y9A6aQVPXqVf2
         JL1kDWRVUUsRL8gZICYUqbxxTUnapwe0YQaVsSQxwjPkMSymD2LIzuAaXzTw6PuyxWJO
         kfIS0k02GPKJy9cegXHXZyRXn2P3eqcMzlpmOYgBKssRkhuYSXUpV2XbWTys5e/gl4wg
         tmXNQ50zWi9YXcX97OTd/AKvNdsAUX9SfhHnPEZAkLHA0trgR+4SELB1AxqbN/amlObE
         U2HyveeaJC5iL3x1uND1LGGXINYg7ErpQN/Nr9j4Yh3Rm2AoDmmPrhlzzpCw6fM2S5MF
         Db+A==
X-Gm-Message-State: AOJu0YzONcrYG3tOQFVQndccE6yv2ksZ4eqf3iAEx73IIgWaS9roT6LP
	wQx4xcmiDJiEB9T/P0GL7K5DZemlI5OcYfzZXJlpr0rl8hEhJDv8JpDk
X-Gm-Gg: ATEYQzwrvKrDXo+l1xqOVaztdOCZdZ+DOqS9n68nrA7suOg3SNGin5nvUp2feRtKh8X
	umA1cndBEcumWtaxj2CkAOAGJSI0SjZPp+2rII9uYsR2nW1IS2TBaxFxMYOaCZK7IrheeZPFhyd
	LeYMcE/DAiX1XlYCK83n34j6LhJaakyu2EDKVaMzuHSTDcwD+g2uZ4v8Yb33rJXfLX9631IXh8j
	TRF/sATThw79OuzpUsgDWKKdFjxC+ydexbl8ip3F+tfkokG/nxY4v3digMWz1NsDsekOxbsy/6a
	KQj1w72XjHXjAhuWTnbeTJd10rP5IrnY6VGy9U2vggPQv1x9COq8Uiffbn5TBhmD7137lU9XoMZ
	jSPn2qb1h7MvxqgY+CeekaHAXQULswkPIb/XeOyEQQKyFvd2w10sdJgHz4jqTuvVRx45FvW+dIN
	MDyDj5E2BKSXVHtcFrtmQ99XzKsX7BlAIr1v5gP9dUZYs2pSPnnNgE8fu3o09C6xBSVYKSFnU0C
	IodkRM=
X-Received: by 2002:a17:90b:4ac3:b0:35d:a557:e44 with SMTP id 98e67ed59e1d1-35da5572530mr5739793a91.6.1774897773406;
        Mon, 30 Mar 2026 12:09:33 -0700 (PDT)
Received: from fedora ([103.181.54.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a54fd5sm17441120a91.2.2026.03.30.12.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:09:33 -0700 (PDT)
From: Ninad Naik <ninadnaik07@gmail.com>
To: ray.huang@amd.com,
	gautham.shenoy@amd.com,
	mario.limonciello@amd.com,
	perry.yuan@amd.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	Ninad Naik <ninadnaik07@gmail.com>
Subject: [PATCH] Documentation: amd-pstate: fix dead links in the reference section
Date: Tue, 31 Mar 2026 00:38:55 +0530
Message-ID: <20260330190855.1115304-1-ninadnaik07@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The links for AMD64 Architecture Programmer's Manual and PPR for AMD
Family 19h Model 51h, Revision A1 Processors redirect to a generic page.
Update the links to the working ones.

Signed-off-by: Ninad Naik <ninadnaik07@gmail.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e1771f2225d5..13d6580894bc 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -790,13 +790,13 @@ Reference
 ===========
 
 .. [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
-       https://www.amd.com/system/files/TechDocs/24593.pdf
+       https://docs.amd.com/v/u/en-US/24593_3.44_APM_Vol2
 
 .. [2] Advanced Configuration and Power Interface Specification,
        https://uefi.org/sites/default/files/resources/ACPI_Spec_6_4_Jan22.pdf
 
 .. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors
-       https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
+       https://docs.amd.com/v/u/en-US/56569-A1-PUB_3.03
 
 .. [4] Linux Kernel Selftests,
        https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
-- 
2.53.0

