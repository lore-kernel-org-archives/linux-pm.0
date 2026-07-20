Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55FA42FCB5;
	Mon, 20 Jul 2026 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583828; cv=none; b=BkVlpa2OSF0zJNy4ZlvcBANijlHsi4olrS87il19Upo5dujOGfchswTH2qzRjl0VQ9SFHV113WPs/oaaWsfqCFaB6NKPjLHG6shY7yB4sDfAJN02m39Msh4+ANAbJ/JLUh3s74oDw8wtASqCU1/9v9q/GKZ/0LbXyDtmI3uS/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583828; c=relaxed/simple;
	bh=12qPFoVRe4sltY6DEryGXGNqGVdEZIxoWITUfO7Jegk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SGMjG7U548Bj4Pet7uD/sKMSLc34cuAZ/ds7chLxoWxvMMGJn7CHCRZx3hYtBi2v5/prT0MnsYQl4723FJg1RqOvqAug2EHsSYH4o9me+XFNVN3QI6smcZnmfUyVF5k9b/M4gTIvnYRA/4z/X04cF+5g+PLUS3/TavmIR1Z9xNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6731A1F00A3E;
	Mon, 20 Jul 2026 21:43:47 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E45BD180DD6; Mon, 20 Jul 2026 23:43:45 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Boris Shtrasman <borissh1983@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260625160556.54830-1-borissh1983@gmail.com>
References: <20260625160556.54830-1-borissh1983@gmail.com>
Subject: Re: [PATCH v2 0/2] selftests: helpers: handle multi line in
 test_sysfs_prop_optional_list
Message-Id: <178458382592.311390.6000038162632881430.b4-ty@collabora.com>
Date: Mon, 20 Jul 2026 23:43:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 25 Jun 2026 19:05:53 +0300, Boris Shtrasman wrote:
> Modify test_sysfs_prop_optional_list to allow multi line parameters, in
> order to comply with checkpatch output that limit line by 100 chars.
> 
> Allow use cases like:
>        test_sysfs_prop_optional_list \
>                usb_type "Unknown","SDP","DCP","CDP","ACA","C","PD"\
>                        ,"PD_DRP","PD_PPS","BrickID", "PD_SPR_AVS" \
>                        ,"PD_PPS_SPR_AVS"
> 
> [...]

Applied, thanks!

[1/2] selftests: helpers: handle multi line in test_sysfs_prop_optional_list
      commit: 426decb0c770ec4e0677906e1f51b6d19dc1b788
[2/2] selftests: test possible usb type values from documentation
      (no commit info)

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

