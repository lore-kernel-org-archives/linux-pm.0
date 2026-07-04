Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EBC39B495;
	Sat,  4 Jul 2026 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783153584; cv=none; b=OBYdXTpwanoTaf2EA3zQbfh6n4HUeQGKmIq6sHyADl0TdEq9Z8yvw3EKWW+Au+c+rqtxo9kadmeLYZpaBsBMZZukds0eAdkEaP0rv6RDefZ2E7+gWGNHHi4DnIJEzujbdfmiAiCHvOMdRJACkY7VmZxYEw01OOKSCO4oLsuS/XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783153584; c=relaxed/simple;
	bh=3TeTu1c65p//hAl/acEkiXvKi70nGAQHRtmMzw+0Za8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2IAGNKLXa+A+5XXbwI/6xI+OVGYeG68QYvhE+xuBUNR7AtSxoYCF75UXyVquei3CBxz1wfsN2OWcrE/6WOBFtYYmAVAzrljyg9hEsY6jPsSwFIP9nRrA6JtksEuu80qiKE8PiBdxMFjE20t9536b0I362/4b4y5Xzp8DrdE8I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiZWi3XP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiZWi3XP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A811F00A3A;
	Sat,  4 Jul 2026 08:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783153575;
	bh=sAbsP7fA1JbHaXOTRwhW76KYquSFRmAAWWtSRo9SlJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FiZWi3XPZoqa6eplwqwPpbWAh3yU6Sv6z3QWLoH8sbvCMu4407KK0BNeuT/NcRrDL
	 vuPuXc2fW0mIkD1KTl1LkMln1RDnHAhidkRNK61NjF9EShlnxKSMS4qovFa/9dsbiU
	 kllOgypCEOtF486AMiP+0BgeLP6b1l2pIlLS/nOjkJqeuQ0b3rWEqzAhNWe123hFHO
	 vfdY7QKGLdO7E//2x4gxXJ2KFn0YLgPMPTcxBr+9PbjTsfuHuCpax8eRFGzj9BJ2HG
	 O+1hfdSMme/i91YRtFOKFVrDwUIpEm7Xy7GWLWE6XttVU2bdonET9gbQRa+F/WyqkC
	 bTw0Q1S9lx9hw==
Date: Sat, 4 Jul 2026 10:26:09 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 04/32] acpi: Stop using 32-bit MSR interfaces
Message-ID: <akjDoZnJsZNxE1tg@gmail.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-5-jgross@suse.com>
 <CAJZ5v0itUVZ6=GCbRomkMiesy5uhZVWWjsUbqFqsZTyNeCBAbQ@mail.gmail.com>
 <akYskLix-iNOAbCM@gmail.com>
 <CAJZ5v0hZN2SsX1uVfDuVzV=7UoHsNbhe8DUaFCaVsd-ceLvZWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hZN2SsX1uVfDuVzV=7UoHsNbhe8DUaFCaVsd-ceLvZWg@mail.gmail.com>


* Rafael J. Wysocki (Intel) <rafael@kernel.org> wrote:

> On Thu, Jul 2, 2026 at 11:17 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Rafael J. Wysocki (Intel) <rafael@kernel.org> wrote:
> >
> > > On Mon, Jun 29, 2026 at 8:05 AM Juergen Gross <jgross@suse.com> wrote:
> > > >
> > > > The 32-bit MSR interfaces rdmsr(), wrmsr(), rdmsr_safe() and
> > > > wrmsr_safe() are planned to be removed. Use the related 64-bit variants
> > > > instead.
> > > >
> > > > In processor_throttling.c drop needless initializers.
> > > >
> > > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > >
> > > LGTM overall.
> > >
> > > Do you want me to pick it up or do you prefer to route it along with
> > > the rest of the series?
> >
> > I'd like to keep this series together if you don't mind, so that
> > followup changes can be done more easily.
> 
> Sure.
> 
> I will be assuming that tip will be taking care of this change going forward.

Thank you!

Can I also add your Acked-by to these two patches:

  [PATCH 01/32] thermal/intel: Stop using 32-bit MSR interfaces
  [PATCH 02/32] powercap: Stop using 32-bit MSR interfaces

? They both look fine to me.

Thanks,

	Ingo

