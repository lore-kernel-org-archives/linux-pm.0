Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422176;
	b=o7lnEIb3shcGDOgoXDnsII5akF9GhBMAam676vDodGHxwMhXp+Pf6VCnRF/afsqI9rZt
	 ALQeies56cYek5mmnXecmti/F+s8vRqVFlGoZ/G4Q+K5vB7HAp4NyPrtAkGGszKVHCBYu
	 3BQQbCbtHzCSsQgYgT++tIcqHPT8b7jMPtw4d8pt+khmwN0dPm2uApbb2ZjAZ4Y02ivph
	 hv9ppdkq0DaCQ6fNNiBW321NXqdFIExmLSCFgzK1aQmz1GoD1vN3SAgoywq1hyoE3nHzW
	 dP4qJf98Kk84LPZKgdRaCXzq/sw3k0PJOElapcAGWR8G3lBtWFVa7to5IvIS9/C7S4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422176;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=efOjjPdCGKge10jrdJWmF7XGxqvbh6DR5hUqJ+f2HiU=;
	b=LrYlX9KDqUtRiLeX8rP4D3MiPxqVip8mRaF/MBUZI+q9FDT7vAlP9dlKbm020j4BiQSN
	 Eo8wpKDYCmo+tM9vspkWd5S/IiHBSG4L3R+EIeyWi48QG7y5ukMmVkseA58RGx3CybB25
	 xBnRT9CYrZE3/xoTFeMSjm7zrWizl8jbZ0rEkb73JP+vbaswM1wiCWir2kot2bCsJRuOs
	 Kto+7vQicK6qFCVxH1+ohKm0itOa0N7XwGAf4npoxQzTfTWUP5mOr/h4LCoOzUNNDpSsv
	 3xQOSDJa9xbBTmafjC9ADsg6E+66coCRiX8VVNqdAkuPXnby6dGdsMLhCRh7w1jViWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EJ/HaqJF";
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1B7607BF37
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJ/HaqJF
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F26513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422176; cv=none; b=ZB2sAuQd/yBczGSagXOZVKE5ExPXQwVJ8nRJhGhPPN7vahO0Z+4SRWBsaXAC6MrRFlqa8M/3zLGmYz/kdfRjpMyb8qRFsSOQHS5VGh9kFLnwQzlU5UNbu15HbWRpiG80PmOMajPBxVEUSwfJCDlLoj3yvSFnyKZeAqu9L/zplCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422176; c=relaxed/simple;
	bh=Zu3U43z/otwzipjXBVzEgYT+YlI5teFIVTX9qY22DaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QekDZN6XSBUlK2gVyZtR7mqCru+sEb8oZKjeY4una8jHknzs3FSyy2XSkZGYFa/q8TNdV69GWKl7AYLKBOKeC6QAPg3Ik/q+GFy10O1bPsSZ8l293f+uZGLeKZICQ1kj9VXj7u3uZJ8hvuZkckyKqR6Aiou++EGF78PmsPY8HTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ/HaqJF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C191F000C6;
	Mon, 19 Oct 2026 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422175;
	bh=efOjjPdCGKge10jrdJWmF7XGxqvbh6DR5hUqJ+f2HiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=EJ/HaqJFJJ8n+v8pHGSJIJuXXcH4GYSrdr7WraatB5h2zw7w2yzcmjKPSy6DosC3Q
	 ycUIC0aouXUlMaUlfwG6cJcB5DH+85mozTqYnpflmPLyzlL6E9tNO28fPwb1bA6d2I
	 XDcsGmx/gzvgPgZZq1mzUjx6057GKgDPamTgtZhzPoqf4rJi2kYM/RYkL7dJCkSm9Y
	 eABgqKGpj31QUTswIgyceYqSr7SumCD957I0lqhAK6G30eRqV/ZtE6VAMlpWPbovV4
	 qyb5gekBEkDCGcQRKNWl7RHtbmK6gRWDT2St1FgobJR4TQn5ey2haZArlyG8K2NFiV
	 5xcSkthXI3KnA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 06/23] tools/power turbostat: Cleanup: Remove useless assert()
Date: Mon, 19 Oct 2026 10:38:39 -0400
Message-ID: <91aa566a7ec32cc2d1401a2680cd71f250cba5af.1792420722.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
References: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

No functional change.

Assisted-by: Claude:claude-haiku-4-5
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 03b72616673b..7b872bb82172 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3283,8 +3283,6 @@ int dump_counters(PER_THREAD_PARAMS)
 
 double rapl_counter_get_value(const struct rapl_counter *c, enum rapl_unit desired_unit, double interval)
 {
-	assert(desired_unit != RAPL_UNIT_INVALID);
-
 	/*
 	 * For now we don't expect anything other than joules,
 	 * so just simplify the logic.
-- 
2.45.2

