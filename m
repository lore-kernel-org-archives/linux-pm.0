Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EBD332608
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816071; cv=none; b=W4w/MWLsCxiUYOpRWJKszDMVtDyaw/hAeb2lWldVvG10l1ruNcOR0HRuFqk8K93NoMnLzLwnate22rOnbJV453WJEIL5If8TGk5cAgHneL+NEeXy2LRkE0kmlimLeCOCudpuEGcteNo0U7TSe+HByWuTIdbAXK7i8UUCB1VXKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816071; c=relaxed/simple;
	bh=NNOGRi2Pk73elP/uDZRT2G7dsMhVJMDHI6gq7/8u8lE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UJVYcJuTMrQ5fzGAUa4nE31p6XyfxRylUAAWUfY9HMNJ1vq7xlTCsoLGKqNu/EwC4uZSbqKv+QL2HJQg6nRAJTyE7uvr+PFhhx9+c12NKJ7/uJAlgpvkdY8qjXKkRBYmJNyKxsU8dm49bQvsMLSymP16ppTBfxiTVciIE/RvbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiczjVDv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiczjVDv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488971db0fdso18592355e9.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775816069; x=1776420869; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+sH4Pq0+JhCvPKdGn3HzVN61BGlxBFICyOKzedDdf5g=;
        b=DiczjVDvTKeUbF1nWymk3QrVFP4ep8iZpwGa8wZWkmezut4qg6U3iiock7L5UmNiHa
         On1L3eV36SKpRUWEIGBxwe3nWL1bc45qjbx01TvkxO5hkfIwQTKtFfwZLDqAlGZByKCl
         DplXRxu3po/3n4JdC31qgPsQBWbdNpM8Qlfbt4ZwexkIB50T3erkCxo5c43Ns1d2H2ma
         hNP9nRHclQSEQurxS2A8+OkwXIYUH83rVjRVNjHzM0PtA30k++e/v5WwdKwPYUeHIblR
         JiOZdJ0UfOY6YEV2MLyApusiKEwkYN1GOTj/nrgCTTRlyYgmWakLkaIIDYe253cbtGhw
         j9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816069; x=1776420869;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sH4Pq0+JhCvPKdGn3HzVN61BGlxBFICyOKzedDdf5g=;
        b=T8j0Ia4rKgyG1pkFV79idGATODwm4FAc0cGiWigm3cftS7mvPXgBxBUlfU1IjOpZWp
         Gc75huhJfAtARcIOFL628bH0vomA0nq6LO3JKbIAyDSUvGZ1B/aNLXNrF2koWBDFePRg
         +valrX+FZPw2Jx/ZcM7lorR3KimMNCaq1dwXEcMRE5Yxps2U6Tu9UTn5LqEU6frM+GZQ
         yJ793fx2a5U0TEz4QaULcVccswIJG7eH0kPSBd5pT/dAXxE3mVVvEyHBaJY80kigfe0w
         F5FMcux8dSftiu5qJv1YISV2V1yTsEe0AYzfr4F+uIw6KRmHUyi7O/No5qUE05YUHpOx
         yJdw==
X-Gm-Message-State: AOJu0YyjUf0QU+wpSjajPBxcxU5LYRhhxPmWzyxxByYiX7kYeY9QyNdp
	UfV4ic7h4+AXx7BjkX0qaqQa0nU/3IGQ/Kn8yhjzyrVXL0KGj4Z8V0rNHq/nP/Ui
X-Gm-Gg: AeBDies2g/APR0ezzG3lkem4yfoGy9ImGVUJixw/uVX5EuGyv6SV2qM/LSe1Hiq34sc
	tjiV6ytykJ5oysO+bwwloCVrl3e+gLCfhx5Ed7nacgbXaZZynEpsgcMx94eUMPjK38s87MNJMot
	E96PWDxdfkRtcs+D7kFjQad4opJk3oOHs9FJCPNroS59jT7+AlfTSxS2koAjIlg0fMaAB1a+ard
	Gt7+dL2jMjDY1IiGCYNpaXcdP5IET+N/vCwJt960rd8I4T3795ycjzNTcysTfBrW6P3+7MgVsTj
	HBkvbJfmKxzhMFn830OxcZUm/pC8KORoJjnxMsO0MxqMjIE+a1/oudKBB7+otoJKJLu22BVgfXp
	9Dn232nRIm7XsCDY0UIwOGd3RB00LmbZCsZgkr0ps92n2qaAQ0VzOETtONat4xe2nz8azNqe9rW
	9TPT4cv/aMHiZmUe5/A1c=
X-Received: by 2002:a05:600c:8209:b0:485:3fa9:358c with SMTP id 5b1f17b1804b1-488d684bafcmr29472215e9.17.1775816068634;
        Fri, 10 Apr 2026 03:14:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b56d1asm62986385e9.15.2026.04.10.03.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:14:28 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:14:25 +0300
From: Dan Carpenter <error27@gmail.com>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: linux-pm@vger.kernel.org
Subject: [bug report] power: supply: max77759: add charger driver
Message-ID: <adjNgZAaULzTBtJO@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Amit Sunil Dhamne,

Commit 70d7dd27f6dc ("power: supply: max77759: add charger driver")
from Mar 25, 2026 (linux-next), leads to the following Smatch static
checker warning:

	drivers/power/supply/max77759_charger.c:117 get_online()
	info: return a literal instead of 'ret'

drivers/power/supply/max77759_charger.c
    97  static int charger_input_valid(struct max77759_charger *chg)
    98  {
    99          u32 val;
   100          int ret;
   101  
   102          ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_INT_OK, &val);
   103          if (ret)
   104                  return ret;
   105  
   106          return (val & MAX77759_CHGR_REG_CHG_INT_CHG) &&
   107                  (val & MAX77759_CHGR_REG_CHG_INT_CHGIN);
   108  }
   109  
   110  static int get_online(struct max77759_charger *chg)
   111  {
   112          u32 val;
   113          int ret;
   114  
   115          ret = charger_input_valid(chg);
   116          if (ret <= 0)
   117                  return ret;

This needs some comments.  From the naming, we would assume
charger_input_valid() returns true for valid and false for invalid.

Based on reading the code get_online() return true/false as well
but what does it mean?  false means offline and true means online?
In which sense is this a get_ function?  I'm so confused.

   118  
   119          ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_02, &val);
   120          if (ret)
   121                  return ret;
   122  
   123          guard(mutex)(&chg->lock);
   124  
   125          return (val & MAX77759_CHGR_REG_CHG_DETAILS_02_CHGIN_STS) &&
   126                  (chg->mode == MAX77759_CHGR_MODE_CHG_BUCK_ON);
   127  }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
