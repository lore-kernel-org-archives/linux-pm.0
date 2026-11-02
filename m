Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658944;
	b=WBeqKhVOhZY59AMb8caBRX3+gJJu4E3ritDi2MOFNT41vcvNksqsBaBcICWRt6d/nvYc
	 PQ6qwx/J3QmTcWJE00oz7mWcx33rL4DTbIOIeYAsWA85DPih8PUpJKvBl1zHEZnk2uGai
	 RgGLCpXsycP+OJ0gENnufziqoLsKXyqKvrpxHVaNp7wydl21xEfjK6U39AdyHRTr7v/xF
	 nnrBbPXLpiShQA4ncikXuxjqcuQUbDi5gkw5Ttqwx2sKynLNpW2V0VR8wKHkFKo6o3PHa
	 Gqw93LojUe83ez/jbG0W4VED/HGWwMPbN4BfRm8UKGC6oc9oxBD/97pHlIYAnwYu7Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658944;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=WB/3GQG/invUH430kybLJVqhzDKHnUACPSywPsPFm2Q=;
	b=MnXw2CAoNNE1Da2FbZBKY8ea3TYXfL8KBtwhM4rDNL0PxFGCGayu8enwPy3o3BGj9J1e
	 lEDeU0urw8eIaj3sTtQJLSfqZDfpXzVuhSt8Oyq9rBYspXJkrI+yHFmlnt8dPhc57eSjk
	 pWeLxzZkJy3wDtR2To2me3oW0GzpySxcJN+rpWbxpcgJZ6wAJ/2N87g4u8HRvEo7k3dip
	 /njUVLYoA4HhjboQv+OI9K4e8GZA40DwEcf0cVaCrC9z+C7WXDvLW2Edzytti293rmSFZ
	 yii60sMzrfEKLSn4nUEV7xGQoZOfVqecaduZvbOB3TFrFNgVIYEZxI32df3wclR1zuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IyZOLzv8;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B84606A324;
	Mon,  2 Nov 2026 22:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15B84606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IyZOLzv8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793658944; x=1825194944;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=taGbRzqe3xus4DwQuds9A8WTMnWUJ2/NU/L5ww7heq0=;
  b=IyZOLzv809qj4Cc5WiPsw/Nn2jZiidUxIn8et0VButqh1Pa+KLyQuab+
   onXSYNOG/Xv9MCAtafPBA7yuA/m5tWaQyOtUW5bob6g+x4q/9SFb+iNOK
   LU9Gfdt8aX3eEGUBgqqPVPQ2fLTerQXr82ITwFjwjKi9za5068DKfktpR
   IW7IlztiS5m9B60TKyPGSMl9IZZGprSWGIF10enP97gWAF3HvdEqMY9FZ
   FBWevK06927fv0cO7tzqFL8Cw7P7My0ilHrml0OyfJrjkViQCyueeqJqA
   9WGB1oJxcdRMwrBxqaHtZPtYPFrkBDBEHIR3MA9N+e9SdvNfBZEntAZ04
   w==;
X-CSE-ConnectionGUID: TqcD3gLpQBavIu5EoXtN4w==
X-CSE-MsgGUID: Oa1dL0lDSBuMvn+YSH+FOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2400766"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2400766"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:35:43 -0800
X-CSE-ConnectionGUID: 78N5Ry7URtq/fpdfkq8w4w==
X-CSE-MsgGUID: aWBABTg9R6mGLnptiYovJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6563581"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.189]) ([10.125.109.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:35:43 -0800
Message-ID: <cb38e8c40a4f2af26ee87dc37eea9c0cf4398075.camel@linux.intel.com>
Subject: Re: [PATCH v2 09/17] iio: hid-sensors: Discard
 pm_runtime_put_autosuspend() return values
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson	
 <ulfh@kernel.org>, linux-pm@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>,  David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Date: Mon, 02 Nov 2026 14:35:42 -0800
In-Reply-To: <20261102220546.6fa5c62d@jic23-hlaptop>
References: <20261021235818.3059519-1-briannorris@chromium.org>
		<20261021165858.v2.9.Idbac8a0f9ecdd345191130e256e8d881d991bfc7@changeid>
		<20261102015255.487bd1bd@jic23-hlaptop>
		<84d712c6aa3df7df8fdb6cb85b85d720bdab5840.camel@linux.intel.com>
	 <20261102220546.6fa5c62d@jic23-hlaptop>
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

On Mon, 2026-11-02 at 22:05 +0000, Jonathan Cameron wrote:
> On Mon, 02 Nov 2026 08:55:44 -0800
> srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>=20
> > On Mon, 2026-11-02 at 01:52 +0000, Jonathan Cameron wrote:
> > > On Wed, 21 Oct 2026 16:57:10 -0700
> > > Brian Norris <briannorris@chromium.org> wrote:
> > > =C2=A0=20
> > > > The hid-sensors driver propagates the return value of
> > > > pm_runtime_put_autosuspend(), which is not particularly useful.
> > > >=20
> > > > Returning an error code from pm_runtime_put_autosuspend()
> > > > merely
> > > > means
> > > > that it has not queued up a timer or work item to check whether
> > > > or
> > > > not
> > > > the device can be suspended and there are many perfectly valid
> > > > situations in which that can happen, like after writing "on" to
> > > > the
> > > > device's runtime PM "control" attribute in sysfs for one
> > > > example.
> > > >=20
> > > > For this reason, modify this driver to simply discard the
> > > > pm_runtime_put_autosuspend() return value.
> > > >=20
> > > > This will facilitate a planned change of the
> > > > pm_runtime_put_autosuspend() return type to void in the future,
> > > > similar
> > > > to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put()
> > > > return
> > > > type to void").
> > > >=20
> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>=C2=A0=
=20
> > > +CC the various hid-sensors maintainers.
> > > =C2=A0=20
> >=20
> > =C2=A0=C2=A0=C2=A0 Acked-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> >=20
> >=20
> > > Anyone remember why this does
> > > pm_runtime_use_autosuspend(&st->pdev->dev);
> > > in this code?
> > >=20
> > > That is unusual...=C2=A0 My immediate instinct is to
> > > get rid of it, but maybe there is something subtle
> > > going on.=C2=A0=20
> >=20
> > When reading sensor via raw interface, you need to power-up, read
> > and
> > power-down (This is done via runtime PM). To avoid repeating this
> > sequence of power up and power down for consecutive fast reads,
> > auto
> > suspend is used. If there are reads with in 3 seconds, the sensor
> > will
> > keep power up.
> >=20
> Ah. I was too vague in that query.=C2=A0 Why is it enabled only the power
> state interface rather than at the start when runtime pm is enabled?
>=20
> That seems to be done via a slightly unusually on first turning on
> of the trigger rather than more generally.=C2=A0 Normally we'd expect
> it to be enabled in driver probe and all paths that need the power
> on to do a pm_runtime_resume_and_get().
>=20

This function is called from probe() of each sensor instead of calling
in each driver. I agree this can be different function than this
particular one. This happen to be a common function.

We can separate the function in a follow up patch.

Thanks,
Srinivas


> I'm not seeing why it is in this particularly location which doesn't
> seem to be particularly sensible to me.
>=20
> Jonathan
>=20
>=20
> =C2=A0=20
>=20
>=20
>=20
> > Thanks,
> > Srinivas
> >=20
> > > =C2=A0=20
> > > > ---
> > > >=20
> > > > Changes in v2:
> > > > =C2=A0* Split iio patch into per-driver patches
> > > >=20
> > > > =C2=A0.../iio/common/hid-sensors/hid-sensor-trigger.c=C2=A0=C2=A0=
=C2=A0 | 14 +++++-
> > > > ----
> > > > ----
> > > > =C2=A01 file changed, 5 insertions(+), 9 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-
> > > > trigger.c
> > > > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > index 60808e2430ca..d76a6d9f04f6 100644
> > > > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > @@ -154,21 +154,17 @@ int hid_sensor_power_state(struct
> > > > hid_sensor_common *st, bool state)
> > > > =C2=A0{
> > > > =C2=A0
> > > > =C2=A0#ifdef CONFIG_PM
> > > > -	int ret;
> > > > -
> > > > =C2=A0	if (atomic_add_unless(&st->runtime_pm_enable, 1, 1))
> > > > =C2=A0		pm_runtime_enable(&st->pdev->dev);
> > > > =C2=A0
> > > > =C2=A0	if (state) {
> > > > =C2=A0		atomic_inc(&st->user_requested_state);
> > > > -		ret =3D pm_runtime_resume_and_get(&st->pdev-
> > > > >dev);
> > > > -	} else {
> > > > -		atomic_dec(&st->user_requested_state);
> > > > -		pm_runtime_use_autosuspend(&st->pdev->dev);
> > > > -		ret =3D pm_runtime_put_autosuspend(&st->pdev-
> > > > >dev);
> > > > +		return pm_runtime_resume_and_get(&st->pdev-
> > > > >dev);
> > > > =C2=A0	}
> > > > -	if (ret < 0)
> > > > -		return ret;
> > > > +
> > > > +	atomic_dec(&st->user_requested_state);
> > > > +	pm_runtime_use_autosuspend(&st->pdev->dev);=C2=A0=20
> > > This is odd enough to make me nervous even though the patch is
> > > obviously a no-op change.
> > >=20
> > > =C2=A0=20
> > > > +	pm_runtime_put_autosuspend(&st->pdev->dev);
> > > > =C2=A0
> > > > =C2=A0	return 0;
> > > > =C2=A0#else=C2=A0=20
> > > =C2=A0=20
>=20
