Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.42.203.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568253;
	b=gfgxGtKWac5xdYbrpIrW09eSR4JlnVo9Pe1CngOE/weDuoHaHV+TJaxveUTfb3+rgWmE
	 ba9gqvGwNNwLJ5qha7PktTbRl3M/0PyksodeS4I9bD3UAGIRz30GBPmbOiFFAppDksFKh
	 VM9cc0BNqonU2oNloWHC+4Ggq4MY3RsIpbHLCZ6zACTqgb/Vp6glcqPrqaahUcduePUtT
	 s8T7BQq7b5pA2RUqsGPIH7AaPYZsrvb7M4dBGDqpZurml6kqaF+ezquZIrC3kz9mSXB7g
	 bLiA0ATEFGayO66JEE+NY+KHwbW+9tU0gQptl8DlSPXQ/7htvP6pz8QEWHVyvIbP86A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568253;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Vz8zzO+pbP/JF+uMRgI6d/03y9BDYJeIS3sGQ4sLnXE=;
	b=FIcAdC2DLhkqfHAEgrqPMeQbcUfCQYHzzjZMJP1SpUDoupMw74hjTNkNjwiALl+Xbmb5
	 x/knHIWt0L8TXqCDTXyEg+7DWxZxQlqbU1kzBllgH/bFHconasAmH3221IAHbKfPwvl3a
	 awCamMFgDWi9KmusPrEBdwxm1Hov0IWrzbLBQYab2uPrQnl8k7R3tQYDyj9X+FTOKVl2u
	 0srXfMXVmStK0hJ9eSBm4YBApFfF2zbOIq0zneArpLsB9aIe0afmcmbAOdmiofldTf+2i
	 elXBYaqI+fpSf4Wve49qGC5zGb7ms7yfPfckMujBx+dpV0+wpRPdpI3EnkV2c8c9f9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=hbZmYkwC;
	arc=none smtp.remote-ip=52.42.203.116
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750DA606A31C;
	Fri, 13 Nov 2026 11:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 750DA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=hbZmYkwC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794568253; x=1826104253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vz8zzO+pbP/JF+uMRgI6d/03y9BDYJeIS3sGQ4sLnXE=;
  b=hbZmYkwCE4LFJdcImXN5o3zE5gJB35q/MNPL5BSS2U+eJBhgb9fEB8Ds
   tF2j13OaxvHQFR4TJ3hrctXH07jc9fRgerWj1RIXCGmY1TWarROwtWlnq
   zg0Efv6uuxQqCBNUt+eM2FOdkudXHti9H43DCYD9e/1PUgEGvZZ5JebcK
   rGOUD11dM2VHJTNvh95l6oF54AeWsyGqo9J2BGgF0/J4ZnoK19KmZX12X
   /k5iA+8/YESn343SDossW4bMCbnaPBdEnxie6L/AKMlWvOg0Yf34jUr/w
   S05f1maOtQehC2jz/1+ZrfddkZdYZgupi1daYP1tjcerR6/122/B3fQiz
   g==;
X-CSE-ConnectionGUID: sDC0FOpCR0qdwvrHPByt5g==
X-CSE-MsgGUID: Vymrz5xWSuW0fzyncDCV5w==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33912754"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 11:10:53 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:21664]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id 0f377dd7-6e8e-4d00-9c9d-ace017f8e592; Fri, 13 Nov 2026 11:10:52 +0000 (UTC)
X-Farcaster-Flow-ID: 0f377dd7-6e8e-4d00-9c9d-ace017f8e592
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 11:10:52 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 11:10:51 +0000
From: Eliav Farber <farbere@amazon.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eliav Farber
	<farbere@amazon.com>
Subject: Re: [PATCH v6 7/7] power: supply: cros_pchg: use devm_blocking_notifier_chain_register()
Date: Fri, 13 Nov 2026 11:10:47 +0000
Message-ID: <20261113111047.36008-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113104459.35839-3-farbere@amazon.com>
References: <20261113104459.35839-3-farbere@amazon.com>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This patch is not in the series thread. My mail server refused the second
half of the series with a submission rate limit, and the resend went out
unthreaded, so 5/7, 6/7 and 7/7 are rooted at 5/7 instead of under the cover
letter.

The cover letter and patches 1/7 to 4/7 are here:

  0/7 https://lore.kernel.org/all/20261113104218.32566-1-farbere@amazon.com/

All seven patches were delivered, so I am not resending them. Sorry for the
split thread.

--
Thanks, Eliav
