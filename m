Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BD382F1F;
	Fri,  3 Apr 2026 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210675; cv=none; b=fxPUHkxIIovro3SIDSfE9RZvdbYhuxJHcAuR3YUw8dw11DrPudMSG4xIyyw13oo5d+ArAUlpyNoAadW9r5iGHMW1KdtQbAnBkRJnWYCkbbyO8OUrocb7gP5VdXHw26oaNHMbVjUPj8zIF1YCCqS2LK3mkVCOwJI/4B6/pcPltE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210675; c=relaxed/simple;
	bh=nCK2cjRjdUkyaUHFwq1pM3cPECQPLn84HA5G9U6CD88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEU/HrXo/98WuXLwAL7q+911AolE3M1Ob1JkmAJC1kcxJ60tYdSaDMyAmoE13ZUYJy0x7Ubtdk5L2sbCElMPDTK01vtGysp42ih5EVd4j6uf9CPCNCzg0k0k49s1+rzF4QjjG+Elbm05qJc0UOIBwI8JSReclEM5TlNeS2QARHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E48qU7OC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E48qU7OC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604F4C4CEF7;
	Fri,  3 Apr 2026 10:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775210672;
	bh=nCK2cjRjdUkyaUHFwq1pM3cPECQPLn84HA5G9U6CD88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E48qU7OC6xFjPerUSUZYJ12mNKtop1wOk8mjGiOxGihJzLPR99CmmQsqzAPL4jua2
	 YXOll3riGP6uYNeratDMe58sSulLppbzuCCqCoH/lz1Xn/hQN3N16ULHTmvhbx+oLV
	 91V/M1EdSu3aWdj5+7VSZi3R5sAtlwqgZlJubCuU=
Date: Fri, 3 Apr 2026 12:04:30 +0200
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
Message-ID: <2026040357-undefined-gave-c98e@gregkh>
References: <20260331153413.2469218-1-wusamuel@google.com>
 <2026040136-ocelot-simply-8981@gregkh>
 <CAG2KctokEVVuhrs6tYuMjFF4ALR=tX80iZHrt4bhVvEKyoHzRQ@mail.gmail.com>
 <2026040236-kiln-carat-bb6d@gregkh>
 <CAG2Kctpr7vBm_=Xz4H5FHYAfFxg=bDt35j6B4EprfUGio=Ftew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG2Kctpr7vBm_=Xz4H5FHYAfFxg=bDt35j6B4EprfUGio=Ftew@mail.gmail.com>

On Thu, Apr 02, 2026 at 12:37:12PM -0700, Samuel Wu wrote:
> On Wed, Apr 1, 2026 at 9:06 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Apr 01, 2026 at 12:07:12PM -0700, Samuel Wu wrote:
> > > On Wed, Apr 1, 2026 at 2:15 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Mar 31, 2026 at 08:34:09AM -0700, Samuel Wu wrote:
> > > > > This patchset adds requisite kfuncs for BPF programs to safely traverse
> > > > > wakeup_sources, and puts a config flag around the sysfs interface.
> > > > >
> > > > > Currently, a traversal of wakeup sources require going through
> > > > > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
> > > > > sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
> > > > > wakeup source also having multiple attributes. debugfs is unstable and
> > > > > insecure.
> > > >
> > > > Describe "inefficient" please?
> > >
> > > Ack; I’ll provide a more detailed breakdown in the v4 cover letter. To
> > > summarize: the "inefficiency" isn't just the number of sources (150),
> > > but the fact that each source has 10 attributes. We are looking at
> > > 1,500+ sysfs nodes to get a full snapshot of the system.
> >
> > Wait, no, something is wrong here.  You should NEVER be wanting to
> > combine multiple sysfs files at the same time into a "snapshot" of the
> > system because by virtue of how this works, it's going to change while
> > you are actually traversing all of those files!
> 
> Agree, the current approach with sysfs might have stale values. The
> BPF approach holds a lock while traversing the list. It's not a
> perfect snapshot, but it's internally consistent and arguably better
> than the current sysfs implementation.
> 
> > Why are you trying to read 1500+ sysfs files at once, and what are you
> > doing with that information?  And if you really need it "all at once",
> > why can't we provide it for you in a sane manner, instead of being
> > forced to either walk the whole sysfs tree, or rely on a bpf script?
> 
> The data is fundamental for debugging and improving power at scale.
> The original discussion and patch [1] provide more context of the
> intent. To summarize the history, debugfs was unstable and insecure,
> leading to the current sysfs implementation. However, sysfs has the
> constraint of one attribute per node, requiring 10 sysfs accesses per
> wakeup source.

Ok, as the sysfs api doesn't work your use case anymore, why do we need
to keep it around at all?

> That said, I completely agree that reading 1500+ sysfs files at once
> is unreasonable. Perhaps the sysfs approach was manageable at the time
> of [1], but moving forward we need a more scalable solution. This is
> the main motivator and makes BPF the sane approach, as it improves
> traversal in nearly every aspect (e.g. cycles, memory, simplicity,
> scalability).

I'm all for making this more scalable and work for your systems now, but
consider if you could drop the sysfs api entirely, would you want this
to be a different type of api entirely instead of having to plug through
these using ebpf?

thanks,

greg k-h
