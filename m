Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCAC3E1CE2
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174506; cv=none; b=AIHj69gfv36RcCxd4wgkzS5g2MgMjujO61iuU1EvZbMmmgB7FiifjNMNck2p0V3FQvF0QRzDQcsUTtauE25s1LOy/T+0llgSrQcQuGyUx8P8MVIYt3ZG3LITdnPj8bokYJd13FaqwI8Mf0uwmuqLme85ryhUeN0fb/DfqikwHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174506; c=relaxed/simple;
	bh=5v+8yVzsJNS2OqUbx+zYbExHDFzJ7wxfSJt6e2Kr3iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwmwjpqK9Xk18517pk/hW8LJ+Eneg/FdpL9t7Kn4BsUT3sBXK7BN6nsA0b6P3i3+Dpjlw8+VAc6Yf4R05eaTo4q8QXWxzJCrSOkD1hqAO9FcJWLnCDvLcZNCF9hudP1P/sluxqgU5665s+d2VslL5ZCa7ao0G9oaAaompSYyweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvDtkYCH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5048b7n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvDtkYCH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5048b7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776174504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCt6RRkW0qh14/EJdQA8UqKuNaPoleddLVh6YrdRU20=;
	b=MvDtkYCH8INm0h1alw7WjkieCz1/d1cpgU43/J9a0DVnCvHcJTHaoeCQzDS24Q8Q4UTpL+
	gVTUD4Ud+YgIUX1rtSpiE/ierbCh9nYYejCjFl84Hg9lIXWOUXiXsOJRssGjLR3ydA1qMU
	yrixkOs4VmBYIChVEccpeQ8TXOWfKCE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-g6W6zLzSNYWXZx780ewO3Q-1; Tue, 14 Apr 2026 09:48:23 -0400
X-MC-Unique: g6W6zLzSNYWXZx780ewO3Q-1
X-Mimecast-MFC-AGG-ID: g6W6zLzSNYWXZx780ewO3Q_1776174502
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8aca172588cso74933836d6.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776174502; x=1776779302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCt6RRkW0qh14/EJdQA8UqKuNaPoleddLVh6YrdRU20=;
        b=Z5048b7nQ6BvZmSOOePoRzKzNZMM/3I8S+gEVuD/bT50rSgL+ONq6PDVy2V7UYtRpt
         RIlyWPqvbLwZtSBDNgGiaxfBeg9BnHq6xfzrp7i2/cth0D8Nv8491GB+bpYFobbqC50L
         WhejBO6PugfUdymw2mtItm7LEQbdp4O/RevWZzJ1p36E3MRnJQ77XPV/hHD9qtWdDbJS
         D8ZKtCm9cEiWnpzz8gwt0CHFEYoPR8s5XY2rVYUZAm5fUdVJza9xkgWYyvD1PVukwfYG
         P7oh7Zfiu/9HZje3w/LqzlEOtSf+2ThxB7AbaLQ9rCTa2e8azOpeWXGhuAg9bjGJDJBD
         KA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776174502; x=1776779302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCt6RRkW0qh14/EJdQA8UqKuNaPoleddLVh6YrdRU20=;
        b=DCL8VsPvgusAMgGbxIOGaw1pqEnQ3jZxXOSa4K1If2sbYu6RsWGsmT1c4BFtoTfvQ8
         +6zaig9wZUAeuKSLB+Rdg4WrNw9RNWJ3frF33ZMEFlkij82wXi3YFByjeLU8AqWR3w1i
         dD3Q5IIjUNzAv2sKAUMf5ti5aS5hFjOXWnMfLM0QPDw8rdXkA52nfjyfrDKNkLkd9e/O
         JhjQCykF80m97hCUH+MTmI5TaYglYH1F7hn0BGZXSRXjz2GKBdlIf2dA/6FIQUqJrWZr
         lVOiUEheg6LmSpXTv/4+NpMDcOrsNY9fabFqkKDl5tV77SnY7U6cgjfWPeKrn9jkRo6q
         AI7w==
X-Gm-Message-State: AOJu0YyE+p76Uer8Lnapw2V/RBhKZnHykViDoERA/2hRl/mYOCxoSB8v
	OJCIIlMP50RxfCgKfanxqLJY8ui93T0SGN6Xi1srlBlZwCdfk7ry6v0Wf0cPWLlKqY7UnzWFNjr
	N+Bmfpy4atgcuPpUN+it4ux+ICF+oLpaQRb8K97MCLovB/kXsIXpI7NPSBnNq
X-Gm-Gg: AeBDieujnskDDBx3EEzNZaTwLBQrS0rWuT31VjiAsgM4FRpXKiKkRWvBUzBHb1rjxko
	wQ9Ek6d4UNuaTHn6CzcSvK14MlADG508CFxiL6R4fgEjWJplrkNaKQPEWD46bDYBQQxAiwLsRSg
	N/HM4OLFdb47m+F7St8obuGxPn/XH7XyDP+b7ETyG9SfN+wvbhkWvaqzn2G+4cTmTN0JnxxDNnn
	rhOy0JeVsF/QK4yeMYkfgkbk04bNu0eFHQ8oqR6sIBRVww6h41rCUNm8DL57CLcKeI/ReU4gXqz
	7GrgFx9jPi/qQteXwrsbbhqP3qXoRLmF5B5XRRbBiVagX6jHPiN40zfIPSa04Xttl1Ggh2cFVLD
	Ve00+Wd4s337nn4/Am4CflHOJ1f4OCHCILUAMG6sTPIaXeRJyiOXJiw==
X-Received: by 2002:a05:6214:500b:b0:8ae:5f29:effc with SMTP id 6a1803df08f44-8ae5f29f37emr33197506d6.54.1776174502325;
        Tue, 14 Apr 2026 06:48:22 -0700 (PDT)
X-Received: by 2002:a05:6214:500b:b0:8ae:5f29:effc with SMTP id 6a1803df08f44-8ae5f29f37emr33196786d6.54.1776174501709;
        Tue, 14 Apr 2026 06:48:21 -0700 (PDT)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84cc9b8esm118916546d6.41.2026.04.14.06.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 06:48:20 -0700 (PDT)
Message-ID: <e6994ee6-328d-482e-bfac-907cea307ebb@redhat.com>
Date: Tue, 14 Apr 2026 09:48:20 -0400
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
 <bdc53af9-ca09-4f32-80fb-4288775853b1@redhat.com>
 <MN0PR11MB61604669C6DF6D1F372108EACD252@MN0PR11MB6160.namprd11.prod.outlook.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <MN0PR11MB61604669C6DF6D1F372108EACD252@MN0PR11MB6160.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

kernel is a Fedora version of 7.0.0-0.rc4

I have two ADL systems that exhibit the same behavior.

#  grep . /sys/devices/cpu_core/events/*
/sys/devices/cpu_core/events/branch-instructions:event=0xc4
/sys/devices/cpu_core/events/branch-misses:event=0xc5
/sys/devices/cpu_core/events/bus-cycles:event=0x3c,umask=0x01
/sys/devices/cpu_core/events/cache-misses:event=0x2e,umask=0x41
/sys/devices/cpu_core/events/cache-references:event=0x2e,umask=0x4f
/sys/devices/cpu_core/events/cpu-cycles:event=0x3c
/sys/devices/cpu_core/events/instructions:event=0xc0
/sys/devices/cpu_core/events/mem-loads:event=0xcd,umask=0x1,ldlat=3
/sys/devices/cpu_core/events/mem-loads-aux:event=0x03,umask=0x82
/sys/devices/cpu_core/events/mem-stores:event=0xcd,umask=0x2
/sys/devices/cpu_core/events/ref-cycles:event=0x3c,umask=0x01
/sys/devices/cpu_core/events/slots:event=0x00,umask=0x4
/sys/devices/cpu_core/events/topdown-bad-spec:event=0x00,umask=0x81
/sys/devices/cpu_core/events/topdown-be-bound:event=0x00,umask=0x83
/sys/devices/cpu_core/events/topdown-br-mispredict:event=0x00,umask=0x85
/sys/devices/cpu_core/events/topdown-fe-bound:event=0x00,umask=0x82
/sys/devices/cpu_core/events/topdown-fetch-lat:event=0x00,umask=0x86
/sys/devices/cpu_core/events/topdown-heavy-ops:event=0x00,umask=0x84
/sys/devices/cpu_core/events/topdown-mem-bound:event=0x00,umask=0x87
/sys/devices/cpu_core/events/topdown-retiring:event=0x00,umask=0x80

# grep . /sys/devices/cpu_atom/events/*
/sys/devices/cpu_atom/events/branch-instructions:event=0xc4
/sys/devices/cpu_atom/events/branch-misses:event=0xc5
/sys/devices/cpu_atom/events/bus-cycles:event=0x3c,umask=0x01
/sys/devices/cpu_atom/events/cache-misses:event=0x2e,umask=0x41
/sys/devices/cpu_atom/events/cache-references:event=0x2e,umask=0x4f
/sys/devices/cpu_atom/events/cpu-cycles:event=0x3c
/sys/devices/cpu_atom/events/instructions:event=0xc0
grep: /sys/devices/cpu_atom/events/mem-loads: binary file matches
grep: /sys/devices/cpu_atom/events/mem-stores: binary file matches
/sys/devices/cpu_atom/events/ref-cycles:event=0x3c,umask=0x01
grep: /sys/devices/cpu_atom/events/topdown-bad-spec: binary file matches
grep: /sys/devices/cpu_atom/events/topdown-be-bound: binary file matches
grep: /sys/devices/cpu_atom/events/topdown-fe-bound: binary file matches
grep: /sys/devices/cpu_atom/events/topdown-retiring: binary file matches



On 4/13/26 9:22 PM, Mi, Dapeng1 wrote:
> It looks strange. Suppose cache-misses event doesn't need to assign the 
> offcore_rsp field. Could you please run below commands ?
> 
> grep . /sys/devices/cpu_core/events/*
> grep . /sys/devices/cpu_atom/events/*
> 
> BTW, which kernel did you use? I would find a ADL and check if it can be 
> reproduced. Thanks.
> 
> ------------------------------------------------------------------------
> *From:* David Arcari <darcari@redhat.com>
> *Sent:* Monday, April 13, 2026 7:53 PM
> *To:* Mi, Dapeng1 <dapeng1.mi@intel.com>; Len Brown <lenb@kernel.org>
> *Cc:* Linux PM list <linux-pm@vger.kernel.org>; Linux Kernel Mailing 
> List <linux-kernel@vger.kernel.org>
> *Subject:* Re: [PATCH] tools/power turbostat: Allow execution to 
> continue after perf_l2_init() failure
> 
> 
> Here is the -vvv output:
> 
> # sudo perf stat -e cache-misses -vvv sleep 1
> Control descriptor is not initialized
> Opening: cache-misses
> ------------------------------------------------------------
> perf_event_attr:
>     type                             10 (cpu_atom)
>     size                             144
> unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms:
> event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
> unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms:
> event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
> unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms:
> event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
> unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms:
> event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
> unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms:
> event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
> unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms:
> event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
> unknown term 'ldlat' for pmu 'cpu_atom' (valid terms:
> event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
> unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms:
> event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
> unknown term 'offcore_rsp' for pmu 'cpu_atom' (valid terms:
> event,pc,edge,inv,umask,cmask,config,config1,config2,config3,config4,name,period,percore,metric-id,cpu)
>     config                           0x412e (cache-misses)
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>     disabled                         1
>     inherit                          1
>     enable_on_exec                   1
> ------------------------------------------------------------
> sys_perf_event_open: pid 9255  cpu -1  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -12
> Warning:
> skipping event cache-misses that kernel failed to open.
> The sys_perf_event_open() syscall failed for event (cache-misses):
> Cannot allocate memory
> "dmesg | grep -i perf" may provide additional information.
> 
> Opening: cache-misses
> ------------------------------------------------------------
> perf_event_attr:
>     type                             4 (cpu_core)
>     size                             144
>     config                           0x412e (cache-misses)
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>     disabled                         1
>     inherit                          1
>     enable_on_exec                   1
> ------------------------------------------------------------
> sys_perf_event_open: pid 9255  cpu -1  group_fd -1  flags 0x8 = 3
> cache-misses: -1: 11224 321150 321150
> failed to read counter cache-misses
> cache-misses: 11224 321150 321150
> 
>    Performance counter stats for 'sleep 1':
> 
>      <not supported>      cpu_atom/cache-misses/
> 
>               11,224      cpu_core/cache-misses/
> 
> 
>          1.003110088 seconds time elapsed
> 
>          0.000000000 seconds user
>          0.000846000 seconds sys
> 
> 
> On 4/12/26 8:34 PM, Mi, Dapeng1 wrote:
>  > The most possible reason for the "<not supported>" is that the "sleep 1"
>  > process runs on a P-core where "cpu_atom/cache-misses/" can't be
>  > supported. It's expected.
>  >
>  > BTW, you can add "-vvv" option which gives more details like "sudo perf
>  > stat -e cache-misses -vvv sleep 1".
>  >
>  > Thanks.
>  >
>  > ------------------------------------------------------------------------
>  > *From:* Len Brown <lenb@kernel.org>
>  > *Sent:* Saturday, April 11, 2026 2:09 AM
>  > *To:* Arcari, David <darcari@redhat.com>; Mi, Dapeng1 
> <dapeng1.mi@intel.com>
>  > *Cc:* Linux PM list <linux-pm@vger.kernel.org>; Linux Kernel Mailing
>  > List <linux-kernel@vger.kernel.org>
>  > *Subject:* Re: [PATCH] tools/power turbostat: Allow execution to
>  > continue after perf_l2_init() failure
>  >
>  > On Fri, Apr 10, 2026 at 12:06 PM David Arcari <darcari@redhat.com> wrote:
>  >
>  >  > I'm using a Fedora kernel:
>  >  >
>  >  > vmlinuz-7.0.0-0.rc4.260320g0e4f8f1a3d08.40.eln155.x86_64
>  >  >
>  >  > And turbostat is:
>  >  >
>  >  > # turbostat -v
>  >  > turbostat version 2026.02.14 - Len Brown <lenb@kernel.org>
>  >  >
>  >  > >
>  >  > > You can poke with "perf stat" as well, but this will depend on what
>  >  > > .json counter list is compiled into
>  >  > > your version of perf.
>  >  > >
>  >  > > probably a first sanity check would be if these commands for the LLC
>  >  > > and the L2 work:
>  >  > >
>  >  > > sudo perf stat -e cache-misses sleep 1
>  >  > > sudo perf stat -e L2_REQUEST.ALL sleep 1
>  >  >
>  >  > # sudo perf stat -e cache-misses sleep 1
>  >  >
>  >  >   Performance counter stats for 'sleep 1':
>  >  >
>  >  >     <not supported>      cpu_atom/cache-misses/
>  >
>  > I think this should work.  There may be an issue either with
>  > the perf utility or the perf kernel support on that system.
>  >
>  > I'll cc Dapeng.  Already the weekend where he is, but maybe he
>  > can give us some perf insight next week.
>  >
>  > thx,
>  > -Len
> 

