Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7104A441D
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530143; cv=none; b=QYi7R1hpfoWL5Og7EpKtMS7q1LSlWH2dGd9/yDQfolH9eQUSIpDuy6h8Y80A0iGFLmFxKLgewruF57S+Bv7NOgkF2X8vyM0hXdQY/Al+D5c6rGMifwMnONfH5uEAs4+Tw1lHk91m1JZ5Mu+gMYDocr5kTKvICqzXF143BLy0ANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530143; c=relaxed/simple;
	bh=sBMKJj1wJR2KQ7ZpbNH6wfu8gkUhjzUFlY4sK8aE2oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzhSW8yxpQY5p1xrB2WbU2sNGpSgFTdfRr9uregdD4gJaw9H472FuuSna+tMCcNR+HLdGZ0zrVaYFcnblhPmSlDG9zsy2V8dR2X0B5RxxRSNsWBQRD+5P04X2dsVqOKUIF5AfBu8ksH3xgd7tj+5ZRUbBr9ZaXNdkX/pulMy4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvUrEnzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvUrEnzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542D61F00A3D
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530140;
	bh=On1GTSXvYcveYA7MPDV9dgrLnbm7g4xsYcGKHj6xq8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nvUrEnzVrVhpnI4l8XZsaFCS2idBlmeVB/LEhAU52p7fgHdNYVm6/eWV2yzL0qQhL
	 75oxIo4+pgHVTGDOAyfI9mod6U5yOeJ8FGfBrL54IjUWmgjhB5pG97FqGCtv1YpFvX
	 O7DnCkZk2+FNenSd1ddazNBJK+CrGx7D934Y7JghUlZiMi7TerTDbHb4phRjTtOCQS
	 Uf9FA8eeYkIlmRzKgiQO7mVIcabriYrdUiyRn6wxLleyS4hQV3ZUZ5llN1nG0cov9F
	 e3CrzD4q+dH0ikvY7goIn4TC7yav9m5kyeNexq3G6zKuOEhJe3og9ea5KFRG/GiD7K
	 sG7h7kIF1U+KA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a2e9851ed7so9820181fa.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 06:55:40 -0700 (PDT)
X-Gm-Message-State: AFuF++lOvfUHxf9BD1yPi1eqn5b7e0GXGteeIpnh9cMMNS0XmbkdKv2S
	oLb00FwLVnjevsY89GR1KuWxzV2cFBsTd6YbSqdBKO4dvIhFsfTpTN638x+HBTb3gKLpWn5F67R
	ROQSuhFptkCz4s2CNQLhrumbGOZRUe9g=
X-Received: by 2002:a05:651c:30c9:b0:3a3:7681:6d5b with SMTP id
 38308e7fff4ca-3a376817423mr3889351fa.19.1788530138666; Fri, 04 Sep 2026
 06:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817103324.1020212-1-andriy.shevchenko@linux.intel.com> <03b270ab-4a39-4a82-b970-c0c10f400549@arm.com>
In-Reply-To: <03b270ab-4a39-4a82-b970-c0c10f400549@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 15:54:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j8peVE9RN2zCpHL-=tfpjZJ2MZo4JLaUyxxLkx3CQBLw@mail.gmail.com>
X-Gm-Features: AcwNN1VVkWplp4lw5QGty9A4P2UsbZeWBoHxlMsfOmx_eaPEc1nkL4niW9UKPrs
Message-ID: <CAJZ5v0j8peVE9RN2zCpHL-=tfpjZJ2MZo4JLaUyxxLkx3CQBLw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] thermal: sysfs: switch to use scnprintf() to
 suppress truncation warning
To: Lukasz Luba <lukasz.luba@arm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 10:01=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 8/17/26 11:33, Andy Shevchenko wrote:
> > Switch the sysfs code to use scnprintf() to avoid warnings about potent=
ial
> > truncation of the names of the sysfs attributes. We can't increase the =
buffer
> > size because the size is the part of an ABI for some reason. Note, with
> > the current size of buffer the affected attributes have a room for up t=
o
> > 1000 names, which ought to be enough for all cases. There is no functio=
nal
> > change, as the same limitation was implied before.
>
> Right, it doesn't touch the real truncation check problem only avoids
> the complain from the tool. We can think about this later in some
> redesign.
>
> >
> > Fixes: c56f5c0342df ("Thermal: Make Thermal trip points writeable")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >   drivers/thermal/thermal_sysfs.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
>
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied and added to linux-pm.git/fixes, thanks!
