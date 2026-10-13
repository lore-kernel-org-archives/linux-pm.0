Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178737C115;
	Tue, 13 Oct 2026 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791856176; cv=none; b=ncdTZ1yBBTKg6uU1O7FnBshJNAPiNncTqXUs5A+puYIv7VSEcFHgGA3J7grzCBmrBl8CZ4jkNB/Z8h15IKfdiWv6PEdaD8z8/DD5eZMR4bX0eKFxROQJW1bBKbjo1Z+2RG2M/hwugVPz+ZK/GocynjwR826B549C8rjlaFEh7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791856176; c=relaxed/simple;
	bh=plGdVSlqb35R3qnpCsCIhy+Ug2HYFCfvMhF2GQJbCto=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODBP7tXpxcwDtBcYEYV3+XLDFBusApzoNNBOPIXchPVhk+w7dGsYHGT2NqNTCB+Nk2RxM1G1vy0+lhUCTt7zUpI29xN8m6Kx7vhTfs8wj7ENsKitxaZamDQobu20TH3UGRmdxIekEatwh5PE+cg+extoLN5ECXduJOjjuE5wV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g4uNMJIx; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g4uNMJIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Message-ID:To:Subject:MIME-Version:
	Content-Type; bh=Bk7vNVIzvwlhGKuORjsthkVABBxxeTYA//wGfPVVrJo=;
	b=g4uNMJIx+r9v2feoI2p+JdiwHxJBsrXYuPCV+JTVUXQqtYKf37dNh2Ek5xFVu1
	PWgU6J9/kn+UHsrQpHS1CrS0a29a+kPabsuq9iTcXQ+UKNL7Uh+vaU1iOzDulld7
	MUZXZ2kQe7F8kxYTMYoFrS5O8qooDGKHRrw8D+dHq55vE=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3f3zdjc1q+PS1Dw--.42686S2;
	Tue, 13 Oct 2026 09:48:14 +0800 (CST)
From: Hui Su <sh_def@163.com>
Date: Tue, 13 Oct 2026 10:32:02 +0900
Message-ID: <179185512249.2280940.7181297775843011626@163.com>
To: Rafael J. Wysocki <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: schedutil: Serialize start against rate limit updates
In-Reply-To: <CAJZ5v0iHXc4+si4TspPB+oNyPNED+9s90B7VJwrMa91J6GOGCg@mail.gmail.com>
References: <20261007155820.3194105-1-sh_def@163.com>
	<CAJZ5v0iHXc4+si4TspPB+oNyPNED+9s90B7VJwrMa91J6GOGCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f3zdjc1q+PS1Dw--.42686S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr1fCF1kAw1kJw17WFWfZrb_yoWxKrX_Wa
	4kGrnrJwnYyFsxta1qkFsI9w4UKryF9r9xZay7ur17J34fXFZ5Xrn7Xw1fu3ZYya4Fkw4D
	KFn0vryxWry3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU9jjPUUUUU==
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6h6oCGrNjd5mgAAA3G

> But instead, I'd add a wrapper around sugov_update_rate_limit_us() that would do
>
>     guard(mutex)(&sg_policy->tunables->attr_set->update_lock);
>
> before calling it and I'd invoke that wrapper from here.
>
> Also, the comment should explain why the locking is needed which it
> doesn't do now.

Agreed. I removed the generic gov_attr_set lock helpers and added a
schedutil-local wrapper using guard(mutex) around the raw update helper.

The comment now explains how an unsynchronized start can overwrite the
cached delay with a value derived from a stale rate_limit_us value.
rate_limit_us_store() continues to call the raw helper while holding
update_lock.

I'll send v3 separately.

Thanks,
Hui

