Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366949B466
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162454; cv=none; b=jskyOdt8jKO5pKb9ny6/dJrAIbOTOvwwII8ZoEtXNWVgXxeEcVWyP6/BfqDmbBOpMhMwN/2V/B32UfgEzgh4mIal63v+OsS7aLyLmtQRqSIsouIiqlTSmLhrH8K/eHQHE4DFhvvW2t5dAO7w1Ua9/z4mJ7TaMWnlG+qSw27OTrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162454; c=relaxed/simple;
	bh=ljPZGMW3EOOyQDGbBFq6Gu4+MAFs0+T56XB1zZrbm2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sylqbQgY+Rg4ZzoUlMew+NfTyrlOWEc14rcHzBwnSmUJjgi4fLPsV7shqGRCVSn05Xaw05NcKGyvwYhvLcDUtj8/G8l3YQmL5N+8clT3b+w7HwwQpxtZBRzEV7Qe3LfskQL7ZPBhUz8gy4fi5bWzQqOf7cQevlAr9fN2cI4lb7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVWOiFIK; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVWOiFIK"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c14c9c8ccso107790eec.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 04:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790162452; x=1790767252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M3A4c/xbFZ6e0tq+hH+/3HeXVXMCnlcmFGa/+buKPU0=;
        b=BVWOiFIKs2ja0GMbAE2WuwcWnyFcW3E1bmvWj/P1Z4sHdFzevPgXnMLf6U+4SChNRK
         ThMpxkMNan5bX1AZ904J4qOgvBHI+bvo7Wa3R2jS8W0mhkhuCIOhCZ+t2YAgD9gaW5Ub
         zVD7Jwz8oDk0rE4qOBeWvnpjD9dwVG1M7YCZBKeAGmtIChPbY+ZZAXnOBTSL9ok+IQN0
         LD7s0I0nEBWlKZ7vOBMgUkeJqrIWaZ+8rqGcJkq3wQRfedt4qrowVvH3ODniEF24JtkB
         d6MwreZxeMkp3AfN9Dz+//01pDqy5eL55GmfJfRAwzJUXgoWU7jW+vOHKcHrFHPkFkoZ
         QjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790162452; x=1790767252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M3A4c/xbFZ6e0tq+hH+/3HeXVXMCnlcmFGa/+buKPU0=;
        b=HrivKTMjRRnjERGNoZXEQRef5E1eNjRvYCh7jkGNKP9vkYE3USj6dLa3kTOFp6QGyM
         aMMg5WkZVQq06MfEYFBEESNSENi/PAiPlo2bQz/kByY1PKniWJoDpCXV+aF/Od/diQi4
         MsqFalpoSD8fS9V9/TBONmtEzz28GmUp2eeFz/GKBB2X0TkTLSal15wTHSsQe1XiFvuM
         zGv90AwTgb1rQAKfQkQ5bPkN4WOy0YBwXN3MAljpoyi+IxY7w+MvKirBfMYCXbww/t0M
         rqcnBZWwJKATAQfEFn35yxBbJR5zrvXSs6Ar3rpd1QdGynDOxxeZRHl3zRBAZdNKScJA
         8/rw==
X-Forwarded-Encrypted: i=1; AKwUvBwqAvGVqLLJStFafdF0GnTKvb0m6n4IwOHXlhyr1Ky0PmqOgvl6SbII13cNWQM/VlJI+i1dRZRuyg==@vger.kernel.org
X-Gm-Message-State: AFuF++kE0GFdIpejKUOwHwtjh/SglH3gSKgsrFPIv3VPltan0jmraZI8
	ZdIog9evESpJL5cMLix+y8Hd7luJ2f84wFysYpVqNWfyAzDpK6lkvffl
X-Gm-Gg: AYBFou05uQ1YGte6uryv2g8hBIPOyOEbRbVrM91aE4CTmOquQ/yv2dk+L8retkPyBJV
	q7elhqGce6nxLQRcOtG9ZeblnnJ4x2UwxePUkauw695tMYd1vn3uU73q1H/KGNmNJXrIw0YyRmZ
	LORPcMMbaFKlsqb0JzDOnfF1vIHYXt+fQ7oc2Xw0Y5+/YTl3vuHXcM6rPs9BdBLwBJmR20PiOkg
	kJXvi1EFjAmbb2K4H+QgeOJzZTa9UlBOiW1nEdyRs5GPochYCwY1bHlOKU4AuG7jdJK2I3mBF8D
	avKh5OgZKqJJ9134mCMhEYM1hlr9RZED9woYu0KtyG0Kw8OsQ/yHac2Qoti0wtgRhOckrp0uTvb
	0wHXCY7YRG4JjVZmvs0PC+KIAaGA/hRXLYj6MErApXrpAMpZtURBrrqMv2Hma9Ewc4O/zi4JneY
	VoO8IwbXiwJdDS6d7sogV0hEsjX2A/pP/YAk6YJloz9P5yoBMf7ldvyvTn0aD4POtZ0HSU8vDZ3
	n8VE2W7bDWQ1NQCK6lCd1fyAjskc/PuRRkspIjTac9DYC81t6VhZHK4LP4QHMxNXH6OlZ/xL8vA
	OrekjcAzmknTYTQAUQ==
X-Received: by 2002:a05:7300:c8c7:b0:33f:3750:4e22 with SMTP id 5a478bee46e88-33f3750519cmr1326580eec.0.1790162451512;
        Wed, 23 Sep 2026 04:20:51 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96d46f48sm11925271eec.23.2026.09.23.04.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:20:51 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Skip the suspend_noirq config save if runtime-suspended
Date: Wed, 23 Sep 2026 16:50:44 +0530
Message-ID: <20260923112044.187266-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arOpj4C67BnrNreM@wunner.de>
References: <20260923022511.24932-1-navonjohnlukose@gmail.com> <arOpj4C67BnrNreM@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 23, 2026 at 12:27:27PM +0200, Lukas Wunner wrote:
> Hm, pci_pm_suspend_noirq() should bail out earlier because of the
> dev_pm_skip_suspend() check.  That check resolves to:
>
>   dev_pm_smart_suspend(dev) && pm_runtime_status_suspended(dev)
>
> The code comment in device_prepare_smart_suspend() explains that
> smart_suspend is true for devices without PM callbacks.  But only
> if the parent has smart suspend enabled as well.  I guess that's
> the sticking point?  That the port above the card reader doesn't
> have smart suspend enabled?

It is that check, but it fails on the card reader itself, before the
parent is looked at.  no_pm_callbacks is only set when the bus has no
PM ops either, and pci_bus_type always has pci_dev_pm_ops, so no PCI
device ever counts as having no callbacks.  With no driver to set
DPM_FLAG_SMART_SUSPEND, the reader never gets smart_suspend.

pcieport does set the flag for the port, and on this machine the port
stays in D3hot through suspend.

Thanks,
Navon
