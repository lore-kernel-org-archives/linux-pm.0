Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C7391820
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774105940; cv=none; b=dDgEgTGxpjUHF56GfjJRX6HUviU954wAyMKJMeTei3iQwxrJRByzOhJhvDOcPvxCvJKt1ge032ytf7hKWjlXD2UJeFe2K2aewF23RV0ux/jtHt4F5p6pXwf52UhZOo7TYXW9zqH/2hVbD0VO38nm6viUW/z/llOiL1HJKy/g2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774105940; c=relaxed/simple;
	bh=gD1q6VTwcr3ywJK3thmlj3oefKwCOvFp8KGDVpaIr9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiiEptYTagmIzdo2MrtOYSzSmRAzK8AGx1+KQrfeYwlnmEexR/l6nCr888NPyNNlEkm9+V2sFTgrxvZFkGRlYzaLOI/ShT6kT73EkMWFC7pE+BsRYzrs4cmHZOYDaW0NrSnqxAevqfrHbyChHiIpDLdaDE5gEAbePv+5g46+8uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sH9TlI3B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH9TlI3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FF5C4AF09
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774105940;
	bh=gD1q6VTwcr3ywJK3thmlj3oefKwCOvFp8KGDVpaIr9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sH9TlI3BLUAgQ5noUfDXKLXqORTdkMae+MkhxTq4JKYmhYsWyu1SMcCgmDjU3xIgQ
	 z8wdri4lAum4xlM+bbceKkSwyVleUcuKcKy+gYI2N0lwUSXAINISDyAtG0tWLk3Bw7
	 tE1L/WzB5n42AVVydTEUurZKNlvI48l/e7h8X3vJso/ahKGCIucuol9CzF+O2nuwOW
	 fgF2Ap2YDGu7XxFPbY7/OyiTK/Kn1byNCS5ENJcY1NLL22PTEvKxGj7G4X8El9UYy2
	 J6Jb13NRG5uwBbvTBMN42+2k2hzO80EyQq0sfT9abPGNvY6cPq09xokxWLyufhNoMR
	 pl+BlNGBfcTrQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40438e0cba6so1956832fac.1
        for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 08:12:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUO3XIVZxsdxotkGd0YNjEJItfVoTxHujkQrr/siIaeGhlXwvxNjQtgdD6A0acot0wb2RD61LGmjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUGBMe6vlYe8K12wconlfNz/ftHsReJpJgmqS618uDbY9ozTzd
	7bkeQ8E82cqwkDXICYaEYZStgnnPSv8UBCrbpCEks8aetrflAm5tiBVfq1cBkojXGWlUxEQxxi5
	4c1HKqeDT8wS0KFfEUpC6U+6yfHKU0YQ=
X-Received: by 2002:a05:6870:f214:b0:417:3936:1c7a with SMTP id
 586e51a60fabf-41c11138b63mr4241564fac.24.1774105939612; Sat, 21 Mar 2026
 08:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202603211336.i375F7lD-lkp@intel.com>
In-Reply-To: <202603211336.i375F7lD-lkp@intel.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 22 Mar 2026 00:11:43 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0bZMGpdKjvgw7S54NF+KeXPtvhsanKmSs1vHDhx7F7Lg@mail.gmail.com>
X-Gm-Features: AaiRm50EBCXkYVYAInLz4rhnn5PAPFokSX2lprR94ZFvTJQ1blDiv0BKjixMPe0
Message-ID: <CAGTfZH0bZMGpdKjvgw7S54NF+KeXPtvhsanKmSs1vHDhx7F7Lg@mail.gmail.com>
Subject: Re: [chanwoo:devfreq-next 5/5] drivers/devfreq/devfreq.c:1946:37:
 error: redefinition of 'devfreq_group'
To: kernel test robot <lkp@intel.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org, 
	Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Jori,

There are build errors in your patches.
DId you test it? I hope to fix and test the patch before posting.

On Sat, Mar 21, 2026 at 9:52=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git=
 devfreq-next
> head:   38aa14f9be920f3fea6fe3f16b69b7a0cd0478a1
> commit: 38aa14f9be920f3fea6fe3f16b69b7a0cd0478a1 [5/5] PM / devfreq: chan=
ge devfreq_class to a const struct
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260321/20=
2603211336.i375F7lD-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260321/202603211336.i375F7lD-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603211336.i375F7lD-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> drivers/devfreq/devfreq.c:1946:37: error: redefinition of 'devfreq_gro=
up'
>     1946 | static const struct attribute_group devfreq_group =3D {
>          |                                     ^
>    drivers/devfreq/devfreq.c:40:1: note: previous definition is here
>       40 | ATTRIBUTE_GROUPS(devfreq);
>          | ^
>    include/linux/sysfs.h:291:37: note: expanded from macro 'ATTRIBUTE_GRO=
UPS'
>      291 | static const struct attribute_group _name##_group =3D {       =
    \
>          |                                     ^
>    <scratch space>:89:1: note: expanded from here
>       89 | devfreq_group
>          | ^
> >> drivers/devfreq/devfreq.c:1955:38: error: redefinition of 'devfreq_gro=
ups'
>     1955 | static const struct attribute_group *devfreq_groups[] =3D {
>          |                                      ^
>    drivers/devfreq/devfreq.c:40:1: note: previous definition is here
>       40 | ATTRIBUTE_GROUPS(devfreq);
>          | ^
>    include/linux/sysfs.h:298:11: note: expanded from macro 'ATTRIBUTE_GRO=
UPS'
>      298 | };                                                            =
  \
>          |                                                               =
  ^
>    include/linux/sysfs.h:285:38: note: expanded from macro '\
>    __ATTRIBUTE_GROUPS'
>      285 | static const struct attribute_group *_name##_groups[] =3D {   =
    \
>          |                                      ^
>    <scratch space>:93:1: note: expanded from here
>       93 | devfreq_groups
>          | ^
>    2 errors generated.
>
>
> vim +/devfreq_group +1946 drivers/devfreq/devfreq.c
>
> 9005b65099ee4f MyungJoo Ham  2011-10-02  1945
> e4999090951abc Pengjie Zhang 2025-12-16 @1946  static const struct attrib=
ute_group devfreq_group =3D {
> e4999090951abc Pengjie Zhang 2025-12-16  1947   .attrs =3D devfreq_attrs,
> e4999090951abc Pengjie Zhang 2025-12-16  1948  };
> e4999090951abc Pengjie Zhang 2025-12-16  1949
> e4999090951abc Pengjie Zhang 2025-12-16  1950  static const struct attrib=
ute_group gov_attr_group =3D {
> e4999090951abc Pengjie Zhang 2025-12-16  1951   .attrs =3D governor_attrs=
,
> e4999090951abc Pengjie Zhang 2025-12-16  1952   .is_visible =3D gov_attr_=
visible,
> e4999090951abc Pengjie Zhang 2025-12-16  1953  };
> e4999090951abc Pengjie Zhang 2025-12-16  1954
> e4999090951abc Pengjie Zhang 2025-12-16 @1955  static const struct attrib=
ute_group *devfreq_groups[] =3D {
> e4999090951abc Pengjie Zhang 2025-12-16  1956   &devfreq_group,
> e4999090951abc Pengjie Zhang 2025-12-16  1957   &gov_attr_group,
> e4999090951abc Pengjie Zhang 2025-12-16  1958   NULL
> e4999090951abc Pengjie Zhang 2025-12-16  1959  };
> e4999090951abc Pengjie Zhang 2025-12-16  1960
>
> :::::: The code at line 1946 was first introduced by commit
> :::::: e4999090951abcf39543aa22b7a7a7f13c5a5857 PM / devfreq: use _visibl=
e attribute to replace create/remove_sysfs_files()
>
> :::::: TO: Pengjie Zhang <zhangpengjie2@huawei.com>
> :::::: CC: Chanwoo Choi <cw00.choi@samsung.com>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics
