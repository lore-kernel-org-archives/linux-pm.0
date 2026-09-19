Received: from mail-m127173.xmail.ntesmail.com (mail-m127173.xmail.ntesmail.com [115.236.127.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF13B71A5
	for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789806721; cv=none; b=LowMcZXrsTU/Ldf7cUekFRmA2Cpv2RxWlZDlHUFAiic6k22GfWyBIN0qszRaLN7xJJ/okQau1MH4mVSXxE6TXb5dGcbhpGj9Pr2cVeNAFwXxPytLkjvfuhxVUL4jz4oGdxqF+mqENmuzriAWz1HPrrMzte2lulrGwS0TiavyWi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789806721; c=relaxed/simple;
	bh=IBn7NK07EWQGYv/0ntvcrOPWNtPlGaMiG7OMMQN2nWM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rBTNCxzQmPLJla3W3lLCrkO+SJUSUilKugEWZxgFFTyiYnE6zJkhKs2DvB9M9cGbH/pAsOu3dB1vuRNW0XaGksRiYVl601ZLayyj1ogZtqtUz96SItyARKy+E/R7uVttNCCZ3MCnITHYyggNqVVUf6hFvOCi+zWOQz/Sjf+25no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bGDQreUe; arc=none smtp.client-ip=115.236.127.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bGDQreUe"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e57cbc10;
	Sat, 19 Sep 2026 08:35:21 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/4] Small fixes and improvement for Rockchip pm-domains driver
Date: Sat, 19 Sep 2026 08:35:07 +0800
Message-Id: <1789778111-173149-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0b716d33d03a4kunm44a9997f1a8ede
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQkMaSFZKGUIZHRpLHk
	JDGRlWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bGDQreUecK4toVl98oJs/g+sgRC9/zYPNO+VUMnfUis9BEmyUcvX6IVYgHwPoLUpRsOYiw5ErbCswGLS6jrmFl+k88QSa/8BDILyk0zL58RnwZzxAX48iAaWh1/ehcvsSN2cxcAdSga+u3wv3QV03Y88Oq/qAjPHIRM/x2gjSkc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=uue1hZ9zUDtz6zYZ4RhBB6/ukWRQjbmJjBrnP1FOymM=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>


The first 3 patches are for fixing. And the last one is for
improvement.


Changes in v2:
- switch to use devm_kzalloc()
- add Sebastian's tag

Shawn Lin (4):
  pmdomain: rockchip: propagate subdomain add errors
  pmdomain: rockchip: fix clock leak on domain probe failure
  pmdomain: rockchip: don't ignore clock lookup errors on attach
  pmdomain: rockchip: drop duplicated errno from supply failure message

 drivers/pmdomain/rockchip/pm-domains.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

-- 
2.7.4

