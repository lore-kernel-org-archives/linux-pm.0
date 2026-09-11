Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241148A8B7;
	Fri, 11 Sep 2026 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132158; cv=none; b=lhS6+bAzn3UEOme+xj7GgSkioRukFJ/vIgAqHgKqpKUs0KKrF72i8VC5UmV9fA5uN/jMSmSfMu9TIyTlMkbYSH4UfDzEaYpCpqPLSHgPNHkleh7gMzJH4uRHZPGbyVzl5sWrgBtf3joiZuIijdYiAZWeF3304PxNdEz0EpQy28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132158; c=relaxed/simple;
	bh=AjqkbEsSKx+AHnfeBN3jPNP4+3pJ5U+cE3oJ7FLQYeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uBuW35ZKtCTDSN6dr3WNmgbW5oYK7nqjQ4D0JNzdpcFUGZ846QMMWzCEEknwI1YRyGwIOOp/ofBMoZCYp3IkBfj6j8sEE+pOc6EzSoRHlixdRTd+rVSJIdmbwDwPlGWuXfcacSqXwgnVE6igjWISNAiyWVEHzPB9VmFMkiBtIdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXWR4ml/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXWR4ml/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E001F000FF;
	Fri, 11 Sep 2026 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132157;
	bh=IPy5H6d0FeclZkOXLVARd1DU4ZcOXhR7FQMK5BIAGU8=;
	h=From:To:Cc:Subject:Date;
	b=oXWR4ml/F9cQofSBuIydw/msfHSjJXAQhEewCGK8SHQeIWqoQZECnji3tuKH7VEVL
	 lPcLOfQn5FVPsnDT5RU6ObUz/LdG7r25nFb4HoZHgvgvSpXDBbRI+YQ6tVchkpWhWK
	 iPoeTIF0iD+RobksIXSimZDTCejv2ef3UUcvFuZ3oAK+TOwgTXIXjU9aQkItzlqRI1
	 Q9ZkxIh1r6lZi2ZJ6QLTsj8AU8TL/0kDH/3voVCaazkh0ueMz+yMt8bjlC3xGcUyeU
	 D/cl6I7eedWTa0OQEzlxHx5a0FzBOJYVl+zEHadscWYP4oEsWgP393sXNr4BwuEuSb
	 k0ibMQ5R8SdSw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 00/10] ACPI: thermal: Register thermal class cooling devices under
 parents
Date: Fri, 11 Sep 2026 15:00:07 +0200
Message-ID: <1965933.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series generally changes the way in which thermal class cooling devices
are used by ACPI device drivers registering them (ACPI processor, ACPI fan,
and ACPI video) and by the ACPI thermal zone device driver.

First, it causes the thermal class cooling devices to be registered under
parents in specific locations within the device hierarchy which allows
their relationships with other devices to be recognized more easily.  It
also drops custom sysfs attributes registered by the users of the thermal
class cooling devices because they are not particularly useful any more
when those devices get proper parents.

Second, it modifies the ACPI thermal zone device driver to use thermal class
cooling device parent information for binding cooling devices to trip points
in thermal zones, which was previously done with the help of the devdata
pointers of the cooling devices and effectively prevented drivers from using
the devdata pointers for their own purposes as originally intended.

Finally, it updates the ACPI processor and ACPI fan drivers to use the
devdata pointers of thermal class cooling devices in a bit more efficient
way.

The first two patches in the series are preliminary fixes preventing
Sashiko from reporting "pre-existing issues" in the subsequent patches.

The third patch is a thermal core update allowing thermal class cooling
devices to be registered under proper parents.

The other patches update the ACPI processor, ACPI video, and ACPI fan
drivers as per the above.

The details are covered by individual patch changelogs.

Thanks!



