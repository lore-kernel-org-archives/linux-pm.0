Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091E3AEF46;
	Wed,  1 Apr 2026 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034937; cv=none; b=jXFEG/q3Xwz90NPp7bP6JofniNqjIVrFDCdMS3848sWWhJjHAT9+BtQLDkPbx1w94CCfd0nJQa1i9c5rqGJXmm+n60LUN73Dgeoe1WPw1ASNIkeYjWl4qav0augjX9uEuSZwDnEl/29NucsHDTl5aSu5/wkRE2Kf3z5W+T3P51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034937; c=relaxed/simple;
	bh=MbauUPQspJHR0GdLliIx6BVUDnFU+IiADRZGVQ9BaLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG3a+gqqXNogx1GbCCB6mNVEDBi9AMeU+1wFlNHifHdLFiTX7TVKdxvk4RSgjiHX7TB0TJviJ4dlsiafUZl2ke4cbASYC1D31M7/6yFXfCHl0dyrjGz5VyaWMAsXJYZP2YjdqpzJ15viABgqsFJf2sogm6KNzPZZK4PafnzmxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=caXwpaGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="caXwpaGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D41C4CEF7;
	Wed,  1 Apr 2026 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775034936;
	bh=MbauUPQspJHR0GdLliIx6BVUDnFU+IiADRZGVQ9BaLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caXwpaGNnldVX3yT6hRRLXMuHUQyLW4rE5/5s6B84MRWQPwO5NhUC/T8Vsh89mYtI
	 3XEEOyqcPrXCQyPDFa3qvbzjAX/Sj8gFJrw6IJ7ogLb2Xrym9+WVxLcAAgcPnbKBfa
	 5qx0C2z61tC0sZKXFLpaLLVAOC3O/HzauiW4VKmE=
Date: Wed, 1 Apr 2026 11:15:34 +0200
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
Message-ID: <2026040136-ocelot-simply-8981@gregkh>
References: <20260331153413.2469218-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331153413.2469218-1-wusamuel@google.com>

On Tue, Mar 31, 2026 at 08:34:09AM -0700, Samuel Wu wrote:
> This patchset adds requisite kfuncs for BPF programs to safely traverse
> wakeup_sources, and puts a config flag around the sysfs interface.
> 
> Currently, a traversal of wakeup sources require going through
> /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
> sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
> wakeup source also having multiple attributes. debugfs is unstable and
> insecure.

Describe "inefficient" please?

And if you really think that doing an open/read/close on a virtual
filesystem is inefficient, then I have the syscall for you!

I've been trying to get readfile() accepted every few years, looks like
I last tried in 2020:
	https://lore.kernel.org/r/20200704140250.423345-1-gregkh@linuxfoundation.org
but I keep the patchset up to date in my local tree all the time.

Would that help you out here instead?

> Adding kfuncs to lock/unlock wakeup sources allows BPF program to safely
> traverse the wakeup sources list. The head address of wakeup_sources can
> safely be resolved through BPF helper functions or variable attributes.

Who is going to be calling this?

> On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
> speedup (sampled 75 times in table below). For a device under load, the
> speedup is greater.
> +-------+----+----------+----------+
> |       | n  | AVG (ms) | STD (ms) |
> +-------+----+----------+----------+
> | sysfs | 75 | 44.9     | 12.6     |
> +-------+----+----------+----------+
> | BPF   | 75 | 1.3      | 0.7      |
> +-------+----+----------+----------+

150 sysfs calls in 44.9 ms feels very slow.  but really, what are you
expecting here, sysfs should NEVER be on a "fast path" that you care
about performance.  Why are you hammering on sysfs here?  What HAS to
have this type of performance?

In other words, what problem are you trying to solve that having access
to 150+ sysfs files all at once in a faster way is going to fix?

thanks,

greg k-h
