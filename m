Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B05678E2;
	Wed, 23 Sep 2026 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191230; cv=none; b=AcBlAt2v/joaVUGDAaUn3WguNwB3a30h7Vb7m5uLdpnbaad514vuXFJJuhk/cS4DoFfMoMI902lhlmEwIWjYFsnOQ+o1Xv0wJjVkLpRvy8V+3CJfCj5MvyB8/h5B0XeJikKYPr84vaH0YZ+a1c/QM8b9fg0fFxh/1zie4GP0Gfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191230; c=relaxed/simple;
	bh=0aZFlhZVr77a5ksWvobIJRD2dJC+8wMI4EmNW+zD13A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=W40RjJajeoXnLv5Ki/XySo3+KeZoi1qKxo0UAHldzXCSQI8jt+98GyXtksp/DOx6L5H/9gu7e2C5tVnovXUg3Kv3FNDFcA7j1wpKMeuQ9QBojhjQ3F8ZwLHpSx8mrMkmi+s/hxv/XcWEwxP6HKd/1mRMajzivNtaEiyDiPSJXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iWCxJfG7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iWCxJfG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1790191220;
	bh=0aZFlhZVr77a5ksWvobIJRD2dJC+8wMI4EmNW+zD13A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iWCxJfG7J+YuXEI13qXN1lO7eMgfNuvPt7oIE2U4ut/Knn+6d/ehUuPi850XbK4Yt
	 HX+khWgSL8ygTsxjmUHIXGVsF9NPkEqhVq5EDr8+i5iXzi0mMIumtvDe+Kwu9ZBXlJ
	 62Iy0Lp9m5qwDzZkoYW45+KWPtj5CucJ/ijjg6WU=
Date: Wed, 23 Sep 2026 21:20:16 +0200
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Matt DeVillier <matt.devillier@gmail.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	"open list:CHROMEOS EC SUBDRIVERS" <chrome-platform@lists.linux.dev>,
	"open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS"
 <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <94bc83bd-5237-4637-acd0-f44df1cdaeb0@weissschuh.net>
In-Reply-To: <CAFTm+6D7OKYCqfw3yXnRX4jfmbD4ZBcf2TRL-2Tr+6LWSxWP=g@mail.gmail.com>
References: <20260825120929.13168-1-matt.devillier@gmail.com> <20260828142318.1881516-1-matt.devillier@gmail.com> <apToX3Paxb5sdClO@google.com> <CAFTm+6D7OKYCqfw3yXnRX4jfmbD4ZBcf2TRL-2Tr+6LWSxWP=g@mail.gmail.com>
Subject: Re: [PATCH v3] power: supply: cros_charge-control: adopt EC charge
 state on probe
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <94bc83bd-5237-4637-acd0-f44df1cdaeb0@weissschuh.net>

Hi,

Sep 23, 2026 17:14:31 Matt DeVillier <matt.devillier@gmail.com>:

> Is anything else needed to move this patch forward?

Sebastian picked up the patch, so it will end up in v7.4.
There is nothing else you need to do.

Thomas

> On Sun, Aug 30, 2026 at 9:35=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org=
> wrote:
>>
>> On Fri, Aug 28, 2026 at 09:23:15AM -0500, Matt DeVillier wrote:
>>> The driver previously always forced AUTO with no charge limits at
>>> probe, which discarded sustainer thresholds and modes set by firmware
>>> or firmware setup before the kernel loaded.

(...)
