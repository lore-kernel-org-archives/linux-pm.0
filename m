Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B5C3BBA0E;
	Wed, 29 Jul 2026 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309127; cv=none; b=YnM1ZKxWwRVXrxc08LH2clndwM2vamg04Dm1KS2dwG+uGBuRjla/i4MiFXXiIcgiR0RxIg+P2DmpUY9CLkT/dq0qzEHHiT7w96BiYAW3mcOYQ1+OmHWgip1OdtJMaEPiRAPEqE5mw6rggCqN2EcbGQkXfZkvqeb0NiBcxrSQ0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309127; c=relaxed/simple;
	bh=0jBSwWWxAPh2XhzKlKX3Ha/G7MTAa4fmccZf+ivZit8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eE+x5/kyJ9Zi50Bx+atpzCDDvO8ULu2RfiT8Q/kTCZ3yp5wCZWacixKFrEjdLQv52oj4cL+vI/q62zy1Dxn1tnrz36UoEkEr5vSiDssQaOtVniOZKyJK7nI1jZChmDhxdhQtOe16u156p5v554QwAKCyXHJl8dD9/1Y8b8rl5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=OFHIbaRs; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="OFHIbaRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785309115;
	bh=ItAzDrGXYP8b6c97M26jIDQMPp6eaBvh2rEKaBw/1IQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=OFHIbaRsOTjWdRnwsUZ3WL8hir8N4KeeRsgLOEoWr9vW5pR8v6QK5Kh+9J7ztvmtl
	 XVYsDRgS2WZPuveMlwU+V03KqlDILSQyUV1yIitGkaaMhDj/bRXGkIY2k1hyMZtfpO
	 IlqKEyp6JauQkC7c4nS/HNLmimjyXyed+8lbTKHE=
X-QQ-mid: zesmtpgz6t1785309103ta048b11d
X-QQ-Originating-IP: 2KaEe4OPHTK3VuFLrCf1V0uN+XzuixMQmanUNhrWej0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Jul 2026 15:11:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15843917138568715823
EX-QQ-RecipientCnt: 15
From: Haowen Tu <tuhaowen@uniontech.com>
To: laurent.pinchart@ideasonboard.com,
	rafael@kernel.org
Cc: gregkh@linuxfoundation.org,
	hansg@kernel.org,
	kernel@uniontech.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	oneukum@suse.com,
	pavel@kernel.org,
	stern@rowland.harvard.edu,
	tuhaowen@uniontech.com
Subject: [PATCH v4 3/4] PM: hibernate: notify on image write failure
Date: Wed, 29 Jul 2026 15:11:22 +0800
Message-Id: <e2b88a0b33797b36ce4b1c8340a9f33d844fb79d.1785226280.git.tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1785226280.git.tuhaowen@uniontech.com>
References: <20260723084633.GE648629@killaraus.ideasonboard.com> <cover.1785226280.git.tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mfy7wfw2LMQ4F9Vpyw4N3tk1S5MfL5MK6bnS4EsOq2FSKhM0oVocn0a9
	V/8ERSOCv1xLQ4PBrmjwoZLVEPLerrNTHCW6f7/Y8I6aHWLtFnX9J3opA+kaT9U7DW89FtL
	yPqUx9xz0CIqWVF1i/pgs6SbAC7BUJwYEQKREQB0sImeDz9IwhRbbCco8ThhXAbWqWo/Vmv
	3CjvyNGgBALd72GUdnHZyXcWeQRNYtQxWz/xC6Ksi6kSwxtjumMNLRq+5xRDAOHyyivEgNt
	hsiREn17PCDFFwjMGEfIXZIOfyNoXegmMzEMlToouIu6hKV63nJcM6kFDgrGxpfP+1NGEBY
	M8j5MP7Urx6UvoLVx7J3Cpd7+vFZzHKhnOfIQ7QsZTZcMPwoQU5n0QuEaaKTwvRnntz2A/0
	4mJdxEu9qE8LXzi9BCJjoDk0OS2fzWxc6xGx+CtCJtcbkZ/cTz7di+Vsk32uv8jHxTvj12Q
	M4T1MeDOmMbmdLu/EU3rbRqhasYinVNYp/qtIWFE+Uqv7F1aStELLusfTMstjwc1IHOLLov
	X59JxNffsC8FPiFQ5kJ1IZt1RsiMR4Ocsa4BqGsXYFOalVdHq1IRuwfiLakkjdiMLVrdswF
	YEYpDUmRcP5gx/Wlr3iosnG6spTCOQztUi4sF8H63RVqlqFYOgZSu0VxY5geVCRRqBasdJh
	WSq/+pad+ji52xCYj8nKvOinnY62C+pLdmsMWsihA7RmlrOoyKu7Q/joaiw1h8SVvdHRRrE
	9OKqGo5QZS0arfLBWu4lGx5cUJW4c5Tm6FCseyyMyy8B0UNqmGG59VXJPYMW146KtT37HU+
	ZwcaMxggAsV11wR1/rhDfTdsgyFZJ/DQLbzQ6dOI8a7LP0nTMNG/RWZyxaLR7SI9KwpPJWX
	4CKIosLH744mOI3xajsBK2nLn2lhl4HduEKYhStxU4M8C9fWgnupttpGNuSmRRn6xo65hj8
	c0+k0GWBHv36lcVQp5W+loonUhgdRVwmOO7Zm4DWg6DqY7/9sRtmyPxmt9/CBEYbpOjOwlR
	WzRjsDbrtmEkdhPuOqIPWbsvcdBHUan+ARlr/whrTeKF5+NVNWQfZkYXCXDKk=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Some drivers may defer device-specific resume work after the hibernation
snapshot has been created, because the system is expected to either write
the image and power off, or enter the test-resume path.

If writing the image fails, however, the original kernel continues
running. Add a PM_HIBERNATION_IMAGE_WRITE_FAILED notification after
swsusp_write() fails and before userspace is thawed, so drivers that
deferred resume work can recover their device state before userspace
observes it.

Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
---
 include/linux/suspend.h  | 1 +
 kernel/power/hibernate.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 2cebbec3e2f7..36a5b3a8cb38 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -441,6 +441,7 @@ static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
 #define PM_POST_SUSPEND		0x0004 /* Suspend finished */
 #define PM_RESTORE_PREPARE	0x0005 /* Going to restore a saved image */
 #define PM_POST_RESTORE		0x0006 /* Restore failed */
+#define PM_HIBERNATION_IMAGE_WRITE_FAILED	0x0007 /* Image write failed */
 
 extern struct mutex system_transition_mutex;
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 045d29f55011..592862fd45d4 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -890,6 +890,9 @@ int hibernate(void)
 				power_down();
 		}
 		pm_restore_gfp_mask();
+
+		if (error)
+			pm_notifier_call_chain(PM_HIBERNATION_IMAGE_WRITE_FAILED);
 	} else {
 		pm_pr_dbg("Hibernation image restored successfully.\n");
 	}
-- 
2.20.1
