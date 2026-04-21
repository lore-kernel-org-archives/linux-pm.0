Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5994B3C3BE0
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781949; cv=none; b=BMMSmX1mlHEJho8lQb+LweLhNs7z066iXjjmUBDfOJCdBJ04enjbU75YHJ5icoWuXc+U5338RzrWozqKgU5a4JDN0mor0Og1t+4x+29TR5OrqpZu66khmZ4BbH2Pzqf3cOyuy1p8SIPjpFi21rhj3SqK1Q8ZVGmuQfGTM7uxWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781949; c=relaxed/simple;
	bh=y8Mrf+JnVlF8PFrzrOGuurggSoZ7eOUF4VSd8PL9iSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2Ivbyetag8IRc2AbNyXruVCHxRb5tGa3L0GyLCmaryBJAAow9AUqKxOBVdPuBJpHTsEiJ2fk/I2qoXNfY10c68zUSgBUlLs3iDjeZRzhiA9mjLQ6fDznKZfKUdr12P19BIjRLkS4/H7qmu0322CLsUMYvT/mTdarZ/UCX6MSdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGf2CCtn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGf2CCtn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776781947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jAB+Dx5vhxlsIP+MacZVy1ahhGNIAgrxZqNwov43V5M=;
	b=NGf2CCtnVkea7jYtS1h9eydqXKHgAUrxd8/xezHPHT2fwcpv7Rr47id2l2v2Y+QI63YpF7
	86YIm41H9P8IMvicCADNHtQqFVmNBhxw2SqsZwCun0Etn0Nfk+iugkcw0WLMRGHef/4FrY
	bMmpQi/rhQUe4UGTl7KNXE2CCGXwfkA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-eM0kOu77O2S89t2LNr7F4Q-1; Tue,
 21 Apr 2026 10:32:25 -0400
X-MC-Unique: eM0kOu77O2S89t2LNr7F4Q-1
X-Mimecast-MFC-AGG-ID: eM0kOu77O2S89t2LNr7F4Q_1776781944
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B9AA1954B06;
	Tue, 21 Apr 2026 14:32:24 +0000 (UTC)
Received: from dba-icx.bos.redhat.com (prarit2023-dbaguest.khw.eng.bos2.dc.redhat.com [10.26.1.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E464B180047F;
	Tue, 21 Apr 2026 14:32:23 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Arcari <darcari@redhat.com>
Subject: [PATCH] tools/power/turbostat: fix unrecognized option '-P'
Date: Tue, 21 Apr 2026 10:32:17 -0400
Message-ID: <20260421143217.3717297-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The '-P' short option (shorthand for --no-perf) is not present in the
optstring of the second call to getopt_long_only(). This results in
the "unrecognized option" error when the tool reaches the main parsing
loop.

Add 'P' to the second getopt_long_only() call to ensure it is
consistently recognized.

Signed-off-by: David Arcari <darcari@redhat.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f1b8059a4eec..5c3b455dc1ff 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -11441,7 +11441,7 @@ void cmdline(int argc, char **argv)
 	}
 	optind = 0;
 
-	while ((opt = getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:N:o:qMST:v", long_options, &option_index)) != -1) {
+	while ((opt = getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:N:o:qMPST:v", long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
 			parse_add_command(optarg);
-- 
2.53.0

