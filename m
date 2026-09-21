Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEEA3358B9
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961849; cv=none; b=QrQrqviJbQUiIgoyChZCI9ni3NR2RVq+A1Ic8DyBTrJHnzpfWo92IbNle360n2zjN9cPLakZHNeiu4HyODVh7kQcsSwssIJnLVfLpEZbJ1wkp1clGD6yZdxyVRvaN1f0qcLAeR/Mn9K4u+iVK/I/iTE1C/JBWmHBr/tgGVXwEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961849; c=relaxed/simple;
	bh=x/6QvB9InBIhpi7aIvuJrdQOgjAvdt+ushjxl3YRC1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oaqK9sHd/nlfnWphprln09ZvCZSpTH8uz8p89q7fXn3X980Wk7skypEBbEfZ4oJhwXRCVzqribhIDxmYDh2YQKxOUOn0V8UJmNhTvqBTYe3cjXQEBM+2cUQjG7gvO24/1CwmwLrPA7n8OH+hu6TjtXXeqgGCCbcLxipvKEklrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LB3abMeH; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB3abMeH"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eefae4so7483445ad.0
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 20:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789961848; x=1790566648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OOn5aDKklfWuyRcWQiw2HtX9kHA+GiSG8zyirY1ZU/0=;
        b=LB3abMeHzcwmn8haOBaErtdqkMJww582qo+kyJVBiroFPfGRLlMYoCrhaPWQtXM8u2
         rdx+0J30ymGqxiGexjinw8fdLhxQA4ArmqHBIzyfLqKtR6vjQYwYOZ6Ji46mlvT7d8Jr
         W6mwkYE0pRd1u+IlkNv/QLS76lzD7eabVLuWAw+20nRpjVk+jwAbgOs9Hj743laKDt+R
         0OsM31AS596tadEYzjq18RAP4zyczzsce4hFvcFQQiLjbUe92URbBomPS2yqHOiR3p36
         R6fh39ViVZ5Sr2WLpz9dS4WDRcbGKQpBBQdBiPJUK/HkCqxZvKHuOxTcMb5Y4gnPdUgY
         HOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789961848; x=1790566648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OOn5aDKklfWuyRcWQiw2HtX9kHA+GiSG8zyirY1ZU/0=;
        b=w/vF+rHqRZleZ2WP3OBuGzLaKPAKowjebXemNEIFILEGFZFBxwoVXd2IEE36HOVeiM
         Ijb1rLtbBSfbSrZLnP7NFa6Fu5I0JTkN+gmPU7tdVTCD1iDu58M8BnwesmwoREA2+5mH
         4VmDKpv13vLFIbvINNZ+dBJdJ0uRN/72G+eEefoLRnSmv8IWOi0J4w3PooaSxK6wv2n+
         4u9w8j1sIrZ3+WWuUVdruqOWV+r6d9FJrA+gZ3FAzaPwxFaaan5UxVJA4FUXiSH1GIDt
         zffCAYre03m500b19K0XdW08YQrnEK0SHOPTZMzbZwRFN+arZsI75L5PbL6F+rY78DFd
         Nyjw==
X-Forwarded-Encrypted: i=1; AKwUvBwZDomTHrJ0It03QFauwUmtox+KdDzuch4zA7o/tuWJzJnOtu/17LnoYNBcpP/bqqGoJL//K2CpXg==@vger.kernel.org
X-Gm-Message-State: AFuF++ki57MON/6HGA8PLS2FnMb8LQVsuaq9hZ0iPwlvWktA37CUgFzT
	V1cUQQx4zqOO0XX/JaKMJDdWx6v2HN7a1CnuSDLyOKum2FCQhHwloY3V
X-Gm-Gg: AYBFou0e3afIAatzc32g524Uj13K4iy+jrrjkWboKpONFerAn0uoN7WXC9n02PY9vK1
	YJZId1RIlG3cWFkigsaTAvJsAaQVb3OtPZI1Dh4GcBpQuQ0JQuQJ9wkP3xS/9godd1C9S9954Zp
	r/qut110GkELE5Q4IaktzlGn8Of/1NPwXK/TNTHan92jYC0bwIJz53rULB02xGfREou1fOI9Ezd
	Xzv4LOE9J+OMXWvqWsxQ6bG4+Xa7fMZ5T4x7Lqp/QTzVwZELymk0NefOlL/V2UWgbT/ZTpCJvxG
	Esl6xBqa07IVGBC5BbSCXOHHOigzP/+csOUBvMLcuDAZibEd8ALlXZhp7IjxDqPBPM53XR7Kxdl
	c7EEkGHScLHK8QTN8Yvfah3dTD6/J3fBUCblzVBXB9Gf3xuL/abK9OsNMrs6Kt40LGSV1oW0SVr
	NoD03FRKfjwFLdKhEsTYZsWC1oDk0rhmrEaK8rU5WKX8SygVcXvGXNfHk9TjCmayQKwVn/+GLTu
	sC2NtjsRZTAQbgDndfd7jU9GtoVQegO05NfgUnCVGQEK2e0GC2pbd5Or85f1Lba1mfFVgTl2iVK
	1l+RgEur3n8FEQ==
X-Received: by 2002:a17:903:2447:b0:2dd:7370:e19e with SMTP id d9443c01a7336-2ddb2233bc1mr94006865ad.16.1789961847686;
        Sun, 20 Sep 2026 20:37:27 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc18032d5sm25966515ad.83.2026.09.20.20.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 20:37:27 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	rafael.j.wysocki@intel.com,
	Jacky Bai <ping.bai@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	u.kleine-koenig@baylibre.com,
	Marco Felsch <m.felsch@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Guoniu Zhou <guoniu.zhou@oss.nxp.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 0/3] pmdomain: imx: Use pm_runtime_resume_and_get()
Date: Mon, 21 Sep 2026 10:37:05 +0700
Message-ID: <20260921033708.14433-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series replaces open-coded pm_runtime_get_sync() and
pm_runtime_put_noidle() error handling with
pm_runtime_resume_and_get() in the i.MX power domain drivers.

No functional change.

Found by manual code inspection.

Best regards,
Phuc

bui duc phuc (3):
  pmdomain: imx: gpcv2: Use pm_runtime_resume_and_get()
  pmdomain: imx8m-blk-ctrl: Use pm_runtime_resume_and_get()
  pmdomain: imx93-blk-ctrl: Use pm_runtime_resume_and_get()

 drivers/pmdomain/imx/gpcv2.c          | 16 +++-------------
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 15 +++++----------
 drivers/pmdomain/imx/imx93-blk-ctrl.c |  3 +--
 3 files changed, 9 insertions(+), 25 deletions(-)

-- 
2.43.0

