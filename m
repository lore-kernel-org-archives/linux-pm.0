Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564FA4B44A4
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661119; cv=none; b=LO9EVDhtD3ZGOdUbNCkI2yRL5hGXVpsJuF/ZGSt93gAaoRFM8JUhPU07aD333P5WdRiS2b22KNVKJuQTULex6PuR6JnNus97Yr5hAcvuOHJE/WP5anDNuof5gYv5b/bcArcdUxem6BQSeO8iaXpAvdVanMICNzpIxESlhIKIW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661119; c=relaxed/simple;
	bh=WZ/X1J+FgtaaLh8+x4jOo5vLn+ulOLLCnMUuIfGdG9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QO02FSd/Pc9N4VNRBqBqpl5z8OYiprPyqgsmQmJVR7fOK81b5bhYb7j1i5N4vPX5rbvInyUWo6xwYT88oSWIn9PU3j9cF8PC35Lf3NEP6PiDPBBRmrfrBuhCeyK9/UTNfCHFHLoqRExODYKH80RLJ2RtZHsksTMupG0LClD82Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYlMlPst; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYlMlPst"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so7947445e9.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789661115; x=1790265915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gla01MaALvns0Dwp2tgzeez6/2m4FJ1qC2kzsmKt4Ew=;
        b=jYlMlPstuttE7e2LFaN8fJoXT1OcooBrI/gtaLJQs/ATcQHkWI1l7/q6j05bIiIJHg
         ZlI5RKpc/AdL+ahl1aZKrxCtwSo2qgtP9OEXpqCsYCz0txPRFuJdr8ei6AFEAP4FVQag
         UT9lMRe4hdtl4X6iHy9mOAXuP3fvyrqXBBTpCQGkYQOXdk0Uk+Mj9AHvCHGNkt+UvstD
         O/q/H/EaO4AMweVdzJGbKTHClt6VKAOYxF02/F/I4NJlKFzeowKYIaGJqrSYEVoH/lOu
         trykbUg59M0vTtxqm6BXl49qVRbErgSaNVstVbCsese9Vd0dU4X4vBgS/Ksq6pSyLZ9U
         u7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661115; x=1790265915;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gla01MaALvns0Dwp2tgzeez6/2m4FJ1qC2kzsmKt4Ew=;
        b=j0OFGc2/UNiUkmIVtl3jes4m2FaB17eWe/efTBeL5eGBWXL/eh8l7Xi9VfRFjE9UVR
         Wpigt1OT+njAhT6UxMAnX/gRh64J5mrvau08+mlDd9ANS5t1dzyCyPkM767Apgg3etEt
         dX9/KgFl8Pd4o+so+oKthiD+dEHKo/JUK6Kodq+0dxkME7sLp9Jp5pNLumldY7iGxI37
         EuaIFCgHofu/ml5Rd4Ydcsb0PijwHIsMACqu5OJP6kSoylwlCZjee6QJu9AnDCcHhhZS
         mbxxSAjb1YPevi7aXcl/Yh0pUSHW0t2DtU5IFtoETXxX2A7mzEsEbtHyR52PUQc3gljE
         t/EA==
X-Forwarded-Encrypted: i=1; AKwUvBxgvcThiSutyD4lDnWfT72x+lBHRIbP72IwM6nkyl/znzEuHKmOvFcNQ/aZk28ilZ4jsiMpXSuMJQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ki+HAVA0rAgNy5UUU8PHTS3L4ZexFBgh+xENWkpe4JpUF2DZRW
	HoJJJ4lQ2Jpf5mySXNpdU7Vamr5Mv/lABlJZnaZrbsQ/GSpS55WkfwcT
X-Gm-Gg: AYBFou1IKRr8T6isKY03Wdn/DTXrigVPZRY4DLStYssdwcX5mbF4dRjesaba2+b5Epj
	kTyfCABkwMHcAFxJTS6eyuSu1LjWmL+c3br0FGAGfZZNZxdI/jABYLdu1Ac2nPCMAMXjx9wkKvp
	lEZeCKJCr2TXJJT8m04Wl1pb2bTb3ZjCFTrdEKxRA1CpwQkUwEuN/WVz9p7HcgyVKkMbjCv0uLP
	mXpQ0inqn4z6Ozve0nTdVnhZe3QWWIioxKtm5bf976d63rWmBqNUNSiXarsIy9WbRuLLo097PaE
	n98XXXyE6uPI/cI9DFm2hE2cUwrYmkRHga4tD5PT5hsn3QwY8Us4jTuYLWbAMZbXPgnnwWsXDsL
	8qvuWVrDFx4Zl+E7WFsVdfG77SNSNNo2pU7dZ93djtPqo6G3H4zu+VysP2rKOtuvkVDGpOfaMwk
	nyeQQQEyulXbam4yeC2+AHApOFooTrnzRXQVNSMX+y4QDmcGHv78kt6sizxYYmc2bVxnfJ/lNHg
	eWqv+BDHg==
X-Received: by 2002:a05:600c:8b8a:b0:49d:1f10:8b9f with SMTP id 5b1f17b1804b1-49eac463921mr112202255e9.7.1789661115499;
        Thu, 17 Sep 2026 09:05:15 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.113])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4870bf3494dsm15649963f8f.28.2026.09.17.09.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:05:15 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Ananthu C V <ananthu.cv@oss.qualcomm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] sched/cpufreq: fix schedutil's boost frequency handling
Date: Thu, 17 Sep 2026 18:05:06 +0200
Message-ID: <178966110618.2386.17602156528185920946@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ananthu,

Tested both patches on a Lenovo Yoga Slim 7x Gen 11 (Glymur,
scmi-cpufreq) on top of next-20260915.

1/2: with boost off at boot the little cores get cpu_capacity=553,
which matches the 4723200 boost maximum as the reference (4032000
would give 647). A workload pinned to cpu6 runs at 4032000 with boost
off and 4723200 with boost on, 3.14 s against 2.50 s.

2/2:

  # cat policy6/scaling_max_freq
  4032000
  # echo 1 > boost
  # cat policy6/scaling_max_freq
  4723200
  # echo 0 > boost
  # cat policy6/scaling_max_freq
  4032000

One observation: policy6/cpuinfo_max_freq still reads 4723200 after
boost is switched off again.

Tested-by: Oleg Keri <okerixx@gmail.com> # Lenovo Yoga Slim 7x Gen 11
