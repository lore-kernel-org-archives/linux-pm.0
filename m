Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF163B2FC7
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371977; cv=none; b=dOkouvbWWzA3gRFBVqpjxhE2yeWXEM8AqV+ZMAJHZ9n19Nb+SYXZ46YyG8cmV6YYVbEwXmtHYn5AyMY4R5Ooixj8d/ENUe05Y/VGXgB0kaQ7HLSdPH/rcj1wTPRX2hEpWBNPVeAxh+r/iZyb3qxh8FlJ6Buppj0HCyY8uz0yYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371977; c=relaxed/simple;
	bh=h+4NVJo3wpAjspHwkhwsyzZn+zEl2CEEOehXzRGNdBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rb6AStXAjwInma3+fw2/SVmSBWCS4J8A2ersYXTqkvlVDSsS9WxxDg0nh9d+BTiTXJvKZuFNZntOt/38XODFqMgzzhYQOi0ZEfXu18T38AIxiXezv7LMk3wF5PjNE1CotpNh7FvYDEo4Wxf2kOp1i6TmVw+Gr0VtlMH61NjXGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jodHEZLM; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jodHEZLM"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c829366cf25so9100252a12.0
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779371975; x=1779976775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqeEG6FXEKElqAGUt/Z2qfbIbuB++N7b4Fh1Zt6D5dk=;
        b=jodHEZLMnrXvcr0U+8aiQ3+8HMthO764B3RtgzEf+7ztkCNfkmkIlQBTfUmc0CO1Gm
         znKHCX5+9bAECaG80vh/IPP806tKIqZE2l7HZLe1YU0HCE1c+TVzdByotFkWkoU+YEws
         qLgdufxQuD2gsyG2s9NK2v18HBYBS1w+SMsS+Qi6jr0LEmhA4R7O7tZpYus8VaPMyFeG
         15VYXBj+eYi7/OswJ5AioWab2qhZVYFRjyf4SpApvc+UkSyiNxbsaWg55EmuzRTPh+T9
         X183BhHSUrQrVCzdTIOykwkJ84D445JXsSdEAvmO37Cr/WfIjw3mclOhGc8OX4c80G1x
         Di8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371975; x=1779976775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqeEG6FXEKElqAGUt/Z2qfbIbuB++N7b4Fh1Zt6D5dk=;
        b=DxY6yRRegLwi8G2MiNDuVPE+zR4iOcqr8oYM8HmQ7GRK2axUY2fGW+IpZfsvAgomKL
         R+Pg4mgpVeCHvLMQWGxApWBXxzhrV5eRMhEP3Sl3TAx28zYP2yO2PO2L8ltl2hRjLboA
         nBmUFnltcvHLoH6YSh6BYfwch2GGco7CWzPaOmj2xwHpZeh6VZGqvHogu+HjaeNFKqYr
         ATKxk0Z0XMKo2TBRN24ecnXOqZPsFjgh+kHCyCUnk8gPHixWTNSqw7ltMpQhXdWM4tgi
         cT/iq97FUx6utCPs3TCSw4JY9KRD71VsQ00ZTrullrZbNVjdKR8ZLY4cvyr4ZzEBuS9F
         XvBw==
X-Forwarded-Encrypted: i=1; AFNElJ9DxCejhS6nwa2mREi/AMsF5ur9lOdeGFyJ5t399U3gNXZr3hUSqP6FAh76jkwX9P7YVFkhx//IEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/HOTbawsyNVcZAA9f4IPwg31QGS1UYex3+YrN3evVQOtdO5S
	DTKXbKLaxIbc6qmeSB7UVj7D1xG5OzRcJu7HVhclNG59FAd9vWRBnROBUX+lr67Kc/+ijT7BBi0
	oLjqytw==
X-Received: from pge1.prod.google.com ([2002:a05:6a02:2d01:b0:c79:83b3:cdf8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:431a:b0:39c:a78e:dba9
 with SMTP id adf61e73a8af0-3b308ac1b14mr3725831637.40.1779371973881; Thu, 21
 May 2026 06:59:33 -0700 (PDT)
Date: Thu, 21 May 2026 06:59:33 -0700
In-Reply-To: <20260521133326.2465264-4-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-4-kees@kernel.org>
Message-ID: <ag8PxTTi5NxT51EW@google.com>
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	Petr Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, 
	Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Eugenio =?utf-8?B?UMOpcmV6?=" <eperezma@redhat.com>, Jason Baron <jbaron@akamai.com>, 
	Jim Cromie <jim.cromie@gmail.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Kees Cook wrote:
> Using Coccinelle, rewrite every struct kernel_param_ops initializer that
> sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> for example:
> 
> @@
> declarer name DEFINE_KERNEL_PARAM_OPS;
> identifier OPS;
> expression SET, GET;
> @@
> - const struct kernel_param_ops OPS = {
> -       .set = SET,
> -       .get = GET,
> - };
> + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);

IMO, "OPS, GET, SET" is more intuitive, especially since that's the order used
by DEFINE_SIMPLE_ATTRIBUTE and DEFINE_DEBUGFS_ATTRIBUTE.
