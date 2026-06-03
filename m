Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F94E38F25E;
	Wed,  3 Jun 2026 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780521296; cv=none; b=OxfMRpJ6Ln0NZnCaGKDeGxRk4jYrtXNdLTSxwwUAANo8L5cShV27on18073YLmJcfkZ3bjQ/vO5GJGEr2iK5yZnvwuBK+ZhvRqpML8Shnj+qPIcaD4FDayXa2XRz97v4YThM5/drmw0qoc5sglgbwAH1a2GrxArootjz34JGtVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780521296; c=relaxed/simple;
	bh=+glWu5lyCbcRjkIT2bwJUQt8wBgDSFCHqvetEXTp3GU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pMSs+yNFMyExinyw8Q6yVUJ4xROc6cRKzcAFu03Of7OQ/vQnOXOBhKzbC6/rH+NC39muv12nC7gwGjhX4t4ZJs8E9KqG2KQOAi/8AiremtxxuYtaaDejLRHUeiqhFHbTi3J9BnsWCHoiL/vc60bZsSa45juZ+aV77DofHGHHmlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3747A1F00893;
	Wed,  3 Jun 2026 21:14:55 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 1E38B181D83; Wed, 03 Jun 2026 23:14:53 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Paul Cercueil <paul@crapouillou.net>, 
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Costa Shulyupin <costa.shul@redhat.com>
Cc: linux-mips@vger.kernel.org
In-Reply-To: <20260515185043.1523363-1-costa.shul@redhat.com>
References: <20260515185043.1523363-1-costa.shul@redhat.com>
Subject: Re: [PATCH v1] include: Remove unused jz4740-battery.h
Message-Id: <178052129311.2671410.17383042434045118752.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 23:14:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 15 May 2026 21:50:41 +0300, Costa Shulyupin wrote:
> The last user was removed in commit aea12071d6fc
> ("power/supply: Drop obsolete JZ4740 driver") and replaced by
> a self-contained IIO-based driver. No file includes this header.
> 
> 

Applied, thanks!

[1/1] include: Remove unused jz4740-battery.h
      commit: 0549c4c01338abe343a4ffaa4733475d0a85d38a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

