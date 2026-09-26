Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0385A3A8384;
	Sat, 26 Sep 2026 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790414820; cv=none; b=aHLFNiCrhs8IScUwTPrKaN6gs7nIIQKhHrvy5wqYJV16Rw+qyZM5iPn1w6R0OtfEVFEDHBQ77iU/hKaohOl1LCPNhsXHXEEiGvOeFceq+ND8M4JO/zTchi5Pc1ivmPeAx0c+Kg6nLjMXR8cMQxRGj2Lhu54p52Xn0iSy5/Od0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790414820; c=relaxed/simple;
	bh=P4kh85FTN8DAxfJsZLJOniQICOo28o7KmNDKIvMnSoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qABQBmE4b3n/PY+3Z6e0OVgAlk+U4yEgXsdEf6ltJ/P5p84ex9hvELPJxhgE5HMw21OK6Z4R8gyclIv7dCrCPDp4Nz5nDyXOfQmjdc0auEd8yCZYAxQjLdYI70kkkhuKe7w1VQqqy/8TVIA34AplaDxnGXcAB4LTrEG05262aJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k320yvC/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k320yvC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE841F000FF;
	Sat, 26 Sep 2026 09:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790414818;
	bh=apeXnFxwzPd45aFiHP0MNpAyA7JkKV4wuaIPOREj6NU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k320yvC/8eFUDkUHTucUsYfIFPTBJRLOAqKMjYUGTeuvP/Q89YgerwbE6E2JAe8Xt
	 u1uOdprP1otEhBeIa3MSONT5D76mh8IzLQBsOmK22qZILMF9UPt2IP4GswMo6/kQ2T
	 +K85a5hk0LFQTFyHXVTbW7r+FdW4xBYelMlNH8rpnk2FnJz8VEtzAB/7rVjNWbbeYF
	 xDiIq2bGXGS7DVmB8Q41b+ODN7zBr63uEVBuyAG8Cl/kiZMsbbmkKR0Ca3G0tcVDjB
	 fwAgD4YMPkTfAuOXJeCGMj+pyf6aYRapzk0pD7GGYBrwiedtC+mcr2kl4ZjheBtI79
	 MkstHnVzkERBg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 26 Sep 2026 12:26:31 +0300
Subject: [PATCH v2 2/5] hibernation: ensure secretmem pages don't reach a
 snapshot
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-hibernation-v2-2-235f69f3ab2a@kernel.org>
References: <20260926-hibernation-v2-0-235f69f3ab2a@kernel.org>
In-Reply-To: <20260926-hibernation-v2-0-235f69f3ab2a@kernel.org>
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

Recheck that hibernation_available() after userspace is frozen and abort
hibernation if it is not.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/power/hibernate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d2479c69d71a..97de677e360f 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -412,6 +412,11 @@ int hibernation_snapshot(int platform_mode)
 	if (error)
 		goto Close;
 
+	if (!hibernation_available()) {
+		error = -EBUSY;
+		goto Thaw;
+	}
+
 	if (hibernation_test(TEST_FREEZER)) {
 
 		/*

-- 
2.53.0

