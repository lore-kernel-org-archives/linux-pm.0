Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37CC3AEF5F
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281065; cv=none; b=ScXQfdPXjDM3WbQ6iz9xj2I3w+c2IRT8WRrqCHltRDlAYq+6vlYW/vzmLAitZ9UIA8zFdHyH3SuggD66ewxKOILJ2TFd/WnmNzMugsHCARqNPRWY5ih4Gkyo4DeTqgGGEINRRzgu2xT5uLkvpvZT4DXsqSIO1shAqPhmrGRfSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281065; c=relaxed/simple;
	bh=qaSxrvp/mwC13Q7utahNJ1rzVTRO2S3htqAsC9VGCkg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbXsmvAeGYzIH+3b+ED3TvKL6QepzLgfz8x6JufFUw7shj9ReOM/VOStmQpS5r3juYi4EO45EkGE8RjXZCw4V5mq9oqRBCh67fo2ydmaRKTJ+2olTBz0YtN4l/UNBByT+hDzRHYOhIvNR1/0gIwKbWORjhD4nrNj8nYXzsdnX3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqQVpv2k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqQVpv2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A96EC2BCB6
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777281065;
	bh=qaSxrvp/mwC13Q7utahNJ1rzVTRO2S3htqAsC9VGCkg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=KqQVpv2klHN4COV6/FkHtGLvqgVFkUMT4XFJC65IOX6sG8xMXlBbILxqhy0DGLHWT
	 vRkBVrRrDhpzCvGLu4x32fB8S1yW0vfAc9KlRyvTuVA++qzvvZEGgFHssDxbhTY4ti
	 YnDMuXH7ZAKlVt9ROPxf+WG47KUlD6NKy82YEtUa897rWPOPFsAEtVEzvdP7ZBnypv
	 JbS6iOftOzhUtF19JtppvA8EkIF5VcT64Q9HY2QYf7Gakp6+pYjsfsZFQ/kGnFVaKQ
	 OSAeMrjCj7B4Ho9+Bq9FPX/4VanruG3fMzWDo++g8MHRY+pS5xHcs48rAbcymojK/l
	 n+6JnUbG3655g==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38ddd8d3b7fso75893421fa.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 02:11:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YwL4eqW9adIP2PunN51bC3YG/cOic/ktDeDuCNuH20fqhZn4nkl
	IfAj1fmOIPhZPWN+IOgLZzuUo1krtgEY93hzS559aRv7vbqt1qcrY+qZwbq6j+/q1t7/Juk4HsJ
	MM9c2OttFkvZDSkGSmIfps6/aiqDEgQDRsHV4mJzeKw==
X-Received: by 2002:a05:651c:1594:b0:385:dde5:1bf3 with SMTP id
 38308e7fff4ca-38ec77fafbbmr120389861fa.6.1777281064121; Mon, 27 Apr 2026
 02:11:04 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 05:11:03 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 05:11:03 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260426232705.422938-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426232705.422938-1-rdunlap@infradead.org>
Date: Mon, 27 Apr 2026 05:11:03 -0400
X-Gmail-Original-Message-ID: <CAMRc=McUr8Tuv9+LNQ0=ufj1z4Tstp_ujmL=r7bXrLaBXg4E5g@mail.gmail.com>
X-Gm-Features: AVHnY4J-trfR2TwyypS6Hanf_46Aygty1UjX_AoYiPK6iXgvv9gAsNjcaBTj1Gw
Message-ID: <CAMRc=McUr8Tuv9+LNQ0=ufj1z4Tstp_ujmL=r7bXrLaBXg4E5g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ABI: sysfs-class-reboot-mode-reboot_modes:
 fix doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 01:27:05 +0200, Randy Dunlap <rdunlap@infradead.org> said:
> Repair the docs build warnings in this file by unindenting the description,
> adding blank lines, and using `` to quote *arg.
>
> WARNING: Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:36: abi_sys_class_reboot_mode_driver_reboot_modes doesn't have a description
> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: WARNING: Inline emphasis start-string without end-string. [docutils]
> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
>
> Fixes: d3da03025e6d ("Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
