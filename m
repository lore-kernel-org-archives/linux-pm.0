Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068C299929
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633488; cv=pass; b=GfrIyoyUSisW1sYS7sIAu3bBMDelxrau4X++pu7Tg2IMDrjpbqcGomBJoNMltVKY1uq+tPLCKTLuDqaR5xtV/2kJ/nrYRGgmD8MQnDNRpXa35IOExdGQpd5HpnsOthMgEr8eDHmQ5WhsAqw/qe+lvGIxJkLSeRU5ZTrxy+lNKCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633488; c=relaxed/simple;
	bh=izyNufNv3l0EJK2+rtZ1T7rBl3b1uNLGp9DIpmbczBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URdP+oAbIEjLG6tSBh7KWxOa5EljPQEdeQHKImyonKWn4ThljqJAkgl9AlByJqlO5i4XM5wb1ZWhmwGDxQa3d+vQztj2QaWfVKwln9DNe2X4be5n08I1uVUR3c7GxqekG5UowWlBq1L9bZXSdoqOcHaLRqjplJeQu/0PoI3WBdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pC71eVXu; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pC71eVXu"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44b052142e1so3418534f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 17:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778633484; cv=none;
        d=google.com; s=arc-20240605;
        b=aHhBA/LpIW156WNERacr1mTtGA3KfQvdDhB70468WLwBz69jEJj17jxKHY/7K3uekK
         Fw/FwKSkBoiEIwHd3NsZ9svM/J0hllWA0k53ao/x2SS6N/LEU1MMlcbaXkAby3h57quR
         QNp2tA3K8iIGvP8+zGOYjTd3MVe+sv9L3/Gf+QXzzSD1pH8VpD4wWGWMevJswOTjDwe5
         8H8TqtUYvjrBwBoUOAnge/trEv/N6EJGHYWQMF78bu9tZ1vVaHZG7zYrTfF4u1Im7B7P
         /xolHZ5zH/nFDGlVgVuC3Y4pyuduEHvCjf4Tqhzm13jwHKcgD+5IbyEz62OEVOJ737Ui
         RCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A0yqDbK591ypC5eJWQGsP1nPlMWdMRq98a5gApsWXZY=;
        fh=qTikJx49CjKhTfrJlCxmBT/XwdmNOVE1kKof8R1/g64=;
        b=Qtq2g0r99RBzl87M0wbOhYlkxIZehe5GUYi+rHvaWkYQIuII0CYXH3cfmsIuckLMt5
         M4/fFRIpEUsvywZ0m1HKgOeGAQlk0psvzs22APR2AJqtJMv5e3ZxYkUHl6IoheW3WOkK
         excZgVdHLaQdWALOkPNXn3eN/cBY5y3lYhekbDnrLXRolIG4UtUx9FJ2GCw1KxAF06sX
         RamJRuCH67salzEc0/M7PLqn4uNGl1RCwYmUb1ZawG/DnD0BIPsSdSebqFlAOzIdYVOZ
         mgGSAndr70qW/O35BGIYni7oXi1wq0j4waZky70Zy7JN/1UVgB/3fMGWr3FU7gwQ0g2r
         1E9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778633484; x=1779238284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0yqDbK591ypC5eJWQGsP1nPlMWdMRq98a5gApsWXZY=;
        b=pC71eVXurgf8caoIXfmSy14jVsV6DMbcG3ZpiY3KbFvMTBWgSBb0V0Ev8LJ3eUx85z
         wb3FpsxuYOjXuky3A/MVX3+s3HnipsymhSvhNtKXddtSWPKT45kmbxrQPOClpE08eS9k
         Fs8Z4a2y6C1CRwMedrrVbj8bCjJr5XGagYLgyh0KacbQPlKzMJ6Ewzn/wq7B1SpbUls/
         5GrpGwLl9OASDSpYmyTqMAQ1RtM/ZlIcjGAmZHluO5cWODf3PtmlYCa6sNOxO9ZFTDqS
         tOWjy2Bpdx+dFcsUZ5V7D+M5pJYH+tV20PYEJSPs97Met6N06ELVEl2HOhVPzlpdzrXI
         y4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778633484; x=1779238284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A0yqDbK591ypC5eJWQGsP1nPlMWdMRq98a5gApsWXZY=;
        b=GK9Jwo6IB3T6+bOlznOCn3N8siRAO/QEzEmVZi5lM6kZWdyud3AMDRIupTj8ZWHlzL
         CT1IODg3X0AKb6XrfqZCB7+pS5Zk8m43oNrvjEj71Utp2EZOR3l05Q4n7i7zrN1jTunJ
         8FQt/xqUkp5qEpxNJn+x5ij9+XINUM/KQ5zNp1DYJIrqPriUUrdfKQzuDC8XTtx35HXC
         y+4E/tnbLoLpBn+d2okfJpN4dc+/xswIVgfeyt1l1ly8BSJUdMQp2sUSw235usSSmvRN
         /oOxXqIKaYjxj29ChFGUESjaSKPWGMSu2Yk8RMN0ejEx9SmZ7l0nJ81I8vr5NwHScf8j
         DY4A==
X-Forwarded-Encrypted: i=1; AFNElJ8kiidZmrH1sFw6ClfZydBwGMB60CAPfY1AwtYPRw9Knz/boBFJsJnu/HZbOSBEcgrs/XauirLM5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6B0FrbF+Kx2g5wMB8Rwjr65DOZM1xJlCjrXjrmY9To5/e1wvc
	bI82mrxz37+EcZZlOhfL1HymwXaTzyXMXrr4O1YrSh8u0xBf0gloL+f5WDf0I+bQ1ncTljTHm0Z
	IJyfHyyurIDygkJEUr8Fke9d9R7I1wuU=
X-Gm-Gg: Acq92OGFqJI/wxwHz5BzCbDnmdlZ5CedZAsTiO8KgWBVTtViYpJ3PpMPDneRbj5o7lq
	MPOEj74BJugnbXISbP4R1WUz6IRO8BPHZ40D4xr50ZzI0v0KPJ64r0v98oLDHPobT7UQa/gE9XP
	okIdt4Jfz65SkkcMTbRcI5xtH8AnxYtFVFsu+Zxt3lALFZ5/SGhBRAHZPgO04G3+J+NNd92oYIw
	JaBm2Loydx7Hvuf/9bpyEbQmw10wGzj3VXBA3uMyOsycnlPz48NrBxz9ESyH7NIjNTtvSegW5xY
	ofHXzGYxxo5lBTDQzPbKt04P0JzL8rKf0pTjxrE1ZIRnlng4+H7OdWJAR4ddxnZ+VQ7VHLBBWGa
	Eu55PfJwggXRuITvQzD6wFnAnTg==
X-Received: by 2002:a05:6000:3109:b0:43d:6f0f:32fe with SMTP id
 ffacd0b85a97d-45c59702e8fmr1423029f8f.31.1778633484225; Tue, 12 May 2026
 17:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511174559.659782-1-wusamuel@google.com> <CAP01T74KQ6bie5o++i_gHM19J+s2RzDyM6=w87=oUZgPagPejw@mail.gmail.com>
In-Reply-To: <CAP01T74KQ6bie5o++i_gHM19J+s2RzDyM6=w87=oUZgPagPejw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 May 2026 17:51:12 -0700
X-Gm-Features: AVHnY4K10O6Mxpl9QjZAt4PGuFBG9tJtHHyQLjkej2TGD7aWVby8-50dFABh7DA
Message-ID: <CAADnVQJtuKQh-bpDDeqWCQRM1zb2sSgo0qET_+1+JFOL-6cpDg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Support BPF traversal of wakeup sources
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Samuel Wu <wusamuel@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Android Kernel Team <kernel-team@android.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 1:44=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 11 May 2026 at 19:50, Samuel Wu <wusamuel@google.com> wrote:
> >
> > This patchset adds requisite kfuncs for BPF programs to safely traverse
> > wakeup_sources, and puts a config flag around the sysfs interface.
> >
> > Currently, a traversal of wakeup sources require going through
> > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to qu=
ery
> > sysfs is inefficient, as there can be hundreds of wakeup_sources, with =
each
> > wakeup source also having multiple attributes. debugfs is unstable and
> > insecure.
> >
> > Adding kfuncs to lock/unlock wakeup sources allows BPF program to safel=
y
> > traverse the wakeup sources list, and a kfunc to get head of wakeup
> > sources list is needed to start traversing the list.
> >
> > On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
> > speedup (sampled 75 times in table below). For a device under load, the
> > speedup is greater.
> > +-------+----+----------+----------+
> > |       | n  | AVG (ms) | STD (ms) |
> > +-------+----+----------+----------+
> > | sysfs | 75 | 44.9     | 12.6     |
> > +-------+----+----------+----------+
> > | BPF   | 75 | 1.3      | 0.7      |
> > +-------+----+----------+----------+
> >
> > The initial attempts for BPF traversal of wakeup_sources was with BPF
> > iterators [1]. However, BPF already allows for traversing of a simple l=
ist
> > with bpf_for(), and this current patchset has the added benefit of bein=
g
> > ~2-3x more performant than BPF iterators.
>
> This looks good to me, you can add for the set:
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Rafael,
how do you want to route it?

If you ack it we can take it into bpf-next.
I'd think patch 1 shouldn't conflict with other 'wakeup' changes.
