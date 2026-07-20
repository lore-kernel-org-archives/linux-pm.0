Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8839B4AE;
	Mon, 20 Jul 2026 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589180; cv=none; b=tDTcOeVRb6SY0HdtMCj8+NbVlmaiHfVhzjVzWQkUwAHVx/3r0NlbOJ8qof6TZRRtfc+fgwhl5RkYLDwCyDZkLzoTzYR77KBPvM1YqUIp5fqMPhtAwJgGtSt5ZA1t1UtrHl3tNYwxMewh3nYncTBP9v5JZrobT/ZD+xi1zXyNhYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589180; c=relaxed/simple;
	bh=OGYOPEbdHce9kIvJcA6VrLi/Ks1vTCtGBPCX+SrT69A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bxVuXKYSfOp+jFu8xg3jU9P5hDgl4yNRxk3qWJtd1uKWJTtQcaZDUQBesyaFoDiwFWzn1oK8Xodr9iqZYSqSbM3HVCg2MfZwXavWMLHGbFTwD7fDdoaL1Rc6OfixYWaKkyOJ90SnPktYddL3xZjS0Nod/vHieFA0A7ZotR3H0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933BA1F00A3D;
	Mon, 20 Jul 2026 23:12:59 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 091B1180D23; Tue, 21 Jul 2026 01:12:58 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704152336.51384-1-pengpeng@iscas.ac.cn>
References: <20260704152336.51384-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] power: reset: piix4-poweroff: add missing
 MODULE_DEVICE_TABLE()
Message-Id: <178458917802.375902.10604192611886880672.b4-ty@collabora.com>
Date: Tue, 21 Jul 2026 01:12:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 04 Jul 2026 23:23:36 +0800, Pengpeng Hou wrote:
> The driver has a match table for the pci bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
> 
> [...]

Applied, thanks!

[1/1] power: reset: piix4-poweroff: add missing MODULE_DEVICE_TABLE()
      commit: 675d0e4521e87779fbc82c958095d369addb196e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

