Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97793DA7C3;
	Tue, 19 May 2026 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176649; cv=none; b=E37c9yRhEk0ihOQIZ1cvnwIB5o1rpKWd8DwqPVG87mDXPGVXx/lWHRdpRKXI3vB2PLA4+0guCUs7nuHjacXN9UQh4Fw+gXeCnF9DCG9QUhZNw/ZaTLeM8YyUwwUJks+TbV7MajLO03rwMNFcWTO+3tT55pFQOm7szeocP+7B2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176649; c=relaxed/simple;
	bh=V08i26t1HAdUDU8S0o6MaDq1sEz+EmPcsPPBkAxRDBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KeDKaZjP9k979U9EAio6tC1z0wedgCPXQvvQRTak9O9pUB+fQYK/wbIOiwHEdv0lNHpwkXWyjjiWoezpeiN9yhMv4MzUKlx2PaSIPJUO8Dwob4UTfNTj33yzRCRZgWUQBaEKdTn5DwMPg6ek+mpXWDWM+oX56D0CYvf6A5pqozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OBO8RfFp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OBO8RfFp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E963FC2B9EA;
	Tue, 19 May 2026 07:44:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BCE39606E9;
	Tue, 19 May 2026 07:43:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B6B511AF8BA2;
	Tue, 19 May 2026 09:43:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779176629; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7BqXTRRdtzZ3ZmsxEhsnczCBT/VuG4h0WlQgPJGuimE=;
	b=OBO8RfFpFDbsgEjqiFyV/cv7aIkeZoLfS/t2H5ZFY3Y7NltTqYS2NHsfHQX3qcIJq0+tAc
	yShSLl6CComziH3hKJqf/eEmxBeR+hKUVqmFKbrIJdqdOVc+7zdRjlbMLtW+OhVCAUcY7n
	w4uKRCBs9yCIACoIfB4vnAgybJlpvdv3H9sGIA5XJ68vogxyvJaRysfqHWhetjVyj2rC9i
	wGD0QHUwQsP9iZjUbOyAc159qnkOByMAGsjGp/VmTwIpna7/K1zZtSrVNnvGl40B5FOElO
	egIsyGxuW7SEvqXZ8CzMoDwah/zxh/85qNbSz7QJhb0Fp5/I3RrpACxQTxqgRA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Mayur Kumar <kmayur809@gmail.com>,  rafael@kernel.org,
  daniel.lezcano@kernel.org,  rui.zhang@intel.com,  lukasz.luba@arm.com,
  linux-pm@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: armada: replace msleep with usleep_range for
 short durations
In-Reply-To: <9ae2a769-4b2a-4990-90d4-0a1c0f05ba82@oss.qualcomm.com> (Daniel
	Lezcano's message of "Mon, 18 May 2026 19:57:46 +0200")
References: <20260511153750.183640-1-kmayur809@gmail.com>
	<9ae2a769-4b2a-4990-90d4-0a1c0f05ba82@oss.qualcomm.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 19 May 2026 09:43:45 +0200
Message-ID: <87se7nsv2m.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Mayur, Daniel,

Actually I have a couple of comments :-)

On 18/05/2026 at 19:57:46 +02, Daniel Lezcano <daniel.lezcano@oss.qualcomm.=
com> wrote:

> On 5/11/26 17:37, Mayur Kumar wrote:
>> The checkpatch tool warns that msleep(10) can sleep for up to 20ms.

This is a tool that gives you raw advices. Is sleeping 20ms a problem in
an init function, clearly outside of any hotpath? Honestly that does not
look like a big issue to me.

>> According to Documentation/timers/timers-howto.rst, usleep_range()

This file has been dropped in favour of a more up-to-date
Documentation/timers/delay_sleep_functions.rst in:

1f455f601e20 ("timers/Documentation: Cleanup delay/sleep documentation")

>> should be used for delays between 1ms and 20ms to provide better
>> timing accuracy.

Again, I don't see the point here, we do not need accuracy, do we?

>> Replace the 10ms msleep with a 10ms-11ms usleep_range.

10 to 11ms feels very arbitrary and has been selected just for getting
the tool happy. The above file states:
#. Use `fsleep()` whenever unsure (as it combines all the advantages of the
   others)
#. Use `*sleep()` whenever possible
#. Use `usleep_range*()` whenever accuracy of `*sleep()` is not sufficient
#. Use `*delay()` for very, very short delays

Accuracy not being a concern here, fsleep() could be the way to go, and
the actual implementation would end up being usleep_range(10000, 20000),
which is exactly what the tool complains about.

In general I would be in favour of avoiding this kind of change that is
not motivated by hardware concerns, but if you really want to fix this
checkpatch.pl warning I believe in such case you should go for an
fsleep().

Thanks,
Miqu=C3=A8l
