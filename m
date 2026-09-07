Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8D422A7F6
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773749; cv=none; b=WD4AHN6qAwBckHbKJ7/p4XKVvTVWxMgRZGcD2neDPn2UVpS8kbIfwTjrM/33sZYTdn6TbYw8Qi65nNvmUXUKLzNBpFlZ8AyyGKedl+ujTGC6iraLD7NmuWB9YxephlXu2Hsrb3n6jFcBoVV3CSRhJ6Q0bY0iSTrCOJvRwZ6Izt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773749; c=relaxed/simple;
	bh=+1OruMYcQA77jLKl8fk/VE7hjZNXJ6hFvLeuBJHiyjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0/fibcC0BAz7ieeVvGxNVjOLIhqcmQL211VhW3pp3a4c5vJTaShBv8DlZ+H2kC2e+Lta8/MOPE2YqvcZ0FW6K09t6FAXy4b6Xt50jNUa9g3rlKu8nDD4T1G+BamT84Q0yDShpC0c/TYcekndFh2JajYEt3PkDaEIIuO8M3ajKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjOf9nwp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjOf9nwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788773747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+1OruMYcQA77jLKl8fk/VE7hjZNXJ6hFvLeuBJHiyjQ=;
	b=RjOf9nwp6JNSXSmtINnZHU3rK3QP08aHAWOvG2TIL/pHlxTeT/7WKrhw8hHj4mdInAadSD
	6pR98cQTKGKvWcFfIW8gGgUfZyvCqC5raQePeV1u//XbtF+uyh/VtmXdkz7/FkB+mhUcrv
	qXFvnAUSTUpT7xjKXr8cxkglHhn3lMs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-U96dqzotMg279n9Gg43hkw-1; Mon,
 07 Sep 2026 05:35:46 -0400
X-MC-Unique: U96dqzotMg279n9Gg43hkw-1
X-Mimecast-MFC-AGG-ID: U96dqzotMg279n9Gg43hkw_1788773744
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E53B1801300;
	Mon,  7 Sep 2026 09:35:43 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EA98D1955F11;
	Mon,  7 Sep 2026 09:35:22 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  7 Sep 2026 11:35:43 +0200 (CEST)
Date: Mon, 7 Sep 2026 11:35:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Marco Elver <elver@google.com>, Ye Liu <liuye@kylinos.cn>,
	Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Yi Tao <escape@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>,
	paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org,
	jpoimboe@kernel.org, mic@digikod.net, tglx@kernel.org,
	akpm@linux-foundation.org, david@kernel.org, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, rafael@kernel.org, gnoack3000@gmail.com,
	ljs@kernel.org, sj@kernel.org, rientjes@google.com,
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	pavel@kernel.org, lance.yang@linux.dev, mhiramat@kernel.org,
	pmladek@suse.com, longman@redhat.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com,
	babu.moger@amd.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/8] sched: introduce for_each_process_rculock and
 for_each_thread_rculock
Message-ID: <ap6FWZ9FYjkFKoH_@redhat.com>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-2-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-2-ye.liu@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/07, Ye Liu wrote:
>
> Introduce for_each_process_rculock(), for_each_thread_rculock() and
> for_each_process_thread_rculock() macros that acquire the RCU read
> lock before the iteration starts and release it when the loop is left,
> so that the RCU read-side critical section is scoped to the loop body
> instead of an externally managed rcu_read_lock()/rcu_read_unlock()
> pair.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks, I personally like the new _rculock suffix more ;)

I see the comments about indentation from Lorenzo, I am fine either way.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

