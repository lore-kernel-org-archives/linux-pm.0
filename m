Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A6950AC0C
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795805; cv=none; b=lX8TDjj6SvLu97TfDnnxFiANCSmSJ4NjhDilRa+ylH6bZGUcRT7EOlOZbCacfMPAV8Bhrn1OyFuGcKHeYlTdDvoabkqAZxu235n7KBCJOSCkuJREoXGqQuHDNdlgMD4BknJMFvlvVTQZ97GH/rEn3jUdqVzYl8QduUQMFjut0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795805; c=relaxed/simple;
	bh=MICC69rDhpY77nwXlWteXYHHthmexIfa62lpP2Cj7Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZSDPUIl7NOJ7vaiEyiED8YBMYzLoszSeLuvjUkIV542ST4rK0TE1LT+V+3/ZfAcPMS/oCRglkh4k8hw6v4NEGXfUkADZty9x/vFhWsqvvxMuO6kkimPO/Klw9OLyJuG9enMjdR6QEEHsvpwyj3T5fwpxAMA39Vbt+f4DiQDXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Dcby7mMa; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Dcby7mMa"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9391252b5caso242886585a.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788795802; x=1789400602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9N6f/b+RDjU+5LdwC1W3FgNOtZzFd5njRslDhw37g/s=;
        b=Dcby7mMa23igHcsyogt4hMcsQ+LF9/ES8wasSJN5liRTHzn6a+6B8eXPqKM0aOy1Uq
         x9PaKWDzBn1NBHviEWZtE9wBpsyTU44o/5IhM4HkZHowaBVBQ7TwQxBmmNUaTpq31Z1R
         3NHxEtcae0R7ht9bjMQLD5quH78Ei9I7pWfkkADIT42Fh3jUNU06bgnkfg3/E4MsGxdO
         LXi0zYbnzstFxw5QmexR0S35KLzBUoQ/5kuCbBwEnHSnlN4Y0CtzlckZOBIq8p12pC6R
         gvaFbq6dtBVtj4sZ/m8gBRTbhGEiaABmWOIhFYsKEQFGBbyytulKzhaZW5RJZqer41Am
         SezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795802; x=1789400602;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9N6f/b+RDjU+5LdwC1W3FgNOtZzFd5njRslDhw37g/s=;
        b=MCIH6VRvBT1NVH8TVHEXq+aaJS6k+IB1WWtSOHGT1PWfwGPYMkHfgBP6T4lMbAIquR
         LKpf/VviA7KNg0yQGTfT1wSVVKp7veofrTYZlz9UTTIGnf8/Psu1/ntIce6iP01lMbqs
         2AC0alWTbntDe4KUSd8UajbKhzVpwlyfJ3kirrlLjXIFLYEbM9Es095DqXhgLdp/zqKO
         eJ9kL2wdq4PLOmxuQnpAHG2KPuCeL/LYN3ugBCHeY7hfSDX17g4trfU0Jj5iEpcEjbG3
         aSt6cU9ydPKR3yBzaWlyFzaxbX0VMk0iatxn4iXG92bfFVrMp3FlN3arB4BN2OYuvBew
         0DdA==
X-Forwarded-Encrypted: i=1; AKwUvBy8Ug9phsf5ISg5jRYveZ8lPrOf+zJTgB1wDckrzd+VMYi79rocDVlNOs4Wn4WhnOg0Oo7nSPClQw==@vger.kernel.org
X-Gm-Message-State: AFuF++m/nbSb/jKGusszOZ7jmayBP+VYtXVLYPgYLR4+/hPqsoxbCHUN
	S9S/thtFYHqcRxM5X5/UCMPh4P9F0hww+TvYHl2kZlzrJxHzSsKv4w68tvORcy6Ldg0=
X-Gm-Gg: AYBFou3nkngdu//+SYKzBkVP3pkhM56lITKtYC5Qt2XjalVsmbUIHqykQ4NGx1CRuP1
	jADJl11j6E13jAup/fLtff74mm5kdZZ9LCTm309w8w1OxjBCdndD49P/jH0JhbBNMIBDOUkW4s0
	lS1MpFo2jZhvF/lAcrMcZVj7k+hbVC19qdi9r7NVGj5CPwbqlHEeI2KCBP8zX9d4Qvx4k6KEbLf
	zR2jWwKozL1/qNReMyE8o6JGd1A8PLo3nvPO0OA/+EG3rHDZkdes7qVNw32TX4elNvphZcn92HJ
	nubj8YqS47NlQYFJ2e7tA57QGgmGrq252heWusm6Wf9dfEfE/W4T4nwwkH+XxvvfPrbBREjo3cO
	oEYrcf/ijf9CmSrsp6J61WU+ZY6+f2cQhJMglYbD+Jvf4Ukvj+wMBttpjEK4+6cgYhD7NoGLjbK
	CPUcbm7Lu/QNHceWafOZ+ybjEs495VZ1Lm7y3vBBWSkM9cufCXIczZbnW61OnNF3JFOFfdLfecV
	bsh0cJabFda1JIqje1+9dOhtVNBXO/Tp/NoXFOpvrDA
X-Received: by 2002:a05:620a:1a10:b0:939:93f:3b41 with SMTP id af79cd13be357-93980341197mr2411106785a.16.1788795802336;
        Mon, 07 Sep 2026 08:43:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406bf8c3sm94620766d6.48.2026.09.07.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:43:21 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:43:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	SJ Park <sj@kernel.org>, peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, 
	rostedt@goodmis.org, jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, 
	tglx@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
	gnoack3000@gmail.com, ljs@kernel.org, rientjes@google.com, shakeel.butt@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/8] mm/ksm: convert process iterator to
 for_each_process_rculock
Message-ID: <ap7biSs63MDeB34i@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-4-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-4-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:29PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process() loop in mm/ksm.c with for_each_process_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: SJ Park <sj@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

