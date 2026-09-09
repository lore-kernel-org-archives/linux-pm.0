Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EDF38A71E
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932710; cv=none; b=Z7hPQqyR1VOozEXIG/yVloTJGp0bqKgHHGCq+UmuL5mEDIehQ6O7rKvznZBJ0mOGU6RrD2XHpVY2Zfwv0H2n0aWWurNpfTdDAPUB/aikdN9oFnpQNQQ0Pr9mFHiMnOBGYQo/IK32cZldVKzCWogghuf4wVVhKCGsbdcTPqfEb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932710; c=relaxed/simple;
	bh=rDW2mzO/o/iaTvF6aCK69cv7zdaLQNwI4VuzgmDfGpA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QnTBCYv7S50IttfbAVJfdYGkI9zI4MJLw5/8i5Tv5R6Oq5h9L5WCitqj3uC+E70duqOgxfK/Kty1ZB6z9b70Rszq1pdbl4swEXtYLRQmaC3rjQA/pKVvxy7qaWIpDf7o7iZ53Ao1Z7OJVQpSVfzU4B1NP+OV4KcP9pSndnEatVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IBKRMU7Q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBKRMU7Q"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so4191863a12.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 22:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788932707; x=1789537507; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=faNvRZdpir8v7/BAWQM9NETUGmzw+j7McnoCTckB6I4=;
        b=IBKRMU7QYjGhh/gjWyVja0QBCn/jxRQ/JEWgbvkDeyVzn+wheFb1Pu1g5HCHIJFceW
         fgquFpiIPxitDKGTEe88TrxQjTVSEC9lpv8WgFbobEeBPpZ1HOuc5YcPljiTzWrm9jPI
         PuM9aPBa4axtMEFfxbv4bhSjkWnD/gUjeZ6kx1TBmH4FVYWigL/LcyOLpiikaN4hzKjV
         xMB1pdiJI/4Y+9aSVw2tcbiQUEdnaUbDrh4EG8z/jKuFn6ZjHNUYfWNhpaFW0Tw6+Kxv
         j0dQinW4fP+ILn9YisZaJFBZCsJNzSZm9cca249p9Bkfp58voT6iZl3r1eQ1/U2fdExn
         bkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788932707; x=1789537507;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=faNvRZdpir8v7/BAWQM9NETUGmzw+j7McnoCTckB6I4=;
        b=G68LHuHNJHwUZF0tznNMys6Xh9ICaSe4PyoG4iF+X5R+FKXtPj7lpQKrZHEYO9KAtU
         3PZhSmSYKYXOxVHSbKugf3IXDuJLQwTVnzl9dfpPZEHyQR9+EUOpfxi2c27kxfDqRn7E
         dYZqIWyQ1zFBajaPg0k0Mx52H8peCY92I0FkdZVOeL+tQ2QnSUklNo5C+5JXRK87+uOc
         8/vSOaTUmEGAY1CweJf34K6zlBwV2QVHzUslSTVYBPN8q7oeml/MC0IzGwtQAqIQ/0/R
         oZsqvvwPGb4tuk0xUjMzkcHN1YWczwe61R3uaSpdGJ8CgZtbHVymVL/64nucwhwqL6vE
         h7HA==
X-Gm-Message-State: AFuF++nofRFt7uSjx6gwlwD4TKJ4AHwjvZL4yhxyoQjWtJDIhikAP0XZ
	I7WXtErvUpgtrzfYznjPpJy96WDY7nQRqH7R6SWaCkdTvQ4VSFKvfm9pJQi8/dKem/uIgTA28w5
	q6l4k
X-Gm-Gg: AYBFou1IFazfFNFRM7HBk264DNE1pSg9S5y+CdQ1MsKIGxOpL6hqDZXLSlG8u0yIwYy
	5rQguqf+2Vf5XbJXL4vbdJ4hOvDV6slCRvb4GUyPhtEW7YY3fuqX3XxsRt4LqIl0yKcmKdCLK2R
	26qovUkZycy+oGkRrwRxyX+uZTFqo+w4XF5QPJ9nqYOmntDJh9ADh4xZPFH4s01xNhZoBFYS0cY
	mrahRRmG+ACv/bUuWlFAIjFWPllQf3R+v8tM4M4Pl/GTqJQQdhtN6x/EVpQ3uRjrW4ztVOZpasc
	CZLY+YXqtruwZdJ9jUyL52QMALHTuhV/vqzJ6gFP8jh5qUpSkvlkY2g1Id3UAN0fy+SwF2mXXZd
	6Wu0I5zUo3nupZ7+VqxZlcMd8SiwMgavP0jyV0zcIgNWWqBT5gHV/28gNdNLIdPbeupEtfEoCcX
	zOjRdO7q0UqXYJWSipoTtJSmbERvtrUKApspv4+hA/NKRljWOV0wjv8tGAMp/7zH2yTmF+SS9k2
	w==
X-Received: by 2002:a05:6a20:c89c:b0:3d3:ae1f:d7f6 with SMTP id adf61e73a8af0-3da3a0c387cmr51781823637.22.1788932707109;
        Tue, 08 Sep 2026 22:45:07 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397d6d1becsm3144095eec.22.2026.09.08.22.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 22:45:05 -0700 (PDT)
Date: Wed, 9 Sep 2026 11:15:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates 7.3-rc
Message-ID: <aqDyX2swnxjWCJ4M@vireshk-B250M-D3H>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-7.3.rc2

for you to fetch changes up to 1f6de65e3314519ce462bfd3a1d29e918f97e4e5:

  opp: fix use after free in _update_opp_table_clk() (2026-09-09 10:23:05 +0530)

----------------------------------------------------------------
OPP updates for 7.3-rc2

- Fix potential multiplication overflow when calculating freq in OPP
  core (Colin Ian King).

- Fix use after free in _update_opp_table_clk() (Peter Griffin).

- Use %pe to print symbolic error name (Sumeet Pawnikar).

----------------------------------------------------------------
Colin Ian King (1):
      OPP: of: Fix potential multiplication overflow when calculating freq

Peter Griffin (1):
      opp: fix use after free in _update_opp_table_clk()

Sumeet Pawnikar (1):
      opp: Use %pe to print symbolic error name

 drivers/opp/core.c | 30 ++++++++++++++++--------------
 drivers/opp/of.c   |  6 +++---
 2 files changed, 19 insertions(+), 17 deletions(-)

-- 
viresh
