Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3CB389DE9;
	Fri, 30 Jan 2026 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811873; cv=none; b=WY31p3L/nlrwebHs/g8WFPUQeHjVzvTGKl5XVtpnldEZ6Jv7JcsNQ1mnB0JfnzZ+jPtpArNRgu68dsIefzD/DEjaA1H93SNSHRDriVlkLzwnXz99oOI3hDX78D5oNvhNK0P9bwVgOAwYkTOS2tKDqxZa8btHGClDg2mknhS/VhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811873; c=relaxed/simple;
	bh=KXLPZDFw8ClfGR6yvhfI7UCYDHsgAOLDlb+0biunI7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xkw5TFy9tA61ctId4rGSKEZHKIhfz1eMsVKfmbsIBEwzS0plS7ovSW5schYIOT0ISx13S2wieUvfInhjR9EBV5EntDIjq82EDNYItjUqXB6Gcl2+FmiN6ylAKNAFWAyxId+lxgGNrvLNYLOWY/ES9/vCYI6ess9tZOOUdU5RGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F6CC16AAE;
	Fri, 30 Jan 2026 22:24:33 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id BB302180596; Fri, 30 Jan 2026 23:24:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1769158280.git.waqar.hameed@axis.com>
References: <cover.1769158280.git.waqar.hameed@axis.com>
Subject: Re: [PATCH v2 0/2] power: supply: wm97xx: Use devm-variants in
 probe
Message-Id: <176981186775.331784.16421404001791768718.b4-ty@collabora.com>
Date: Fri, 30 Jan 2026 23:24:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 23 Jan 2026 09:55:42 +0100, Waqar Hameed wrote:
> This patch series contains some clean-ups that makes life a little
> easier. It was originally triggered by a NULL pointer fix in this driver
> that has already been applied from the previous version [1]. Therefore
> note that this series is based on `for-next` branch in Sebastian
> Reichel's tree [2].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=for-next&id=39fe0eac6d755ef215026518985fcf8de9360e9e
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/?h=for-next
> 
> [...]

Applied, thanks!

[1/2] power: supply: wm97xx: Use devm_kcalloc()
      commit: 72db889394d89ffde61e7438f0cdfc0135c9da48
[2/2] power: supply: wm97xx: Use devm_power_supply_register()
      commit: 3db37475d78ed0c2857f289a535dd44b045a904a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

