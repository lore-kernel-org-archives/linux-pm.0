Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043A3FDBED;
	Fri, 15 May 2026 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870453; cv=none; b=LlUlKyzKnav9ex8va7q8BXZR84uy7yCvCL3/8ZXwYYq0XX8QhyV5rxrlgHxvJOENhErDEY9W/haP1mvz90LwgCJ/W/E7UjLJ3TmAshJNR6FsIPYTLfL09fV9F3DzsgWtKTxGfMC4TIMzm8MZpfPSQupbzEYuG4hy/yhvlVshkFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870453; c=relaxed/simple;
	bh=NlyxVwletN8VISE8HlIqhkDzqFEYxQqO7/BjIZcgBFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqUK7pHVzD9qzJrtSWBaVG5ucl/d5M9EmIHNWReS+zqzLMSCQiLyxPN829fS6e3MFe0gnNJ0hCpUSDUmradG+38J1RB/XsC2mYvp6b/bxvxIGWWomYReIMPyvhb8Ms2Gt8QrFuPdop3rjZ0PMAmXl1b1DR7XDlwYNRJEMMgImR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id A14F3A01FD;
	Fri, 15 May 2026 18:40:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 99B596000A;
	Fri, 15 May 2026 18:40:41 +0000 (UTC)
Date: Fri, 15 May 2026 14:40:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Huang Rui
 <ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] cpufreq: amd-pstate: Use trace_call__##name() at
 guarded tracepoint call site
Message-ID: <20260515144049.10fe72fa@gandalf.local.home>
In-Reply-To: <00e25aaf-6b85-4717-9b63-2c607a446a77@amd.com>
References: <20260515140121.2239414-1-vineeth@bitbyteword.org>
	<00e25aaf-6b85-4717-9b63-2c607a446a77@amd.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 99B596000A
X-Stat-Signature: j6of5rfr46ugap6rr7hmeer1k6uaz4pi
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/zcGDGatqyq+IlbqyMXf9E/QXqIWz5W+4=
X-HE-Tag: 1778870441-136073
X-HE-Meta: U2FsdGVkX18yemvqUxsK7QQYN0EdKcHKNDLArV1Dp60Sz5Pfeqhp/hPzL5OucyPyIhgE7iaBYBgXaC3EUVub4/n1G2dT663203DolYJ2IHHtvbFqZq+rvw0rPZIZr9BAxQhFg7aE1t4BwN8i7WMxbCA4pZvtmJFnJimyQC6wHnOtAZsLzkHJ3xvkyhhuVgFVsBMqRibBrsfAWnUcwKHAU7cKtl2JyKhjqBqsIcE/Zc6anZdSMVBWhZQvTcM68O4dw90nXJfgCV7i4DLN+6hT/fUwCextG04NnALX1a1/sUKdLNR82e6AzCakMzAde/OQDDuu0FKAe2XH7fQBDuU0QMB8H7wq6b7Dy0af6nx74HyS+/PnBttTQQ==

On Fri, 15 May 2026 13:29:33 -0500
Mario Limonciello <mario.limonciello@amd.com> wrote:

> No concerns this going through another tree together.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll apply it to my tree.

Thanks,

-- Steve
