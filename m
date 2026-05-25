Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661833F54C7
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724161; cv=none; b=sup9BP72jVNG2cBWJv1mbKap5pIIWmFP8UiZEk96uieStmzT5XWrIuJEaupxKUZTk96DcojjzFe07fmSq5VrdxNBhp1O3mmdxJe0OAR8DIoJRva3hjeA5L/7MyAHlvx0OmFL8PqBnFVmcU33QcpvkSeq9FqqBc4/6zVSoLgfGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724161; c=relaxed/simple;
	bh=+w66b8Gvg+VAwraZayT4UIf5GSugXAlpaIfSRcWeFnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GL89NHIBL1/QqvUty2bE8MDNZD4H3c+P0AR9mT0e8K00DEbFOOEE5o8WVlLrz2irjumKNcrmqtzrAHg4nXIrnFEbqcDZ5FE6iJmG/nBPCDWm5/M5Jy6i3YIukdMBc6MUPzKO8fxn8fPYOaQbgzIs4IR0npAT5fEzzYVA8ItkVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipmrO8lK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipmrO8lK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195A31F00ADB
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779724160;
	bh=neTwT8y6ZPG9dbKI04XCdPRs629XMkbckXQBqvMur9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ipmrO8lKg/hi24IyefYD1vHGNNIICCoRV5UtseOic+BX47OUSbhDEmPl0ZlXi2ElW
	 w1s2ddh97w/ASWcJxHvueWo1mUGeioSSjEU2d6txYVPAZhIhcwlSUhpiUd3/dU9quK
	 ZLLf1pf+FpUQKjeX+aK0bweNpw32/UUwt+l7O3CP8N0Cw6Vf56meZ9IPyT47V+XYfb
	 DXpDVWxQjMcXIxawnCHnSgXMSnBUeSppsnfWCHkMJQ2SIqb1JIEWExO+B9E4Ybs/f2
	 Sk4ddZ4VxpB3DtjDLcyseg8eZjdQiNRUVQ+ZLTY6Ax0QzdWUsnN7pc+McIG+ordaKw
	 s0g1UOAYzvaoA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8891febd2so12805526e87.1
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 08:49:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9QOuC9KBQoD7CFRbAMo+FX6aoc+PVa6jipVfXtvGpQTbBsQrQHlwa4vI4c/IO3SfIEDA21SRr2zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvDw33lkZDmRIGEsiMnDfs/eNVo7jrnGnfFzNDPrR4khVwi1J4
	rJsSocNIQVzCDd7veQYiIZPxdFYk38vpEHdIzkH0tUGR4nbM6jKWpU9Lk/nX/rDwyNdKzaw+CUO
	mEj5eqmitXwaxCtF5fJCz1aSe+9CWLoM=
X-Received: by 2002:a05:6512:3ba9:b0:5a8:f984:1541 with SMTP id
 2adb3069b0e04-5aa323cdd95mr4116170e87.37.1779724158466; Mon, 25 May 2026
 08:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779423281.git.viresh.kumar@linaro.org> <CAJZ5v0h0TmT651oHFs068gxBAsqE=Y4sEY+rPC3OPkdFijndYg@mail.gmail.com>
In-Reply-To: <CAJZ5v0h0TmT651oHFs068gxBAsqE=Y4sEY+rPC3OPkdFijndYg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 May 2026 17:49:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hCXi+V8-t_uHH3e+AnKjbfPj2nHAnxwwRijpaQg3yVaA@mail.gmail.com>
X-Gm-Features: AVHnY4IuupOLrFUPXdEwMNnfSJ733E9iYqszx1t_dZIBuYIEhr31wcZHg67uOwc
Message-ID: <CAJZ5v0hCXi+V8-t_uHH3e+AnKjbfPj2nHAnxwwRijpaQg3yVaA@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] cpufreq: Simplify freq limit handling
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Stratos Karafotis <stratosk@semaphore.gr>, 
	linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 6:43=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi,
>
> On Fri, May 22, 2026 at 6:19=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro=
.org> wrote:
> >
> > Hello,
> >
> > Here is the second version of this patchset.
> >
> > V2:
> > - Add tags from reviewers.
> > - Drop intel-pstate change.
> >
> > Lifeng Zheng (1):
> >   cpufreq: conservative: Simplify frequency limit handling
> >
> > Viresh Kumar (2):
> >   cpufreq: Fix typo in comment
> >   cpufreq: Avoid redundant target() calls for unchanged limits
> >
> >  drivers/cpufreq/cpufreq.c              | 31 ++++++++++++++++++--------
> >  drivers/cpufreq/cpufreq_conservative.c | 12 +---------
> >  include/linux/cpufreq.h                |  5 ++++-
> >  3 files changed, 27 insertions(+), 21 deletions(-)
> >
> > --
>
> All applied as 7.1-rc material, thanks!

And since Linus complained about -rc5 being too large, I decided to
move this to the 7.2 queue (along with some non-essential cpufreq
fixes applied recently).
