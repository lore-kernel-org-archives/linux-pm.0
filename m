Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962174E1C96;
	Wed, 16 Sep 2026 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593226; cv=none; b=FNLy5Vwou/zt0GpphBMPv4umfnXP0sGGlNnDa/2v8W1gxhVSKzKmNXAc7J+QvTr+l6rXYG+sD8VBoZ5eQIJxxtFLYBj5Mz856zJd8AHP7+ULOFhQqSoSvdU7BWpiJGQ8w+4bKTSUBhVugNLiWd9Gf366KXS64f9wLS0kmkSpVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593226; c=relaxed/simple;
	bh=qJUrC8VXySjaMw0QEUwRXNx6Xoy5CnlVQPrOEXS6f28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALbXpdkwFRuDp9VMixRQcM3UmLQVklBQag2JVRRuSAyWPN/t/1rBWWSZg3QfpdJ9hsAqd2b+BCJGReogERk+DIBgUzz+KRb4FVhO9mcXleVavdQe1EuhQln47SNX6vDJZ8KpdfONII1cPxxwZtsSXTMFWp19MUdxFVkzvKpxvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dohLMzS0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dohLMzS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716DD1F000FF;
	Wed, 16 Sep 2026 21:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789593203;
	bh=Qr8LnhYJFUtSA5D8VtGo9iYQs19fU+oWP9yAzZMiHDc=;
	h=From:To:Cc:Subject:Date;
	b=dohLMzS0oBlFlbPqKRH2k0zP73ekX1/LbWxmIocHkCKKeuXv6I2zM5Y54kShNFXLn
	 Na93qi8Mv5z/FwQ5Ku7aBpAgWmdEy/8SrnnQR1s9T43rswVRGNpebBGlHY7EmUoaIw
	 4UHK5RIUoEBHAMsgzzmIi9s+YTcXO/iZ7P8rOBHmjf5E02acAy/pcsJF882+pPGCr6
	 VVorAHCNO0TtY6ufcysAwQibwhFe/HnP7AMgqywm2Amc0zcBy4Q3dQAUinUuQm6ZaU
	 qolCviFL0cGeBGwwMrBQRKlnzUu1lkNN30g6f2YLDMfBaHjgqPzPbBy0I4cFwbpddh
	 Dv1lNbBHUO1+w==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Eric Naim <dnaim@cachyos.org>,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH] PM: Add resume event mapping for PMSG_POWEROFF
Date: Wed, 16 Sep 2026 16:13:14 -0500
Message-ID: <20260916211317.433349-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PM_EVENT_POWEROFF (0x0800) and PMSG_POWEROFF were already defined in
include/linux/pm.h. Add the resume_event() which is used when a shutdown
sequence needs to be aborted and the system should return to normal
operation.

This completes the PMSG_POWEROFF infrastructure needed to support
differentiating between hibernation and shutdown sequences when
re-using callbacks for common code.

Hibernation is started by writing a hibernation method (such as 'platform'
'shutdown', or 'reboot') to use into /sys/power/disk and writing 'disk' to
/sys/power/state.

Later shutdown will be initiated with the reboot() syscall with arguments
on whether to halt the system or power it off.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/base/power/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e130da4281410..7265553ba24ca 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1472,6 +1472,8 @@ static pm_message_t resume_event(pm_message_t sleep_state)
 		return PMSG_RECOVER;
 	case PM_EVENT_HIBERNATE:
 		return PMSG_RESTORE;
+	case PM_EVENT_POWEROFF:
+		return PMSG_ON;
 	}
 	return PMSG_ON;
 }
-- 
2.53.0

