Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583189;
	b=3kCwxxq7gp5QF8SgF91ljgogyACbjzerU54Eds0AjjUiJAeDfxyuOiIujzTDwmkglG7X
	 ybAjdE0eO3kDCEJPTQ9YXPg2pFgbY8E2RobADC/wr2R3owrL3YmsMfPoQzjWCvvdoVW30
	 pIJ4JsjLse8ygkXSQaVPQBphX6xvQlxBfDbXyF6fVjQWyvzn6q8IqfbR1wetGfX4brhgZ
	 Ajz/YovbcCnWN2sj2H921I/mMIZ9WhbR5ItuaakimIGC7FCmBwL2xUUMkIXg96nNsIhcA
	 UL3D2o3tpplFJtzUlbDzRqoDVd11OnTHSu/9GYMXydiww6EZ74d/BlQmMDpbyXLvDKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583189;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=8IHD7IGFw8pYBNaJMIkJqX35GDvx4WMIMR/xQpCnM5o=;
	b=Jyugh0jZpk/jAW7/K3JUP6/sdmRJze1YHuKTQsjHxFXYqP0jf5TmOcZfRBozOp/N5Was
	 0l4GhAYiQZytqBMvUJf6nB6cGvgEV6ijKn96OwByZqTrmuDRKT8MCshr47Mk7E5jJH/Tb
	 1S5hIA0LqFKlTOZDYd1Sy644OR4oZOu8zuP3NERzIlow1cUmP0uReixgpVRbwGeGmXFBZ
	 gBwpdxHPRZZyHjbIqot5RTCkez5JuH5Ymia4UsTaailTNr05XXnum/Q/WvtE4RLmi48jG
	 Ri9/Mcf1ff9dlzcaxZgdwyK/Gp3ILbsJ05/rKF5+jeDQzQ/PYzNnp9dtb4GRVoz14Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSyi67TY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B8606A88C;
	Fri, 13 Nov 2026 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSyi67TY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E491F000C5;
	Fri, 13 Nov 2026 15:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583189;
	bh=8IHD7IGFw8pYBNaJMIkJqX35GDvx4WMIMR/xQpCnM5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=eSyi67TYSSXO0lOg6lWLUqrSZm7UotZvHugPv69tyVP73XkIY4riiClo5MYN09oUI
	 KuxnPFBTe1y7spEd4/Xf23NtvVCrdL7fcmTtSPPPgH9zYQIfvqe7SZloM5prIjd7W3
	 nEQR9Y4yfMQ+1K1Sx0WdgjadOztSZz/KCSnWpEGkqelQv19ENuWsR8c5E7DpQk5xkR
	 YGzQgL1i6jOGJKF6KDx3lfAuc/zwHPnW+1ixoZqszDdFmF2I50hDTfHBr5RA7/+HSt
	 0Pgau9hRw2LMgBSyE9XEr7rwakc3mYlPFO8r4U1jlJmf6ayO+sMHtyW5dWJJ072xnn
	 gmCM+f3HtTRGw==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC 2/2] bus: mhi: host: Add diagnostic print for -EBUSY in mhi_pm_suspend()
Date: Fri, 13 Nov 2026 12:18:00 -0300
Message-ID: <b490fbf692dcd8883b05a1475a7197104f596f0d.1794582108.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <7ce7895da501c3204416b69b0049ff488904f6a5.1794582108.git.len.brown@intel.com>
References: <7ce7895da501c3204416b69b0049ff488904f6a5.1794582108.git.len.brown@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

mhi_pm_suspend() sometimes returns -EBUSY, but doesn't tell us why.

Print dev_wake and pending_pkts when it does.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/bus/mhi/host/pm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index ced83fbb1a51..2eb7344b3b39 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -871,8 +871,12 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 
 	/* Return busy if there are any pending resources */
 	if (atomic_read(&mhi_cntrl->dev_wake) ||
-	    atomic_read(&mhi_cntrl->pending_pkts))
+	    atomic_read(&mhi_cntrl->pending_pkts)) {
+		dev_err(dev, "DEBUG: suspend busy (early): dev_wake: %d pending_pkts: %d\n",
+			atomic_read(&mhi_cntrl->dev_wake),
+			atomic_read(&mhi_cntrl->pending_pkts));
 		return -EBUSY;
+	}
 
 	/* Take MHI out of M2 state */
 	read_lock_bh(&mhi_cntrl->pm_lock);
@@ -900,6 +904,9 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 	if (atomic_read(&mhi_cntrl->dev_wake) ||
 	    atomic_read(&mhi_cntrl->pending_pkts)) {
 		write_unlock_irq(&mhi_cntrl->pm_lock);
+		dev_err(dev, "DEBUG: suspend busy (recheck): dev_wake: %d pending_pkts: %d\n",
+			atomic_read(&mhi_cntrl->dev_wake),
+			atomic_read(&mhi_cntrl->pending_pkts));
 		return -EBUSY;
 	}
 
-- 
2.45.2

