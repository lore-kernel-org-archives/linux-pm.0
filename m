Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982149;
	b=LoIQDb1B2W4XBDh4EfX5sWUsFlb9foO7560qJ5k0XBg91O7FDcAwx7Lh4UhbppeH986U
	 xJcpKximv3ifdCge0v+0rflcat1gQQwON3LMmzwU3Jjgy0Mzu0Slcg+hBg9H6Q66hh7T/
	 QsQyuXd89v+WdK5qaSHX8me8nSqhVyEHvcjharb6ohyKJBEbjLeQ/Z8fp3OeYyB9ZlZ9S
	 EHxJcJAReEXXhhFIHdBMi2pV7zcs/FXb6QCdgyrSySHLaj4Yr3F0Bl2R3hPDMRjotvHQv
	 dbnjUXix2g3RAzGZPKNg9iMnfsp3JkDb6eUKXtUa10hxM6+pZVXvZaVuDg/ReCWQirA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5qoJPw+qIEyXRRR0ruoMunl9bad/9mwg4HzwIER48nI=;
	b=UlA1M5sFnkTnsnKppW1prHt9C0GeQfqzypQ89fo2lXaAEcvdEd9RVE7cwwJcRPRTvqSp
	 rvC06F27AJk0swtSjfVkcGXS4cn+UBplxwBX99fa88wewC0MrBJp6C+mliNFX6IBGH0np
	 2p4taDWHZTLGB79y/aQ23vDUTUeiylsQjGK+7lEZBKSqHvK8kgsd0qn9FBREncBPI8DB3
	 8/5KImkRd8nj3UjSZisyOKSH01ch9LukEt3bs+WrWIy+C/ks7ITD4HFPaoi2NEr4g0t/x
	 NvsRH5cHrLWWXoJQqtPrambwBIze3gtIeTyXveVM9xZHaRjtRlRf6F4xg/FUr07/M9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+n5sxOE;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A3606A32C
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 16:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 837A3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+n5sxOE
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-49083b985d2so39086f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 08:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793982148; x=1794586948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5qoJPw+qIEyXRRR0ruoMunl9bad/9mwg4HzwIER48nI=;
        b=C+n5sxOE985uUnk8dQQXRVNC0HtjGMCyQUl2n3DTnj8kK0Qtw4uLms6awbAOzww2OG
         tS6nfpqghjSLyFOec3ubyoXM1rncg1Pjx0d0z4bFEJ+jr3ftkBZpc/yieqqiqm0V22DX
         KJqQ4QJlStK76jhQUIHUTJIdn/TjUZsUb8wkWkbp937yiVcl1jVJ/5YGg76sZ+n/SES6
         Y/mzex/btJgGGq+jbljBzOC1vlPCLUKTeT5VyeGANPGN69NYldmv35IoNBjcwOsjxsjp
         1nbKGaExDgWvD1TwZaGieH6wi4Sd6CD1CHc1X7Nl65O/C20M6j+1ERjcAUTdLFnplJpY
         9tXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793982148; x=1794586948;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qoJPw+qIEyXRRR0ruoMunl9bad/9mwg4HzwIER48nI=;
        b=QkyiSoSkptjPpbRdXta3xt9hghtWYBaW1okSsxrZpKLk7U8qv6c3G0GsIeACwu6Lh+
         PlB4oG5Hd4syLZFZiP5pBB8pDMx4Ah5JICNrgbLljK6yASSzTn/Baj80dlAB7apQCodk
         El46e1d1tNgfLbSx2Ty8MZHpZgqOLrE/POKrq6Nz5CtcG8KtLHo1LRSYuqxxQ63QuQ2H
         bz4Y+pz5Ixu3naJy2De63cwysJ7RDlYRLygX4aDau3gHOrZkzL5nzrWJzdWjXTLWAI3b
         Ofsl+zXRm560c47Kigr7lLpMTlmeOwEjHD8SnXTkIc2WX/XAibbEtJydXAcmAZsF4s4X
         Pssg==
X-Forwarded-Encrypted: i=1; AL+hErH6R+8uZk0tNBObdgAQr4hfdDNvxMElu+kGwXnS4oGkJL9bgkZOHe6vvRA4XRjDmbsLQrBUjR1oaw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8GzclBF4ozoIdN94NTObF9zP6EUWbMboggvyUphNeEzs7H2CTg
	7bF0mNYtQjfXz18xXOcLr9RfgFrxqxYtHEMecdw1T+KtOda/+DUdwjHu
X-Gm-Gg: AYBFou1QTSRfZjMETHZtSWf//izSB+9+82xJwlRaSloWqtg34aRKXGiJ3MZKTOIiYcm
	7N/cCMRZxYDwmW0wBE/XBoYfnrZFC5z7pwQtrsTO2b4lbtHVR8w8MZQmckpAcvg8wW5m9DIhYX2
	q5OUvbemdr7HVGH4jVjvui8U0HE6DHvQGG3v/pBPatDoB41XdeZUVXQOwB1P+z403dyXfvA9Xbe
	5sIPg7Z5b0By3oZhsCe4IpqdxTmAIAGtRePXj6UWte8cZ3xyfowrAONf53jD/MCsy5BrbskZ0DH
	NlArQy9trCXanGSNYqmwyHhM2oWfAHbBYDRzXj4ohr+hJDYGGpZm+h0SFzN4xonlFo0nx/g6pSB
	udo+8/JWwncGnPhSLCtjScEbqk/0kBikCZFCo9mzg61tJC11/j6C7htc2Kj1+cHqMOXFLZ9RrI5
	nTcGuCFe+g6WlN9jvV+oHT4vwcTswNtaUqCFSjSWYgycnmc6m9d+nz8b3lsZ5G7Yu4t5xlQzh/1
	bHRNNWpoo1AV/7Y0dGJUdybBLJiRG7lBxJ5IByq1a9cA/0hWACkv8phTLCmzSa3r8Z2U9KPpnvU
	LyZoYKG+T9WzjpvtGiZkIwXZGuf9m4GYsBRk78cvn3kdxSY0iT/lo8o=
X-Received: by 2002:a05:6000:645:b0:48c:6611:82 with SMTP id ffacd0b85a97d-49272a3ab3fmr5316957f8f.1.1793982147441;
        Fri, 06 Nov 2026 08:22:27 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d087a3c5sm3952650f8f.0.2026.11.06.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:22:26 -0800 (PST)
Date: Fri, 6 Nov 2026 19:22:22 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
Message-ID: <au38gSTzmvPKmqWT@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-3-vincent.guittot@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106151947.3991524-3-vincent.guittot@linaro.org>

On Fri, Nov 06, 2026 at 04:19:29PM +0100, Vincent Guittot wrote:
> @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  
>  	dequeue_hierarchy(p, flags);
>  
> +	if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
> +		cfs_rq->idle_seq++;

This needs WRITE_ONCE, no?  3/20 uses READ_ONCE().


Cheers,

Kayra

