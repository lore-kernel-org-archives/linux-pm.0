Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842701;
	b=xMc1Ao+kW4e4nCUgQ5TTOIWAkdimIXSekklPbbnQmHGVwJ3WMUPlKv/FDaj1zbshInBl
	 lGMI5NQ4mNNNQ6BOUwrt/h7tHCcUzvb2zFnNKw+8mwXa+WJa4DW3fB9sHs6QgDi1/Npec
	 zRzBWrefwbRAwD6YbJ6XpGwrmnV1vEJGeSJGdSi0N2kD6u2O7x/sIVEgwhYnQAUX7lmTX
	 dcNfhwj6d/EqsO4/puxKfujU2nrMjPWYJWntZbJwX6OuJEFGkmHBBzIhzQhewzZLYLuPj
	 L3Kv0zhGjxiHQgYpNrLa75t9cq3i+dFPG+986oVjGBxz96m/ktzKAHuluVnLP2MiKmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842701;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OShwcgume0qsMyIroIng9kRw/hq2uAXrc3M/m6vyoT4=;
	b=AbOiz0l/x3uUqUP9WK+3Z0wMiOg9T2aMuwUus28/jt5byCGdOny/ts+DDc5oc4MvdoXU
	 HFLIx3BzzVllp2eFo4rzt29spoghBLk7ouhLfBoA/IOK1jh8gf3JJHKMVwRJQ8+/1xz7r
	 IusR2CvsbMo3d5ehpF/O/g1zD5V+hvFlpAv+o9SRNeBOwZgxaJf4KdWe5vyGYy9M6n7P/
	 Sln+vAPwi/zYXQ6uRIwJaTyNY2AwFjnxsT3muurPzygen9wLWDrRE3YxbcMRE3VAmQYJT
	 KTJt1B9f7vdPM0KE7jRZTMrw5r2jtPkeOXqb6fKVvyi9TJ3eGEhsXpoTkqD8Cx0gPqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xf4EfoLE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A5E606A31C;
	Mon, 16 Nov 2026 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xf4EfoLE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCFA1F000C7;
	Mon, 16 Nov 2026 15:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842701;
	bh=OShwcgume0qsMyIroIng9kRw/hq2uAXrc3M/m6vyoT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xf4EfoLEajFX2rYfuGfjGhxn0V16UuC0Gkc26HEpPAmEcT4XxwDIYJaGDq6O3mUKS
	 JaFf2Qyd4qSfjRiUggJas4f0AJImSx70CU6tyrNajNRoo4in4AlnZ9OA/Qwgfkux06
	 H0FQsgCWyRe1hgfVsUT85i7xBe+UFKATOMfr49X6DCNx3Wox9Yy1y16YTqFdTz3jXJ
	 lTnYEHZTDhZ1oip22q6uyoqm+MOwZZMH1zE007qRK2bH9++oa2JMahEJ5ERw/x0pml
	 LMIe+x96RDu0ThNG6IuxGT19ZhHr9VULtu8PK43AX5Hi6McOoluC+BBv29el1rySf2
	 1a6++Ygt2kieA==
Date: Mon, 16 Nov 2026 15:24:57 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org,
	arm-scmi@vger.kernel.org, philip.radford@arm.com
Subject: Re: [PATCH 3/3] powercap: arm_scmi: Refactor scmi_zones_register
 error path
Message-ID: <20261116-imperial-mighty-platypus-edbffe@sudeepholla>
References: <20261115110546.2344308-1-cristian.marussi@arm.com>
 <20261115110546.2344308-4-cristian.marussi@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115110546.2344308-4-cristian.marussi@arm.com>

On Sun, Nov 15, 2026 at 11:05:46AM +0000, Cristian Marussi wrote:
> Refactor and simplify scmi_zones_register error path by using
> cleanup handlers.
> 
> No functional change.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

Hi Rafael,

Can you pick up 1/3 and 2/3 as fix for v7.4 and this refactoring for v7.5 ?

IIUC, the refactoring is done at last to keep fixes simple for backport.

-- 
Regards,
Sudeep
