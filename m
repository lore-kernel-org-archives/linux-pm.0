Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F934EF08;
	Thu,  2 Apr 2026 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102811; cv=none; b=sDCIHPP3M2mHZ16fESAhhiyhWvpDwxDIWvvunUG8UZ4JO0vo5ONmwMviZfq2M8cUt9irHHqIuxC9nfHcBtcMjZwh+X3a1wrZ7KK6cFmXo+o1n++Yhr2gCKcBXD/8z4wwcnlcIO6/XvvZOZxkn7UVUNlRQnqQtsksPPILp1o09AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102811; c=relaxed/simple;
	bh=UKVHWahi0fbxbYI6ys1MP8/QXMc97IMmvnDflgapZOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMxEeRRBP6Il82HQX09mVkz5zp0+XxSPNmTN6pxhjUCFfELEXgX51F9i32OybuqMrDO1K/g/r2d0isuQLqV03j7glQBxiNmL1YZIdJrftNJcDWiAfQBwb2uze+dZaU8hexzYh0pCM58TY6nkX9BmTRnVBt8nkQC7CvCxfVQFxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YvEHhBmX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YvEHhBmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B08C19423;
	Thu,  2 Apr 2026 04:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775102810;
	bh=UKVHWahi0fbxbYI6ys1MP8/QXMc97IMmvnDflgapZOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvEHhBmXANVWMbSDMVncIB6qfTjgyq7oPFhn4ZChI2qpM+mPpXdrZEmzqP7YTYTOg
	 0o11r2Nnqe9EmO6EcYz3yOyp2ekICkDympqvHA8DxAZ4+u/3CS5Ei0Q16moOu8xAYu
	 nGDOZKC34utjZGQRQtZEaQ67BxhKjsB3YXn56NZM=
Date: Thu, 2 Apr 2026 06:06:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Support BPF traversal of wakeup sources
Message-ID: <2026040236-kiln-carat-bb6d@gregkh>
References: <20260331153413.2469218-1-wusamuel@google.com>
 <2026040136-ocelot-simply-8981@gregkh>
 <CAG2KctokEVVuhrs6tYuMjFF4ALR=tX80iZHrt4bhVvEKyoHzRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG2KctokEVVuhrs6tYuMjFF4ALR=tX80iZHrt4bhVvEKyoHzRQ@mail.gmail.com>

On Wed, Apr 01, 2026 at 12:07:12PM -0700, Samuel Wu wrote:
> On Wed, Apr 1, 2026 at 2:15 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 31, 2026 at 08:34:09AM -0700, Samuel Wu wrote:
> > > This patchset adds requisite kfuncs for BPF programs to safely traverse
> > > wakeup_sources, and puts a config flag around the sysfs interface.
> > >
> > > Currently, a traversal of wakeup sources require going through
> > > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
> > > sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
> > > wakeup source also having multiple attributes. debugfs is unstable and
> > > insecure.
> >
> > Describe "inefficient" please?
> 
> Ack; I’ll provide a more detailed breakdown in the v4 cover letter. To
> summarize: the "inefficiency" isn't just the number of sources (150),
> but the fact that each source has 10 attributes. We are looking at
> 1,500+ sysfs nodes to get a full snapshot of the system.

Wait, no, something is wrong here.  You should NEVER be wanting to
combine multiple sysfs files at the same time into a "snapshot" of the
system because by virtue of how this works, it's going to change while
you are actually traversing all of those files!

Why are you trying to read 1500+ sysfs files at once, and what are you
doing with that information?  And if you really need it "all at once",
why can't we provide it for you in a sane manner, instead of being
forced to either walk the whole sysfs tree, or rely on a bpf script?

So, what problem are you trying to solve that looking at all of these
files solves for you at the moment?

thanks,

greg k-h
