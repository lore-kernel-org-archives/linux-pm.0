Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9C3F4829;
	Thu, 17 Sep 2026 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625244; cv=none; b=MTDa4lXr5WU3k8Pps2o0QMwgfNcc66KogmRJLIAg95dsw3rHezPBgxsQRnkbUAGTuwGURRHRREp6Lyf6IA0UP8SEFssQTybvQnr7NGyt5cS4viNHw15257najEgwf6XLZP2ZpQQaSBPWA8aVcsuQvoG1LiD7qZb/c9aexIpy9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625244; c=relaxed/simple;
	bh=2sGBOlBzy6gZduEvQ/KmVSsxm7sJCweHihXoYZpU57Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ExWUe+i2ybx45LHtgSlhFnPS46LUdVbepJkV34nnDVOOTUBmbBmfcFxpvYkX9EYyuYtXUmdTncU1659e+bVy7v/Ol5DXiOIMQk+/XQZLlPK1rnfbjhHNcQe3EaQDjYb/uZNFURz2UNq/ywemGTuZrFJvSRnvlkGUUNkAJFBW9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4+1CR8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4+1CR8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9739B1F000FF;
	Thu, 17 Sep 2026 06:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625242;
	bh=YGGbnh7nf3PeA0Yo51x/8OYia2ASfwXMoEdA72QHwpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U4+1CR8L3NtdMnHUbE4+EILa18NfHZ3q/XTfVOFCFxoXQs03gVYgWeMceSE6H+nK3
	 BidirIiFi1yF8XDLY5G0JngHcZ2UmwnNFe7iEo/TS1AP5gPWu0GoyDgDz6xOqYkxwI
	 DHZVBGf9mD/vD5D0/ll1NFnd/9YIhQtgUXOmLJO1FZ8E2Ak5fbmNui7WllDKTApIGh
	 S3HOpmbIoElc5YmVvv7zsbl9WaTvLnXMqaBQuxfyzxOtbPdS3J866XeyPG99wtJ897
	 VRwfpD4hxQUxSshprfkFx9AHYzEbHM31IL+nkr/iDRXwdzMOmU1eOX37AND2WdIASA
	 KNkXms2omVOqw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 17 Sep 2026 09:07:04 +0300
Subject: [PATCH 2/5] hibernation: ensure secretmem pages don't reach a
 snapshot
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-hibernation-v1-2-7f7dfae3dbe0@kernel.org>
References: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>
In-Reply-To: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Potapenko <glider@google.com>, 
 David Hildenbrand <david@kernel.org>, Marco Elver <elver@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Len Brown <lenb@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.1-dev

hibernation_available() checks for active secretmem users, but a secretmem
file can be created after this check and its pages may get into the
hibernation snapshot although they should not.

Recheck secretmem state after userspace is frozen and abort hibernation if
secretmem is active.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/power/hibernate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d2479c69d71a4..281ad49411481 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -412,6 +412,11 @@ int hibernation_snapshot(int platform_mode)
 	if (error)
 		goto Close;
 
+	if (secretmem_active()) {
+		error = -EBUSY;
+		goto Thaw;
+	}
+
 	if (hibernation_test(TEST_FREEZER)) {
 
 		/*

-- 
2.53.0

