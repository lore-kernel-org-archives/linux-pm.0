Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB419380FEC;
	Mon,  1 Jun 2026 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352996; cv=pass; b=eLY+JT9TU57KidtMsCt94Y3VMGgWRPswYeOOBWO/n3MTjay3iQ28p3EhrqsGkSWeK/e46ck+NLf8Z6pBeVu8DazSy6nhakZHW8/eD9YKvB3HaYRlx26ZqUP9cPEldbN34gKEH35BL6Qa+n4pNY38EuiI4KWjrKrvfuUgYTm8jjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352996; c=relaxed/simple;
	bh=UPQwCscVtgDUQ1mTHgvHUwQtr/d6yIRXe4kCBSusT64=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=McbT866nzHmHXZXSAdh6rVvwZR+LTTOiB8ab7/U0Oi9GOz6FdTE4Bms0M+cutwuC2iMypnhLR4WYDLgrhHKWw7n8C4EMjwGqijzCEUaJ5b9qtXsMYAyj4vHxZXq0zRuPcmLGLywpEZaENErjk2hYM059vkSk8dZB83rBprCPh/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=VmrZVQZx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="VmrZVQZx"
ARC-Seal: i=1; a=rsa-sha256; t=1780352983; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jKiq146Y3/QWr7TMdy35+B1u6dLmojlaMU1haZp6b1bNvF/r2rIYXPBSeEfFcNho+G9KOWHFC1UzoRsL62Pumn/jdhmDRGUOBRf9SedjXjZSFV6QMtBTtRZZ6TjLGFrgMFcD+1O8Y5TO/P8aHaDR4ybdnUgHEsen1HdCRsRONf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780352983; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UPQwCscVtgDUQ1mTHgvHUwQtr/d6yIRXe4kCBSusT64=; 
	b=UkSWFvjgjGMi8Jj8rhaDLl4zWh8DetBhA+7OTmNMGI79ZVM/Yjl2UrAOEVPsgAl6sgjUwMJLs0Cglhw9WP93l+nKYV4sledMEbh/d8iJTqrJ+Lom1Z/D4lv9xn7/MXR+2isaejytCAiU39fwuyPN3JT803hro5xHodUzFdQp71s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780352983;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=UPQwCscVtgDUQ1mTHgvHUwQtr/d6yIRXe4kCBSusT64=;
	b=VmrZVQZxMDt2SiKdyvYywOiBKnBA1vae2JPp6+DtiEf/gKoWvUYRA/U34NisvVAM
	QEsxgZ7BTdQ0BPm+QMB08XPgvRYIvZyuaJJ9bn3KXvtVOoEGshSNnVLcWDUj8Ehr/lR
	Wq4Nl3ZZNtItg7T1R39OMy/1v2Qh8UcvZNcg8Q5s=
Received: by mx.zohomail.com with SMTPS id 178035298195343.03006438163857;
	Mon, 1 Jun 2026 15:29:41 -0700 (PDT)
Message-ID: <0718140c743adcf52f6a4442c86fa25049e49cd0.camel@collabora.com>
Subject: Re: [PATCH 2/3] PM: hibernate: Add platform_enter hibernation test
 level
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, Brian
 Geffon	 <bgeffon@google.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 01 Jun 2026 18:29:38 -0400
In-Reply-To: <CAJZ5v0gFqVNT4ceYaPODC7M-Bs4-+AaS6-Hrwwzdav8XbKdfLQ@mail.gmail.com>
References: 
	<20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
	 <20260518-hibernation-decrease-time-in-copy-data-pages-v1-2-3998bdf90ee5@collabora.com>
	 <CAJZ5v0gFqVNT4ceYaPODC7M-Bs4-+AaS6-Hrwwzdav8XbKdfLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Tue, 2026-05-26 at 13:28 +0200, Rafael J. Wysocki wrote:
> On Mon, May 18, 2026 at 11:34=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >=20
> > Add a 'platform_enter' hibernation test level to allow testing the
> > full
> > hibernation path up until the last point of return in
> > hibernation_platform_enter().
> >=20
> > In particular this allows seeing print messages from the code run
> > after
> > the hibernation image is created on platforms that don't have an
> > easily
> > accessible serial console, since these messages are not present
> > upon
> > hibernation resume.
> >=20
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > =C2=A0kernel/power/hibernate.c | 13 +++++++++++--
> > =C2=A0kernel/power/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0kernel/power/power.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A03 files changed, 13 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 001e4556b137..15cb7a090770 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -75,6 +75,7 @@ enum {
> > =C2=A0static int hibernation_mode =3D HIBERNATION_SHUTDOWN;
> >=20
> > =C2=A0bool freezer_test_done;
> > +bool platform_enter_test_done;
> >=20
> > =C2=A0static const struct platform_hibernation_ops *hibernation_ops;
> >=20
> > @@ -636,6 +637,11 @@ int hibernation_platform_enter(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto Power_up;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hibernation_test(TEST_PLATFOR=
M_ENTER)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 platform_enter_test_done =3D true;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto Power_up;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hibernation_ops->enter();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We should never get here =
*/
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (1);
> > @@ -700,6 +706,8 @@ static int power_down(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case HIBERNATION_PLATFORM:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error =3D hibernation_platform_enter();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (platform_enter_test_done)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (error =3D=3D -EAGAIN || error =3D=3D -EBUSY) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event=
s_check_enabled =3D false;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_in=
fo("Wakeup event detected during
> > hibernation, rolling back.\n");
> > @@ -848,7 +856,7 @@ int hibernate(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error =3D power_down();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (error) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (error || platform_enter_test_done) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* re=
cover any devices that refused to thaw
> > */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dpm_r=
esume_suspended_devices(PMSG_RECOVER);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > @@ -870,8 +878,9 @@ int hibernate(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thaw_processes();
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Don't bother checking whether =
freezer_test_done is true
> > */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Don't bother checking whether =
any of the test_done flags
> > are true */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freezer_test_done =3D false;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 platform_enter_test_done =3D fals=
e;
> > =C2=A0 Exit:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filesystems_thaw();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_notifier_call_chain(PM_PO=
ST_HIBERNATION);
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index 7f53ef65b789..04f0c429519c 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> > @@ -273,6 +273,7 @@ static const char * const
> > pm_tests[__TEST_AFTER_LAST] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [TEST_PLATFORM] =3D "platfor=
m",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [TEST_DEVICES] =3D "devices"=
,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [TEST_FREEZER] =3D "freezer"=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [TEST_PLATFORM_ENTER] =3D "platfo=
rm_enter",
> > =C2=A0};
> >=20
> > =C2=A0static ssize_t pm_test_show(struct kobject *kobj, struct
> > kobj_attribute *attr,
> > diff --git a/kernel/power/power.h b/kernel/power/power.h
> > index 7ccd709af93f..0d33d0e46ed0 100644
> > --- a/kernel/power/power.h
> > +++ b/kernel/power/power.h
> > @@ -259,6 +259,7 @@ enum {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_PLATFORM,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_DEVICES,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_FREEZER,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_PLATFORM_ENTER,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* keep last */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __TEST_AFTER_LAST
> > =C2=A0};
> >=20
>=20
> In the first place, test levels are designed to be applicable to both
> system suspend and hibernation and I don't see how this test can be
> applied to system suspend.

Indeed this is specific to system hibernation, in fact, to the
"platform" hibernation method. I hadn't noticed the test levels were
designed to be generic.

That said I still think hibernation-specific (and even hibernation-
method-specific) test levels would be a useful addition since they
would allow validating the steps between the end of hibernation image
creation and system power down are working correctly.

As far as I can tell the reason against that is the current uAPI?

Would having test levels listed in pm_test that are only applicable for
certain sleep states (and method combinations) not be acceptable even
if they are clearly named? eg "disk-platform-platform_enter"?

Another option could be having a separate file to list the test levels
that are particular to each sleep state and method.

Or perhaps we could add another test entry in /sys/power/disk like
test_resume. However that would only work for tests that don't depend
on a specific hibernation method, so not useful for this specific
patch, but could still be an option.

>=20
> Second, the last device power off transition during hibernation may
> not be reversible and adding a test that goes past a point of no
> return is not particularly useful.

On my platform, this stage is definitely reversible, and is definitely
useful, since it allowed me to benchmark the hibernation image creation
process which would otherwise be impossible.

This is a test that the user chooses to run. Even if it doesn't work on
some platforms, it can simply not be run on those, while being useful
on the platforms that do support it.

Thanks,
N=C3=ADcolas
