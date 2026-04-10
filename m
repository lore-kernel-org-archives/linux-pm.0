Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B43E3D8C
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844580; cv=none; b=DOLsaUJAeOsaCRNodGXR2IiD2lHrN5TGKjtJZRW4uosDJMnImOke6SUUSk2+eaPWbn/8iBhRXElMMJZBOKHVCMV1h4W6o13QWJGXqSUvit1/saAKP5+S+FY8ZbnZqjo0M4csd6FnnaJzpAwBv0msX2KLz0cBjeNZ99RVYUxW71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844580; c=relaxed/simple;
	bh=NpoNTpXLTuMOAT0YbuNUcfCenF1RdyeJP6LTpTrDukM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6oFJ/BGQvaW+sOZsOMW9j2WEXdsJeAx6eX1lh0LZOT5C22uf7adNFz2cvJMq4JBnE+ALq7ZWeocuNLW1GIFufgCdNcfzmOb91PDokDnW7IjlFUz79pY2Zi6Hgw+wfoXI2l/GQbCgZB6y7MTk+e/I3u9iNFgf06zflc+92vID64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY2JNmw4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY2JNmw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F53C19424
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 18:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775844580;
	bh=NpoNTpXLTuMOAT0YbuNUcfCenF1RdyeJP6LTpTrDukM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SY2JNmw4elpbtDC3dLY50kjXCwhclzwKmvgZPJBsRxqQeckTbaFnUaJYtlX1IQ2iQ
	 ds4YerLo6S1zOyI31MzKbVrzLIVg3yru6ngu/wivls9ctZec8Up5UrzTpfZvXB19nk
	 36Kpuh4jTzg1R3Fg9wAy8rZgSO9uBgO3Rt17sUdqr01u5p1/II+mfKD0CYOy0AFGIe
	 VXop4uuX866Clyyg3r7fDqWtUvdc/62Gnz5Z1dGvWKuK0AH5ZaLRUhZizd2WMD0evq
	 t2ZMYsT8pDMEeikG8jqCw982uz/bKM2CVtif+jW9MpvUQxH6CmkWqAHtjGJlWl390I
	 WyVFAbb+GfqYA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66bd4f7b2d3so2627648a12.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 11:09:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YxXw2LHRRslsA7uL5GKHrc9mtJxi+gC4bjjiXtjJg/414iIMwKu
	lDAbb0Vyf/ZmOfbMcalHNoHBD2fZfgz/wL9GML5FMIG5R5BpyK1gT5K0hIMnGN0Uz0Ibj8+f6si
	7z7Y73mTC2xbLspc5wRunEZacSkfU0wo=
X-Received: by 2002:a05:6402:5cd:b0:66e:aade:e2e3 with SMTP id
 4fb4d7f45d1cf-6707a18ed01mr1854266a12.27.1775844578914; Fri, 10 Apr 2026
 11:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319140307.441950-1-darcari@redhat.com> <CAJvTdKmLA=n07hkkXLbwMex-_Byji9EOy7wkkFHrcPCj8tzMqw@mail.gmail.com>
 <CAJvTdKmepvPzWDM+6s9YERe27H6pSKbDb62yfpTSs57hWsEmRg@mail.gmail.com> <5ec684ae-b778-40ba-8a10-dfbf274da7dd@redhat.com>
In-Reply-To: <5ec684ae-b778-40ba-8a10-dfbf274da7dd@redhat.com>
From: Len Brown <lenb@kernel.org>
Date: Fri, 10 Apr 2026 14:09:26 -0400
X-Gmail-Original-Message-ID: <CAJvTdK=CoV7L1FmeVUTAO=U7eJQevjUnqr-CPk2CDxAO4zu3Ug@mail.gmail.com>
X-Gm-Features: AQROBzDzelpF6ozoMHBYO4l7lKfkjWuJSivuzqKEOYz_iZeRmi9uJZOBMqmEYPE
Message-ID: <CAJvTdK=CoV7L1FmeVUTAO=U7eJQevjUnqr-CPk2CDxAO4zu3Ug@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Allow execution to continue after
 perf_l2_init() failure
To: David Arcari <darcari@redhat.com>, dapeng1.mi@intel.com
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 12:06=E2=80=AFPM David Arcari <darcari@redhat.com> =
wrote:

> I'm using a Fedora kernel:
>
> vmlinuz-7.0.0-0.rc4.260320g0e4f8f1a3d08.40.eln155.x86_64
>
> And turbostat is:
>
> # turbostat -v
> turbostat version 2026.02.14 - Len Brown <lenb@kernel.org>
>
> >
> > You can poke with "perf stat" as well, but this will depend on what
> > .json counter list is compiled into
> > your version of perf.
> >
> > probably a first sanity check would be if these commands for the LLC
> > and the L2 work:
> >
> > sudo perf stat -e cache-misses sleep 1
> > sudo perf stat -e L2_REQUEST.ALL sleep 1
>
> # sudo perf stat -e cache-misses sleep 1
>
>   Performance counter stats for 'sleep 1':
>
>     <not supported>      cpu_atom/cache-misses/

I think this should work.  There may be an issue either with
the perf utility or the perf kernel support on that system.

I'll cc Dapeng.  Already the weekend where he is, but maybe he
can give us some perf insight next week.

thx,
-Len
