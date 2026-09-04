Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23B1A6808
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556821; cv=none; b=DhA7dXC13Tm5Bl6qC95YDnJe5uYaReJCt7Ug2WWJ7Dcl7DPJhgn4Tp3f7CMbLduBr/t9o494cpqEP5W+alBUu7GkOTmfxZQVzX8JDkXclDfcuwiPVe1gdn3bhzCJdw6twV97mtnnJuT5fyaTOyhCvedVAuNpN3k+o9UenxlfgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556821; c=relaxed/simple;
	bh=WECOXtzgmU3pytQmEyldGn4N2Qsc3l93x2GCjunkLAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYfGGPjYXyYOn5KtY24eKDpfdGeinnfwv4HVlDouXfzAOn24Ql9wisrRHTOPl4o87PNyuHbTIC4gPolktAte4BofNy3FHYrdCGhWdrJnC6CfDxKY3wolSe9SlSpREfzLAjWcEwxLL1j09bXAs3aJ7qu2LHUB4VkkqXtXRXQ8cTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eNN+XXck; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eNN+XXck"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ceab75934dso13443955ad.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788556818; x=1789161618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JOM/X+z5mBAOMP3cnh0Z9yrAw//GnO+efgsvLLHBMy8=;
        b=eNN+XXckrIE6mef/kXyQYKl20ly0pXuLyvVBOIUR9tGFRcN3JbmrH9z/3LE4Y53Ugm
         OKGgfXOIttncnoBhZU0TqW73w8/Sv2v0f9EshKjWLiAHMnYs7RQTuj6+du72ceJD872I
         UQXVtmzTi5oI+vvPtIMUQ0rXNyOWji0As1R3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556818; x=1789161618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JOM/X+z5mBAOMP3cnh0Z9yrAw//GnO+efgsvLLHBMy8=;
        b=bnHdI7uhChz3mX8IMEL8hyeOyD1YizMoGzpPCwlPugrmrSBijKL02DH+/1zAxAdQcy
         qklm1sCmyfWGIIM67u/QuUDSXeRdq1WC1akcwyCHpZho8bcJMQJOdgEkifXkti1waKuo
         ve2jerhMbapocrwQNyO/BNs+HkfSCRBS/1aXSDqYf0f0qpS6in/hsRHWaorU3mOD8BDj
         b3hWpS1W/iVxyctNJuaMhAeXTP/1WsEwte0bg/nbvdppfLsOytEUVgA3GrHlEyMyK9KJ
         apEvwKHb9+5l7BOwbHp352tEAfxBYnl1DBlyFE82lWI1BE7v53kyuY2mnbSpHdY3T6Xd
         tiWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtpcn39LB2xoGprU3F7jCOR810JHMPY7KkC2i8Iw5f1TCMD1qLTe4DGSrKApmlkYmfiu7DSW/GNQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lPuTme4VQrhTKsP7kijMegcihCP4dnovlNm9OVfGzibdsnJpwj
	UOeGhVZMRo6VRWgco7CLzUdqLaocAe4w/S6+I9VSoyzLaLysJvGJFMfkV8H+gRfKAw==
X-Gm-Gg: AYBFou1SXtCxgdcXasa+b5vtkSEhpDWkjz3R5n715yVPgcO2/CZZush/l6AzivwPTvR
	CLVHqE7MvPV8OtuT6PxCIh7Wm/eLDh5ukpyR31qlZMU00knvxM0QZwaZ9NEE6aVvxDfP3c7PlPy
	X0mFa1X/mplp0cQT09iRSJ/VXjLnwE299r0UPdjN6YIE+oJdDPfwjJZ9O86LMUcLPt+Iu78V6zq
	I2cIltsTRYlpY7OO4SaVvgw7jXUjw26u9sdluNDlPrBOBlqRIOEh7Rd8SIJEb0Oio+fS0RiqIGp
	VVgwFVwIu82aHXJQhzHgBa66iDgefwNZ3Cbr5YbZD0zKcjX0s+KYuYtaWmU6ij7q3kT63lk1CsO
	+I0D3J2Gh7VkZAB8G2vui3laAfz89qHBGcK6qgGPn6M57/yTyIVJmS9n5ymLuDG/r7crurOU+0G
	ayVVAp6TFbFPwP89qNxJM3/5P8d/PlCKblzcIq53vsRvnKg7GxwEdtzI3SS3dDXSDHSUHkXAqjM
	4CL4FY4uakhKQDd+n+Fs4I9ghg=
X-Received: by 2002:a17:903:98d:b0:2d8:d4d0:792b with SMTP id d9443c01a7336-2db12831fddmr111315835ad.15.1788556817531;
        Fri, 04 Sep 2026 14:20:17 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5597:62ab:c321:4a7f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3339885ca07sm10438663eec.1.2026.09.04.14.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:20:16 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 00/11] PM: runtime: Overhaul kerneldoc, runtime_pm.rst docs
Date: Fri,  4 Sep 2026 14:12:05 -0700
Message-ID: <20260904212000.4167880-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series started as a relatively small observation last year, that
Documentation/power/runtime_pm.rst includes a number of API descriptions
that duplicate similar docs in the source/header files, and that they
tend to be a bit more out of date. This is a great case for pulling
kerneldoc into the generated documents, so the docs can live closer to
the code.

Per Rafael, "that's the plan for the future":
https://lore.kernel.org/all/CAJZ5v0jFdUDN_Z5isEpWoisxzMHSgzu460VH2LDCLQTRsUtEDA@mail.gmail.com/

The future is now!

Of course, nothing is ever that trivial. I found several other itches to
scratch along the way:

 * Basic warning-free kerneldoc validation (resolved in patch 1)

 * Touch-ups to the existing kerneldoc (misleading descriptions,
   borrowing valuable work from the soon-to-be-deleted runtime_pm.rst
   portions, trying to improve ease of reading/understanding) in patch 2
   and 3

 * Pull drivers/base/power/runtime.c and include/linux/pm_runtime.h
   kerneldoc into generated runtime_pm html (patch 4)

 * Move dev_pm_info descriptions (+ more) from runtime_pm.rst into
   include/linux/pm.h kerneldoc (patch 5)

 * Overall reworks, fixes, and (IMO) improvements to runtime_pm.rst, for
   clarity, and hopefully to make an easier and more useful read to
   driver writers and people less familiar with the subsystem (patches
   6-11).

   Highlights (IMO):

   - Clarifying core concepts in the Introduction. (Pretty much all new
     readers I encounter have a hard time with the difference between
     "enabled", "allowed", and "active".)

   - Adding Example driver patterns -- because the API is so large and
     complicated, it can help to try to walk people through standard
     practices, and what everything means in context.

I purposely kept some of the larger changes toward the end, to hopefully
make it easier to rework or reject them while cherry-picking some of the
easier stuff from the first part of the series.

Feel free to add suggestions! Within reason, I'm open to tackling more
here, as I think many people have many valid perspectives on exactly why
and how the docs do or don't serve people well today. Or I can tackle
less, if you think some of my choices are not improvements.

Some possible follow-ups I'm toying with:

 * Slimming down the API might be better than heavily documenting it. A
   smaller API is a more digestible API.

   My only concrete next step: drop __pm_runtime_put_autosuspend(). Its
   last user is nearly gone:
   https://lore.kernel.org/all/20260806-smmu-rpm-v4-1-8183d007331c@oss.qualcomm.com/

   I could also see deprecating one of
   pm_runtime_put_sync{,_suspend,_autosuspend}(). They all do slightly
   different things, but I'm not sure every difference is actually fully
   intentional (or at least, not necessary).

 * Tweaking some of the behavior on pm_runtime_barrier(). Today, it's
   very asymmetric, as it prefers resume. But I believe there may be
   value in making it flush (not just cancel) pending suspend too. That
   may be in a future proposal; for now, I just try to make its
   asymmetry more clear in the docs.

 * Sand down some more rough edges on return codes. For example, it's
   very difficult to get any useful meaning out of pm_runtime_put_sync()
   return codes. There's a high chance that anyone trying to treat
   return codes as errors is inviting bugs. (Is -EAGAIN a failure?)

   Of course, the answer there is not "document it better" -- we can
   make it easier to use.

Regards,
Brian


Brian Norris (11):
  PM: runtime: kerneldoc fixes
  PM: runtime: Improve set_{status,active,suspended} docs
  PM: runtime: kerneldoc wording improvements
  PM: runtime: Pull API docs from kerneldoc
  PM: core: Document struct dev_pm_info with kerneldoc
  PM: runtime: Expand introduction with core concepts and structure
  PM: runtime: Clarify ->runtime_idle() callback return value handling
  PM: runtime: Clarify driver callback expectations and structure
    Section 2
  PM: runtime: Misc improvements to runtime_pm.rst
  PM: runtime: Add "Section" hyperlinks
  PM: runtime: Add Example Driver Patterns section

 Documentation/power/runtime_pm.rst | 915 ++++++++++++++++-------------
 drivers/base/power/runtime.c       |  93 +--
 include/linux/pm.h                 |  93 +++
 include/linux/pm_runtime.h         | 409 +++++++------
 4 files changed, 878 insertions(+), 632 deletions(-)

-- 
2.55.0.979.g7e5102b832-goog

