Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA792352004
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340273; cv=none; b=tDgmaPUesFZs2aO8xhZsXkrpSK9/mYUT/iLZHosI4TqYh1dKEHgX2zBcuSfx0vca25kjL9TH8p7kI6zBa0F/lUUfs4R3gFYCOwYnqzLjw1GAIwysH45UzLmfq/RrAmCJHE0W2jKiS9z8f7vnvTAyJUyhsBDoyl7b0d3U5KQO3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340273; c=relaxed/simple;
	bh=F/czMXhN+/gYA/ZYxrII+3TQE4EszIbUnP3IrF4T8cI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4LiNOBZkmkhhYo9E8LX4NZ25446+8TQQBka8bYIUubkZbViqIvRN1FwprkmQLeS+myx0iXWoKJ/XyISvwq4t9RnOsL1fq0pI2iJimEvy1Y4ThI23ogptlp3KQuCi49Z1h1vIakh5jR+Fbls0vWeAk/5jbtC+JKSJAPcL00eWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RoXmA907; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoXmA907"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780340270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kYgC9NhjyhbzjBqvwbQGHj0FYRnYvL1gShtOT5R24xg=;
	b=RoXmA9071rWBxYIC2ZpDw7hdBZqQOCGKosRt0tm/CLhm3Gz3kGn4JcL5ArZL/S0teVkzct
	+gdC7N3IbGvckju7zh9qC5Wikl16vbK/86No597qQEDFninBzsmGXrXZ+S8/Vz3GDl55Re
	BBWm2f0A7H6Go/yaH0G4FN3TSF/qBwA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-vU3GvPDbNQCsWDbpLHQEKA-1; Mon,
 01 Jun 2026 14:57:45 -0400
X-MC-Unique: vU3GvPDbNQCsWDbpLHQEKA-1
X-Mimecast-MFC-AGG-ID: vU3GvPDbNQCsWDbpLHQEKA_1780340264
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9E371800343;
	Mon,  1 Jun 2026 18:57:43 +0000 (UTC)
Received: from lszubowi.mht.redhat.com (unknown [10.17.16.237])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B74501800347;
	Mon,  1 Jun 2026 18:57:42 +0000 (UTC)
From: Lenny Szubowicz <lszubowi@redhat.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: pavel@kernel.org,
	lenb@kernel.org,
	jikos@kernel.org,
	jpoimboe@kernel.org,
	tglx@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: hibernate: Preserve error status in create_image()
Date: Mon,  1 Jun 2026 14:57:42 -0400
Message-ID: <20260601185742.144125-1-lszubowi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Prevent hibernation errors that are encountered in create_image()
from being overwritten by a success from arch_resume_nosmt() on
the routine exit cleanup path.

Fixes: ec527c318036 ("x86/power: Fix 'nosmt' vs hibernation triple fault during resume")
Cc: stable@vger.kernel.org
Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
---
 kernel/power/hibernate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index af8d07bafe02..2e837a9c617b 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -324,6 +324,7 @@ __weak int arch_resume_nosmt(void)
 static int create_image(int platform_mode)
 {
 	int error;
+	int nosmt_err;
 
 	error = dpm_suspend_end(PMSG_FREEZE);
 	if (error) {
@@ -380,8 +381,11 @@ static int create_image(int platform_mode)
 	pm_sleep_enable_secondary_cpus();
 
 	/* Allow architectures to do nosmt-specific post-resume dances */
-	if (!in_suspend)
-		error = arch_resume_nosmt();
+	if (!in_suspend) {
+		nosmt_err = arch_resume_nosmt();
+		if (!error)
+			error = nosmt_err;
+	}
 
  Platform_finish:
 	platform_finish(platform_mode);
-- 
2.54.0

