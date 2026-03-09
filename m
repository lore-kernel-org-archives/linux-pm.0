Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD532F068C
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078009; cv=none; b=SYOKPCNX+/R+qqv52SAusy0QGGZ2IHoFHO6aQ1meZ8ijGAZH8H2Pfpz/cHboV6zyyAMu+Xq95xtDKxz7Swb4IgWTLxfGkFFcIw8hqc+b1MhIsKc05zhie8YVbrb97uMrGntqMxZw/Cprgb2/wF7Da7rpH+6BGYXrpOiH7HqJqG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078009; c=relaxed/simple;
	bh=oCEhlLZnAMET3W8cPKj+kER/fOP29DvPax7r06L+X0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVwMbu1OClYJBplPI9aKw3HuA9qVC+w5k8xJjYVImdqfKdcTVhulNKfc78bT5S2Uaxkiw+sbUpK4NIDehMxdeA220B3fXFLeo3MsT+KTKFOk+t9ibchKz+SAeDOmQ1mlpY7HEQR5oluv46JHHrBpTdVTlcwrgp7gnGKiToJlnjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GBYI4CKb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GBYI4CKb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=X8iZt8ctlycm1iwZX/d4mwj5+lFShIkjLCkahGTR4VQ=; b=GBYI4CKb8sbWjA8qr29ub8p9fv
	q2odQ3CytdVcOtc4vPjkTef1O6G4rLYzMIULQz7OyirYGNC4aytfdjyEIB7K6KpZqaLul9zz0+ehm
	UANrsbPegcbus5iWSmSs0BEca4p3jWlpu371K92sjPuibk7jf3Kd/Zhs5dy9hOyPNNcvIgzIh46DT
	VUv94fULdlLOx2MZIlm8UEV/6GuuViEc1ituWsg7L6VLK0LbHtjc0WEsZZ12LmR8fW4XIIkYhg5XV
	fT261yMhvnagOoZ2C7YriylEnR7YyMGMua3sCglbh0fW8O70eclT3LAwx4nvRoyhM8avSSdes8RCg
	ivx6TYyA==;
Received: from ip40.wifi.igalia.com ([192.168.12.40] helo=zeus.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vzeaI-00CA1P-Ng; Mon, 09 Mar 2026 18:40:02 +0100
Received: from berto by zeus.local with local (Exim 4.98.2)
	(envelope-from <berto@igalia.com>)
	id 1vzeaI-000000009Ll-2a9v;
	Mon, 09 Mar 2026 18:40:02 +0100
From: Alberto Garcia <berto@igalia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-pm@vger.kernel.org,
	Alberto Garcia <berto@igalia.com>
Subject: [PATCH v2 2/2] PM: hibernate: return -ENODATA if the snapshot image is not loaded
Date: Mon,  9 Mar 2026 18:39:42 +0100
Message-ID: <8cfda38659c623f5392f3458cb32504ffd556a74.1773075892.git.berto@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773075892.git.berto@igalia.com>
References: <cover.1773075892.git.berto@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snapshot_image_loaded() is used in both the in-kernel and the
userspace restore path to ensure that the snapshot image has been
completely loaded. However the latter path returns -EPERM in such
situations, which is meant for cases where the operation is neither
write-only nor ready.

This patch updates the check so the returned error code is -ENODATA in
both cases.

Suggested-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 kernel/power/user.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 4401cfe26e5c..be77f3556bd7 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -322,11 +322,14 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		error = snapshot_write_finalize(&data->handle);
 		if (error)
 			break;
-		if (data->mode != O_WRONLY || !data->frozen ||
-		    !snapshot_image_loaded(&data->handle)) {
+		if (data->mode != O_WRONLY || !data->frozen) {
 			error = -EPERM;
 			break;
 		}
+		if (!snapshot_image_loaded(&data->handle)) {
+			error = -ENODATA;
+			break;
+		}
 		error = hibernation_restore(data->platform_support);
 		break;
 
-- 
2.47.3

