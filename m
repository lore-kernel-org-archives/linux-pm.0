Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634F38AC7A
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817670; cv=none; b=ZC7Hox4NHeP6sYqC5sPj7bbgsEh1PJUP7pdhGAfBO3NiKNDbJUkmrEUotTq7E2V2PD7/oRsWmhgovLQkIuabfzZ0rHmCrTNzsqCRRaYOv5ZyvFCzKJWvvN9yS8HN/jGUdoavoGOdebpqTrMQPDwTNjGPIbFaHKResGO7kuzknp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817670; c=relaxed/simple;
	bh=8Kq2004yGYvDmGpLcFLftKKbGVL7vNOIYvDbWawQjjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6x7l+SXrBRz0W0e17mIjm/aGiUl0f0edlTyAgFIlmGMhGarbBZ+sEE3SEsVp9hCri+Ie/jZws7aKTaXwiXtyBHu6MU68VMW0wXR9f+MuYFPafzofU0CzOZJ8MD13kuQfUaDbCHrx4853aHRCcwwuZ9so40ro+k6Wi5kK1uKU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O70kUc4I; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O70kUc4I"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38cc0b91b01so15331061fa.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775817668; x=1776422468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/73f3/gKMGjhlSVUm1EFqbVBE3w9N0gOSLL9TifoTSo=;
        b=O70kUc4IyIZsPDCMX0M/QfNFbUw6LRk3bdFwMHclPMQyUBzbPKa3uMFmukliuneBkY
         ZhEBlAFRN/M+4B/cDlNZ/y8myfw0FTEi6G0cS4DBj7AILSEJhihYp3GJPbfC07ox8Ysw
         NyGHVB95AErTIBAb5le9DpqQ9h5l/KmCRMlrIDl5ujjd/XFNj2XHPBARol2omFryzSYa
         7iU1DssRBy9MRLr1dTBhuVWuisDWFUtxgFbV/HPvvT8wATP9a3YGRdsAfuikegS8++uk
         mETbVeap8d12dHmA1bBu32YYax19cxh5amp35mk+QWig5RKiJ+9aSJ9ZpWfQCJZ5/1LI
         i+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817668; x=1776422468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/73f3/gKMGjhlSVUm1EFqbVBE3w9N0gOSLL9TifoTSo=;
        b=nEbxhNvehIWYAnUOqKB1CNHy+FR4xXMhE14K9jh1MNrhu5cqYdvEEGJd4m2uHNj9RA
         WUYvYCQYIvK3A/FaxIyC9tgf5IIUq1/SK0ym5UGhT3yLg9LDNovq5ZXavHaHVQ1N/4jI
         rnrbbFsUQtUUm53+DrIc+qc5cc8EmI3SqqeoHJ/MR8UxFJewQXZZctRH1O8S4eDSUAer
         BrLKt2Fo3jYa/QsGbozvNqzLcIOy7fK9XBsmV92EHu9IOy+FSSv1JbzeLuGzQFW607At
         zuwWmtkhMIElA6EtZMY42qGeXk4MkocrbaaNpcvTY8Lie6Xk414JNjbEVjKNIK/hBO+a
         P2TA==
X-Forwarded-Encrypted: i=1; AJvYcCVi71HhICxgcBUk1Q/VIpeWYUWmxOlhSs2jh3K1sYRQEcmFh6hw8VnopzWmivW/ezOWInDygRaI8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwHqlikst7BWnDAp/E8lcFliNxoPWaY/7ToB5OiR/37Ne3xy1Q
	twCark5NNGvBpWtz/hqS5sc+uBg5Nw23uuQgBAEBxHjT8aedqusZGhilHxw9Dm55H7w=
X-Gm-Gg: AeBDieuNEHDlhK4bBMh5Hbvv+Vg72v49dFfqpXQAw1wyvfkis5wQr0+TXWnQvmJCXsb
	atOVroM50pYWVJIfh4wqlfigk9Ircku6eGTgNeovIJ3g8sJODV+GdntpYR2Xy1Z4E1ybrZ7CbO5
	AxhKofYyHYlCk3Vyl6yNqcdCvPcgi13TIkAZ28UXirfgdSNXReBEyrATlT8gJMeHOkAQ6+dXV77
	u5mU93lsggdEmn6nha4mZrhY56cZhLYbE1TVQQSnFekNP4lVMerXXlfuZVw83wg81rg5U1j0Kfe
	8tHkPZiU6APgHWCOeFcVRIkfSBt1h5I86itwJoOGPwd7ifcs3H5RhsGWPTpAj7QkCbYovm+/B+/
	2iZg2EMJ9DKPmrkg4ry5J727y32wYc+SMqzoeuF3Ha5fNy/LsxoHTUQTbG5TpyljWadZUItfREd
	3oZya0qqGJSd0RIamLaH52FYoCDO3hCng5cJZ7Zr02ZwQN2eqAEbBHqab9w4K/XICWOVUuP7fC
X-Received: by 2002:a2e:be9b:0:b0:38c:6b7:ad39 with SMTP id 38308e7fff4ca-38e4bee2130mr9021011fa.13.1775817667538;
        Fri, 10 Apr 2026 03:41:07 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495455acsm5588331fa.23.2026.04.10.03.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:41:06 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/9] driver core: Enable suppliers to implement fine grained sync_state support
Date: Fri, 10 Apr 2026 12:40:44 +0200
Message-ID: <20260410104058.83748-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410104058.83748-1-ulf.hansson@linaro.org>
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The common sync_state support isn't fine grained enough for some types of
suppliers, like power domains for example. Especially when a supplier
provides multiple independent power domains, each with their own set of
consumers. In these cases we need to wait for all consumers for all the
provided power domains before invoking the supplier's ->sync_state().

To allow a more fine grained sync_state support to be implemented on per
supplier's driver basis, let's add a new optional callback. As soon as
there is an update worth to consider in regards to managing sync_state for
a supplier device, __device_links_queue_sync_state() invokes the callback.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/core.c           | 7 ++++++-
 include/linux/device/driver.h | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 09b98f02f559..4085a011d8ca 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1106,7 +1106,9 @@ int device_links_check_suppliers(struct device *dev)
  * Queues a device for a sync_state() callback when the device links write lock
  * isn't held. This allows the sync_state() execution flow to use device links
  * APIs.  The caller must ensure this function is called with
- * device_links_write_lock() held.
+ * device_links_write_lock() held.  Note, if the optional queue_sync_state()
+ * callback has been assigned too, it gets called for every update to allowing a
+ * more fine grained support to be implemented on per supplier basis.
  *
  * This function does a get_device() to make sure the device is not freed while
  * on this list.
@@ -1126,6 +1128,9 @@ static void __device_links_queue_sync_state(struct device *dev,
 	if (dev->state_synced)
 		return;
 
+	if (dev->driver && dev->driver->queue_sync_state)
+		dev->driver->queue_sync_state(dev);
+
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
 		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index bbc67ec513ed..bc9ae1cbe03c 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -68,6 +68,12 @@ enum probe_type {
  *		be called at late_initcall_sync level. If the device has
  *		consumers that are never bound to a driver, this function
  *		will never get called until they do.
+ * @queue_sync_state: Similar to the ->sync_state() callback, but called to
+ *		allow syncing device state to software state in a more fine
+ *		grained way. It is called when there is an updated state that
+ *		may be worth to consider for any of the consumers linked to
+ *		this device. If implemented, the ->sync_state() callback is
+ *		required too.
  * @remove:	Called when the device is removed from the system to
  *		unbind a device from this driver.
  * @shutdown:	Called at shut-down time to quiesce the device.
@@ -110,6 +116,7 @@ struct device_driver {
 
 	int (*probe) (struct device *dev);
 	void (*sync_state)(struct device *dev);
+	void (*queue_sync_state)(struct device *dev);
 	int (*remove) (struct device *dev);
 	void (*shutdown) (struct device *dev);
 	int (*suspend) (struct device *dev, pm_message_t state);
-- 
2.43.0

