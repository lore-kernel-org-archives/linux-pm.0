Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098323A5995
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992008; cv=none; b=exUXr/C91bIoXglllHP05TxHjYTT5+s+a/UYCI9KVMFuPWgs2XfqKdSHobxRKJ8r7JeZ7cjhKTuRxD40PDDx4en3/wEGymUewqZ1P6L3Q15qpo0Kp+y6A2KJ1HtlINR5c0c3Rhrt+VLZ5Mb3XE2gQo1wu62xdqywHce15l9xxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992008; c=relaxed/simple;
	bh=VYSg/77Q+SdFkeWNkEOec2SdlPXuI9PWG8pKMZl+j3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDCnPnyOAJ5ZzILaRuyi0AGCuiJbHKOtAntK/PxjuV7TV6P4mmLamW4x0I9qxc2vaeqYQVa7a6Im3qTzniTDYxiTBBa1t8YFljVYywJr5Y94jJoy1TPu4gVTdmZxjh7fhP7Mkr24Z4sEOErOebSIVjnnvveRQjl4ytzsRc1QJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bANe73gA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bANe73gA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF4B1F00AC4
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 11:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782992006;
	bh=VYSg/77Q+SdFkeWNkEOec2SdlPXuI9PWG8pKMZl+j3M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bANe73gATYsjh3KMjUnPeUOezJIRqax3aenDmhJvfz+AVmEtiDAQcJMwc+0zRQfAP
	 54EGC9DvNucCMXfBA08DawBY8wcwSEX+8YtrTC0gFv2AU3b7cTHuKBylsfr04bqDG9
	 G2ag+7g3MWPfVs932t379t2WON9YK9tyxATxEssb3/RjLgSSj2kEAbjuFDB7aIk7zI
	 p7WfdIme1dp7su1YLbQQOkG1qZtHinUs/VBlNqL0RBIm1k/1EhoBv3dPv9wnSzq9NK
	 7LMaYDjEAn0u3664ev2jJwhzpQtnx/ZBqSIfNGATXzNosO3ZqazBVmfrUQKWQ3EIJh
	 PR9CmYuNHpoRg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb2df5cc1so1446241e87.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 04:33:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoQJ9EdgjphB6J74mccgSKCl7EBShXUEx4+f9/iBSUKOGhn6h7HF8MwQqmPhGqrJF/r3laZuxOIFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhscqGPnZMmTS+/Ib/jPV+OnGWZbPz7xbz915M9SIO+FOAvj/
	oh/06dTQ4S/eH8DjPjNLO2E4u2skdCeICfl9hi8Tqf38fgLyvRNyEHnX3hHb33VwCReONQzKyoo
	++0uWvUK/PPNKzShDpQ8v/huVDqJ+wes=
X-Received: by 2002:a05:6512:4cd:b0:5ae:b792:7f21 with SMTP id
 2adb3069b0e04-5aec68b78ffmr838445e87.33.1782992005260; Thu, 02 Jul 2026
 04:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629060526.3638272-1-jgross@suse.com> <20260629060526.3638272-5-jgross@suse.com>
 <CAJZ5v0itUVZ6=GCbRomkMiesy5uhZVWWjsUbqFqsZTyNeCBAbQ@mail.gmail.com> <akYskLix-iNOAbCM@gmail.com>
In-Reply-To: <akYskLix-iNOAbCM@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 2 Jul 2026 13:33:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hZN2SsX1uVfDuVzV=7UoHsNbhe8DUaFCaVsd-ceLvZWg@mail.gmail.com>
X-Gm-Features: AVVi8CfMpB7NssFif4b5GLRbtyknf5VfY5RNjQktihRoZDbdR6kB2YT4BQb_uxI
Message-ID: <CAJZ5v0hZN2SsX1uVfDuVzV=7UoHsNbhe8DUaFCaVsd-ceLvZWg@mail.gmail.com>
Subject: Re: [PATCH 04/32] acpi: Stop using 32-bit MSR interfaces
To: Ingo Molnar <mingo@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 11:17=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Rafael J. Wysocki (Intel) <rafael@kernel.org> wrote:
>
> > On Mon, Jun 29, 2026 at 8:05=E2=80=AFAM Juergen Gross <jgross@suse.com>=
 wrote:
> > >
> > > The 32-bit MSR interfaces rdmsr(), wrmsr(), rdmsr_safe() and
> > > wrmsr_safe() are planned to be removed. Use the related 64-bit varian=
ts
> > > instead.
> > >
> > > In processor_throttling.c drop needless initializers.
> > >
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> >
> > LGTM overall.
> >
> > Do you want me to pick it up or do you prefer to route it along with
> > the rest of the series?
>
> I'd like to keep this series together if you don't mind, so that
> followup changes can be done more easily.

Sure.

I will be assuming that tip will be taking care of this change going forwar=
d.

Thanks!
