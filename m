Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1939DBCA;
	Thu, 14 May 2026 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743355; cv=none; b=bNSVSh5a9zjuULueQPi9NLrHIh9U3bt+H9F00Nk30b605bXNQ/j8jJx5lKWptiKe0rGawDhvzeBTLKpWd6Zy6pdb2K5y6mRJApR8Ck36ayto5l9VRoiCbPzzzxre2VoaswaJTp4PZGzdiqozkaP6D0nxl82/4lJ51k5RmnS1YXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743355; c=relaxed/simple;
	bh=SDSfEtpecQQXPBh9om6SLWCqztY/2MxKoykeg6ED4QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gx2Q4cb84cxwQ0hyJTjeVEr7s8gHQ8+2ejy6ZeiJq4m38VM42rNhTlVFAPQdE3T/uAFR9vc8NBO3MUmYkaupxe6JWZSkNPgfyO4QKdhRZsd0esd2VpTay7JNcuCrzjiGV33cUY/COHA9tkEE97qWQ35T57VsP71E0s3F9e7EEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z2zCe5sc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z2zCe5sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AA6C2BCB7;
	Thu, 14 May 2026 07:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778743354;
	bh=SDSfEtpecQQXPBh9om6SLWCqztY/2MxKoykeg6ED4QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z2zCe5sc2K/ZXdFiOraGh+Iyx3NKmV826UNPXHngbWCGbMnadzGuBH7sRWNjw2LVg
	 FBqldvWkuzt4LCpgbgG1kFe0ErFXHqfh3dfA8LIDUbbKQ9GSpeOitVP2qYh1/N9sN/
	 Vn87LrIpEG1RwIgW+Zdu1iquGXnev4FNORpaTl3c=
Date: Thu, 14 May 2026 09:21:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Samuel Wu <wusamuel@google.com>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Android Kernel Team <kernel-team@android.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	driver-core@lists.linux.dev, bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] Support BPF traversal of wakeup sources
Message-ID: <2026051417-handbook-uncivil-1a56@gregkh>
References: <20260511174559.659782-1-wusamuel@google.com>
 <CAP01T74KQ6bie5o++i_gHM19J+s2RzDyM6=w87=oUZgPagPejw@mail.gmail.com>
 <CAADnVQJtuKQh-bpDDeqWCQRM1zb2sSgo0qET_+1+JFOL-6cpDg@mail.gmail.com>
 <CAJZ5v0hqdyMnBtvvo7RwUkh5saLvAHkTEVz8Ln09UaKMqoP=Dg@mail.gmail.com>
 <CAADnVQLvuCKLUHnxcEx2+t4diLmuOb9VSthoDea5iktsAZxhTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLvuCKLUHnxcEx2+t4diLmuOb9VSthoDea5iktsAZxhTg@mail.gmail.com>

On Wed, May 13, 2026 at 02:03:39PM -0700, Alexei Starovoitov wrote:
> On Wed, May 13, 2026 at 12:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, May 13, 2026 at 2:51 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, May 11, 2026 at 1:44 PM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Mon, 11 May 2026 at 19:50, Samuel Wu <wusamuel@google.com> wrote:
> > > > >
> > > > > This patchset adds requisite kfuncs for BPF programs to safely traverse
> > > > > wakeup_sources, and puts a config flag around the sysfs interface.
> > > > >
> > > > > Currently, a traversal of wakeup sources require going through
> > > > > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
> > > > > sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
> > > > > wakeup source also having multiple attributes. debugfs is unstable and
> > > > > insecure.
> > > > >
> > > > > Adding kfuncs to lock/unlock wakeup sources allows BPF program to safely
> > > > > traverse the wakeup sources list, and a kfunc to get head of wakeup
> > > > > sources list is needed to start traversing the list.
> > > > >
> > > > > On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
> > > > > speedup (sampled 75 times in table below). For a device under load, the
> > > > > speedup is greater.
> > > > > +-------+----+----------+----------+
> > > > > |       | n  | AVG (ms) | STD (ms) |
> > > > > +-------+----+----------+----------+
> > > > > | sysfs | 75 | 44.9     | 12.6     |
> > > > > +-------+----+----------+----------+
> > > > > | BPF   | 75 | 1.3      | 0.7      |
> > > > > +-------+----+----------+----------+
> > > > >
> > > > > The initial attempts for BPF traversal of wakeup_sources was with BPF
> > > > > iterators [1]. However, BPF already allows for traversing of a simple list
> > > > > with bpf_for(), and this current patchset has the added benefit of being
> > > > > ~2-3x more performant than BPF iterators.
> > > >
> > > > This looks good to me, you can add for the set:
> > > > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > >
> > > Rafael,
> > > how do you want to route it?
> > >
> > > If you ack it we can take it into bpf-next.
> >
> > I guess if someone really wants this, I have no particular reason to
> > object, so please feel free to add
> >
> > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> >
> > to the first patch.
> >
> > > I'd think patch 1 shouldn't conflict with other 'wakeup' changes.
> >
> > Sure, there are none ATM anyway.
> 
> Thanks!
> 
> Greg,
> are you ok with it too?
> I hear your api concerns, but imo it's a nice improvement.
> And bpf is not a stable interface despite some sceptics saying otherwise.
> Just see how much sched-ext api surface has changed.
> 
> So if pm:wakeup folks need to tweak it later they're certainly
> free to do it. Of course, it's better to keep things backward compact
> and deprecate gradually. All options in developer's hands.

I still feel it's really odd to be wanting to iterate over a zillion
sysfs files all at once, but sure, if this fixes the problem for this
user, might as well take it...

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
