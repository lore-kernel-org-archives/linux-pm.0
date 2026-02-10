Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A293271EB
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732406; cv=none; b=VYDGugaYPlWvBLSUJsqr5Iq2gN4Jz9WBuOEhYCxFWOlks+q5/fSLYzCw3EaLvMngfv6ZSpISsC5l82vc10lLNaXDo+QWpiw11Nu/D+SgLkfd6vpS4D9cwlqgaxFC4R0NmdwSu7rO0oSbyjGi8kOdz/e26KfjF8z6s97Z3uhT1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732406; c=relaxed/simple;
	bh=PSOXRdnmSomcPUT/c9SFt7VtTBoyRcwnTm2hz/JlfII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcOXc62N55XYe9W60UaqmRYXUslPVqcYV5mYhBPu62tiT/+n9wnZQI94DQxpb5VUzFn50FUIwI2qfZzZF86OYLa77woUigNh4XpiZKFCdXlMl26p4/RU2rGC7zgS9I9IZut2D9gpPkmWb0xKDs54QqQkh22eM2MIfE+y9H69gaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRDg41uh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRDg41uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08F6C4AF09
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770732405;
	bh=PSOXRdnmSomcPUT/c9SFt7VtTBoyRcwnTm2hz/JlfII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eRDg41uhY0aNU/pmjhlnJnzGOLbdl5By2K6RRegT5O3TKU4hE72Jt80tVjhmEyYPj
	 D70d68E4d7RLbo2c5+Wps4lp0Z+/5hVwjVOSko20j9JZd1syly85wVbqwmP4Fgokmz
	 bLlVAsudskCtB3VwyqhZ2pF6OqebATLSXOONzsLSMKgC7d7UvkkfRR6+9hfrnxTnMp
	 2mldF45wCWhorNWEH0Nsk3c+baSAF97bf0lvTPrDxGRorb/qpvXyfvwuq1nmOxyEuD
	 x/XgNWUG5dd0Sw63mrtNDzUcX7Z8XHIXE3BrAklQZQGf4gDq/o04d3zLS2bFjwXDWd
	 0gge/IVQUPLdg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4086661715cso4249289fac.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 06:06:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWB5fR+td7mFkoK3qL16VtKzpjFAuMqNqFb72vPUcYwRG72HlDYcuEotE/L56BoLbg2dmiu3gbS/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUf+Pxc7W4EyLPTnvuxR2WoRR3VSdsiwPWiqPG16umnv9c0qv
	z1o55irdJTo5PgEKWq+69GBuHiTXjVF0pY2wC9vJvoXtBuk9ko82qc1+JkaNQjpynoAHe12VqEa
	Tt4vGK3yuoJ7aLSa/jWmu9f0C+9EBLeY=
X-Received: by 2002:a05:6820:1890:b0:672:7487:80d1 with SMTP id
 006d021491bc7-6727487838fmr1539264eaf.82.1770732404979; Tue, 10 Feb 2026
 06:06:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202602101943.srec8iCs-lkp@intel.com>
In-Reply-To: <202602101943.srec8iCs-lkp@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Feb 2026 15:06:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jivJBYRicOSODHEw412Se1MHG7Jc=YvA9tc90bzxzuRQ@mail.gmail.com>
X-Gm-Features: AZwV_QiCFcEZU42I5TF4owAOmQRCCikGxP_uFQsTN4INoSlRkkpnJcFx49IeoXo
Message-ID: <CAJZ5v0jivJBYRicOSODHEw412Se1MHG7Jc=YvA9tc90bzxzuRQ@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge] BUILD REGRESSION 8711f3ee7e5efcf1b795c80496b0fb68713e153a
To: kernel test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 12:12=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux=
-pm.git bleeding-edge
> branch HEAD: 8711f3ee7e5efcf1b795c80496b0fb68713e153a  Merge branch 'expe=
rimental/acpi-driver-conversion' into bleeding-edge

This has been fixed in the bleeding-edge branch, thanks!

> Error/Warning (recently discovered and may have been fixed):
>
>     https://lore.kernel.org/oe-kbuild-all/202602100645.LWcwIOMw-lkp@intel=
.com
>     https://lore.kernel.org/oe-kbuild/202602101417.8r6ZtJHr-lkp@intel.com
>     https://lore.kernel.org/oe-kbuild/202602101600.KhGfxuWT-lkp@intel.com
>
>     drivers/platform/chrome/wilco_ec/event.c:514:33: error: unknown type =
name 'platform_device'; did you mean 'to_platform_device'?
>     drivers/platform/chrome/wilco_ec/event.c:533:19: error: 'event_device=
_remove' undeclared here (not in a function); did you mean 'event_device_pr=
obe'?
>
> Unverified Error/Warning (likely false positive, kindly check if interest=
ed):
>
>     drivers/platform/x86/classmate-laptop.c:1025 cmpc_ipml_probe() warn: =
'ipml->rf' is an error pointer or valid
>     drivers/platform/x86/toshiba_bluetooth.c:261 toshiba_bt_rfkill_probe(=
) warn: 'bt_dev->rfk' is an error pointer or valid

Now, these two are false-positives because rfkill_alloc() returns NULL
on failure (and is documented accordingly).
