Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E031714C
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496560; cv=none; b=rodAaTla9fy3qYQwhaq+h3eILzXwVnjPcJ7RWLc4GB5XhZcoC84fBl9UwxHJoGbyN9DcNddfsvvkX9Fq3P34lgakLLftVXEzEVi20Ps/IYBXBRhwA1GlNr/uXsTVIzZau5AuMRZLMXaVjAxLxgLt8u+fIPaZSJdL92DhClTJzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496560; c=relaxed/simple;
	bh=DuP7YJa2KOgy4M15xxh96gj+qpeYeZJfIo9VZaW85f8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lRvL1JO3Niqq5SxYeZdHiNA+o5C11Xvc1BI8n5wHZLGo2kZHdeYWqQRvBd507M24pnN2CSsh9Ll6qNUL7sfBePsO9bs5YEy49oe6JkOxnpywVt3of2LiFT0WpOxGvcv8sg90M3QRIvrt70v7XO91DN3I0cNu6CwunTt+ulNoKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au8ITK90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au8ITK90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA371F00A3F
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 17:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496559;
	bh=cw5KkUIrJ5v5SpXquaOj3bBg+VX41xW2c2t6PWfHGxQ=;
	h=From:Date:Subject:To:Cc;
	b=au8ITK909Q+E3zVTut8Lx5G8a5tnRrIi+bTAt9YowUpohuLCUBBPvZXdWJZ/0iBu5
	 JaHaWNKar7TH9kZOmse9xS9Cw2gMJI/q86ZdxSTHiLYMKio0gMUi+GcWhl/hyWaTrg
	 33+TM2H0FrhALyQc1LOLB3e0y3YU7kZQpHjUBJwDwuYoVnYLlyvceYIYcoPI70JkPD
	 JXDFDEwjGIewpkIT7iOg/lE6V29+XG4sRw2JAMx+HZXGjIbR5SpPFT42JTJCT5zciV
	 aBGGL/AvTf0dIlKAmbcTQc6Ub768/O7cXj0YQSO/96A0qCGdtN72ZdcYCAwv7SaUMD
	 5Pl9ubg5JVc7g==
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5bd7309af69so511757e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 10:55:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YwR3TU9SACdJXShpoWZ0f57YeM60646c/tpDqzQI9MBzn2vg9L+
	eTfjLg/HTwJXqf+BPKCUKzNGkKH4tD6VmirNkSvZjZ5APGI7oPCm5/Ph32OJZMdDp4hx+hGlDS1
	g0Y+aZf7w0MmmnOW8Rh9Q67EjeIugMfo=
X-Received: by 2002:a05:6122:218e:b0:5bd:79be:8f3d with SMTP id
 71dfb90a1353d-5bd8349541fmr977659e0c.4.1782496558522; Fri, 26 Jun 2026
 10:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Jun 2026 19:55:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ht40XZr9tnHJc5v_LPNNNnW7WrX7E9A7G+4irJAfZvcQ@mail.gmail.com>
X-Gm-Features: AVVi8Cex4_xehbmBO9qMunwjVlXyTaiX_AhwFDQyZyqtAr_Tto6c9gJfMdrW4DY
Message-ID: <CAJZ5v0ht40XZr9tnHJc5v_LPNNNnW7WrX7E9A7G+4irJAfZvcQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for 7.2-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.2-rc1-2

with top-most commit 3a2976df778a9af95e91f7ff88008b4517ddc658

 Merge branch 'pm-cpuidle'

on top of commit 5504ce0317f777dcf102751c3e518284226fc2e1

 Merge tag 'pm-7.2-rc1' of
gitolite.kernel.org:pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management fixes for 7.2-rc1.

These fix the schedutil cpufreq governor and drop a bogus warning from
the cpuidle core:

 - Remove a misguided warning along with an inaccurate comment next to
   it from the cpuidle core (Rafael Wysocki)

 - Clear need_freq_update as appropriate in the .adjust_perf()
   path of the schedutil cpufreq governor to avoid calling
   cpufreq_driver_adjust_perf() unnecessarily on every scheduler
   utilization update (Zhongqiu Han)

Thanks!


---------------

Rafael J. Wysocki (1):
      cpuidle: Allow exit latency to exceed target residency

Zhongqiu Han (1):
      cpufreq: schedutil: Fix uncleared need_freq_update on the
.adjust_perf() path

---------------

 drivers/cpuidle/driver.c         | 8 --------
 kernel/sched/cpufreq_schedutil.c | 1 +
 2 files changed, 1 insertion(+), 8 deletions(-)
