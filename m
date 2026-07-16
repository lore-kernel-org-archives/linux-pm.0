Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33541F37B
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205601; cv=none; b=o1sQ234oy2lCUO0vmG1zx4WkK8mYvLAjmSSD1fgP89oP6fOUr+ovBnvxPR1G+J/nmsgN/z4ySUvawDgQt957Am6l1C7p2uQL/g4LSsUlN0xsa+Bn/D6S6xuZRf7Nf2VpjgRVGD8B1uPfX/BW4AIDUP9EJ3GACq9N1gIP19BibiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205601; c=relaxed/simple;
	bh=OxlN32iU+dZZDeFlRrMUjrZz0IkcNsY0YbDQ0qDA3v0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0ATXKzXM0Pp6kMXsAw57S3vFj/a/ut+vtlGhfJoR7CrFkWGloeK/vBVuDZn8kcPjyuG+w+9Lt8FX14X5cayEHakW1mcAY4yUyUrol3E9B0Ww3EcZGU7VQV2bev/NT0SXds28oSQ28tIlwatnbqnFEg5ZP4USfLywfarTqSGOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqpCPouG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqpCPouG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845261F00AC4
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784205598;
	bh=OxlN32iU+dZZDeFlRrMUjrZz0IkcNsY0YbDQ0qDA3v0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=WqpCPouGxXPy6ueFZIiDKndTIcSseLdOW8zJnpgFBSNSoDdKIk/7PbT66hpvii8lF
	 xpGFkHf70LHbzODC2JX/8bknW9AW6hST0M5fCOTn22Ej91WlStU4IXndhEeMkjZpiS
	 FuzbYk7mi+RMgrPZJDIL+OOZfj6dhWIPtZW/Bw3DIguFX3YILXjlr/Om6RgxEe0+5g
	 OvRqs4AzBAP4e4J4WGePbTy/doO1ETuJXTc3TJDSwkcxYHhoOYotCja1Rjwwj2npSn
	 eieU4XXRFGXQiZnP2TA5NVDbGO824HC76MjX7lmsIRls38P0dfhkCaGZfjVgAgftPm
	 g6IOG5Nv4SVbw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aec201b582so6428437e87.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 05:39:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RooMVqoznxNyQaa/yJh/tJIdGeu4gcyu61tCe79P8FvGg60Vsk3nUM1Ik7YRoFpymRLXGCbmr+JRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpMVjh0/sTtGYPZ5B76qAxKfqFHYO9SJjCgv/nbYFPFhngrQ5
	o5Uv/q2AE7VaAUf/onjiqyfh1CJKE5OEFPpVyfnG/xIjQHaeiBRZQ50p1RnebDxPVRKfCSjblS4
	TXcFmXZvenwzP30Q+2ZOJHblb5NhKnuP0Stha4EiqfA==
X-Received: by 2002:a05:6512:4045:20b0:5b0:2176:69f6 with SMTP id
 2adb3069b0e04-5b15d7a50b0mr1154487e87.37.1784205597254; Thu, 16 Jul 2026
 05:39:57 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 05:39:55 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 05:39:55 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAGXv+5G0Ffrh-8UohJuGPQ0e7KGpy11=X7t1JtDYLTJ_tZgMCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715085348.3457359-1-wenst@chromium.org> <20260715085348.3457359-4-wenst@chromium.org>
 <aldS3qTympJuVXYj@ashevche-desk.local> <CAMRc=MfHmejks83bPfe3fKzAzFySGXk2GHMA9oZdMQj0f44eTA@mail.gmail.com>
 <CAGXv+5HGjGTrqqzJrpiQhLrCn3C6H20LXq3niPnoujQLOwgqPw@mail.gmail.com>
 <CAMRc=Mefxn81d0VUwmQgwFtffkL1=Er_1VQZCbC1Sa-Qph4t1w@mail.gmail.com> <CAGXv+5G0Ffrh-8UohJuGPQ0e7KGpy11=X7t1JtDYLTJ_tZgMCA@mail.gmail.com>
Date: Thu, 16 Jul 2026 05:39:55 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mcpu+k-zbY0bDf8q3_9o3qNsrt6uNCao5j3qQLnbjHYAQ@mail.gmail.com>
X-Gm-Features: AUfX_mzb6SG6AJl8tXyuIguJLZaf_DB4m_xujG-Tq3VPuMJuPnQWayz1ClA2bP8
Message-ID: <CAMRc=Mcpu+k-zbY0bDf8q3_9o3qNsrt6uNCao5j3qQLnbjHYAQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] power: sequencing: Add pwrseq_power_is_on()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2026 11:39:19 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> On Thu, Jul 16, 2026 at 4:14=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.=
org> wrote:
>>

...

>>
>> There's one more use-case where the power state trully can be *unknown*.
>> Please look at the proposed new function from Loic[1]. Here we deal with
>> targets over which linux has no direct power control even though it may =
still
>> control some of its dependencies. This is where an UNKNOWN state may mak=
e
>> sense.
>>
>> This is where I also floated an idea of renaming pwrseq_power_on/off() t=
o
>> pwrseq_vote_on/off() for better clarity of their purpose.
>
> OK. Would it make sense to revert to returning -EINVAL if the descriptor
> is NULL now, and then add a different error return value if !controllable
> in the future?
>

I don't think the latter part is needed. A non-controllable pwrseq descript=
or
is still a valid object and has an address pointing to it. Returning -EINVA=
L
on NULL descriptors is probably all we need.

Bart
