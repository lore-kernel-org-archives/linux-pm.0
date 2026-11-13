Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.232.15.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594696;
	b=hx2iuZWf9FKNfqMjLHO0qZDWNxVd0ABBRQKwbxFVQaO8ewqexNK4q5BkY9bPy8pD2pIb
	 dESZISE72MAEDhSBBLtKrPqQ7aC2I38NSszOhl10pZenyA1qJlH/GalMpXnVDvhzcKwf1
	 Qbt9O6BlCeutSnUP7NkkFRhzMzsGluxRweXRnfHj/x6r8iPEANkR35ourXE7JfCbnW7MH
	 RaTXpu4KSv3HXIS8jUtlcPM7jZSNz1Phs1o5wxW3p2iTkamLGmGG9GinEWhFRM8849gS1
	 HYkuSmDRWNytpUwtyVGVnX2qrhV8L+PCz+DIQ79bVD+KAxACpqSr+zhmnRwTLI7B0kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594696;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iO8ZVHxDJQl+61ZeOGiXewTmyRWa4tlHv6blsuVY0ns=;
	b=rxaFGlDdfD5j/WoDwu82SBe2F9WoGZbU+yHl9aGMpHbrXX2XhJEwm2ok+7WMkQyY50TP
	 8LZBzx7a+FMKjKZqtFKmpGm1ENTwsVkD9wRnPBbDDeih1I+z82xHaPihhLKdwwT9bGtMo
	 IlirbJLGYLTZKult0BbRIgjlatKWMrjew353T3BaBWxGL+AvIydjV41iy5ZATjs5FJWWT
	 ROT0dI1pCmiQdiaxf5dMAG5K3iO3ZKdgpGEwa4m24aVCirv3ttPZ4S3+65dG8340FUjkR
	 EGqc36oOUqOBal0aH4vxhHMa+Zq8QCOBtWHi0X4Kvu75T0dImJeE7sIFBOYx5X8K2gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=unwrap.rs;
	spf=pass smtp.mailfrom=unwrap.rs;
	dkim=pass header.d=unwrap.rs header.i=@unwrap.rs header.a=rsa-sha256 header.s=202503r header.b=YNpUQn35;
	dkim=pass header.d=unwrap.rs header.i=@unwrap.rs header.a=ed25519-sha256 header.s=202503e header.b=+iQ2tAwa;
	arc=none smtp.remote-ip=172.232.15.166
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB61606A330;
	Fri, 13 Nov 2026 18:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFB61606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unwrap.rs header.i=@unwrap.rs header.a=rsa-sha256 header.s=202503r header.b=YNpUQn35;
	dkim=pass header.d=unwrap.rs header.i=@unwrap.rs header.a=ed25519-sha256 header.s=202503e header.b=+iQ2tAwa
DKIM-Signature: v=1; a=rsa-sha256; s=202503r; d=unwrap.rs; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From:Content-Type; t=1794594682; bh=iO8ZVHxDJQ
	l+61ZeOGiXewTmyRWa4tlHv6blsuVY0ns=; b=YNpUQn358VEX4vZF9u2GQnvbA/ThCeBhRgb8+
	1fpxdQnr1EJnIhT5ReRpwYEM/QtC8c+7B7VYorRxmXwxjfu1kfeaZAYtphBNYkAZ0mdgUDm8m2C
	Iz58Fk1a7L/PEDij97GZzO2MIv8olzQ9jxFeX7dAobFQOSe6kKZlr2uCNd+5+hdmRvrC3iuDsbu
	LvBpkKZI5jvJk+sjImuo4BD35+UKq0Huhq+/2NQr2XJHDcvzKjpRcbj2943Si3NErjTeTbm/WT/
	ArMnIfsBlY5Zz1/ZOcejrPrzoduyNtEL0dcsKVcus1P5G/tknjYv7yjsBu15VRBQ81k4wdhB+PR
	beYuQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202503e; d=unwrap.rs; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From:Content-Type; t=1794594682; bh=iO8ZVHxDJQ
	l+61ZeOGiXewTmyRWa4tlHv6blsuVY0ns=; b=+iQ2tAwaechiL5NHF/ZPxvpSvxBhmO62ppdfb
	MsTBzI4QsfHghCF54G5nMHr5iy6HWBkTDcIghDc8hurb3ysBQ==;
From: Cole Leavitt <cole@unwrap.rs>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: hibernate: Don't lose create_image() errors to arch_resume_nosmt()
Date: Fri, 13 Nov 2026 13:31:08 -0500
Message-ID: <20261113183108.3982607-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAJZ5v0iJPQER8p0MGHneuyFiFqCbh__tWi9g-u6gQpxwMzhRpw@mail.gmail.com>
References: <20261018164004.132785-1-cole@unwrap.rs> <CAJZ5v0iJPQER8p0MGHneuyFiFqCbh__tWi9g-u6gQpxwMzhRpw@mail.gmail.com>
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

On Fri, Nov 13, 2026 at 7:15 PM Rafael J. Wysocki (Intel) <rafael@kernel.org> wrote:
> Sashiko has feedback on this that needs to be addressed:
>
> https://sashiko.dev/#/patchset/20261018164004.132785-1-cole%40unwrap.rs

Thanks for pointing me to it.  Sashiko is right that devices are resumed
with PMSG_RESTORE when hibernation aborts before the image is taken,
because in_suspend is only set right before swsusp_arch_suspend().  This
is older than my patch: before it, arch_resume_nosmt() reset error to 0
on those paths and the message was PMSG_RESTORE as well.  A dpm_suspend()
failure in hibernation_snapshot() gets the same message.

I don't think the suggested fix of choosing PMSG_RECOVER whenever error
is set is right, though.  arch_resume_nosmt() can also fail after a real
restore, and there the devices need their ->restore*() callbacks.

I'll send a v2 with a separate patch that records whether the snapshot
was taken and uses PMSG_RECOVER only for errors before that point.  v2
also adds a patch that makes a wakeup event pending after
syscore_suspend() fail image creation with -EBUSY.  That case currently
returns 0 and is reported as a successful restore.

Thanks,
Cole
