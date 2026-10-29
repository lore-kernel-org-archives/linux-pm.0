Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290734;
	b=AyE4SM4tWz0vYcsZFKbGIuIM/GMrC5MBAsgNUOpbv+Q7CBtH9eEyC3fLDNLtLMZeyhgL
	 Bb0eJM54mg3HsYrj0QjMAeyp+B6R2d6RKk89HW70g4H3JWFMr5cpLATs3NPHYuFZ+0hiK
	 Up42C0I/ysXeHN9++tnBt0+VPrkBX4p6kSMJghPpsTALKZ2jy/40rxNofAmsRm55PwMiD
	 TOi87AsYe1Z37G99U2BelaUrZFXM8tRbgyDEXhjhoob4pBoA9izUFfft6twkKlMlXLY3u
	 cLTUd8qJoqJ14WQNYUdFkGl8GUiX9rP20KoOndoLYKSKXFx+H7WNVi6b6ZBCUZ+dzhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zq0zjE9ryNr7xW4GezVEPmLmb9C42JNZT1hldeoWSRc=;
	b=HShnO4YtO1CnX4BcgX220QB//+ajg8C1eLYrQrxmR/a9nFUYpziogD9NtfG7ipCa/S+K
	 GTsm6Lrlx4CSB5L8sLms/jh6d5kupAyaEyqZhthtqRSdhNW14VnUTNmrcbigo3HtPoqeD
	 B4EIQ86SLoPZWT+T+ZlP890NZnDEfSyxhF1x3nZj3HC02Tdpz5YlFsbUYxZqVPpSSsddi
	 AnfNfC9obvMHnuHT9lsCWIk5a+C786LUI9zyI5OQLJxw3Rx+RnV15Au5Nitvpy/bMJ4sF
	 hvK/XFC69xqxEGSudfjyhHe6ga6y07/7yaAtp+eFIKn0cs9LgFiCHMddnOpB01llTeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tpke5zmt;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC0606A31D
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4FC0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tpke5zmt
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8241a56cd70so1477244a34.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290733; x=1793895533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zq0zjE9ryNr7xW4GezVEPmLmb9C42JNZT1hldeoWSRc=;
        b=tpke5zmtUnJlJkBJwzaPTLP3Zb97N2ZjiAIcZZcbR92Z94redxcxUvmGdukmvVEm+j
         10zAIHZFqFqr0hD6U4nvqsaARwYDlOkouShO8zSbkjydNSQ8UDkQYOpZPK4uucSYuRHn
         KtrBvEYaVst5BA/OhZJMWrjVBoa9mGliKZZktLM57yJkdeL+i++LJqkIAkSY+9deIvrs
         V3cFtRLWMhNrlgrtQcU20M++KQHZTDpx75P9CJYbgRYCJ6HS1ANbQ7LS2mOpxfCSkFBJ
         Z3etIj53gIuzTB/ewK1fOlYBorpv77w/+KI7mzyV+WFv+YN8RLAIoZhrwwVQf+SvzbVT
         +LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290733; x=1793895533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zq0zjE9ryNr7xW4GezVEPmLmb9C42JNZT1hldeoWSRc=;
        b=OOmZMoEYoHfDMGpVga1TcHe1IT3GCK+5Q3xcjm2nPLPi/w2UhTnfzg++qBgrOUcq/I
         cQGq3R//Wp7i0x0AuWhMUI5hJKtjASt9ayyEcXyKFnsdluNFPWCDjYYqEmszEJ/OzdO5
         jJy5QQ18Zla6BxFMXfuGL1X4VXA7SJKmv0xwFyoU8J1NpVHBdG32K6hA0xNyGfiin2eB
         OOCUhsvMcuSzBe9RKiMD30OQ7vkPnIeg4KTbPdXoHDv7U/skose1AqGjZWOCnggkiBhU
         6uGG8vtszM1Q95Gf/lOXIPvh6k34Cxc/MGoG0UAr8iEwlsZOmzViIHxJ/B/9PDxn6XiQ
         UcAQ==
X-Forwarded-Encrypted: i=1; AKwUvByG3+Jv8YzFJgl/npOVDOlAbUKzLUWH9VSH42/ZgM3aS9FYfsioU8eQSbMzjdIVazsXU0oplohSHQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIVFjbEE9SS90excLH/TgmPxDtMHC/7rSkhrZjSJ4iDKNABj89W
	XBDSmg1skN3TLT7a0i2rQupHMJzwCGv9L7qVd1FU3dK+dpIRbQuYzbFV
X-Gm-Gg: AYBFou2ho4ksnDCLfxiy6f2qASc3LB3N45FwE27ftUypv+PLEj5cX2pJJIh9dN/JQGm
	9+g4KU6p54e2/nJ5aV3xRCqz/JrJZrKQZ5/uSpvXCAdpRP5SshntKBiR/RTVZNN0O6goUetNnJB
	Oe9xmDTPEGw358rDZji+8nDkBB/L+5HrjI5VODBKGCtMel91qvfDMmYUxUVJtxQID3Kb12QhtK9
	JDXf4dBFP2XFiMCEdjxAR0rdAxsKCqP5swuhMZptbxfv/ikuJKfdsR8i8e8SYs3fmG/f64gPkb/
	ywKmAGkDCIhBX2holNN9W1m14eSLA4SjZLIT8Q8KcsCn/O6TdYVgyFaSoyGoCgFqj9Y0smcLAZp
	Jj1/aKlg7Vbt4m6BMa0Kly0P0MMFcgptLsS4syvWJzlxvzBrC3yWJsowfW2gxYSlOsAsJeR12yV
	5BCEsEW2NwPLx0XwGCNl0gx2fMeWJugVUop2gjNI0OKv4SE3B9SRPWIYgbIfnI50PtVKNKGFyNm
	h+o2ENB2/OaNrNqyqMqSlF03YdXe6g7x6f1356WyRM87Ld43hbNLahZBt+8wplVU6jvAdADcMXU
	6rYGv3ytBOijwr2o20Mce4k/bSjoQJk0e4hUs4QIcjstqhBcldsTsFM6wR7yCrOH5BG6BD+BHHN
	6aJJ5CbWPs3Q=
X-Received: by 2002:a05:6830:25c5:b0:81e:bb4b:2324 with SMTP id 46e09a7af769-85ac11bc5demr5500556a34.26.1793290732657;
        Thu, 29 Oct 2026 09:18:52 -0700 (PDT)
Received: from localhost.localdomain ([2400:d802:dd7:8000:180b:d22a:69f7:ac40])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d34045029sm262031a34.25.2026.10.29.09.18.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 09:18:52 -0700 (PDT)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: yangyingliang@huawei.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] powercap: Do not release the zone when device_register() fails
Date: Fri, 30 Oct 2026 00:18:39 +0800
Message-ID: <20261029161839.44379-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
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

powercap_register_zone() registers a power zone that the caller
allocated, usually embedded in a larger structure, and on most
failures returns with the zone untouched, leaving it to the caller.
Since commit 1b6599f741a4 ("powercap: fix possible name leak in
powercap_register_zone()"), a failure of device_register() is handled
with put_device() instead, and the release, powercap_release(), also
calls the zone's ->release() callback.

For DTPM that callback, dtpm_release_zone(), frees the node, either
directly or through the node's own ->release() for the CPU and devfreq
backends, and all three callers of dtpm_register() free it again when
it fails: dtpm_setup_virtual(), __dtpm_cpu_setup() and
__dtpm_devfreq_setup().

With one allocation failure injected into device_register() (failslab
restricted to dtpm_register) while rockchip_dtpm builds its hierarchy,
KASAN reports:

  BUG: KASAN: double-free in dtpm_setup_virtual+0x15c/0x19c
  Call trace:
   kfree
   dtpm_setup_virtual
   dtpm_for_each_child
   dtpm_create_hierarchy
  Freed by task 67:
   kfree
   dtpm_release_zone
   powercap_release
   device_release
   kobject_put
   put_device
   powercap_register_zone
   dtpm_register
   dtpm_setup_virtual

Keep the put_device(), which frees the device name and what
powercap_register_zone() allocated, but clear the zone's ops first so
that the release does not call ->release(): the zone is left to the
caller, as on the other failures.

The problem was found with kbound, a static analysis prototype that
checks whether callers rely on an object after a callee returns a value
for which the callee may have released it, on v7.2.12; it is present
in linux-pm's linux-next branch.

Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
warnings.  Run-tested on QEMU's arm64 virt machine (TCG) with KASAN,
with its device tree's root compatible set to "rockchip,rk3399", so
that rockchip_dtpm registers its two virtual nodes without the
hardware, failing each allocation in dtpm_register() in turn with
failslab: before this patch every failure in device_register() (4 of
4) gives the report above; with it nothing is reported, and the
earlier failures still return an error without reports, as before.
Not tested on Rockchip hardware.

Fixes: 1b6599f741a4 ("powercap: fix possible name leak in powercap_register_zone()")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed and tested them as
    described above.
    
    With CONFIG_DEBUG_KOBJECT_RELEASE the same injected failures still give
    use-after-free reports, with and without this patch: the release of
    the zone's device is delayed, while the caller frees the structure the
    device is embedded in right away.  Avoiding that would need the callers
    to free a zone only through its ->release(), which changes what
    powercap_register_zone() and dtpm_register() mean on failure for all
    their users.  I kept this patch to the minimal fix and can look into
    the larger change if you prefer that.

 drivers/powercap/powercap_sys.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 9197fa20d93f..eacbc3c96db1 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -398,7 +398,7 @@ static void powercap_release(struct device *dev)
 		kfree(power_zone->name);
 		kfree(power_zone->zone_dev_attrs);
 		kfree(power_zone->constraints);
-		if (power_zone->ops->release)
+		if (power_zone->ops && power_zone->ops->release)
 			power_zone->ops->release(power_zone);
 		if (allocated)
 			kfree(power_zone);
@@ -555,6 +555,12 @@ struct powercap_zone *powercap_register_zone(
 					power_zone->id);
 	result = device_register(&power_zone->dev);
 	if (result) {
+		/*
+		 * As on the other failures, the zone is left to the caller:
+		 * the release frees what was allocated here, but must not call
+		 * ->release(), which may free the zone.
+		 */
+		power_zone->ops = NULL;
 		put_device(&power_zone->dev);
 		mutex_unlock(&control_type->lock);
 

base-commit: 4785d7fc44de81f850101df9f8627775a6010c5a
-- 
2.53.0

