Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257908;
	b=SYFOxg8NlryFg7E2CNMjkZK/2GE3hcpKwGylgGrjVnEXo0G4RuGo8KeuP3juPEtL7qdI
	 tL8y3jQjYwfsTc955HzWte0UNKDMODdiHhLYgyB0hR4DiMO2qO5LY2NrBACK+H35QfUc+
	 IY5g0YIWiHPyOtER+/m1asVslNcSvZoqkl2Y+r+wuO98/UobdBfigy4knkWuhfnWkEJVm
	 zobHfbg3SxscZQW783VdsFCyGgOkmgKAMT2MvpQz8lf6RmxEx2K5Fm6cHDp/6N7CmEU8c
	 yCvSr/eHXRg7nQsW5NnWVt/aoKS7Bi3fuGYyzCxCX1iQGOe7Wrc0mhbtl/UqKNrCrsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Iu7Uqt4YczqlMrxp9jzAO7KekNm49X3RSeLMX+ma4tE=;
	b=oCuvooorhW5m05dR7C/vXIk88aZq2VpAzVehVljokIo1zxjltHKc6UypkxKBflZeb2EY
	 JAUcbwyqm6v2ljkl1rn2/0DEo2RIiSniHyEIIfwKBIdWHqAa/XVHnHh4iQgJG8F76uDAM
	 PBn7rBm2iZZkwGDWWaqR8DBpN8C7litosRkb/fCsEW3epXQlwDFkUzoV7O1g7vlXUZGVM
	 OD2Pw9FGaSqWq3Po+WbtwfXfjfxC8qsy+M6Z3ZDALCWMWm5txy7cQveMHU2T3701Q43aU
	 y9xB0MdsUEJ4hac5L8SulFSkuTFGuaWsDlCbkqnSK7+dGB2k9Epe/xLXCRWI2hRGTkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RnbylbY5;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74F606A31D
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D74F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RnbylbY5
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd67d4bbdffso1391715a12.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 00:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793257907; x=1793862707; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iu7Uqt4YczqlMrxp9jzAO7KekNm49X3RSeLMX+ma4tE=;
        b=RnbylbY5TpsAV+pUsapBaJcX2gIJQOOj6Vbx1fYDLjvfitKc0kiwcEVP+6mNXflR5S
         hW8oTxs57FeA9+gGUM6bv2zvZ05drHDUVw/JN4ckopktY0gVRyuv1LIp+Qzp30p/YHwM
         nr96nHJcpDyytaocE+ZgpTYz71E3RD9VhcS2l6SDBLi+Ha+2C3QDduyGYhW2yC0CC/wj
         td6kIXqU+I2v9vzLVgz2kAXZ1RFhl2MRDPxJk36fX8tSx+9IeeacIOJ9EEZYIkK4ZTOJ
         qAvTxMBhIhQDDjjo7oUfmz7pylK0Lc8ZZkyAUElbmH47GEMOvgbhEmvix2K2iTVOBZp8
         AJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257907; x=1793862707;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iu7Uqt4YczqlMrxp9jzAO7KekNm49X3RSeLMX+ma4tE=;
        b=Akaguedb4XHaPK79TNHGgRPe1PPQn+8OGN1So84MQwoHIKJH0DTWdawhGDxuWhwIAB
         IfAhN3XA4UUQxptfOqLM2otSp0T5LNWvpn/hfNFdrdRmJ1yc2Cf4ZFzl7TFPmlctbgNf
         i3sUrAy3R/MXOb4xJxdjnmGAdWeEDD7eWDDD8H7DWlnuMhRjFmhZowIraHEfvBz6LOOx
         rC1VZhsYxxGUjCvWYIFnIySE2awthUIvtUgeBgnZ4R97ITWf0yecnqubY/Em6nLYNqIG
         Z4/rgkbzjZAo/7VRIY3H04Y6+IDoFzNXYE6euu7DrTut54plKdXRD6b4ZO8yyz2xWomf
         CN1Q==
X-Forwarded-Encrypted: i=1; AKwUvBz832QaIToWUeQhHJL5QJc/B4RY7iSTveR8jS5+rIlXa3uXQh7xRwhBeAeKqRYpx1OgYF61QONY6g==@vger.kernel.org
X-Gm-Message-State: AFq9FYLOorS6AzMKX+XOYqKPd+ocGT4TXqH8q1zuKW29NVB2MC6sCrk0
	5090z+94Z/ShYoLuauwONeri4jGUSRIjYm8GfSa8gcQTtFeOBE+yEQLZPmYwbCk7SNOycm1YYzq
	zZpuToxq7ThgCJ0/eC4aLXA==
X-Received: from pfbk11.prod.google.com ([2002:a05:6a00:b00b:b0:89e:861c:6b39])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:258d:b0:3e1:d5f8:692c with SMTP id adf61e73a8af0-3e90234d133mr4462716637.21.1793257907155;
 Thu, 29 Oct 2026 00:11:47 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:11:45 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261029040005.2100005-1-stanleyjhu@google.com>
Subject: [PATCH] PM: runtime: Update runtime_pm.rst for non-fatal resume errors
From: Stanley Jhu <stanleyjhu@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Brown <broonie@kernel.org>, Brian Norris <briannorris@chromium.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Jens Axboe <axboe@kernel.dk>, 
	Bart Van Assche <bvanassche@acm.org>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
suspend callback failures"), rpm_callback() no longer sets
dev->power.runtime_error when ->runtime_resume() returns an error.
However, Documentation/power/runtime_pm.rst still states that the PM
core treats any ->runtime_resume() error as a fatal device error and
refuses to run runtime PM helper functions until the device status is
manually reset.

Update the resume callback semantics bullet to state that on error the
PM core resets the runtime PM status to 'suspended', returns the error
code from synchronous resume helpers, and leaves power.runtime_error
unset so a subsequent resume request can invoke ->runtime_resume()
again. Also drop ->runtime_resume() from the ->runtime_idle()
comparison of callbacks whose negative return codes are treated as fatal
device errors.

Fixes: eef1d74bf88f ("PM: runtime: Only set runtime_error on suspend callback failures")
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
This updates Documentation/power/runtime_pm.rst as discussed in the v3
thread for commit eef1d74bf88f:
https://lore.kernel.org/r/CAJZ5v0ga8qqYg79+hQVtO8T=FOCj8XLmTz3HpEKoOykV_K-HSQ@mail.gmail.com

Two .runtime_resume() paths assumed the old latching behavior:
- blk_pre_runtime_resume() (q->pm_only underflow):
https://lore.kernel.org/r/20261029040001.2100001-1-stanleyjhu@google.com
- __ufshcd_wl_resume() in UFS, where after a failed resume the retried
  resume releases the clock-gating hold a second time:
https://lore.kernel.org/r/20261029040002.2100002-1-stanleyjhu@google.com

Should other .runtime_resume() callbacks that undo suspend-time state
on failure, assuming no retry, be audited?

 Documentation/power/runtime_pm.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 40a5c23d5259..04dc2a538352 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -222,11 +222,12 @@ what to do to handle the device).
     I/O operations as needed.  The runtime PM status of the device is then
     'active'.
 
-  * If the resume callback returns an error code, the PM core regards this as a
-    fatal error and will refuse to run the helper functions described in
-    `Section 4`_ for the device, until its status is directly set to either
-    'active', or 'suspended' (by means of special helper functions provided by
-    the PM core for this purpose).
+  * If the resume callback returns an error code, the PM core sets the
+    device's runtime PM status back to 'suspended' and returns the error
+    code from synchronous resume helpers.  As with a suspend callback
+    returning -EBUSY or -EAGAIN, this does not set power.runtime_error, so
+    the helper functions described in `Section 4`_ are not blocked and a
+    subsequent resume request can run the resume callback again.
 
 The idle callback (a subsystem-level one, if present, or the driver one) is
 executed by the PM core whenever the device appears to be idle, which is
@@ -250,9 +251,9 @@ call to pm_runtime_autosuspend().
 To prevent this suspension (for example, if the callback routine has scheduled
 a delayed suspend or determined the device cannot be idle), the routine must
 return a non-zero value (typically -EBUSY or -EAGAIN).  Unlike
-->runtime_suspend() and ->runtime_resume(), the PM core does not treat negative
-return codes from ->runtime_idle() as a fatal device error; any non-zero value
-simply stops the PM core from suspending the device.
+->runtime_suspend(), the PM core does not treat negative return codes from
+->runtime_idle() as a fatal device error, and any non-zero value simply stops
+the PM core from suspending the device.
 
 Core Guarantees and Synchronization Rules
 -----------------------------------------
-- 
2.56.0.313.g2479322e68-goog

