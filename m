Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638546;
	b=t+5EK5qwTlHZIsWwH/o9GWcuf2yDAIlT7ZtmFwiFWiH5hJriy1iMKpZZc0svYqjeY7ZZ
	 sMHkVG+MzeavBGhkQtla/0ACEphbKrNvSfoBUwbn8pQYSbdSPyTfapfReo35dFGGdBpzP
	 gY5wukb/3zxeGqpjwlTnR5ygWTJeaiyEiUK54Z77mt1ppy65dE+fLilpqvaovXNSyAc3N
	 E0PHwIwvHu7dI3U7Yfswbim3LVdGHqMBr12PNTu690cB4CnJ4MK0pGXwAZ79FpUjpPs3R
	 tYoQUGVuPmryR/08GgMAeqfwZbLe2chATPW6ywkj9BoSehQ5IzODev8q8Afyu6eCezA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638546;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=4RDMzPQ3Kc7Ayt29cgTuAx8lVc5b4/aAlpi/xEsU6A0=;
	b=lloqvva2DMaGE/ge7l2Ylm2MYNRbd3Jg3mndL/v18uH9QDhkThPQzpKO0+ejQ9B+0JTF
	 8yabGAX3H+82JnFAEslyNJvQ3kKsoP5FzErWP+9p0066ESAObN4tzpJCUsaEuoUsjTssh
	 5fzoNjsEQg9I01VsPhA8HC3nqqH4yUYStm7N3NlSkShSuKpzw70EK1givL0H6OOkzkVGY
	 00vi0DRHO0gYep5qgNkr2YYnTsYjJ1UX6bmKQZsGqjwrfBPPBhQecros1yyJsW3e1oi6U
	 CNPg/pNd1Fk9c2B7Y6n5xTh0Z9UGpsqvwux98CHsvYbhL2/U/NzQvIc8+4yN+JywPPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U+WOEszz;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA7606A582;
	Mon,  2 Nov 2026 16:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAEA7606A582
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U+WOEszz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793638546; x=1825174546;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=JXScI8WmnZi2CPPJHPNar6v2gK+emYwKGOG37t5KugI=;
  b=U+WOEszz5zTnfl4ZJ5L5ffryYjiQjn6Jywipg8ipMErcmLRdWfYN9GDd
   6zY8vtznhDH3a5eA4PSR11Jk+FMMqAjTu7esl3nANC81e58Wq8po2uKIi
   sQIljR+VNm/NmBB6Y6vJYgAbsFcVl8gSTklUKC0SqlVqWOErD6IMkQXfX
   2P/fqEsp8+NgIsCE/OARKjaK+kQnYcXxCIDTtraD1O9r6RZWu+1FWnevg
   Z1aYREU5+inWakoLg7jNXKyo+v1M6fPrtv3HHfnr+qmlWlIMdV1owLB0M
   ErnmsCwIgrf7TjZ1liV2ZIQ63//y+aHfI6hCeT213joNlDWYGWgz3W327
   A==;
X-CSE-ConnectionGUID: VGRkpjS/Rbqk+L3ItVEH7A==
X-CSE-MsgGUID: gT4S/WMeQLyrhdOGyWkRPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2216569"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2216569"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 08:55:45 -0800
X-CSE-ConnectionGUID: vXUXCuyvRGCIBpejotJQKQ==
X-CSE-MsgGUID: FmajquUeRGSIy4yc7nvAmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6145309"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 08:55:45 -0800
Message-ID: <84d712c6aa3df7df8fdb6cb85b85d720bdab5840.camel@linux.intel.com>
Subject: Re: [PATCH v2 09/17] iio: hid-sensors: Discard
 pm_runtime_put_autosuspend() return values
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Brian Norris
 <briannorris@chromium.org>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, "Rafael J. Wysocki"	
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org,  Andy Shevchenko	 <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, 	linux-iio@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@intel.com>, 	linux-kernel@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>
Date: Mon, 02 Nov 2026 08:55:44 -0800
In-Reply-To: <20261102015255.487bd1bd@jic23-hlaptop>
References: <20261021235818.3059519-1-briannorris@chromium.org>
		<20261021165858.v2.9.Idbac8a0f9ecdd345191130e256e8d881d991bfc7@changeid>
	 <20261102015255.487bd1bd@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-02 at 01:52 +0000, Jonathan Cameron wrote:
> On Wed, 21 Oct 2026 16:57:10 -0700
> Brian Norris <briannorris@chromium.org> wrote:
>=20
> > The hid-sensors driver propagates the return value of
> > pm_runtime_put_autosuspend(), which is not particularly useful.
> >=20
> > Returning an error code from pm_runtime_put_autosuspend() merely
> > means
> > that it has not queued up a timer or work item to check whether or
> > not
> > the device can be suspended and there are many perfectly valid
> > situations in which that can happen, like after writing "on" to the
> > device's runtime PM "control" attribute in sysfs for one example.
> >=20
> > For this reason, modify this driver to simply discard the
> > pm_runtime_put_autosuspend() return value.
> >=20
> > This will facilitate a planned change of the
> > pm_runtime_put_autosuspend() return type to void in the future,
> > similar
> > to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put()
> > return
> > type to void").
> >=20
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> +CC the various hid-sensors maintainers.
>=20

    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> Anyone remember why this does
> pm_runtime_use_autosuspend(&st->pdev->dev);
> in this code?
>=20
> That is unusual...=C2=A0 My immediate instinct is to
> get rid of it, but maybe there is something subtle
> going on.

When reading sensor via raw interface, you need to power-up, read and
power-down (This is done via runtime PM). To avoid repeating this
sequence of power up and power down for consecutive fast reads, auto
suspend is used. If there are reads with in 3 seconds, the sensor will
keep power up.

Thanks,
Srinivas

>=20
> > ---
> >=20
> > Changes in v2:
> > =C2=A0* Split iio patch into per-driver patches
> >=20
> > =C2=A0.../iio/common/hid-sensors/hid-sensor-trigger.c=C2=A0=C2=A0=C2=A0=
 | 14 +++++-----
> > ----
> > =C2=A01 file changed, 5 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > index 60808e2430ca..d76a6d9f04f6 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > @@ -154,21 +154,17 @@ int hid_sensor_power_state(struct
> > hid_sensor_common *st, bool state)
> > =C2=A0{
> > =C2=A0
> > =C2=A0#ifdef CONFIG_PM
> > -	int ret;
> > -
> > =C2=A0	if (atomic_add_unless(&st->runtime_pm_enable, 1, 1))
> > =C2=A0		pm_runtime_enable(&st->pdev->dev);
> > =C2=A0
> > =C2=A0	if (state) {
> > =C2=A0		atomic_inc(&st->user_requested_state);
> > -		ret =3D pm_runtime_resume_and_get(&st->pdev->dev);
> > -	} else {
> > -		atomic_dec(&st->user_requested_state);
> > -		pm_runtime_use_autosuspend(&st->pdev->dev);
> > -		ret =3D pm_runtime_put_autosuspend(&st->pdev->dev);
> > +		return pm_runtime_resume_and_get(&st->pdev->dev);
> > =C2=A0	}
> > -	if (ret < 0)
> > -		return ret;
> > +
> > +	atomic_dec(&st->user_requested_state);
> > +	pm_runtime_use_autosuspend(&st->pdev->dev);
> This is odd enough to make me nervous even though the patch is
> obviously a no-op change.
>=20
>=20
> > +	pm_runtime_put_autosuspend(&st->pdev->dev);
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0#else
>=20
