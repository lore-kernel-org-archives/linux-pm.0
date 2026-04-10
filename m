Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604235DD1C
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837210; cv=none; b=PN9+IJq8Tt+f7YB+P+FLSbbxXkvv+v07lcSVcvSOicOT4AtxBXelF82WYplT+tuE7jK7tLJCBLSAwDq6iVNi7LXdHgLbBtcozVXihLUqZphgbTJtym/ZOmgFakDbdlfDoim61mTVPMI7P4pXPpQyi5cnuzThkhieaidRfb71It8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837210; c=relaxed/simple;
	bh=gd3Q42UhdfW4lzIIp1OpXhUnTVZF0VmSbRc+ncXhj3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqZcBOGt8WOJD6sOXJAgW2rtKn4FD1CCZf2q6vDZQa+vmt80+afAkQjvPpPl8r+l20p5oSKXEm2gEyThEMS3wD0PGpZEm5ess2dwpmy4SVJjo9lwpixnU40hXo0Qm+1rLXD9kWmJHYIVZllUuV++z8vK9gheqdI++Nq8H5l1AjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aICWUgTr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fV6XysWN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aICWUgTr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fV6XysWN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775837208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f7rOYvPm6/l0aVtJOAyE3lxuNjRSuawlvQVlZvUZj0k=;
	b=aICWUgTr0SH6HSQYysQrjC9317I4bfLTRhW93RSwAzSUas8V1fJzychkb6pmB601hGsZui
	lLURXoP0N4EJS3i1e4eI9j3M8aSXCAnp0rePMG8W7rCWiJmboo0mFTSpgTCXYSlt1tLfkY
	7UrhRWFbSdR3pIkr64cBLNPi5nyECN4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-BScdkSwWNvOYTlWTl9uNHA-1; Fri, 10 Apr 2026 12:06:46 -0400
X-MC-Unique: BScdkSwWNvOYTlWTl9uNHA-1
X-Mimecast-MFC-AGG-ID: BScdkSwWNvOYTlWTl9uNHA_1775837206
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d890580e1so42156941cf.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775837206; x=1776442006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7rOYvPm6/l0aVtJOAyE3lxuNjRSuawlvQVlZvUZj0k=;
        b=fV6XysWNruLvdYJL6qqMqWhSTNx1ZGBassqSpuNQYXRA8ZJM9Son5YeY19TvaFcSmC
         AeULoRtP0IR/lNivJt8zmNNW2/Gb38dvmF+K4yE052WdaH5GC+YeFQl215AQhyQWns5V
         sigwG/iBOM/VoeFwTf/8ZBQIJdthtvBfy213V5QJrNbrSeHb55DbDwz2EQRnjKZvDpqp
         jdRCwY5feU6pE6PbCaMX5Fc6P/W4W0j3rNGgX/QePdMAayh12wZWxxaUla0ITYEs6B/1
         PgTFuzRA5UZXYvuHdob8NTp0tQlIdkYmxFPoravPpKKUJv/lWeuwYHj3f5bIOdWoZV3r
         NArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775837206; x=1776442006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7rOYvPm6/l0aVtJOAyE3lxuNjRSuawlvQVlZvUZj0k=;
        b=frkWPQLdasK2QavGhFK7rDyYn3UhkfzYgv3Pscx+3kcJLmIR+9id32ODj1rU4c6QcA
         5MgEkKMtX4hN/tGXP6IlkygHWgpQ2nLJ5AitCk0H67NihsVZ+j+EWyRw50oVm4CNpIDn
         tJvq7+sD5kCQ2/RrgY3hpauddt0PyMHk1+JgHNhhlhKI71nD1ZQogeYnQB9DAPPIgOPs
         p4LdnWX+KaumFsH+n9u98SISIUMMMHY/2VssyLdbssCWCvSDPeAYyUhIyEypJ6CYXSyA
         VpJbR4rsHAyVceidzbguJgjbr5xrp1VnyCPyLzej79LQAM6+Ih7jJnTMDj/6On75XNCr
         o1yQ==
X-Gm-Message-State: AOJu0YyxRAkxHB3SHMkf9gSjseCrdNjVtDBmkBU9elzcYRcIpOjtJswn
	P03e9Gz2G/L1rJRa7p0y7NhlYgaBbRJbFubGHIjz41qvtvFNBVMQ80RYk3Wz6RRqjA+GYmJLCWe
	JFV7WU3/3thn9PeOLJKFDiDvvcbotjTAXDWcFU7B4FAo8N+sju82apfYNjyMwZpVaLHOS
X-Gm-Gg: AeBDieuqiA7tOVKkQlSXLmZ71wQtuo8Q8NRRMQGv5cp7JZO41ATOBF8BcPv1gfL7kuo
	Xxyh92Q/w1SnqhppG/EVJMsO0JH6ju2xEzkvEYn4lTjWGdJ7h3gvcGk9MrMyzaRKIW3ngRM1y+8
	V4WFmY6Wb8FeFNuzjfJ/mSlAWNXDxT8evtqba0MlNIbsvZKFmINveHoxKT1nYrcpgz4EdzhYm70
	u/F/PhJYvrEnyyhMCX95Qp9GDPgK5gXdQ4A7xZ1NUEYQIYSbOUSOx7KQNM9XcuRcXsPj0SGMx5q
	rmwLhNB5Pt9zO4+IFypqEz6HgY6oERM+pPmqB8wvrVkWwlWteSbI4GVJVQqy8nJB7k/vs/8RgBg
	lYCTYjXWvPOfrdnUx8dy9mxzbDAqFvrxYLqLpnsijswe726hSoITauQ==
X-Received: by 2002:a05:622a:141:b0:50b:38c1:c6a with SMTP id d75a77b69052e-50dd5ad9098mr57720451cf.19.1775837205731;
        Fri, 10 Apr 2026 09:06:45 -0700 (PDT)
X-Received: by 2002:a05:622a:141:b0:50b:38c1:c6a with SMTP id d75a77b69052e-50dd5ad9098mr57719811cf.19.1775837205117;
        Fri, 10 Apr 2026 09:06:45 -0700 (PDT)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd53f9c16sm24332311cf.11.2026.04.10.09.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 09:06:44 -0700 (PDT)
Message-ID: <5ec684ae-b778-40ba-8a10-dfbf274da7dd@redhat.com>
Date: Fri, 10 Apr 2026 12:06:43 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power turbostat: Allow execution to continue after
 perf_l2_init() failure
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260319140307.441950-1-darcari@redhat.com>
 <CAJvTdKmLA=n07hkkXLbwMex-_Byji9EOy7wkkFHrcPCj8tzMqw@mail.gmail.com>
 <CAJvTdKmepvPzWDM+6s9YERe27H6pSKbDb62yfpTSs57hWsEmRg@mail.gmail.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <CAJvTdKmepvPzWDM+6s9YERe27H6pSKbDb62yfpTSs57hWsEmRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Len,

On 4/10/26 8:59 AM, Len Brown wrote:
> Thank you for the patch, David, it is helpful.
> 
> I agree that turbostat should do its best to run properly when the
> underlying kernel
> doesn't have full support, and you found a configuration that I missed.
> 
> I'd like to understand how/why your kernel perf support is failing on alder lake
> to be sure turbostat is coping the best it can.
> 
> If you can identify an upstream kernel version that fails this way,
> that would be great.

I'm using a Fedora kernel:

vmlinuz-7.0.0-0.rc4.260320g0e4f8f1a3d08.40.eln155.x86_64

And turbostat is:

# turbostat -v
turbostat version 2026.02.14 - Len Brown <lenb@kernel.org>

> 
> You can poke with "perf stat" as well, but this will depend on what
> .json counter list is compiled into
> your version of perf.
> 
> probably a first sanity check would be if these commands for the LLC
> and the L2 work:
> 
> sudo perf stat -e cache-misses sleep 1
> sudo perf stat -e L2_REQUEST.ALL sleep 1

# sudo perf stat -e cache-misses sleep 1

  Performance counter stats for 'sleep 1':

    <not supported>      cpu_atom/cache-misses/ 

             11,212      cpu_core/cache-misses/ 


        1.001044852 seconds time elapsed

        0.000793000 seconds user
        0.000000000 seconds sys

# sudo perf stat -e L2_REQUEST.ALL sleep 1

  Performance counter stats for 'sleep 1':

    <not supported>      cpu_atom/L2_REQUEST.ALL/ 

             98,451      cpu_core/L2_REQUEST.ALL/ 


        1.001072723 seconds time elapsed

        0.000761000 seconds user
        0.000000000 seconds sys

> 
> Also, with your L2 patch applied, does turbostat still successfully
> show the LLC stats?
> 
# ./turbostat --quiet -s Core,CPU,LLCMRPS,LLC%hit -n 1
Core	CPU	LLCMRPS	LLC%hit
-	-	1	91.33
0	0	0	93.48
0	1	0	86.86
1	2	0	90.68
1	3	0	98.61
2	4	0	98.59
2	5	0	98.79
3	6	0	90.86
3	7	0	97.64
4	8	0	97.52
4	9	0	99.33
5	10	0	85.54
5	11	0	90.85

Let me know if you need something else.

Thanks,
-DA

> thanks,
> Len Brown, Intel Open Source Technology Center
> 

