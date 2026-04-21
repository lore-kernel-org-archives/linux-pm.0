Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337B26C39E
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789408; cv=none; b=mjok4MXC6gqE06DmUGPXRTxYClvKFvVOkFCMsgV5uiYsFRGGuplFXFgSHp8ZtyzD+ok6DKn5oVHIOro8EXWIRTFPnT2n9KpKQfVmPHOjg1WSRkpi2DcLoa6eoSIIJXSTiss26UUO4ZT5yHKbOoC1UUPpLcuHO6LYb/PWHw/iuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789408; c=relaxed/simple;
	bh=RbE0e0q9mMHN0z46/U0LNMsuOexV2rc1KTRhEwi6lkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pZ2m1FaJ/8KVDjDdS429e8KfZ4dehE+pPJqlBUxAA18i5qCccL9pIHYqHukLYs4MK5JaJ+Wazl0kz+HpzC1RXPVxmLNpqpczIqAfxw3Hasqby4ipPstvrL+IMOXEGqjTRXvXk9wXEvufLFtjiboINiZHrxxOjPdofuSUAC+k8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEQljvaM; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEQljvaM"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so3885235b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776789407; x=1777394207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wIUrNdIXF/OzM+8I4bF+3IsDchXtCAl73sYtHCgqt6w=;
        b=kEQljvaMzSsuBYc7WFDw32+/wU3/8C6TEkpmPMGX0tK3k66uJ4/xhCTSTzrrxDDyo6
         zVZxTAaXAlSsc5P2o0WjAOos2J2DmQmZ2mAotevMYZoA4DBXyapYN0RuJAzrECwQQQS0
         OmDMGI2pGLMeXHHaEnbgEESI+U9LFmzyy+H9Wy/FgtZnUK2GSAOzkWifZtBzDJJc/F3k
         HXptz914GyC4GXmQVphFIOALxrwXD2wOH3Cbyv0AOgYPdzNlDQ2o9L3ECw+p2mZwUeup
         JjdaEfQ/18ly+jtAgfodffLzMk7+EOeO5RTOjCCo46gron5/MR1i6ktCfiSepkS4Kj2H
         W3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776789407; x=1777394207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIUrNdIXF/OzM+8I4bF+3IsDchXtCAl73sYtHCgqt6w=;
        b=I+Z+g0aiGNk0uTOMV63eNNc2qgkbQYqZZT5XYpUmAx0UuLigS5MJbD4mav4HEi7Hir
         pwye1+T5+ZGaN5nRFICjl2OxWYQqk3wJLxuTXjTsihzX4vx8u5Rqny8IeQj5BEmhrkPv
         3IefYRDdwGkVtpzJF313vgaB3k+cxoFP2joV6facXrhCMQFUElcfHGFoL1P7jpmkxAbe
         IFBjHpCLb9HbBXf8EUeQ8h4lj1Bb5zsJ3RepCXVEqQJ9WqD0/lYaU+zXBLI7PsLzA1FR
         CgPp0f5vPvVoI/DfaXappqGkORBf4TpzjACRbvYBtP1iVh8Xf696tLxpR5pZY/IyutlW
         0+Ow==
X-Forwarded-Encrypted: i=1; AFNElJ/9NwuLawgz4wTFe5eU/fnfFehgtNjyerf8r9rN9rB+s0dKUOKIdp1lWBcOfauu4sh9v+TvD8L9Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRgp+ssi+GE/Qh3RBV13yuEZQ6GFdLvI97DTvgQ1XeaPklWyDq
	5rsQbQHQuWha4BgCozNr8Qz4CDbAGuZolkF6uKpIePrkRWGcMsx0crA94PnE1kfN3n9DvXefQUp
	hN//N8Q==
X-Received: from pfde6.prod.google.com ([2002:aa7:8c46:0:b0:82f:20ed:8059])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a247:b0:82c:1cd0:2f7e
 with SMTP id d2e1a72fcca58-82f8b553974mr14884576b3a.20.1776789406330; Tue, 21
 Apr 2026 09:36:46 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:36:45 -0700
In-Reply-To: <aed88qcV6PjEIHnd@lucifer>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410151746.61150-1-kalyazin@amazon.com> <aed88qcV6PjEIHnd@lucifer>
Message-ID: <aeennZlV60k81OBf@google.com>
Subject: Re: [PATCH v12 00/16] Direct Map Removal Support for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Nikita Kalyazin <kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"corbet@lwn.net" <corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "vbabka@kernel.org" <vbabka@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "riel@surriel.com" <riel@surriel.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"coxu@redhat.com" <coxu@redhat.com>, "ackerleytng@google.com" <ackerleytng@google.com>, 
	"yosry@kernel.org" <yosry@kernel.org>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "tabba@google.com" <tabba@google.com>, 
	"prsampat@amd.com" <prsampat@amd.com>, "wu.fei9@sanechips.com.cn" <wu.fei9@sanechips.com.cn>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"gor@linux.ibm.com" <gor@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"thuth@redhat.com" <thuth@redhat.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com" <urezki@gmail.com>, 
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>, 
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>, 
	"jiayuan.chen@shopee.com" <jiayuan.chen@shopee.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"pavel@kernel.org" <pavel@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"yangyicong@hisilicon.com" <yangyicong@hisilicon.com>, "vannapurve@google.com" <vannapurve@google.com>, 
	"jackmanb@google.com" <jackmanb@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	Jack Thomson <jackabt@amazon.co.uk>, Takahiro Itazuri <itazur@amazon.co.uk>, 
	Derek Manwaring <derekmn@amazon.com>, Nikita Kalyazin <nikita.kalyazin@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Lorenzo Stoakes wrote:
> On Fri, Apr 10, 2026 at 03:17:47PM +0000, Kalyazin, Nikita wrote:
> > From: Nikita Kalyazin <nikita.kalyazin@linux.dev>
> >
> > [ based on kvm/next ]
> 
> Hm, given this touches a fair bit of mm, I wonder if we shouldn't try to do this
> through the mm tree?

Yeah, when the time comes, the mm pieces definitely need to go through the mm
tree.  Ideally, I think this would be merged in two separate parts, with all mm
changes going through the mm tree, and then the KVM changes through the KVM tree
using a stable topic branch/tag from Andrew.
