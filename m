Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264547;
	b=zQhXa+smQ7A3jhIlv3q2zn064j3klTPcGhfFdjVdUGaokUihctf8MsDedgOsh7KFm4H6
	 wgwWfVA4HHBzoo7ppC0B604YSZtkCSFz6qR6Sw8smKZ17gxtP3yIU4jhVlv4dZn0CgUTC
	 xrmgUI5JNkRgmGoykRvdVxBejrUpXy+C3iLqz7jFlSy8Rq7i3KBtLF5iyGJnA1M8BUcZP
	 9DhgAVYKeLnCbbZJoBF+d5Bc3GDuUazqDFWnWqxa9Nn8jt1vi43k+oe65nR2LK+tWoxQv
	 czRY98fCm+BHRaQ1xr3Vjv0UCRuW8SfT10x6EZ73NweKjuKjeYr5ZcsKgPpS5F9BIMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Em6bj94swsrfUrSQCXEn0xceZl+9/C90nnaFaaRvExo=;
	b=OcfchytFvj8EULVAX9747OcGNZA3GCGiJKg4XpQ31XLG8qSFA7X68kgyx9B4YTMdIw8k
	 SkX+pu8dDO/bk4yNDTQzqsIdKCjHFjV9QQnFXNH4xT249hVDNUml/JZeebxFJXU2evMb5
	 qfd4vjVHfTWX3+5oZW9O1M8w2YFjnoAy0zv8XXaaZHdKR5ZM22Xet3eHwT0i2GLurFvad
	 RvDzPg5uUseREFrKSgNxueRpiZft6h+NQFv3nY9F2SMYX+PCD4MrnOY0iURq6R8pgi1Fb
	 HOL5Ot+l8fiCl/AOSv0XGaME4yYweZekAorj4wIWeMgdeoIgkbnyrWAmuEVMt6V/9MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v+GdMNW6;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287860A262C
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1287860A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v+GdMNW6
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35c76e9614aso2709207eec.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264545; x=1793869345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Em6bj94swsrfUrSQCXEn0xceZl+9/C90nnaFaaRvExo=;
        b=v+GdMNW6VY8ycTHLfDP4t6NciTC2osSPI32ktEngjDdXmrE1hV/8sVFvczzMG693wH
         roVa6n53id4X2dMpgKp+DjKqlllj47SDkvmmr5ezZIF6LlLu+SfhNQ39/aI40vZyy/Ou
         Z1x9lLclc65fddRgXyNElq4cBZ3FdzDnQWpxJBWLnGus4aXlTpZrVX2FyKbfkpUX7GqO
         UaDKWWAG9kKEfxQX1GODfbN966lJz+jj0swpTaqnlP09hOWI4hrbKWS7mXwGGaGBXmXw
         gl0z03dnYTdfH6Ezjkip09l+kSpsRBWcpFY8YDksWET3NGpvEJTPB4mI02mkjQWTgD9d
         xICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264545; x=1793869345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Em6bj94swsrfUrSQCXEn0xceZl+9/C90nnaFaaRvExo=;
        b=Z1GT4loIhdNZIVe2HxujqIekpf2odeZF2/IUexij8vWwJHyGiVl6fa38r4Bz1kIhjh
         jmUsBXpmgMrIqhYXc/yXFSlGaOr7QlEsJLw9ACPQbvaW+KF9QLn7dByH/3Np1Z72IT86
         mosrmvb+Hf8DfTmkbq4xl6OK3iel/JnsTwl4l1cc/3kVyxU4kRthxCVzm9tUbUw0MiMC
         FeLPhRasGNCWUg00Duy9RFLeCKla/Q2neS3U2D8lETL+GrzyHILXcZMiflvWBp1JPGpS
         Qw02whUg7eVAg5wj9hXFkX3zyW1cRPURghlft2dZng2Y95zcUY/0H4auJY92dUPfXmBU
         Oj8A==
X-Forwarded-Encrypted: i=1; AKwUvByQCiTY1Rf0KA2galS/tOrXb3GABDOS09CI7l3W8cxD3IFBWMjljEHaOafw0SGVqRbvzU6HFRDcwA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJsOLA98TLBu46czHAEZFV48OBfOvqVlAnKNVXjoXfLCtgiDvU5
	lPNGBJv+1S90JcQbQUGAIZgVAW9S6lkXUOA645g6/jC+Awx6AD4s5vA=
X-Gm-Gg: AYBFou0GDfaZk3UAk80+pI1qd7NH4054zwyYqWjWFzRIcpxPSOCLMcb5HXY5NPYcPPb
	GFYBue1dRWTTUi7MjLAKLmBfCcbY0nTPLfRjoYteAhS2aITW2aglT7Zg2hqObApb+4kC//zQ+nE
	ocDL/Vs6Sh2WyMiXt659OoZAUxtOx8YxoqMAnBysJgQ106KdyrIczE1VF9a766Qp3b190wlgiJT
	Ws8lUiJqrQMaf0i6FTDLJ8w9KfktWuxrtbWzLtWhpKYLW/ZK0aapAj6QkB2CwxqvtN0+4tHJGca
	DQL5X5FW1Pjw+24VkuCvyxDP+Fla7UVWONYD/laxVsqq9vI2/J6ZFIZ6s5blXkhl70PsWpNdJEc
	j4PM9dLs45arIpWZFchpdC0gA/D1V9btw08OGZ9AlO4Jx93MVus25xlObyCR/kqnqHx46E/zP5c
	oTjpytw0QyzgJYvPbSHR2vB/aQvt0FEJPBd59dZIgkNSk6JyKWVcu4m1I5qieWgXRqeHY3b0IkL
	BKR+8gClD+s7iCZi8PpVjPYPhX4quZ/nl1hN/jR3LQDS8MPbIVdjv1Z1/KFLBzfNw7ssGfM0pcV
	85F7EwYC5YoMxvdx0SF/mrRv2zvoHh2BD720jCX6uRFPGmnmm4rJa7f51Z414qTvePibKT8ELR1
	5q0kQ+x8=
X-Received: by 2002:a05:7300:7312:b0:358:ec5c:bef1 with SMTP id 5a478bee46e88-36a204773c0mr9949917eec.39.1793264544951;
        Thu, 29 Oct 2026 02:02:24 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.02.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:02:24 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Thu, 29 Oct 2026 04:52:11 -0400
Message-ID: <20261029085504.3547-15-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a /dev/smc device so userspace can talk to the SMC
directly. Some keys that need to be written aren't handled by
any driver, or affect several drivers at once, so they
can't be exposed cleanly through the kernel interfaces.

Keys already managed by kernel drivers can't be written this
way, to avoid conflicts.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/mfd/macsmc-core.c  | 155 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/macsmc.h |  27 +++++++
 2 files changed, 182 insertions(+)

diff --git a/drivers/mfd/macsmc-core.c b/drivers/mfd/macsmc-core.c
index bc4200f57..a30f7386e 100644
--- a/drivers/mfd/macsmc-core.c
+++ b/drivers/mfd/macsmc-core.c
@@ -6,10 +6,13 @@
 
 #include <linux/bitfield.h>
 #include <linux/device.h>
+#include <linux/fs.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/macsmc.h>
+#include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/uaccess.h>
 
 static const struct mfd_cell apple_smc_rtkit_devs[] = {
 	MFD_CELL_NAME("macsmc-input"),
@@ -112,6 +115,144 @@ static void apple_smc_disable_notifications(void *data)
 	smc->be->disable_notifications(smc->be_cookie);
 }
 
+static long apple_smc_fops_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct apple_smc *smc = file->private_data;
+	void __user *argp = (void __user *)arg;
+	int ret;
+
+	switch (cmd) {
+	case IOCTL_SMC_READ: {
+		struct ioctl_smc_rw_payload payload;
+		struct apple_smc_key_info info;
+
+		if (copy_from_user(&payload, argp, sizeof(payload)))
+			return -EFAULT;
+
+		ret = apple_smc_get_key_info(smc, payload.key, &info);
+		if (ret < 0)
+			return ret;
+
+		if (payload.size != info.size)
+			return -EINVAL;
+
+		if (payload.size > 32)
+			return -EINVAL;
+
+		ret = apple_smc_read(smc, payload.key, payload.buf, payload.size);
+		if (ret < 0)
+			return ret;
+
+		if (copy_to_user(argp, &payload, sizeof(payload)))
+			return -EFAULT;
+		return 0;
+	}
+	case IOCTL_SMC_WRITE: {
+		struct ioctl_smc_rw_payload payload;
+		struct apple_smc_key_info info;
+
+		if (copy_from_user(&payload, argp, sizeof(payload)))
+			return -EFAULT;
+
+		ret = apple_smc_get_key_info(smc, payload.key, &info);
+		if (ret < 0)
+			return ret;
+
+		if (payload.size != info.size)
+			return -EINVAL;
+
+		if (payload.size > 32)
+			return -EINVAL;
+
+		switch (payload.key) {
+		case __SMC_KEY('C', 'H', '0', 'I'):
+		case __SMC_KEY('C', 'H', '0', 'C'):
+		case __SMC_KEY('C', 'H', '0', 'K'):
+		case __SMC_KEY('C', 'H', '0', 'B'):
+		case __SMC_KEY('C', 'H', 'T', 'E'):
+		case __SMC_KEY('C', 'H', 'L', 'S'):
+		case __SMC_KEY('B', 'C', 'L', 'M'):
+		case __SMC_KEY('M', 'B', 'S', 'E'):
+		case __SMC_KEY('C', 'L', 'K', 'L'):
+		case __SMC_KEY('C', 'L', 'K', 'O'):
+		case __SMC_KEY('O', 'S', 'W', 'D'):
+		case __SMC_KEY('N', 'A', 'T', 'J'):
+		case __SMC_KEY('N', 'A', 'T', 'i'):
+		case __SMC_KEY('N', 'E', 'S', 'N'):
+		case __SMC_KEY('M', 'O', 'C', 'N'):
+		case __SMC_KEY('L', 'K', 'S', 'B'):
+		case __SMC_KEY('N', 'T', 'O', 'K'):
+		case __SMC_KEY('N', 'T', 'A', 'P'):
+		case __SMC_KEY('F', '0', 'T', 'g'):
+		case __SMC_KEY('F', '1', 'T', 'g'):
+		case __SMC_KEY('F', '0', 'M', 'd'):
+		case __SMC_KEY('F', '1', 'M', 'd'):
+		case __SMC_KEY('F', 'S', '!', ' '):
+			return -EPERM;
+		}
+
+		ret = apple_smc_write(smc, payload.key, payload.buf, payload.size);
+		if (ret < 0)
+			return ret;
+
+		return 0;
+	}
+	case IOCTL_SMC_GET_KEY_INDEX: {
+		struct ioctl_smc_index_payload payload;
+
+		if (copy_from_user(&payload, argp, sizeof(payload)))
+			return -EFAULT;
+
+		ret = apple_smc_get_key_by_index(smc, payload.index, &payload.key);
+		if (ret < 0)
+			return ret;
+
+		if (copy_to_user(argp, &payload, sizeof(payload)))
+			return -EFAULT;
+
+		return 0;
+	}
+	case IOCTL_SMC_GET_KEY_INFO: {
+		struct ioctl_smc_info_payload payload;
+
+		if (copy_from_user(&payload, argp, sizeof(payload)))
+			return -EFAULT;
+
+		ret = apple_smc_get_key_info(smc, payload.key, &payload.info);
+		if (ret < 0)
+			return ret;
+
+		if (copy_to_user(argp, &payload, sizeof(payload)))
+			return -EFAULT;
+
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apple_smc_fops_open(struct inode *inode, struct file *file)
+{
+	struct miscdevice *misc = file->private_data;
+
+	file->private_data = container_of(misc, struct apple_smc, miscdev);
+	return 0;
+}
+
+static const struct file_operations apple_smc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= apple_smc_fops_open,
+	.unlocked_ioctl	= apple_smc_fops_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.llseek		= noop_llseek,
+};
+
+static void apple_smc_misc_unregister(void *data)
+{
+	misc_deregister(data);
+}
+
 int apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops,
 		void *cookie, struct blocking_notifier_head *event_handlers, bool is_acpi)
 {
@@ -150,6 +291,20 @@ int apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops,
 	if (ret)
 		return ret;
 
+	smc->miscdev.minor = MISC_DYNAMIC_MINOR;
+	smc->miscdev.name = "smc";
+	smc->miscdev.fops = &apple_smc_fops;
+	smc->miscdev.parent = dev;
+	smc->miscdev.mode = 0600;
+
+	ret = misc_register(&smc->miscdev);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, apple_smc_misc_unregister, &smc->miscdev);
+	if (ret)
+		return ret;
+
 	if (smc->is_acpi) {
 		ret = devm_mfd_add_devices(dev, -1, apple_smc_acpi_common,
 			ARRAY_SIZE(apple_smc_acpi_common), NULL, 0, NULL);
diff --git a/include/linux/mfd/macsmc.h b/include/linux/mfd/macsmc.h
index 4b4368b99..29fd7b20c 100644
--- a/include/linux/mfd/macsmc.h
+++ b/include/linux/mfd/macsmc.h
@@ -8,6 +8,8 @@
 #ifndef _LINUX_MFD_MACSMC_H
 #define _LINUX_MFD_MACSMC_H
 
+#include <linux/ioctl.h>
+#include <linux/miscdevice.h>
 #include <linux/soc/apple/rtkit.h>
 
 /**
@@ -125,6 +127,7 @@ struct apple_smc_backend_ops {
  * @is_acpi: Is the backend ACPI based
  * @mutex: Mutex for non-atomic mode
  * @lock: Spinlock for atomic mode
+ * @miscdev: Misc Device struct for ioctl ops
  */
 struct apple_smc {
 	struct device *dev;
@@ -141,8 +144,32 @@ struct apple_smc {
 
 	struct mutex mutex;
 	spinlock_t lock;
+
+	struct miscdevice miscdev;
+};
+
+struct ioctl_smc_rw_payload {
+	smc_key key;
+	size_t size;
+	u8 buf[32];
+};
+
+struct ioctl_smc_index_payload {
+	int index;
+	smc_key key;
+};
+
+struct ioctl_smc_info_payload {
+	smc_key key;
+	struct apple_smc_key_info info;
 };
 
+#define APPLE_SMC_MAGIC 'S'
+#define IOCTL_SMC_READ           _IOWR(APPLE_SMC_MAGIC, 1, struct ioctl_smc_rw_payload)
+#define IOCTL_SMC_WRITE          _IOW(APPLE_SMC_MAGIC, 2, struct ioctl_smc_rw_payload)
+#define IOCTL_SMC_GET_KEY_INDEX  _IOWR(APPLE_SMC_MAGIC, 3, struct ioctl_smc_index_payload)
+#define IOCTL_SMC_GET_KEY_INFO   _IOWR(APPLE_SMC_MAGIC, 4, struct ioctl_smc_info_payload)
+
 /**
  * apple_smc_read - Read size bytes from given SMC key into buf
  * @smc: Pointer to apple_smc struct
-- 
2.55.0

