Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D723FD970
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491601; cv=none; b=XSokFaY/BccSpuEjOqCH1AYNf28nuEtssPbTsSISRQhH2XGHsoWWLkD6AJOzpAmIduHwQg2LWD1v27+0u0gw99khlU8gENNsgQWv//wyex/o6SkuKPcIDKx7beYLQy7G1eM1ntbJnUOGfbO4Dz5eZmcUz/tFq10S3kkMDi8QVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491601; c=relaxed/simple;
	bh=0r4awvo3WX8HpQ0jmDWfm41yxp/V5lWErULOVsOPMpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sXpWmjXMMSk8QEskAtg8yn0Qv1liyN+3yjWAM24wZDLv8eE3vNarTvzl9AvOw+Q4EOKgwd6kOOSg4wCgwGNAlaNii9rCdokec6uZcqoJd28hjnQUR6AeS7y5uHSbDGsg1xGG5Gg64AQPcvBEi3cirKTJZ44sREVrLKe8TXgU5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9f/HDq0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1e0xIaX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9f/HDq0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1e0xIaX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782491597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kw3/l9vbkRy63uWAwl6dQq9fs/WXuwY+XB1uAAWGcwc=;
	b=I9f/HDq0/IHUBkFQXqGmBl8DqXh8mK7FJWJoGnA1/+lStpYB//jL65IiWvoSrGyiBySRUz
	V+zyO1UhPWvW6wrIAhSQe/3uD6wIs4Bkk63xB30ipvNiCkhdzhT8DnXaMC3+srrVmXeEMC
	E8ZVXeIN5H1RNWb/6rRZltdBdoH4DKc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-WlbD5MUnOuO7GSWGcFDyQw-1; Fri, 26 Jun 2026 12:33:16 -0400
X-MC-Unique: WlbD5MUnOuO7GSWGcFDyQw-1
X-Mimecast-MFC-AGG-ID: WlbD5MUnOuO7GSWGcFDyQw_1782491596
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8e97889ac8aso7353376d6.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 09:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782491596; x=1783096396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kw3/l9vbkRy63uWAwl6dQq9fs/WXuwY+XB1uAAWGcwc=;
        b=F1e0xIaXoHUbjmRZjBh+oiOBavFDOlR6eOOcszDKLzIBkyjCpOuR+KDSqNuDkgV774
         /pkeF7URo+HJ3K+Jqjs61606kklt+lA2YH04arHog10TpiSse1bbk/n7hDlXTUq11iWp
         KfjNgfv24vG+eAYxyA8gjvRcPEKEbKH8rXewkwMxqLrHtlYaDo84H1eNXRgVBxbHE0Eo
         Ywr3TYJIcZ5q2+KZctCO5Y8pyYvd7In+HklTjDEg2hgb3Nes94C2y5hXPQhOE3rv7aXX
         8AyBXbd+gPd/OwpCn4RBkviawbpqw3eFm6ZAv8wSzxmVSAVEj644L8DgDubeItLUFFlY
         ihpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782491596; x=1783096396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kw3/l9vbkRy63uWAwl6dQq9fs/WXuwY+XB1uAAWGcwc=;
        b=lUxucO35cOcYR8EI09sIQLeNafRpu/ckBSvebxqKZqurqqypDcPXoIXfzaIaN3jxyx
         AFkfB5Mn5dbvUwJqY1u6lv7mBruseijpl/pYHwuCSkCnIVPkgnsh28QJ9o0z3JEpfSJu
         CRpO0u3yc7fYfEOtdjeqsFsFmSA3dLpRfK2vEcQMsd3tUOkhZnA5wuwSBoXLX7FSthwz
         TDKFLvd6CWlVgT628Zqq7DZ8JqbuX1yxkGjaQtrZWr+lk0j9r/wjl/2oeCVHAKxfb60Y
         Zd2pmdLpKOCjuM7DIWKovrMhRW8xU6VYhdcHmB5VYlupHHSg0Y6zODynHhoUUAcPX/M2
         Iv+w==
X-Forwarded-Encrypted: i=1; AHgh+RrxPGtnBlvoG5/GvJ1nroK0tWs5hEd9JPlsmxM79S3NtKgNnGFgKJvcGYJBMwOO19PdXs6Iiw8kwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQGG8Ns8o3CUuixRsv2WEIuSjLcsrV9xkqa4S9xeK9mGhkXNbf
	XnDVOJ6V6S+RTjPoi8LZOCUIuZygC5UrQvBakwKF2BOWiQeEpHTiA+NMZp1yMWpVAFchd62L8YA
	9+RslIwu2caFpQvLe6yzan2F0NDEjnHdgMp4rea8FZcwXSSqQ0r6qNVw2J4wH
X-Gm-Gg: AfdE7clz3BWNXilUNDAqfrpcssZ7mxDlB8a19THmNk/jH/u5J+jF4koDLsCB++QHf9X
	dLLBf1nzi3XdF1JiRryCUm32eHsrdDxUGxM5szuhJshNxJN4NXNNbWuD923tAzgXEAYotF/uJ0k
	wR4UUGEN9wKPTsc8P0ngvNdRpAvKQilScuQAlB4w0PNNPqdoAYnbFAQlD7wDZxN/91tr/93JNjP
	RedXVwcCy4L9i7tmwLTvsLATkwZ4yY0piGvSMTxOuBBLBv3RdHi89CN847gP0XHyB+Yj9CAozdm
	5VYb1nDJCRZhsice/dp4RVMJzk6JP3gPu897IuP5VcoXCTc6qVg5QXpHeTh3Nxtwin3Nf8gSrgZ
	R95oHrCnC98EXuJWfyjoqx/aH+Re1hitQ50/Gfc3PBLeL5JPcxg==
X-Received: by 2002:a05:6214:f08:b0:8ba:3fc9:88ca with SMTP id 6a1803df08f44-8e6d6288e1amr126314686d6.39.1782491595692;
        Fri, 26 Jun 2026 09:33:15 -0700 (PDT)
X-Received: by 2002:a05:6214:f08:b0:8ba:3fc9:88ca with SMTP id 6a1803df08f44-8e6d6288e1amr126314206d6.39.1782491595157;
        Fri, 26 Jun 2026 09:33:15 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018566sm234540526d6.2.2026.06.26.09.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:33:14 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 26 Jun 2026 12:32:44 -0400
Subject: [PATCH 3/4] driver: core: remove dev_set_drv_sync_state()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-clk-sync-state-v1-3-4156d8196dc8@redhat.com>
References: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
In-Reply-To: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Xuyang Dong <dongxuyang@eswincomputing.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>, 
 Maxime Ripard <mripard@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=0r4awvo3WX8HpQ0jmDWfm41yxp/V5lWErULOVsOPMpU=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLsVh4SmnZ/eu+lX9xbTjbc2WlU6P9o2mTu3INrcnQOn
 quTl1vq0VHKwiDGxSArpsiyJNeoICJ1le29O5osMHNYmUCGMHBxCsBEttYw/LPqCjq9dLLlFIv4
 vS+OMCRdDS6NnFbj9jikMjbqctaWUGFGhoXZFyZ9r5+SOvGeS1TQ5jVLJsy9HVIYb5ivJH1gc9/
 hdRwA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

dev_set_drv_sync_state() is no longer used since all users have been
migrated to dev_add_sync_state(), so let's go ahead and remove it.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/device.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index b7a3dd4b56ed..7f71217ecd48 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1128,18 +1128,6 @@ static inline void device_lock_assert(struct device *dev)
 	lockdep_assert_held(&dev->mutex);
 }
 
-static inline int dev_set_drv_sync_state(struct device *dev,
-					 void (*fn)(struct device *dev))
-{
-	if (!dev || !dev->driver)
-		return 0;
-	if (dev->driver->sync_state && dev->driver->sync_state != fn)
-		return -EBUSY;
-	if (!dev->driver->sync_state)
-		dev->driver->sync_state = fn;
-	return 0;
-}
-
 struct sync_state_entry {
 	struct list_head	node;
 	void			(*fn)(struct device *dev);

-- 
2.54.0

