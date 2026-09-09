Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29646984F;
	Wed,  9 Sep 2026 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986979; cv=none; b=e2lYnmdZF9VRVMMs02nlbx7+iTftwjQy2SP17S1sojv7f0Hj8aEuxHySjJehU3myxCrIZKUUFz555q6r0spSYddq67GAw7uBcThmjvSTVW3v+5CvsBUBETauKcCjIndwsdlRjRlTvRmzrWFIf4E/kYYYy7Y32tFWTetOStwju/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986979; c=relaxed/simple;
	bh=UMTBtnzkNQT1wZyPO0HRJxNMgW77946w7bUUMIDruII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JzmmPpVYWOQGSwWccbmIb4PbaPNmsntMwGdZMXK7c3vv8T71MgpD6Oew4kE9ENf6elS7CcZagKKpRaXZlnxrHWDi+NKNQOOkUrJTPZC7SxER5GfmJZp1o2FFpeAq058sn/hczsvoS1uRw3pctfDmfw0fiqE9YQ2Q0aRnvB5jaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0041F00898;
	Wed,  9 Sep 2026 20:49:33 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 023BD18337C; Wed, 09 Sep 2026 22:49:32 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, kauschluss@disroot.org, y.oudjana@protonmail.com, 
 Zongmin Zhou <min_halo@163.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zongmin Zhou <zhouzongmin@kylinos.cn>
In-Reply-To: <20260827020539.22837-1-min_halo@163.com>
References: <20260827020539.22837-1-min_halo@163.com>
Subject: Re: [PATCH] power: supply: s2mu005-battery: return errors from
 dev_err_probe() in probe
Message-Id: <178898697199.883277.15114408407827172199.b4-ty@b4>
Date: Wed, 09 Sep 2026 22:49:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Thu, 27 Aug 2026 10:05:39 +0800, Zongmin Zhou wrote:
> s2mu005_fg_i2c_probe() calls dev_err_probe() when devm_mutex_init() or
> devm_request_threaded_irq() fails, but drops the return value and
> carries on, finally returning 0. A failed probe is then reported as a
> success: the device stays registered with an uninitialized mutex and
> without its IRQ handler installed.
> 
> Return the error from dev_err_probe() in both places so that the probe
> fails and the driver core logs the error state properly.
> 
> [...]

Applied, thanks!

[1/1] power: supply: s2mu005-battery: return errors from dev_err_probe() in probe
      commit: d5146fe3468703d82087270eb18bac81c15c10a6

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

