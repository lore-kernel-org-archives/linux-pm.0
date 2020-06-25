Return-Path: <SRS0=fkE9=AG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA52C433DF
	for <linux-pm@archiver.kernel.org>; Thu, 25 Jun 2020 23:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8B22081A
	for <linux-pm@archiver.kernel.org>; Thu, 25 Jun 2020 23:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BC5QnNm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390917AbgFYX0f (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390589AbgFYX0f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 19:26:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF23EC08C5DC
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 16:26:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b16so3758796pfi.13
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 16:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcg6bLKAHJ0/BxsC+brekPNOiBl21FKQYq+hY1Ge/R8=;
        b=BC5QnNm/L9fi0/7m8QzEN2dxwRm+UEWAUD0wfyKtJN3dH3RSF2OfNu+WtclANsPrj0
         tccUpSmsJU6AXH4UrZsO6uoZhCt2UkUkc+F3mD5CpUKXZYyuWLUNOGBNl2XGZYTF3WZr
         ijY/VFyXQ74HchwLZNMFyPvcLQOxOcA/UoQ0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcg6bLKAHJ0/BxsC+brekPNOiBl21FKQYq+hY1Ge/R8=;
        b=nZhmA67ReJ65npPecuEX5zqi76zBXi9AGQZ8kMS2XluvTvlFpidoAVa4RmUWZqDP+o
         5p8BaA0IXRUCiWE//D+sriMNC/ogEvr3nsVnNzMImQsGiatkBVJ/Gpwnor9xniD+fg+u
         YNzWgZAX8+G4fHHTkXsQzjyODBR6Dbf40qIN6qt2Ge/bWC81QzH9iXZAy8n7maEgai9i
         q73J0/ua7sYozUa/Yb2VFsGnEVBrBlWlWd6+Zqu7LVaP8NyVDBa2uOM04dkR/jsra6OC
         TWXvFvI8yDMdbTwtwhWDhJM0dz2zOxsBXp7OJMRXwR719lOI8fAsEi1WTevMv+mdr5wc
         ZT3g==
X-Gm-Message-State: AOAM533ARNS/LDBW5RgVqfGupNI8O/KumxccvdKv+w04NPdndLeVRBp9
        UJd1qkcHMxjTUzH+khkxrjUBmQ==
X-Google-Smtp-Source: ABdhPJxbIKdpaqZK2+wHlfbZwwz6bF78GirDWwQUzayQq/pWbTr2e2gviyY7c0WS4IBaYh/15HOjxg==
X-Received: by 2002:a63:182:: with SMTP id 124mr232820pgb.288.1593127594156;
        Thu, 25 Jun 2020 16:26:34 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id f207sm8901936pfa.107.2020.06.25.16.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:26:33 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, Oliver Neukum <oneukum@suse.com>,
        linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Comment on unbalanced pm reference
Date:   Thu, 25 Jun 2020 16:26:27 -0700
Message-Id: <20200625162544.1.Iea2fbf7a284191c0f09c2ffbe8c14b872d0f68b2@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a comment clarifying that a PM reference in btusb_qca_cmd_timeout is
not unbalanced because it results in a device reset.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f8a71fdabb3d1b..0e143c0cecf2a1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -581,6 +581,7 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 		return;
 
 	bt_dev_err(hdev, "Multiple cmd timeouts seen. Resetting usb device.");
+	/* This is not an unbalanced PM reference since the device will reset */
 	err = usb_autopm_get_interface(data->intf);
 	if (!err)
 		usb_queue_reset_device(data->intf);
-- 
2.27.0.111.gc72c7da667-goog

