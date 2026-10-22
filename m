Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687345;
	b=cTvj+Zpn11vnl2TquMAZXDxmnvad2Pu3YgXPCSL4tpvxDpZFSWfRyTVCKknb1Vd5WhRc
	 bjuZxtwwZXz4DtsiIJHrGOShUERPG2qyjcE4BkK8eRzR3ipBVKUUYRhw/lwEoV3P+1KCu
	 6daw0DDZkCJ2+wyPl7Rl+IhG0TyzYGKm3rTMsmJJ0/mDJ2Gcj7OYqBKMOesUBas5jBwdU
	 2wGNWPTFTP8CkyNCfoa1EhG1HRSLQVxs3+Qysf9HVJP9i/hLjvjrwPp3i0L0IlRL12YCi
	 cSZJJ/hNmuVqZD9V/3guSha5db/IgDh+Mo1sNrI00JgbsiwzXuUZhFEHXDAgeZzIU1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hXdIlgvfbcMFAqvWezQr9rqCpt7ASFWoYvc8UsUa6j4=;
	b=ihq5JhH/ivIpeTj60HWBL5csooCZB15QpjaFb/hzmqGJCapYo4+XgiqHeGuuDj8Nj5qS
	 qWqSNfQ3vFJBUKJ8fXBxFqaZGSRUA+2Ba8jiElMPxQiD4dAsSXUPXioCWXYTlePLeeSn1
	 uHPK1LKl+h5iRJOAkBQnoozS40o4NJydqZB/sSS5ZROxbrV3OmdtTLOIhlfAOTQipLMpq
	 0/VkV8UBFp4UgPgMVeymkpDtZrkHO7bgCn6tXCI3FXhyPSgepXdVfrllu0ECEVvROYpfG
	 NManBg3LjJbcH7mn1oMEBlWtjBbZde2pw83y+U405FryU4M+yAhcR/q8U/B6W3q8PKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TyQbf+bM;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B1606A31A
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 16:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE7B1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TyQbf+bM
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48bbb06e746so1297570f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687343; x=1793292143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hXdIlgvfbcMFAqvWezQr9rqCpt7ASFWoYvc8UsUa6j4=;
        b=TyQbf+bMDrbcgKouWkSfoAi5JottDRZBdFP5S6Q0pU95+sPvoUAPFqQUJhugGkg+en
         7io2ATGs9CebdPAqlGilGEkHYhez9rJECvJZeMYtMoZaUBR2nB9ydZHCBsQquKerC+xL
         B30J6aGjrmwF0Aj8u0CrelWg+zNaUqHKzGmaakC0CqKEk9FR5g5I/2PiN+3xMtQ9xYIk
         RUyywb+pQDPynhdf4AIvh52MubjCLlq06Oso8pCBgWExz/S+7DMkV+zDBk4Xd4yhg5Jd
         DVW6/OE3BETubwdCJsW371bnHHcfgjtcuttX+bYB50pnNgQZMphMQrpBB8/hWnlD7D23
         Zdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687343; x=1793292143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hXdIlgvfbcMFAqvWezQr9rqCpt7ASFWoYvc8UsUa6j4=;
        b=Rh5606f5j9P4pwcmNjL97w7AVOoer1XUFQ9v/7M4Qyi0oYvN2hgqxwweiOMAXF8AIO
         0w8oHfx80h7JoBpOoycGGOpv+fKVmeK6Iu+NPUDtek4N4CLhXxLBlbQKLmlXq05U3x4p
         O87hOBwPp7dHDG//r3SFA8D3+PxG2jgs1q3iOEqvrggJi50tHXdf0And1oTUGOb5LWf8
         RX32a9Pshw4dWhuIyHQQuvdM+se8oNfBLXYtMLiMDNDXAjxSM1YZOEV+oRpDwqbh0MKd
         RbF/BWZ/CCCAVRCTN1JBeO+Syj7p80m2queU8iUXmmXqE/ScF0tNxOx42wo4H0hY+FnL
         iDJw==
X-Forwarded-Encrypted: i=1; AKwUvBzihisQgcUFYzpoq5HaycTHGXeq40FN62DDNM0xhFpovqjLyieXQzRj03AxwR5LT8dOwLqKktFdBQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKTQkN+VV1KfmLnQRdVL1kcwZbSHrHqk4FFAaGHQ27ru6kRD/bS
	qUMKxElfKfbeHQuThzdIvoJOfQZE/ykKu/upmBuhjHX9G13eoZulIJPu
X-Gm-Gg: AYBFou2jJKEzLHrT062YcBMeUCoWHUZNB4PTSOVNEv8YLZNKwk9gdErSvPYhFEseWll
	ZiYNpwYTUiDoUrIZHecTHdLuns5aJotXCzVEaBxwZRNJ10LuHDp40ILf/PU3xoiOcm7QIPp+oBz
	IpyGUjpI226KVxnC07vASLLuo1nr3+gV8JV0R+46JquFnyB23UwaLG1jAt4ayoQHk5cREBHJIoC
	vMGMLrlgjx5C5JadbYhduuYePM2XXZQVWRbWXAkQSwBO9baMGoaDvUSkiNuK/4ImG5zyq4XXmwI
	da9O4H7iVk6RDbkw3apwAEaHya0sKWdZPuzc7cxMl6CQn75gdrUJroGM8JGxappRUpvaWzyQgLG
	iIEPKCmrvc7U9c1Ht8bWyVSChpcnGTNNLSFH4JCOvtSLp7aTLnIUShiQB0YjA7MtuLASXUna0Qi
	ha9mG9PiGcoo0qK8yXShpDVPaLPgd870OIGPOkh3WCKuNPvmksCfwx0b0ixR4Ek5sDaILkp/zoM
	9Wz2APayqk98pSHH1dz6dvnuiAJdkVKPnJbycOnAZgBB+wX2N/S54WjNOD48g0EQUfPa/pMCkw9
	dZ514w==
X-Received: by 2002:a5d:68c2:0:b0:48d:f6d2:9c88 with SMTP id ffacd0b85a97d-48e26508ba9mr9389330f8f.47.1792687342840;
        Thu, 22 Oct 2026 09:42:22 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2584c3b0sm15040175f8f.57.2026.10.22.09.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:42:22 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
	Joonhoe Kim <26rote@gmail.com>,
	Daniel J Blueman <daniel@quora.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladyslav Tymoshchuk <tvlad744@gmail.com>
Subject: [RFC PATCH 1/4] soc: qcom: pmic_glink: Hold back notifications over system sleep
Date: Thu, 22 Oct 2026 19:41:48 +0300
Message-ID: <20261022164151.592-2-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261022164151.592-1-tvlad744@gmail.com>
References: <20261022164151.592-1-tvlad744@gmail.com>
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

The GLINK interrupt is not suspended, so the PMIC GLINK messages keep
reaching the clients during system suspend and resume, and while the
system is in suspend-to-idle. The clients handle most notifications in
work on the system workqueue, which is not freezable, so the work can
run before the devices it uses have resumed:

- ucsi_glink passes connector changes on to the UCSI core, whose
  connector work switches the USB role and sets the Type-C muxes and
  switches. On SM8750, unplugging the USB cable while the system is in
  suspend-to-idle makes dwc3-qcom access its registers with the clocks
  off, and the SoC resets. Other boards hit I2C transfers on suspended
  controllers from the same work, to a PS8830 retimer or an FSA4480
  switch.

- pmic_glink_altmode had the same problem with its worker, which
  commit c7c56b6ec077 ("soc: qcom: pmic_glink: Fix device access from
  worker during suspend") moved to system_freezable_wq as a stop-gap.

Rather than have each client defer its work, defer the notifications
in pmic_glink: queue them from ->prepare() on, and from ->complete()
schedule work on system_freezable_wq that passes them on to the
clients. The work runs once the tasks have been thawed, after all the
devices have resumed. Until it has run, new notifications are queued
behind the old ones, so the clients get them in order. Responses are
passed on right away, as the client that sent the request is waiting
for them.

The clients treat a notification as the latest state, or as a hint to
read the current state, so an identical notification adds nothing:
keep only the latest copy. Keep at most 64 notifications, drop the
oldest beyond that, and say how many were lost.

Hold back the service UP too, as on UP the clients start using the
remote, and pass it on after the deferred notifications. Pass DOWN on
right away, so that the clients stop using the remote, and drop the
deferred notifications with it, as they came from the remote that went
away.

ucsi_glink learns from a notification that a UCSI command has
completed, so a command still in flight at ->prepare() completes only
after the system has resumed. The timeout of the UCSI core does not
count the time spent in suspend, only the time the system takes to
suspend and resume.

qcom_battmgr calls power_supply_changed() for most notifications, which
keeps the system awake through the wakeup source of the power supply.
For a notification that is held back, this now happens after the
system has resumed, so it no longer aborts a suspend started through
/sys/power/wakeup_count.

Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Signed-off-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
---
I used an AI assistant (Claude) for the analysis and to draft this
patch and its description; I reviewed the result. The testing is
described in the cover letter.

 drivers/soc/qcom/pmic_glink.c | 177 ++++++++++++++++++++++++++++++++--
 1 file changed, 168 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 84fd0c82c0c4..748b335be6ef 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -14,8 +14,11 @@
 #include <linux/soc/qcom/pdr.h>
 #include <linux/soc/qcom/pmic_glink.h>
 #include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/workqueue.h>
 
 #define PMIC_GLINK_SEND_TIMEOUT (5 * HZ)
+#define PMIC_GLINK_MAX_DEFERRED	64
 
 enum {
 	PMIC_GLINK_CLIENT_BATT = 0,
@@ -50,6 +53,14 @@ struct pmic_glink {
 	/* serializing clients list updates */
 	spinlock_t client_lock;
 	struct list_head clients;
+
+	/* notifications held back over system sleep */
+	spinlock_t defer_lock;
+	bool defer;
+	struct list_head deferred;
+	unsigned int num_deferred;
+	unsigned int num_dropped;
+	struct work_struct deliver_work;
 };
 
 static struct pmic_glink *__pmic_glink;
@@ -66,6 +77,12 @@ struct pmic_glink_client {
 	void *priv;
 };
 
+struct pmic_glink_deferred_msg {
+	struct list_head node;
+	size_t len;
+	u8 data[] __counted_by(len);
+};
+
 static void _devm_pmic_glink_release_client(struct device *dev, void *res)
 {
 	struct pmic_glink_client *client = (struct pmic_glink_client *)res;
@@ -149,13 +166,77 @@ int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
 }
 EXPORT_SYMBOL_GPL(pmic_glink_send);
 
+static void pmic_glink_dispatch(struct pmic_glink *pg, const void *data, size_t len)
+{
+	const struct pmic_glink_hdr *hdr = data;
+	struct pmic_glink_client *client;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pg->client_lock, flags);
+	list_for_each_entry(client, &pg->clients, node) {
+		if (client->id == le32_to_cpu(hdr->owner))
+			client->cb(data, len, client->priv);
+	}
+	spin_unlock_irqrestore(&pg->client_lock, flags);
+}
+
+static bool pmic_glink_defer(struct pmic_glink *pg, const void *data, size_t len)
+{
+	struct pmic_glink_deferred_msg *msg;
+
+	guard(spinlock_irqsave)(&pg->defer_lock);
+
+	if (!pg->defer)
+		return false;
+
+	/* An identical notification brings nothing new, keep the latest copy */
+	list_for_each_entry(msg, &pg->deferred, node) {
+		if (msg->len == len && !memcmp(msg->data, data, len)) {
+			list_move_tail(&msg->node, &pg->deferred);
+			return true;
+		}
+	}
+
+	if (pg->num_deferred == PMIC_GLINK_MAX_DEFERRED) {
+		msg = list_first_entry(&pg->deferred, struct pmic_glink_deferred_msg, node);
+		list_del(&msg->node);
+		kfree(msg);
+		pg->num_deferred--;
+		pg->num_dropped++;
+	}
+
+	msg = kmalloc_flex(*msg, data, len, GFP_ATOMIC);
+	if (!msg) {
+		pg->num_dropped++;
+		return true;
+	}
+
+	msg->len = len;
+	memcpy(msg->data, data, len);
+	list_add_tail(&msg->node, &pg->deferred);
+	pg->num_deferred++;
+
+	return true;
+}
+
+static void pmic_glink_drop_deferred(struct pmic_glink *pg)
+{
+	struct pmic_glink_deferred_msg *msg, *tmp;
+
+	guard(spinlock_irqsave)(&pg->defer_lock);
+
+	list_for_each_entry_safe(msg, tmp, &pg->deferred, node) {
+		list_del(&msg->node);
+		kfree(msg);
+	}
+	pg->num_deferred = 0;
+}
+
 static int pmic_glink_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 				     int len, void *priv, u32 addr)
 {
-	struct pmic_glink_client *client;
 	struct pmic_glink_hdr *hdr;
 	struct pmic_glink *pg = dev_get_drvdata(&rpdev->dev);
-	unsigned long flags;
 
 	if (len < sizeof(*hdr)) {
 		dev_warn(pg->dev, "ignoring truncated message\n");
@@ -164,12 +245,12 @@ static int pmic_glink_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 
 	hdr = data;
 
-	spin_lock_irqsave(&pg->client_lock, flags);
-	list_for_each_entry(client, &pg->clients, node) {
-		if (client->id == le32_to_cpu(hdr->owner))
-			client->cb(data, len, client->priv);
-	}
-	spin_unlock_irqrestore(&pg->client_lock, flags);
+	/* The sender of a request is waiting for the response */
+	if (le32_to_cpu(hdr->type) != PMIC_GLINK_REQ_RESP &&
+	    pmic_glink_defer(pg, data, len))
+		return 0;
+
+	pmic_glink_dispatch(pg, data, len);
 
 	return 0;
 }
@@ -210,6 +291,13 @@ static void pmic_glink_del_aux_device(struct pmic_glink *pg,
 	auxiliary_device_uninit(aux);
 }
 
+static bool pmic_glink_deferring(struct pmic_glink *pg)
+{
+	guard(spinlock_irqsave)(&pg->defer_lock);
+
+	return pg->defer;
+}
+
 static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
 {
 	struct pmic_glink_client *client;
@@ -217,13 +305,18 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
 	unsigned long flags;
 
 	if (pg->client_state != SERVREG_SERVICE_STATE_UP) {
-		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
+		/* On UP the clients use the remote, hold that back as well */
+		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept &&
+		    !pmic_glink_deferring(pg))
 			new_state = SERVREG_SERVICE_STATE_UP;
 	} else {
 		if (pg->pdr_state == SERVREG_SERVICE_STATE_DOWN || !pg->ept)
 			new_state = SERVREG_SERVICE_STATE_DOWN;
 	}
 
+	if (pg->pdr_state == SERVREG_SERVICE_STATE_DOWN || !pg->ept)
+		pmic_glink_drop_deferred(pg);
+
 	if (new_state != pg->client_state) {
 		spin_lock_irqsave(&pg->client_lock, flags);
 		list_for_each_entry(client, &pg->clients, node)
@@ -233,6 +326,40 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
 	}
 }
 
+static void pmic_glink_deliver_work(struct work_struct *work)
+{
+	struct pmic_glink *pg = container_of(work, struct pmic_glink, deliver_work);
+	struct pmic_glink_deferred_msg *msg;
+	unsigned int dropped;
+	unsigned long flags;
+
+	guard(mutex)(&pg->state_lock);
+
+	for (;;) {
+		spin_lock_irqsave(&pg->defer_lock, flags);
+		msg = list_first_entry_or_null(&pg->deferred, struct pmic_glink_deferred_msg, node);
+		if (!msg) {
+			pg->defer = false;
+			dropped = pg->num_dropped;
+			pg->num_dropped = 0;
+			spin_unlock_irqrestore(&pg->defer_lock, flags);
+			break;
+		}
+
+		list_del(&msg->node);
+		pg->num_deferred--;
+		spin_unlock_irqrestore(&pg->defer_lock, flags);
+
+		pmic_glink_dispatch(pg, msg->data, msg->len);
+		kfree(msg);
+	}
+
+	pmic_glink_state_notify_clients(pg);
+
+	if (dropped)
+		dev_warn(pg->dev, "%u notifications lost during system sleep\n", dropped);
+}
+
 static void pmic_glink_pdr_callback(int state, char *svc_path, void *priv)
 {
 	struct pmic_glink *pg = priv;
@@ -315,6 +442,10 @@ static int pmic_glink_probe(struct platform_device *pdev)
 	spin_lock_init(&pg->client_lock);
 	mutex_init(&pg->state_lock);
 
+	INIT_LIST_HEAD(&pg->deferred);
+	spin_lock_init(&pg->defer_lock);
+	INIT_WORK(&pg->deliver_work, pmic_glink_deliver_work);
+
 	pg->data = of_device_get_match_data(&pdev->dev);
 	if (!pg->data)
 		return -EINVAL;
@@ -377,6 +508,8 @@ static void pmic_glink_remove(struct platform_device *pdev)
 {
 	struct pmic_glink *pg = dev_get_drvdata(&pdev->dev);
 
+	cancel_work_sync(&pg->deliver_work);
+
 	pdr_handle_release(pg->pdr);
 
 	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
@@ -386,10 +519,35 @@ static void pmic_glink_remove(struct platform_device *pdev)
 	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
 		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
 
+	pmic_glink_drop_deferred(pg);
+
 	guard(mutex)(&__pmic_glink_lock);
 	__pmic_glink = NULL;
 }
 
+static int pmic_glink_prepare(struct device *dev)
+{
+	struct pmic_glink *pg = dev_get_drvdata(dev);
+
+	guard(spinlock_irqsave)(&pg->defer_lock);
+	pg->defer = true;
+
+	return 0;
+}
+
+static void pmic_glink_complete(struct device *dev)
+{
+	struct pmic_glink *pg = dev_get_drvdata(dev);
+
+	/* Runs once the tasks are thawed, all devices have resumed by then */
+	queue_work(system_freezable_wq, &pg->deliver_work);
+}
+
+static const struct dev_pm_ops pmic_glink_pm_ops = {
+	.prepare = pmic_glink_prepare,
+	.complete = pmic_glink_complete,
+};
+
 static const struct pmic_glink_data pmic_glink_adsp_data = {
 	.client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
 		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
@@ -418,6 +576,7 @@ static struct platform_driver pmic_glink_driver = {
 	.driver = {
 		.name = "qcom_pmic_glink",
 		.of_match_table = pmic_glink_of_match,
+		.pm = pm_sleep_ptr(&pmic_glink_pm_ops),
 	},
 };
 
-- 
2.43.0

