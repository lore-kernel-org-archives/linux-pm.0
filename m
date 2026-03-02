Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67923FFAB7;
	Mon,  2 Mar 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461019; cv=none; b=s6pD1OBTdc+75j0b93SUu5XvURRCW/+LFpxujJJRM7FEkDzajZocudKJvNirhpqeQah3jJ5BYBYaQlqFIWM5t6Dk4UWzUdrxtKXnqJkW0ACDxTssZ440Qhl0a/zbfkxof4HovUZ2TJzyVitp4SENK8xFdD/HxLUH7Bv8hepCLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461019; c=relaxed/simple;
	bh=eOi621zBxOkJY1UKHW4ZO6+feq9RArS0Wq0cDsH50hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gfd9Umt3mi9e+/ShDVxQ6R5OdOUMZFD6C2qXP6122li4TyoLiJagJUuCfvGluIuOkUYe6+Q96KBtjac/wz23MYmyTSCve+rATEV35C2arurPIeZyE+y9K66nGNtKC4csi9BvzpbK8qsUqcGL9VDYWAVm0fzbAZ/nN7QQ1e5RVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2223cUk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2223cUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ECDC19423;
	Mon,  2 Mar 2026 14:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772461018;
	bh=eOi621zBxOkJY1UKHW4ZO6+feq9RArS0Wq0cDsH50hg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y2223cUkvjYf8lYJZDxKuyv8L0iTzBaH3j6FhQOjgs5aA+bbaXbTF1IxZkZV9Al3C
	 Lo/KTxpqgArklPvabIdDAElOmALZG3jaHCo1ZVAshHi2SaPPvhl48Fjffx6p11UKGa
	 a6pyqPdjAPbd8lb9rg0HhBJurH3FFmMB6zSa0NG3mroIECbWt6m88JmfasymxL0PLW
	 2GM+f5yDLwg+NyrNWmqhK5rYUqt4Z7hONlA0bmg/ZlamYi1huD1U+DabiPVzOQnlD2
	 U1H6jkDOW6gfpm9hXavn1QO1rNkcFlI/Ixm0BDH+Uu5ilSfACUbRoe+WhdFScYxNuS
	 szdsnJ1D5LMRA==
Message-ID: <502e0f7c-cdf7-4a2d-b038-cfd4b993c9bc@kernel.org>
Date: Mon, 2 Mar 2026 15:16:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] mm: add tracepoints for zone lock
Content-Language: en-US
To: Dmitry Ilvokhin <d@ilvokhin.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "linux-cxl@vger.kernel.orgkernel-team"@meta.com
References: <cover.1772206930.git.d@ilvokhin.com>
 <ae145fe890f028409f727b4921904b547346fa0b.1772206930.git.d@ilvokhin.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <ae145fe890f028409f727b4921904b547346fa0b.1772206930.git.d@ilvokhin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 17:00, Dmitry Ilvokhin wrote:
> Add tracepoint instrumentation to zone lock acquire/release operations
> via the previously introduced wrappers.
> 
> The implementation follows the mmap_lock tracepoint pattern: a
> lightweight inline helper checks whether the tracepoint is enabled and
> calls into an out-of-line helper when tracing is active. When
> CONFIG_TRACING is disabled, helpers compile to empty inline stubs.
> 
> The fast path is unaffected when tracing is disabled.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Agree with Steven; otherwise

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

