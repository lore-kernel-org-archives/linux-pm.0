Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6623A16B6
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557821; cv=none; b=irxrlZNo/zNTz0Weg3q+pGOvAu6WhlbklWw6Ph4LMWDwzx9/PKoK/GmcKlzGReJzVYY8gCtTUc3lOWH0wB+fMbsWn+HsSeGO3kIJNC3e5f8+cSbWXFem91ooH+8spLoceU45pXrXpF5z6CK5+hnNqUKqqejddxDwmzy/uNPsG9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557821; c=relaxed/simple;
	bh=9xfCnfWUft91FQ9MOOueIx15mDmNvVVdKkU3/hZKgHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O97VF8Cl4c4R2voS1/84bUq1M6kEh7UL0ZunXDwSgBpsN6+yFomcbRldv8Fw0JfHKakj+kBghBd0ShMSzFTe/Eq9F9903rz25QlhmVEYxCFVjlUFh+5Yo9pGtPZVcs4YyXCLLNLdpln45Yoz9hqyAxKqaxb9x7urg1FORkuI7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KznDIepM; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KznDIepM"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48434392b02so568188f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789557808; x=1790162608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9xfCnfWUft91FQ9MOOueIx15mDmNvVVdKkU3/hZKgHo=;
        b=KznDIepMwI5gk4UeJdZCO8BouTShkrtZyFygLGKAug/vX9irn7LxY7Qu8fo7SCKdzz
         ymP7kE1Gu8zfPTTanl7KcyUw8/RfsohNp1wGc5MoINZP9ccRvHiGNhDP63NjcKqD1ddi
         RgLpR0dnz0UmM0fS5z0s1n5l87SMtaDBjGHCwzsvrw2S3LjAv0Pb9fq1FGd1n1yBEnO9
         h/0vLsaL6MQNxST1EXz9bjK9T/43Ns3hD4yYDz2TSJKNMw4SGKw7Dyk7GgX9wVh2mu9g
         540Jk/kRxT3RRfcQ7v0Ao6pNZbiawylp7bBh9uR74plkLyY5eSK57UVmoMMxE5W8qvlq
         Y7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789557808; x=1790162608;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xfCnfWUft91FQ9MOOueIx15mDmNvVVdKkU3/hZKgHo=;
        b=hdjHMA1Vi5l6J2DUuZ7AY/rtp+qXGaFmj9T9bJ7Ny0YKR4pHA+7sRUHFKGQa4h5fCR
         x3z1N2J0smgcBj9/PDEs116KMuxXqyl1GPkupsO1Zumon3dhVBamzAmTVXXiTEXP3o9q
         jDDWV76d2UrDYvLyp6QyrMSyn9RC2ois9lx2jnhUJjqOhLWfD8cqLVsVaTyqFCCQvweB
         GwsJ7lbQCCjahDlRMeA8W4632awdmooNwMHUDI5OfhxJc4K0QL0Z0ltCE+m9dkX80qJn
         WGyPg3yr40bEQxFsiRVFgTT0T6NfayaaT9PBBs4HQFHiRCv2Jg1ATD8pUy4WCQ7He7g6
         qUOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeyfo8p0KMPGre56kEii+q7Z9R+moNj7jxbuG4N/3vWdW8Z0/tYSnTpQTMEq59/jv/doIqLr3tDw==@vger.kernel.org
X-Gm-Message-State: AFuF++mwrM9OiL6pN38TYUcPqJyqaGohh0LMuAR7xvZuEivH0Ib1iLea
	D97ldV1ExX09VABbt8s+fCQcolsXayBOk0cS1JeBoPIRctb9i7+CIf7nJW/wrCUpfCg=
X-Gm-Gg: AYBFou11SSBYWhLbhK4Vugftyn1t6oyJ8TF2dqq+NHQi47u54mL8hX20rMcpTn6/RDL
	fCBK18jGEx3Qo2MSzMuQwH45srLqNKaLIR1XsJz/UX343YYkPJGbSItGKwXdRVfsBKy8wqr0oCd
	N0usI/g0z3KcfND6QQwaDQWiZGP1M4pkY9D1SXG/0ApYAhKvEoMqb10Pm7/B+NB/8rhQ2IpwzWT
	aEIYMF63LjND5KMt7UVj0p+29VWaNiSPCFVMKkHRFsG9BUxpp79++zliFVq94iesn6TOlhv3n9B
	8o56FJQ4QNAZWJcrPqAhrNO2k8G6lNO/BGFtOThSbecO32Si9omHMgQbn2GGzRmHuRRDZi2vNOV
	Tcud1OcMCxe8ZJQ+GZ3lZghZyxsYMPuIx2wEvZnfS7YRib9ISI/mS0IXWN44m4rX+PV/le8vaQ3
	l8e9a+M0vO9odsk99xVNuOx5uhkKvaOHulMg+FGw6uwhMHGXofe2+lwIADob9QX+U149HdlNi9F
	WEGQWWwB1s=
X-Received: by 2002:a05:600c:6296:b0:49e:602a:b4ec with SMTP id 5b1f17b1804b1-49eb730e225mr53609375e9.8.1789557807754;
        Wed, 16 Sep 2026 04:23:27 -0700 (PDT)
Received: from localhost.localdomain ([194.154.195.114])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49e83d9057dsm80761805e9.3.2026.09.16.04.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 04:23:27 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
Date: Wed, 16 Sep 2026 13:23:19 +0200
Message-ID: <178955779940.30466.10860982419496123467@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <55538466-2203-42ec-a0bd-b743c04a3b38@arm.com>
References: <55538466-2203-42ec-a0bd-b743c04a3b38@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dietmar,

On Wed, Sep 16, 2026, Dietmar Eggemann wrote:
> In task scheduler code we use cap_scale(v, s) for CPU capacity related
> scaling.
>
> We could move its definition from private task scheduler include file
> kernel/sched/sched.h to include/linux/topology.h to be able to use it
> also outside the task scheduler?

Fine by me, that reads better than open-coding the shift. Your diff
builds here on arm64 (topology.o and kernel/sched/), so I will fold it
into v4 and add the scheduler maintainers to Cc for the header move.

Since the diff is yours: is a Suggested-by enough, or would you rather
have Co-developed-by and your Signed-off-by on the patch?

Thanks,
Oleg
