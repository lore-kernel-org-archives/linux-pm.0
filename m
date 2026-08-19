Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85B47D95D
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153631; cv=none; b=CR2S3O33rCATqRGAHxLHaP43+r73zkFSrnf5g9a8pa7h0a3E0vuY8tFQ5lcA6+URIpxVbvVxtKHDKYrQD1dVk0zgEzYqkXShplZRZz6iT0ZbsaSOP5UBKS1Jy97zUHYUsdhB5Ghn/G3SwX1JMYKbGfs2n8vjmAKny0FlJQ6LdCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153631; c=relaxed/simple;
	bh=4Yli6tecyJEHplZwFU9XXAL6o7x1WGOP/NVWujBjOgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hC/YoepcLTIhSlsdcQCNnxmQHBhhV94napcPwgctH1uuZ6DOfJJGx2QggcVSbZ2OkTYlrw74dWmprS8yGaoDVs5qR6xTVtb8mFEBghk4+r3rwDb3ylyu56x1/c2ilEs5TxytjGXORiqmT08PthBr6lEvXwJlci5/Ugg4Ny59AsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XU/cVw0+; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XU/cVw0+"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848474825ffso11912b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787153627; x=1787758427; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2FvzDQHxVaueg4hvKJpjDuB27Njlxwegg3SIxYd2Fg=;
        b=XU/cVw0+p9kAqaFFKwNtFk5zq0mOExFboyZMXzRqehxsK9WIfnOCnZxYAx+4Wja0eO
         jALKjzpL9AQ2UaqtpGbejqQfbePzO+q+jc4LYfucU3awBgHzWGILbkmSswwY+VAm1pi2
         UKGgkkcpSRYp8GQotWZUdF8iJeMFfwPYy1uaBpIvbtBkcMlacNxcO+Zo3yoYJ2b+sOZY
         jHtIoadd+n/Fh1q7zG4wZkFxmqMW50IjuVPPaoEZ1nhnUGcL9GnWueT8Ir3SzKuhkSXK
         yfyjsZJxqyA5ar+VOfZRzNPZLBgOKY7GvvTrrJ8jE2iLPZY7R0jBRGj2qpfq3Cpe9UCN
         x93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153627; x=1787758427;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2FvzDQHxVaueg4hvKJpjDuB27Njlxwegg3SIxYd2Fg=;
        b=b1tRcJ5uxeVPhapLsh8ER+JApdc1ikFePauOUfuC/iyYb+E6K/L4qAIPkiqz1n057s
         6J5WYANSVgBp8FTH1cTyP45avM5CWLrsZqNpAGmhzsacCbFkKN2izStZGq8Hb8V6agWq
         9pQc1yPw/U+Q+UBNi33j7jf8qaMzQkiDxAeMFji2eQV+H6PcH0IkE5ZLuJFzZEcPF5VS
         5yL6sg1xqDbO6hbNYkl7JaPz2QmuSeFHUGYkdz+ff3wmYQcFyh0nsvwU7GJcMg3Am902
         /0q9B7pMkgOHA8HYoc0o64jF13xjkQW0VoU+a725rYwEcuRMS1VY7C8uhsmafUQnlX11
         8GnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpA+ifHSa1J7d/Dko393ZAQtGXGCbvtmzFF6BnWxlic5cewSjdoTbCsxRQcg+N7OlndDXT1QFSO6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2cp82eUB11Mu9ZL4/90wuoYgRsDV3mD/tviiyA9cGwOZaeVj
	A/fCnI3Z9XybU1fPghp+HCHpsHyA2HQ+GL12lky+jNnPHKMLMtE/m+LZ948XqW5+2xOrEHpJMQr
	KBhjFDg==
X-Received: from pfoo3.prod.google.com ([2002:a05:6a00:1a03:b0:84f:df8f:5a90])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2913:b0:84b:9a69:156d
 with SMTP id d2e1a72fcca58-851df6dc419mr109732b3a.0.1787153626373; Wed, 19
 Aug 2026 08:33:46 -0700 (PDT)
Date: Wed, 19 Aug 2026 08:33:45 -0700
In-Reply-To: <bd9e5b6e-07f2-459d-bca6-e290585060aa@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819102314.1499258-1-jgross@suse.com> <bd9e5b6e-07f2-459d-bca6-e290585060aa@intel.com>
Message-ID: <aoXM2f1YTwgVj8KL@google.com>
Subject: Re: [PATCH v2 00/13] x86/msr: Drop 32-bit MSR interfaces
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-ide@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	kvm@vger.kernel.org, linux-edac@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, David Airlie <airlied@redhat.com>, Helge Deller <deller@gmx.de>, 
	linux-geode@lists.infradead.org, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Pu Wen <puwen@hygon.cn>, 
	Tony Luck <tony.luck@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, 
	Babu Moger <babu.moger@amd.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, 
	Guenter Roeck <linux@roeck-us.net>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Artem Bityutskiy <dedekind1@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Ashok Raj <ashok.raj.linux@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 19, 2026, Dave Hansen wrote:
> Hey Juergen,
> 
> These look great. Thanks for doing it!
> 
> The only wonky thing is how we're going to actually merge it. We
> obviously can't do patches 10-11 until all the "stop using" patches have
> been applied.
> 
> I obviously 100% realize that it's during the merge window, but any acks
> that the maintainers of 5-9 provide in the next few weeks would be super
> helpful. Or, if any of those maintainers want to cherry pick their
> subsystem's stuff out of this series and apply it, that would be great too.
> 
> But, the last time we did some MSR function munging, the tip tree
> carried most of the patches. I would expect we'll have a repeat of that
> here too. I'll pencil in the idea of just merging the lot around -rc1 time.

Note, patch 12 "treewide: convert rdmsrq() from a macro to an inline function"
is going to conflict with the KVM changes for 7.3; kvm_access_xstate_msr() is
getting moved from x86.c to msrs.c.  Somewhat surprisingly, AFAICT that's the
only conflict with KVM's code movement, so it's probably not strictly required
to send a new version after the KVM pull request?
