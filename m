Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D7218BBAE
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777125; cv=pass; b=BaKc+t1vlLZyKXND0CbOsv+JqlCjjVTpqzdsQebubydufTeo8vTSGHzZ6oZlwqhx3UM25ZAHpZeI7AAc0OtVEAsaf/E6RCHmE2gdVM+8ED8/mZIWlEjrK7sSUA0I7tqPC8H5AXmN5cuoHaEJQULgUw3c8UodaIFae4NM2HW9COU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777125; c=relaxed/simple;
	bh=PmAIcppCWJmcGf0UnWT1GlVwFgygixvvwcZwvNaEkWE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpto/vFDUCXGMgu3aC/ERz2WWqwiI93qMMQY1kZfEfoHQKi2awNCOqj5BgPznCp/JRl+yXzwb5+4WsLlW3cXBvj6EkNI35PyZBvAUG47sleS/VfW4zE5nJGL6Cb9TbbpMBmz+W+LSf+N1CtB9aWCHWqHgnM7MYZwLw3yS7FL4Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFtvQD1R; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFtvQD1R"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56a8e0ea02aso7290760e0c.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 09:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778777122; cv=none;
        d=google.com; s=arc-20240605;
        b=cPzAlRBmb6s5BHwi9qN6If9a1U6jalg/EafD9UxIgJMP4l3lEfGTn6kn9xkbUVdYvG
         NefyeRt3AAPeaXnP96cT1uJHn4JIpeZ+Z6lykNxOUcE+fQKog+NydnpzKPqupZQ5gXu6
         /1ENLEmNokp3LDc+4qaCnaQIbUL6cMypBbrXphQzMwvgQZXQqonCUM0fxu82UT+za6QS
         xQFZK/1U/21H9ymnU8ivi1He5DxoTIVAeRFKQLa0GOycMQjn9OoZ7yhbH3BaluLrw0e+
         MVc9tw2FHX86rz23MqPRH04MirmK97NduLnb41zo8hw89wkp/TpICQMo5Z3WMezvIHRj
         ic9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=os0eHsZVJX0chVl1RmCC7RjaweXl8YpOUWjuIOShXWI=;
        fh=Cj5irtRZ6zm+mY8HMFx/WahCjv5T5Y+e0JFtVhQ5f3Q=;
        b=kLtR0S1kVIW4wyk3jHjYRmyd2TbSvA6zSKeMQRQyUxnMUdZu6rHw+Z4UIQLm/xn6Mn
         p5qM/YPbJtojCyFnBVe7vD3kmMXzHU+wrCV2rPvV5h86W7k2FSqIwmxd4oNK8paKi5Dp
         QfPEriPo3tRkvOgjkPQ20AAypjsjo6Xy5qYx3m+v82Xrf2V4YMsDCMbuNW5adABxLH3W
         /PvNMTAqcKV0L9Z0ufWuid9IV1+Bqe5SssCDalDcBM53NvVr5hziVThIOe3qOhE9ldQN
         lBpQRUtDP/c4vcafyFfbwquCOBHHRDanOXF88um8ehSsM6yEkfvDRkv0I6h2pU+mKglT
         8JGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778777122; x=1779381922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os0eHsZVJX0chVl1RmCC7RjaweXl8YpOUWjuIOShXWI=;
        b=VFtvQD1RTdgqWEX8R7rJ5E+lG6jtu3YV71KQieo9tFcPnVu8X9ckwARGLw2zVJUmRv
         4QnKB8BzYAXDs9qtMf8+fVr5c5p4LaTpFMbopxQuEUAbBz8WjxBGCFaJEeQUTFzqVaur
         UvDfEH9PsiCLOC++9gsqSYnngByVIIggErBVF/tG3vYFcPIzvcw0H1fill+TMfu0EpA/
         Z7CoXdN1wcK6GMibXBW5zW2q1rznvEEYPUBHmt1sT8DF/5UMSq8tNiNC+dKvATeBFRON
         iAttSBSTPdQXLV1iwmET0wtHGCPj3tcDp1ikzcx9+oKlzGhMAXUazhajmAQG4TnppxAe
         4iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777122; x=1779381922;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=os0eHsZVJX0chVl1RmCC7RjaweXl8YpOUWjuIOShXWI=;
        b=q+w1PdJrE4bWbltDJQmBwFG4nwWTzykWgs5pI8/bR2OPVzxuMkg1LKsZE8aLEgxuSz
         tBctX2aeVcvPUc0lPej7DY65VpM40P7jTO6K6wBn9BwlFveWrL3BMDZUAvLbfn28rDjB
         dhX1+Th7pB6VLiGGa7Mecs45roS4suII/PXIQ0lVHqci0uCgj7pk3f5jOXj53bPWXR3o
         9hLPF/SAUTF9CsBu0Z2iWNdvaJHCHNntfNjab2u2vfYl+R1JVEJAvOem5spDE7gTVauR
         p7/l/snKuAM6fIDZSQU/GJ80+ToW8eAprbVjfVuLlyWRzN47bWJC/Iq3ZXW+yEMlULUB
         jCXA==
X-Forwarded-Encrypted: i=1; AFNElJ/Dc/9yNJjp0QnPLTcYzMVS88BeK4gR5nRJxsPbLg6MNMTwIyZ7lGG79R3YAuOLTthUNQzPk1WzVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZEN6l7A6pAs0O6323VQTF+EHN4ub9dyj0JdKXt6upxKmMlTx
	OVNdGMgbm24LOfzTtICtUJBfbZJ2z3/CIzutDX8kLA6eNiWC63Q8UPs+hqUE66fWumy3UlXYANM
	KKHvrzl0V3Y0Jbe3hoJRBk7irn6OP5J9YmPgKwLjs
X-Gm-Gg: Acq92OHA65qFeMoXoicrqXh9NZ50gpUouEhMUypyc4p8BxoFL2a2tJW48JCuWMX8nW0
	7krBgxL0++t1rI9qpzEfZFfmCfycfbznXVXZfWGnM95CofyxftwonBI73l9ejPDlbCb0dGiBf0y
	tE7ugKB415nd6n9H1Rk1+8OgoAvdizbYXlFrRKbjOkvY24B95tGqMimT+QWSarIFTB3DQTBpFNX
	f4xkFlPYBFtYUHLzdKTYrpv1wzhLYGFVmHPLCNizdM5PD3LRIMPAJQRyqV8dE2BOlMXpr6ELNP3
	p5wzyTxpiDPM/H/aCP39l0iP2MrNc9OkVjOYqId5xmAqVlw3Cp7oeMcNUv2gh7tJg/aqosUqaZk
	vENXq
X-Received: by 2002:a05:6122:1814:b0:575:178f:62d2 with SMTP id
 71dfb90a1353d-5760c092d3cmr165926e0c.14.1778777121451; Thu, 14 May 2026
 09:45:21 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 May 2026 09:45:20 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 May 2026 09:45:19 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260508081812.12345-1-itazur@amazon.com>
References: <CAPTztWb67XZvfcMVnbegDNNW0LJa9UsaTGx3M898xJUJrekk0w@mail.gmail.com>
 <20260508081812.12345-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 May 2026 09:45:19 -0700
X-Gm-Features: AVHnY4JqumP2VJstFZ-DobQ0sDmpWwtOhYCl663Ih2m9TKxeTUM0glktONR3Yps
Message-ID: <CAEvNRgG07EMrx-SpMaO3gHmdGVwOb75XNy7_RARBo0chidn7Yg@mail.gmail.com>
Subject: Re: [PATCH v12 10/16] KVM: guest_memfd: Add flag to remove from
 direct map
To: Takahiro Itazuri <itazur@amazon.com>, fvdl@google.com, seanjc@google.com, ljs@kernel.org
Cc: Liam.Howlett@oracle.com, agordeev@linux.ibm.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, alex@ghiti.fr, andrii@kernel.org, 
	aou@eecs.berkeley.edu, ast@kernel.org, baolu.lu@linux.intel.com, 
	borntraeger@linux.ibm.com, bp@alien8.de, bpf@vger.kernel.org, 
	catalin.marinas@arm.com, chenhuacai@kernel.org, corbet@lwn.net, 
	coxu@redhat.com, daniel@iogearbox.net, dave.hansen@linux.intel.com, 
	david@kernel.org, derekmn@amazon.com, dev.jain@arm.com, eddyz87@gmail.com, 
	gerald.schaefer@linux.ibm.com, gor@linux.ibm.com, haoluo@google.com, 
	hca@linux.ibm.com, hpa@zytor.com, itazur@amazon.co.uk, jackabt@amazon.co.uk, 
	jackmanb@google.com, jannh@google.com, jgg@ziepe.ca, jgross@suse.com, 
	jhubbard@nvidia.com, jiayuan.chen@shopee.com, jmattson@google.com, 
	joey.gouly@arm.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	jthoughton@google.com, kalyazin@amazon.co.uk, kas@kernel.org, 
	kernel@xen0n.name, kpsingh@kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, lenb@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, loongarch@lists.linux.dev, 
	lorenzo.stoakes@oracle.com, luto@kernel.org, maobibo@loongson.cn, 
	martin.lau@linux.dev, maz@kernel.org, mhocko@suse.com, mingo@redhat.com, 
	mlevitsk@redhat.com, nikita.kalyazin@linux.dev, oupton@kernel.org, 
	palmer@dabbelt.com, patrick.roy@linux.dev, pavel@kernel.org, 
	pbonzini@redhat.com, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, pjw@kernel.org, prsampat@amd.com, rafael@kernel.org, 
	riel@surriel.com, rppt@kernel.org, ryan.roberts@arm.com, sdf@fomichev.me, 
	shijie@os.amperecomputing.com, skhan@linuxfoundation.org, song@kernel.org, 
	surenb@google.com, suzuki.poulose@arm.com, svens@linux.ibm.com, 
	tabba@google.com, tglx@kernel.org, thuth@redhat.com, urezki@gmail.com, 
	vannapurve@google.com, vbabka@kernel.org, will@kernel.org, 
	willy@infradead.org, wu.fei9@sanechips.com.cn, x86@kernel.org, 
	yang@os.amperecomputing.com, yangyicong@hisilicon.com, 
	yonghong.song@linux.dev, yosry@kernel.org, yu-cheng.yu@intel.com, 
	yuzenghui@huawei.com, zhengqi.arch@bytedance.com, zulinx86@gmai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Takahiro Itazuri <itazur@amazon.com> writes:

>
> [...snip...]
>

Brought this topic up on the guest_memfd biweekly today!

>
> Agreed with both of you.  I'll adopt the filemap-level approach:
>
> - Move the zap/restore hooks from guest_memfd into filemap_add_folio()
>   / filemap_remove_folio().
> - Tighten AS_NO_DIRECT_MAP semantics so that, for folios in such a
>   mapping, the direct map is invalid for the entire time the folio
>   resides in the page cache.
> - Drop the per-folio KVM_GMEM_FOLIO_NO_DIRECT_MAP bookkeeping in
>   folio->private, since the existence of the folio in the mapping is
>   itself the state.
>
> On each guest memory population path,
>
> - memcpy-based population from userspace goes through the userspace
>   mapping of guest_memfd, not through the kernel direct map, so the
>   filemap-level invariant doesn't affect it.  But this is slow, which
>   is what motivated the write() syscall support.
>
> - write(): meant to speed up the userspace-memcpy case above by doing
>   the copy in the kernel.  I believe Brendan's __GFP_UNMAPPED/mermap
>   work [1] would give us a low-overhead way to get temporary kernel
>   access to an AS_NO_DIRECT_MAP.  Landing mermap may take a while, but
>   this series does not introduce the write() path, so mermap is not a
>   blocker for now.
>
> - kvm_gmem_populate(): this is a TDX/SNP-only path, and NO_DIRECT_MAP
>   is not available on those VM types =E2=80=94
>   kvm_arch_gmem_supports_no_direct_map() returns false for
>   KVM_X86_TDX_VM and KVM_X86_SNP_VM, which are its only callers
>   today.  So it doesn't interact with the filemap invariant IIUC.
>

I'm a little bit uncomfortable this statement since it seems to say TDX
and SNP aren't taken care of. Would just like to discuss (for
a line of sight to SNP and TDX support):

For non-in-place population where the source physical page is different
from the destination physical page,

+ TDX: the TDX module does the population and works with physical
  addresses, so no issue with populate? Other parts of TDX may have
  trouble though, but that can be handled later.
+ SNP: sev_gmem_post_populate() does a memcpy() after using
  kmap_local_page()

Would mermap be a drop in replacement for kmap_local_page() here? Would
guest_memfd need to force a TLB flush after mermap+memcpy?

> So, unless I'm missing any path, adopting the filemap-level approach in
> this series should be fine.
>
>
> I'd like to consult with you folks on how to proceed in advance.  In a
> separate reply on the cover letter thread [2], Lorenzo and Sean
> suggested that the mm pieces should go through the mm subsystem:
>
> On Tue, Apr 21, 2026 at 04:36:00PM +0000, Sean Christopherson wrote:
>> Yeah, when the time comes, the mm pieces definitely need to go through t=
he mm
>> tree.  Ideally, I think this would be merged in two separate parts, with=
 all mm
>> changes going through the mm tree, and then the KVM changes through the =
KVM tree
>> using a stable topic branch/tag from Andrew.
>
> I see two reasonable paths to get there, and would appreciate your
> input on which you prefer:
>
> Path A =E2=80=94 validate on KVM side first, then split:
>   - Post v13 as a single series on the KVM list, gather feedback and
>     make sure the design is acceptable to KVM reviewers.
>   - Once v13 looks good ("the time comes"), do the MM/KVM split,
>     rebase the MM part onto the appropriate MM branch, and post the
>     MM part to linux-mm to build consensus with MM maintainers.
>
> Path B =E2=80=94 split early and seek MM consensus in parallel:
>   - With the filemap rework already in place, do the MM/KVM split
>     now and post the MM part to linux-mm directly.  The KVM part follows
>     on top of a stable topic from MM.
>
> Which of the two would you rather see?  Happy to go either way.
>

Vlastimil pointed out that there's a temporary limitation now that the
mm-tree cannot do stable branches shared between trees now.

I think it depends on how quickly you plan to refresh this series, but
Path A wouldn't be blocked by the temporary limitation.

My opinion would be to go ahead with a new revision (Path A) to fully
address comments before splitting the series. Any Reviewed-bys can be
carried over to the split series anyway :)

Alternatively you could wait till conversion lands :P Either one of us
will need to do more work for conversion wrt direct map removal.

>
> [1] https://lore.kernel.org/all/20260320-page_alloc-unmapped-v2-0-28bf1bd=
54f41@google.com/
> [2] https://lore.kernel.org/all/20260506080753.14517-1-itazur@amazon.com/
>
> Takahiro
