Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C947CC8D;
	Tue, 18 Aug 2026 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069934; cv=none; b=drTT1YeHMnaRbY4T60KAUeY73z1XOD/65vlr58rbW3TL7rxzJtthmYigUHyogvUzF65z2a1n2AWii/1mXq1rMboAma1sPQ9htdIqR4XweywaytUzBZTwhqN3bWX6UBMxZR/qL9ieA7EqceBJuImDm6wZr2WoNuAuaWg5Cd3ZA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069934; c=relaxed/simple;
	bh=1ScycsAa5oOmb6+2okTCaHSYs7E/VybkZJAYubYjwkQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=gAJVS9VCZG+YGyTXkISSbtiGb4gUDMNUOkCVrvJbV37OlU02HxmsNzPh6NFjrDY9WwaqYI6OuUT8I7vawaIlA30Loemq1wQVhjwMA1bQDNMeYjWgvytzRYxu8GGHCnKf1EYu5/VzMCoGqY+iUaWce6Vg9uxZU8Wd7wzEIsHOZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kceisutE; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kceisutE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787069922; bh=7yFVWt2ZhQx0h57GYNYoYDR6FUUtvz+o1d4NQW0TJkQ=;
	h=From:To:Cc:Subject:Date;
	b=kceisutEDhu4w++sxEEjXXzABDNc/2obLHLPWjn8PTMfe2nMn8aIWhqwn54TI0qJB
	 u3ljnYaljZDLsB7WxRK9vL9XtTfGAnjdmETvvV6hdXmJh6jQUsFKKECOr/cCP6H1+7
	 wjeZHXgcGzlAKZR5o9kFK9FRy+Jc1yQuDXnWwrBs=
Received: from zs-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.. ([124.79.168.208])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 4A79FA19; Wed, 19 Aug 2026 00:18:39 +0800
X-QQ-mid: xmsmtpt1787069919tzegpa7zr
Message-ID: <tencent_C5AC0A02FC01F700E764F8C2E3ECE4F41009@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujx3GZKOoy1qvB8rhaucD0H9CBaJ64/hrODxuJNeXMbL3megbJUb
	 rQXMVg338xQjf2CN6AfrAmWwzK1EMg8JAJ3tNk6Jcq0qRSAbfdo2XI0tHMu3n6NGQRt5ly+C8WGa
	 N84BGF7O/YXgtk/RahNSrXWu0WW/FudFnofc9YzFUSMaqFqWh3NsUoHjMzcMj3hZ1BvhAhuK9QVq
	 NZkeFXwPm0KEJyXFUBngh2ak/WgTNPg9tjmdxBq+vaBeg6ZwEK4jnUiPQj5hELmzLIG1yeH1vs1c
	 iEglOUgD9DFud/QfeABtx8SLSGrD+9cHuw1T5TM26CbJ4/+JRVT+bEy8k6P/nfIgsHkmo971To0r
	 dkNUzX+UmhN9CfBA7o93BE9MFLpXvHyXAiI3kkHKb1jbOZj+noF9v+RSfwLp4sTaPM87yv9jma3b
	 YkwHNpDlohsikfmDqwOYzUrY+ckSFfGbwDixBLgEvTu1XzY8qqsulkhrjKlAwsz4l/hzFk6IMDzH
	 6FQww7ZwOLZyaViYZbdPwnWWAoMkKza+lfwW8nIyOjmjpZLdYuNFcXWBPirVGcgOimxQxuAvDPoX
	 A5gDK2yJn8deyYmvCEz8oVhxS6TU5fmmKeZ9GgYbEXF9qlZJ0CUZjWyVolNfV/XpjjK2MPji3QIR
	 HNUmqtZAh5OOd3RVgzc6I73NGujSzJcaEi5s2jmJ4wYoorV6TXmKEQtq5YIOsmqfwndrIVTB77EO
	 8IiPEbiFSC7Y/sYJCxgoR4fuPg+lfTYKP5Ex7ipp5NltVBL4IFG7meCempqjv2tqFByIYTuy7hVh
	 L+mZdQXGXpMiMfvqFjjWRMUn7i/0LOju1201r7lss39rbiAxiBTgA7JQTIwyhQ8Xu/UYiCXZKw+e
	 AmuO37YH0/djh9bypmfLz3i1Tbu1SarUaUTwqrCf9k3asdGWQ/oyQHkgwJpK8OXY7fZxk2AibC/x
	 qEKx5ms/iINynS9Xj2nJORbAWD1JxeX2f1asHSFcLSdnJmvgVCxweKd6nl9x6iSx2Hda6t/RXYDq
	 VEHBIflY9TTmSU6YhHQN/gU9znZO5MeDUIA9Pi3QnuDam74V9VQF9vxU9oRYk=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shibo Zhu <3499129952@qq.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] PM: sleep: Unblock runtime PM when device prepare fails
Date: Wed, 19 Aug 2026 00:18:39 +0800
X-OQ-MSGID: <20260818161839.158128-1-3499129952@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device_prepare() blocks runtime PM for a device with runtime PM disabled
before invoking its system-sleep ->prepare() callback. For a device that
has never enabled runtime PM, this changes dev->power.last_status from
RPM_INVALID to RPM_BLOCKED.

If the callback returns an error, dpm_prepare() does not move the device
to dpm_prepared_list. Consequently, the recovery path through
dpm_complete() never calls device_complete() for the failing device.

The error path drops the runtime PM usage reference, but does not clear
RPM_BLOCKED. A later legitimate pm_runtime_enable() then reports:

  Attempt to enable runtime PM when it is blocked

before clearing the stale state.

Call pm_runtime_unblock() on the prepare error path before dropping the
runtime PM reference, matching the cleanup performed by device_complete().

The issue was reproduced with a platform test device whose ->prepare()
callback returns -EIO while runtime PM has never been enabled. Before
the fix, last_status remained RPM_BLOCKED after the failed suspend and
the first pm_runtime_enable() produced the warning above. With the fix,
last_status is restored to RPM_INVALID and the warning is absent.

Fixes: 3e5eee147b7b ("PM: Block enabling of runtime PM during system suspend")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: ChatGPT:GPT-5.6 Sol
Signed-off-by: Shibo Zhu <3499129952@qq.com>
---
 drivers/base/power/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f71467f6ada4..4ed2e9b7e99b 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -2234,6 +2234,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 
 	if (ret < 0) {
 		suspend_report_result(dev, callback, ret);
+		pm_runtime_unblock(dev);
 		pm_runtime_put(dev);
 		return ret;
 	}

base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
-- 
2.43.0

