Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70FB2D3EC7;
	Mon, 13 Apr 2026 04:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776055680; cv=none; b=Hkz+mkVtWscjfZUXfXeEaZIeg6yIa/hT24bY0jI1gZAUyFH86brcYtEYK+GidOWR+GKEjYsYfhudR8+Gg58HaSwR+7kAYNLILiSc0/XXyyciJ1aB29AvU4g9qP5ijbXXFzNnn8Ik30OhkwZj+2faofNpk/72bCR0RaL0D1v69+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776055680; c=relaxed/simple;
	bh=v/MxTEgt0hfDRYM2J4O78Ddvv5cWzOkaEyqDEpxmr2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX9okdWSvUza96cI+ui4X/zsxQH99Mib3kYAIsAITKNn861l+xltjVP5McpbyDeZdRvU4tVWP1NoG3osB1JVyxFjdbfVDSD2Ug7MXqXsEva4+BhdRweTcukaPzMmDqgBt62PcgY154tVtIp6b4pOkafbaos+9EvEBH9JL0vAlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e2VgYpjK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e2VgYpjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9FBC116C6;
	Mon, 13 Apr 2026 04:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776055679;
	bh=v/MxTEgt0hfDRYM2J4O78Ddvv5cWzOkaEyqDEpxmr2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e2VgYpjKczj7Pun2KG9GFlVkVKtOK9XPyLldoNp8qiHxoU3wsAIZGRnxtetuNi8FQ
	 98+G+b9+L4tNGlAAvX4YyPbNmD39LuqJSwhQ1oCkBMvl3xW0kpLg9g7ZHLbBRzA+hn
	 JAlqkYc2BGvmGeMPFkbM70KOsJIe0GLLTVXI64PQ=
Date: Mon, 13 Apr 2026 06:47:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Samuel Wu <wusamuel@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
	Android Kernel Team <kernel-team@android.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	driver-core@lists.linux.dev, bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] Support BPF traversal of wakeup sources
Message-ID: <2026041315-oval-rut-cb8d@gregkh>
References: <20260331153413.2469218-1-wusamuel@google.com>
 <2026040136-ocelot-simply-8981@gregkh>
 <CAG2KctokEVVuhrs6tYuMjFF4ALR=tX80iZHrt4bhVvEKyoHzRQ@mail.gmail.com>
 <2026040236-kiln-carat-bb6d@gregkh>
 <CAG2Kctpr7vBm_=Xz4H5FHYAfFxg=bDt35j6B4EprfUGio=Ftew@mail.gmail.com>
 <2026040357-undefined-gave-c98e@gregkh>
 <CAG2KctqOLeYm_NFUjGdXQcBo1KhSZpXFQxQdM-DQBV4Mn0ahTw@mail.gmail.com>
 <CAADnVQLELWyv0kuv8wK3FJVFdJPbp-tD8d3p2pgCiVrcw_cVNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLELWyv0kuv8wK3FJVFdJPbp-tD8d3p2pgCiVrcw_cVNA@mail.gmail.com>

On Sun, Apr 12, 2026 at 03:48:58PM -0700, Alexei Starovoitov wrote:
> On Fri, Apr 3, 2026 at 9:28 AM Samuel Wu <wusamuel@google.com> wrote:
> >
> > On Fri, Apr 3, 2026 at 3:04 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Apr 02, 2026 at 12:37:12PM -0700, Samuel Wu wrote:
> > > > On Wed, Apr 1, 2026 at 9:06 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Wed, Apr 01, 2026 at 12:07:12PM -0700, Samuel Wu wrote:
> > > > > > On Wed, Apr 1, 2026 at 2:15 AM Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Tue, Mar 31, 2026 at 08:34:09AM -0700, Samuel Wu wrote:
> >
> > [ ... ]
> >
> > > > The data is fundamental for debugging and improving power at scale.
> > > > The original discussion and patch [1] provide more context of the
> > > > intent. To summarize the history, debugfs was unstable and insecure,
> > > > leading to the current sysfs implementation. However, sysfs has the
> > > > constraint of one attribute per node, requiring 10 sysfs accesses per
> > > > wakeup source.
> > >
> > > Ok, as the sysfs api doesn't work your use case anymore, why do we need
> > > to keep it around at all?
> > >
> > > > That said, I completely agree that reading 1500+ sysfs files at once
> > > > is unreasonable. Perhaps the sysfs approach was manageable at the time
> > > > of [1], but moving forward we need a more scalable solution. This is
> > > > the main motivator and makes BPF the sane approach, as it improves
> > > > traversal in nearly every aspect (e.g. cycles, memory, simplicity,
> > > > scalability).
> > >
> > > I'm all for making this more scalable and work for your systems now, but
> > > consider if you could drop the sysfs api entirely, would you want this
> > > to be a different type of api entirely instead of having to plug through
> > > these using ebpf?
> >
> > Almost all use cases want all this data at once, so AFAICT BPF offers
> > the best performance for that. But of course, open to discussion if
> > there is an alternative API that matches BPF's performance for this
> > use case.
> >
> > I'm not opposed to dropping the sysfs approach, and I attempted to do
> > so in the v1 patch [1]. I'm not sure who else currently uses those
> > sysfs nodes, but a config flag should remove friction and could be a
> > stepping stone toward deprecation/removal.
> >
> > [1]: https://lore.kernel.org/all/20260320160055.4114055-3-wusamuel@google.com/
> 
> The patches make sense to me.
> 
> Patch 2 adds a bpf selftest and corresponding:
> +CONFIG_DIBS_LO=y
> +CONFIG_PM_WAKELOCKS=y
> 
> and almost green in BPF CI.
> 
> Except s390 that fails with:
> 
> Error: #682/1 wakeup_source/iterate_and_verify_times
> Error: #682/1 wakeup_source/iterate_and_verify_times
> libbpf: extern (func ksym) 'bpf_wakeup_sources_get_head': not found in
> kernel or module BTFs
> libbpf: failed to load BPF skeleton 'test_wakeup_source': -EINVAL
> test_wakeup_source:FAIL:skel_open_and_load unexpected error: -22
> 
> We can still land it into bpf-next for this merge window.
> 
> Greg,
> any objection ?

Yes, it is too late for 7.1-rc1, sorry, there will have not been any
time in linux-next to add it.  Let's revisit it after -rc1 is out, and
again, I feel that "walk all sysfs devices in bpf" is not the correct
solution for a system-wide snapshot interface you want to have,
especially as the one you previously added you feel is now obsolete.

thanks,

greg k-h
