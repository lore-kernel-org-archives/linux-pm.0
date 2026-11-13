Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597048;
	b=L+TLn7k1FVSSpBrRAWkW+P57On7q7EfZ4yaX+KebIZjn82AYSShHNaClS6EVwuckN8f2
	 xFajx9TXKT++BTw0cdxSmUTWNyWzJ8p4wd4IbiKgIBObJiye6thCy6FQtTHE0RJTHmDaB
	 qrNYyPorwEYxi4BkqrfNl23lqGOnV8VA07QEU29sJ9oWxiI0m/GXFczhhFbAR9Gsc3HPf
	 oOsYtNcVNqnk33rpSTFCG49ybK2n3ctrAIoIIbyIOFNMiStouNJgrUb9D0D5UrPiYtJOx
	 8rdKOr0c56lx44zMxW39d4jd2fv4gFYb4pWBusrddKnzWoAAihADTd8+svf0/iM3baQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597048;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WAEOzMDkQXHeFaVJ78vzghFDASGs+HMG8qMN8m4Kh+4=;
	b=0KJ67kOrWE41rA9KoDpo2rXA4GF2COzr0/jNItUcLQSu+qBgdPlvewjO2KhowtF/sJL2
	 vnd0K8vjojGviD6wNbN3v2Nk+u+CX4Kx0JE/f9Z0tFdC6fkJtDC+EXv9AVKlYpIT2EFwc
	 9Rcyw4eLyG4ykSQ0JqoDa65a2rfXc/l3iu8b5mnW0kFR1V6d5VwXfG9nillV2rmxCkWm9
	 EdfMfv9TzoStEX7f7fa/QYvekH3GVT+JhECs/x4bNqqXlKMLMGxedM7RfXmjPWE5kBlQK
	 1cT+TAMRlPCiBkOq6qSr/niCiJKpJ8ai4gGsIHB4XwEiHpuzjnzu9eSfOg5Hb18MMdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cenp1BxD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B9606A33D
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cenp1BxD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46D81F000CA
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 19:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597047;
	bh=WAEOzMDkQXHeFaVJ78vzghFDASGs+HMG8qMN8m4Kh+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cenp1BxDqSDwZTsEQ+jGLR+1OqBpZu6ZDupWEn3U3uR8YlKg8JMaRWuGQ4tMTC95d
	 M22jJBPOZ1SZseNUVpQW/jxdXzJ1xbY9W2fvLLoC8TYPMOkMvpCJA/lDKD8JLRMbu6
	 LZ2D3Dpig1mZPp8P2GmB9d4vNpeT6giO4+pqrEgK+cE4PZK4cWJ31A1veqbhhm15Es
	 pij84dqsxnQDZxkdD9qI7OyHOPKDUjPVPrjGqhL2gEtXaL5RTxc6aS6GUYECURgETU
	 zjAJKsnCR34T1kmSSdbOqxwqc1DxgWx50+b5qak8pq1gO3Gxe11saQKdcnCNpq1TLQ
	 8FlONx5JLEA+A==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ab4354db11so17552491fa.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 11:10:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHU07Lxdh7XL2lAHBFOXQJ78rP5SBvGPaylWW2tQXjgOaVsbLb7JkB32Hx3EFUg16wtYYf9guGLtg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/26980yrKW2SLnF/1zgOWIUYt3JtNOU/06TYCwkoGpt59FJuBW
	rYuiQ3CM2jD2cT2g/2BScZh3/6WE94S+WRaRamtS5SGgauLT69PJZyg8HSJtGPdmOfamCCHrALj
	OZadgtl1RQtP5mw6+MoodAqni6NAkvfE=
X-Received: by 2002:a2e:ab0c:0:b0:3ae:90:b8a6 with SMTP id 38308e7fff4ca-3ae2b524882mr11616641fa.26.1794597046238;
 Fri, 13 Nov 2026 11:10:46 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202611111143.CWKE7ewK-lkp@intel.com> <32021bd4-e144-4674-a5ed-ef8b38950b7a@oss.qualcomm.com>
In-Reply-To: <32021bd4-e144-4674-a5ed-ef8b38950b7a@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 20:10:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ga8+ULra1Fg2a9NOpV=b0uXb57S8=n2LsatLO72JA=PA@mail.gmail.com>
X-Gm-Features: AclHuK_FISev9QdymkiDcQ8s-xIg_N8ybQmVcnLi7gT1LjucOJzp4oodMqBg0ns
Message-ID: <CAJZ5v0ga8+ULra1Fg2a9NOpV=b0uXb57S8=n2LsatLO72JA=PA@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 9/22] drivers/platform/x86/hp/hp-wmi.c:1057:16:
 error: implicit declaration of function 'devm_battery_hook_register'; did you
 mean 'acpi_battery_hook_register'?
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: kernel test robot <lkp@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 12:18=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 11/11/2026 6:46 PM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git bleeding-edge
> > head:   51bafe2e7302403a43ba45415bf9a268a7fcaa05
> > commit: fafe4f5166bc3d43e28967efb9ea82b1f456b798 [9/22] Merge branch 'a=
cpi-battery' into bleeding-edge
> > config: x86_64-randconfig-2003-20261111 (https://download.01.org/0day-c=
i/archive/20261111/202611111143.CWKE7ewK-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20261111/202611111143.CWKE7ewK-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202611111143.CWKE7ewK-l=
kp@intel.com/
> >
>
> Addressed the same issue on
> https://lore.kernel.org/all/cbd2aee7-95ae-4d30-8458-b7da2910867f@oss.qual=
comm.com/

Thanks, it should be fixed now.
