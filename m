Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583185;
	b=WUyPUNhJQx7u2tJ0gCsiPjFpHlUFb4Vj0dbYHDSqvGBh1Wk1lsKbXGBWR1Ui0h7ZM6iE
	 a1LxFNYZM1XXEqNm0WnqZRo5EktxeqYSUxR5k+cKVHqUxyT5Cx9WfuMsuFmBlzAcP3+lV
	 flrzG5G4RC2ln4k7U8wjz1inKbGmYxv6mhQq4mXZ1wivFTcbsRZ5WMSZ3XLXQQFe9x0iM
	 k5zGg0+riRgGz9CrQJVCW34omkKCIg1MuOWbCk4SDgHCr/xQ1vzS0z0KEjx5GSqkm3FAW
	 ir5vweUN5J7puZ+LQ6TOulurwvv/0nzGkyj95RLu/1U3pXYHDjfdKwBhBkNWALx0jow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583185;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kCbxg8z39y+qkIydVuGWiPMvNUIcUhkqrl5vBT7cprg=;
	b=yrj658SN6QKmg480Z8P1ADT5OLtpwtrCU6TllEa8LQB8nxUI8lBSe+PcXjyPh1Jsgd28
	 IIQS5v9eLJ1iNTVvI9AYjTMDo4hGKPTfDO6Lqjaqy/305LIN3ygcRHwkb1Ww1XeciVU5g
	 Qs25qu/iDmHP7kgwEPf8trmnU2UQxHkRbeYd07INsCYsCbWb0jSaPKzSx12vxC+I5uVg3
	 yvX7ra5hZZEgW5l7qpHimN8QvpInY2WU9kQ8oojqIAB8qCjF0bXtRcuewTOM0ppPMbJpb
	 DBfN1FVw8/SamtCjvIrTSnAgP6GrvVKUxag+byW8yr9/6CUHlye4tAA90l1Tu/kF/7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/kDiTXV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45544606A327;
	Fri, 13 Nov 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/kDiTXV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4BF1F000C4;
	Fri, 13 Nov 2026 15:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583184;
	bh=kCbxg8z39y+qkIydVuGWiPMvNUIcUhkqrl5vBT7cprg=;
	h=From:To:Cc:Subject:Date;
	b=a/kDiTXV0HhjTRgOv3A2r5ZIwNGULZdyKhWV2AZBQMN4qb3BDxn1NCwvZ3jFGss6L
	 gUoPFuC9x/ePM5cPig0zqAA/yZoUsHDlrDieHe74zHiMjZMIRafhe9SsD5NHzcCDvf
	 OjNHH4jue00Un7LeGpV8Ta9bqvArTEVR32ZC2eZspqNrd7st1u1LX5si0tjKkb92fo
	 /x7axVKff1UkcQHAbcts5q0HWvkx8FcO9vbFXUVCNfA9Cbpf7kSs7YM1CJpO+VebKT
	 UPUhFqWUogIDgshiATe+VxJfR/hAaQFhO0dv6q853xMWJ8GXkPFmAvztareKC2m385
	 FZbNRP7xaLSjQ==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] bus: mhi: Address MHI system suspend abort
Date: Fri, 13 Nov 2026 12:17:58 -0300
Message-ID: <20261113151940.2922539-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
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

For Upstream:

[PATCH 1/2] bus: mhi: pci_generic: Prevent MHI from aborting system suspend

For Debug of underlying MHI issue:

[RFC 2/2] bus: mhi: host: Add diagnostic print for -EBUSY in mhi_pm_suspend()

thanks,
-Len
