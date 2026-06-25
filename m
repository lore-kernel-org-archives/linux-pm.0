Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E643388E5A
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403658; cv=none; b=Elr3AGNBA6peImrB3xqbUKWfDIdiWES9kfw5SUG/rywJLYWCYiAt6kbVi28Gequ9et32MGCNYQ7IQw8n8VvFgls4F5tZ/ldoFHXJ/NXXe83N0kXrJ+OSep3kk3bdA6KagFCq4Ojey7Vwvv67mn/8GL57iNuVYZO515dRUNGhYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403658; c=relaxed/simple;
	bh=Dr5pVOCfCtLgESp7BZBpALP9oXjjL95wrkaWuiXd0G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJk8lXSQ/srXNwon24Ga2j3pYumCNMShyex2E5iQuo/enAQayTNIOHvka06Z9/8mRnr57RzRazvp5PviakAN4KlJ7tzowblTRjrnrHRt/yYMnhBRbF/1QnWE9Jy2ZYh1juwdVuWAo4DnsbeRHS+g/EIrplNV2bWO0NiM3w/P7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9aKWmDP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9aKWmDP"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46dd46901dbso864423f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403656; x=1783008456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iyxSXNZjt2zGM3OkK+9ft4Li7aIHJEaVpQSWnGw8toA=;
        b=B9aKWmDP4ufkcuDf3xFQHfVMt9H3ehrLiut7snjULzTw/snenis+a/C6Lf2eup7T/P
         YGnYANOgf4Xk/c7p7nPHUT+HiUr7BzXcLj3en7p9U6oZNGrk/Kl3TSQtD30/Q64baOh9
         qCyiPUTS8jj266ee5uAjpQM7WOERLWmEsKTKieZSev7tPITMD995tAGJ18sGmLXzxkaw
         IdozAbcz0hH07k+4WvFqtSdJaJUuqGrJGyG12A5igS0aqX5aWK/o/Gjzn5QkwqNY8YJR
         IKmxEnsWaE4Xf1Mwm9hEZgnbMlmP6vj5Z5SBWuRNwj7h1x3uXHJMcWbP9vTFBEbL1Rvz
         feqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403656; x=1783008456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyxSXNZjt2zGM3OkK+9ft4Li7aIHJEaVpQSWnGw8toA=;
        b=pkUaocmGO9sG1XPKOSg1wVc7uSD+umtJB+d8ERfcuyqFbzRqN5nBBjqvbl645HbKjP
         sMqfzhkR+BVThGKgnSINqPZJ4yXI5JLX6faKFkEdZWrwVkrlKTYVBU34Me0W6Wk9+Ihn
         9/a+tRLJvdvY9KHXQUyWRD7qqDS4z+aWFlx6ZkI+dWhW5DF6r909jbRp64BT2Uy8JssO
         qcwAXOy62bSeqRkWgJeUBPuLS8rp1H4Dg/pacAAkShGar1WFo8EGdC713OKYu04LRa+u
         8xVv30coxfqqO43zXYN40mLw+cLy6cY6osf9/+T5FVns8XIBj3Xm0Jpxn0mhyGFR8zZ9
         ZVaA==
X-Gm-Message-State: AOJu0YyRPg/WQxZJIldXyrh+I8M5+L0fwAmiqySnXPfSaCZtPcsidZUd
	mlTyKDL4Vts4jChxMRjy1KMKMDbII+nfpQh6na/jaUAOETRg9hMRt3+R
X-Gm-Gg: AfdE7cl3yUk/BaPCP5gx7ZFfSyZ6C6HptZztNmpC4B8+my+bQ/Ta4gjwdQsQamijDqr
	PxPpF4HMSMf888c/c90v62xEiNkbI2o0ldSwN19NRak3CWUMQ9eKr0Yy22DNG9WlJQWxcibYNI5
	JZqhKc3HCysBuJ5tOWUUHIbOSttTjik+8aVmcp4ZMOKmLtVEWDrsrSyrfCMYGiiPDZJUDZxUzLa
	XDoE+BHtEItdmdgiJkw8HHbuQbuAj5mDDlPy2diyr/aLgRs0iO6pHgCIVGDypjn4txiE2uGFshm
	WBi2rq5RvT9GACQgt7AULBsU/Ex/xi8g8EejOqXjbymZfv1UqslI1RsSMn4W3W477IL2Z9Q0jSV
	+yCPQs6cg2I8bMLzz/Wiuch1H0yLNf2FgnpDBm5vhCzLMghX057u9wqP33DV+rpnvMkQZ3Ou+I9
	+zYDKxY0p5+Fu+
X-Received: by 2002:a05:600c:5296:b0:492:4a56:68fa with SMTP id 5b1f17b1804b1-4926688583amr44277695e9.24.1782403655390;
        Thu, 25 Jun 2026 09:07:35 -0700 (PDT)
Received: from beast.lan ([2a00:c281:1461:c400:bf16:e4f3:7fa:c2dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fef710sm12844515e9.7.2026.06.25.09.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:07:34 -0700 (PDT)
From: Boris Shtrasman <borissh1983@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boris Shtrasman <borissh1983@gmail.com>
Subject: [PATCH v2 0/2] selftests: helpers: handle multi line in test_sysfs_prop_optional_list
Date: Thu, 25 Jun 2026 19:05:53 +0300
Message-ID: <20260625160556.54830-1-borissh1983@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify test_sysfs_prop_optional_list to allow multi line parameters, in
order to comply with checkpatch output that limit line by 100 chars.

Allow use cases like:
       test_sysfs_prop_optional_list \
               usb_type "Unknown","SDP","DCP","CDP","ACA","C","PD"\
                       ,"PD_DRP","PD_PPS","BrickID", "PD_SPR_AVS" \
                       ,"PD_PPS_SPR_AVS"

--
Changes in v2:
- correctped typo IFS vs $IFS.
- Added the patch to treat usb_types

--

Boris Shtrasman (2):
  selftests: helpers: handle multi line in test_sysfs_prop_optional_list
  selftests: test possible usb type values from documentation

 tools/testing/selftests/power_supply/helpers.sh           | 8 ++++----
 .../power_supply/test_power_supply_properties.sh          | 5 ++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.47.3

