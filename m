Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79E3BFE33
	for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081230; cv=none; b=DzXTPHu2oY0sE+9+ts/d7kgWE89FcrhbFCsPKq9Kh7SFlsfFtyJhksU9QgId315tyNT/nqCBTTTWxgENa68DQ4DmlN9zq2Bt0+bSSQbhmdYxcwbeCotGPmDga8CoAglSmjDwUokDjRtYso4aY8zHVxDgy2Vb1n0pQvttgk80MKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081230; c=relaxed/simple;
	bh=Z4ezkkAj8vOPAJEl9cshJEOhHWdLz3AQn9RWlMjI4mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzTYmaptY+w5Hkr3LLNYLUpWchRb3BJckmFxN+9ZV4SeexNkT7RsUEMTFSvx+7s0217KUnojvbuEx4NfI8KPvgv3ffPl5qp/Yo4kk7ry1IhrRvh8Cu4COQloYYYAI8VNNKONHR6CsGbmMUeVPOtuq1vfw0MwA8GeSEZX0KJOg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBptiMOs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjPGdFuV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBptiMOs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjPGdFuV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776081227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75N24M6KXVzzBEiJ/Ez5ZD/cTIY0DJ7q5+kbHpzvI84=;
	b=TBptiMOsbQMN/LVDTogS1A+poCBn4gMSmFUb7hHB0Glil0SGnryd+ziWi4uZRZDFplW68N
	qj5QSZYKqcdxCiENr5Jatm4ftvA+C0XevL8rubCoIz6e//kC5P4TQsG0NQh20xVOhi/Erv
	djMC3or8MFkzoYusvaXhOmxlHFjxPII=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-UMicAEp0O2euRlQqMs5XKQ-1; Mon, 13 Apr 2026 07:53:43 -0400
X-MC-Unique: UMicAEp0O2euRlQqMs5XKQ-1
X-Mimecast-MFC-AGG-ID: UMicAEp0O2euRlQqMs5XKQ_1776081223
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8d3bea3aa34so500130785a.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776081223; x=1776686023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=75N24M6KXVzzBEiJ/Ez5ZD/cTIY0DJ7q5+kbHpzvI84=;
        b=IjPGdFuVYwDsQn5S5WdMrzwc+jEf9nw/jbMiA2k0BQgbE3a4IPH8mhUFuDu1/DKQBI
         i4+25+LXEnQsJDriXVGy64nHZRt8y6ZxnNPIObGYGIY7XF3k/WpZeKNd9xW6oXXphPxj
         XkhThqV96WAKqmcukBIHc21Vqv3WW35x5QQIGDtVkX0yPp5cCIlcoJ1xUv6w6TJVHGmP
         aFCQAV4Vjnew+crW0Diy2M/bRu7qGQTiztr/1QgPsk4ckWd7gklLnDMbZF5BmrxkZp4L
         ppU6jhW2mBu8ygxLs+KTgiIz3cIcP78hQD0odZv75tC9wZHjNqBkxKk+T+Zzl1CtY4Q/
         m3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776081223; x=1776686023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75N24M6KXVzzBEiJ/Ez5ZD/cTIY0DJ7q5+kbHpzvI84=;
        b=Jidm+WRX9qRJ0o4Ezkw6FdMD6TRHNFHZam21/+zILZFxz5LNAjlr1KZSuoIvEyOvHt
         a8w64FMZm1LZ2PThwL/e3lSNtHbGOYKKpgVOf9mHauy9tK4jnc1yYN0AUOXl2jkclrR9
         wibsvzzjt6xNTRVv2+Hq+QeqFgbUJik6VrzNCvl00ZcuYlsDfmUCO6dHRc+8LyrqcV+Z
         l4yrow2CJgQrE6jp/wjRcCTgwi8HAyJ0s3iYin0vp4yor6LNebuPdH+Y2ittXVADhi3a
         tAzls7Lk4FZ/QH+FkujmtAb+ceczEXDXG7tYnJxPqdYB7zBfhszBE71alHSQjqvX2XIi
         N9YQ==
X-Gm-Message-State: AOJu0YwdRHRVf+P6SpLTA97l3GuxWkXUHs38Kbx/q60g3lnp7C0TUFUz
	z6h1Lad8fBkDHRJvxDwUg5eXVYYJYqfwFXrYRvxFd9EfzZNtpL8Xk4ryyi15z3jDV9iDHmE+dlx
	HPYFDsYd5qLluJQ/xa6DGDi+XI7Y2WSp8FtALoINR4cwoPgZtuCkpBzfh+jpW
X-Gm-Gg: AeBDiesTnK5DO/rXeao5vln6xacpj/3MmJi4Wq0BIYJ61rgWoilIk68kysB+Bqpterm
	kfIRmcps99JEztqoQTaIHkmWCukSYdcCknVrHS37ec6wy5aM8xJwNloMtrHaaFGru3hel5Ux/Bb
	S5i8VfBEad/PH+dBmWlnWgxYI1e3WGC1AABx8sQSjUzObs9DxfDc3VYsT3aTFSDoI/c+WZ/gKqZ
	rdKCACb58CCUFL9+JtLIytdFLjc0cogxwTh6vQWnAhIs0xZqfh/uj00O96Ol+cGQsGmNCHnyIST
	6jBVAzzREx2yLfZ62eN36zvQ6MZb5xQf0SsaXZETEVKoJqNKYY6Vu+N8zeF8inIcPF90Acv/xaD
	CRcHmztC6PfIvBzOkNUCDK0O0j09CSIlYd71TsXF6Ju/NZNLWYIh4zQ==
X-Received: by 2002:a05:620a:4551:b0:8cf:e1c9:b29a with SMTP id af79cd13be357-8ddcd8f6c6dmr1901636385a.20.1776081223117;
        Mon, 13 Apr 2026 04:53:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4551:b0:8cf:e1c9:b29a with SMTP id af79cd13be357-8ddcd8f6c6dmr1901631585a.20.1776081222475;
        Mon, 13 Apr 2026 04:53:42 -0700 (PDT)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb963d7edsm835149685a.39.2026.04.13.04.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 04:53:41 -0700 (PDT)
Message-ID: <bdc53af9-ca09-4f32-80fb-4288775853b1@redhat.com>
Date: Mon, 13 Apr 2026 07:53:41 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power turbostat: Allow execution to continue after
 perf_l2_init() failure
To: "Mi, Dapeng1" <dapeng1.mi@intel.com>, Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20260319140307.441950-1-darcari@redhat.com>
 <CAJvTdKmLA=n07hkkXLbwMex-_Byji9EOy7wkkFHrcPCj8tzMqw@mail.gmail.com>
 <CAJvTdKmepvPzWDM+6s9YERe27H6pSKbDb62yfpTSs57hWsEmRg@mail.gmail.com>
 <5ec684ae-b778-40ba-8a10-dfbf274da7dd@redhat.com>
 <CAJvTdK=CoV7L1FmeVUTAO=U7eJQevjUnqr-CPk2CDxAO4zu3Ug@mail.gmail.com>
 <MN0PR11MB6160DDF6952E2B595B2EA1C1CD242@MN0PR11MB6160.namprd11.prod.outlook.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <MN0PR11MB6160DDF6952E2B595B2EA1C1CD242@MN0PR11MB6160.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Here is the -vvv output:

# sudo perf stat -e cache-misses -vvv sleep 1
Control descriptor is not initialized
Opening: cache-misses
------------------------------------------------------------
perf_event_attr:
   type                             10 (cpu_atom)
   size                             144
unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms: 
event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms: 
event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms: 
event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms: 
event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms: 
event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms: 
event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
unknown term 'ldlat' for pmu 'cpu_atom' (valid terms: 
event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms: 
event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms: 
event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
   config                           0x412e (cache-misses)
   sample_type                      IDENTIFIER
   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
   disabled                         1
   inherit                          1
   enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 9255  cpu -1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -12
Warning:
skipping event cache-misses that kernel failed to open.
The sys_perf_event_open() syscall failed for event (cache-misses): 
Cannot allocate memory
"dmesg | grep -i perf" may provide additional information.

Opening: cache-misses
------------------------------------------------------------
perf_event_attr:
   type                             4 (cpu_core)
   size                             144
   config                           0x412e (cache-misses)
   sample_type                      IDENTIFIER
   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
   disabled                         1
   inherit                          1
   enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 9255  cpu -1  group_fd -1  flags 0x8 = 3
cache-misses: -1: 11224 321150 321150
failed to read counter cache-misses
cache-misses: 11224 321150 321150

  Performance counter stats for 'sleep 1':

    <not supported>      cpu_atom/cache-misses/ 

             11,224      cpu_core/cache-misses/ 


        1.003110088 seconds time elapsed

        0.000000000 seconds user
        0.000846000 seconds sys


On 4/12/26 8:34 PM, Mi, Dapeng1 wrote:
> The most possible reason for the "<not supported>" is that the "sleep 1" 
> process runs on a P-core where "cpu_atom/cache-misses/" can't be 
> supported. It's expected.
> 
> BTW, you can add "-vvv" option which gives more details like "sudo perf 
> stat -e cache-misses -vvv sleep 1".
> 
> Thanks.
> 
> ------------------------------------------------------------------------
> *From:* Len Brown <lenb@kernel.org>
> *Sent:* Saturday, April 11, 2026 2:09 AM
> *To:* Arcari, David <darcari@redhat.com>; Mi, Dapeng1 <dapeng1.mi@intel.com>
> *Cc:* Linux PM list <linux-pm@vger.kernel.org>; Linux Kernel Mailing 
> List <linux-kernel@vger.kernel.org>
> *Subject:* Re: [PATCH] tools/power turbostat: Allow execution to 
> continue after perf_l2_init() failure
> 
> On Fri, Apr 10, 2026 at 12:06 PM David Arcari <darcari@redhat.com> wrote:
> 
>  > I'm using a Fedora kernel:
>  >
>  > vmlinuz-7.0.0-0.rc4.260320g0e4f8f1a3d08.40.eln155.x86_64
>  >
>  > And turbostat is:
>  >
>  > # turbostat -v
>  > turbostat version 2026.02.14 - Len Brown <lenb@kernel.org>
>  >
>  > >
>  > > You can poke with "perf stat" as well, but this will depend on what
>  > > .json counter list is compiled into
>  > > your version of perf.
>  > >
>  > > probably a first sanity check would be if these commands for the LLC
>  > > and the L2 work:
>  > >
>  > > sudo perf stat -e cache-misses sleep 1
>  > > sudo perf stat -e L2_REQUEST.ALL sleep 1
>  >
>  > # sudo perf stat -e cache-misses sleep 1
>  >
>  >   Performance counter stats for 'sleep 1':
>  >
>  >     <not supported>      cpu_atom/cache-misses/
> 
> I think this should work.  There may be an issue either with
> the perf utility or the perf kernel support on that system.
> 
> I'll cc Dapeng.  Already the weekend where he is, but maybe he
> can give us some perf insight next week.
> 
> thx,
> -Len

