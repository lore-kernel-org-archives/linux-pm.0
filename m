Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE517286A5;
	Sun, 18 Oct 2026 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341640; cv=none; b=V0ERtia9+oIDeu6JbGyZ8ifYERAGS07PdOAAXVaZx+SLKFk7Cb7YPqcN82en+9DPuCHDh8MYuynVmAQQ34RADi6d3vVYvvJ86qbsMu19ml+EXRKH4WLu6p8AgrOAP2cCi8U+8Z8W700QL/XjkDDMoi6T9xubwI/Q5GFkuDCbK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341640; c=relaxed/simple;
	bh=srs7dtHAwwNYQ2JL1zx6Oix5Hvf9coSfZJceTwN2lUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CATewN9LN3GyS0ygUudtFnkAMawVsL8SFmpB6zgQy7yn85MTsLblMsDARNmwYRLomHYr0DDbj243m8yQHfjI/HOVwvTlK/Ky0/PsR1Aklx6eRYPkmgHKwg68riNPKu0aHVbNq6Fep6JrPYUZfq3BzrKs8To468Y2maAUBJ5SBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; dkim=pass (2048-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b=PSoKXqHm; dkim=permerror (0-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b=SM7wkrlC; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b="PSoKXqHm";
	dkim=permerror (0-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b="SM7wkrlC"
DKIM-Signature: v=1; a=rsa-sha256; s=202503r; d=unwrap.rs; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From:Content-Type; t=1792341631; bh=pCKsnZzzQU
	klhIVb1fk/+cwj/EuYdFTeu++dyamkAVY=; b=PSoKXqHmBchRCTMc5+EKjF5dszSgV+ObJ01Y1
	BAjc9Ii87VIbx0NlAar2sTTxyfAcYX7ck8cM5QMyeheO25w9t7ZF0XvwrTQVw4Eo15lafzGKmlg
	RptQrdteUh79Q1sgaNkaoXdNNTmQsEswA2fKewCD7LgErpMSkAyeSfxb7TOdiRLNWAY9ZbLWbko
	cVvXzWlv9BkVU/6e5IovnFjuPBsWEuc8JkWh6uHZdNEJNWSAQANdHr7Rt9n384XQe0+41e1DEck
	FmkLyoYts751EH4HDHiFKccZuoWdh3Gw4XyC6C4LQHQnh2hOOvYcfOWDOBA7iwZyTO1a8Z2L1TL
	6jihA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202503e; d=unwrap.rs; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From:Content-Type; t=1792341631; bh=pCKsnZzzQU
	klhIVb1fk/+cwj/EuYdFTeu++dyamkAVY=; b=SM7wkrlCJ4TS0vGLHKaAH6kK113CTacLkka6r
	vH10j+teN56a6F9VhL7f2pbvgDZFH8tv6Gcm3R/BoklHv9DBw==;
From: Cole Leavitt <cole@unwrap.rs>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Cole Leavitt <cole@unwrap.rs>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: hibernate: Don't lose create_image() errors to arch_resume_nosmt()
Date: Sun, 18 Oct 2026 12:39:42 -0400
Message-ID: <20261018164004.132785-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_image() calls arch_resume_nosmt() on every path that returns
with in_suspend cleared and assigns its return value to error.  That
includes the error paths taken when pm_sleep_disable_secondary_cpus()
or syscore_suspend() fails, which jump to Enable_cpus/Enable_irqs.

When SMT is not disabled (for example on CPUs without SMT, where
cpu_smt_control is CPU_SMT_NOT_SUPPORTED), arch_resume_nosmt() returns
0, so the failure is lost:  create_image() returns 0 with in_suspend
unset, hibernation_snapshot() treats that as a successful restore and
hibernate() reports success to user space although no image was
created.  A wakeup event that aborts image creation in syscore_suspend()
is thus indistinguishable from resuming a hibernation image.

Only call arch_resume_nosmt() when image creation succeeded.  Failures
now propagate, so a wakeup event that makes syscore_suspend() fail
returns -EBUSY to user space, like wakeup aborts in freeze_processes()
and dpm_suspend() already do.

Fixes: ec527c318036 ("x86/power: Fix 'nosmt' vs hibernation triple fault during resume")
Cc: stable@vger.kernel.org
Signed-off-by: Cole Leavitt <cole@unwrap.rs>
---

Notes:
    Tested on a Lenovo ThinkPad P16 Gen 3 (Core Ultra 9 275HX, JHL9580
    Barlow Ridge host, I226 Ethernet), in daily use since 2026-09-17.

 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index c13f68ab7f6e..f53f844114a1 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -380,7 +380,7 @@ static int create_image(int platform_mode)
 	pm_sleep_enable_secondary_cpus();
 
 	/* Allow architectures to do nosmt-specific post-resume dances */
-	if (!in_suspend)
+	if (!in_suspend && !error)
 		error = arch_resume_nosmt();
 
  Platform_finish:

base-commit: 32c52ec87d6245ee2d12ed5dd509e40062939b50
-- 
2.54.0

