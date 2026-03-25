Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F1282F10;
	Wed, 25 Mar 2026 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448358; cv=none; b=vDAw1pm2aeXj/310OjhZiOsjk0/PKgDaMZQbYGxDpwfdMvozyHrlNOvtelwQ0Js4n05r0iFTXcKUTFxmAgMEHNPhpYTyM1FtNm5OeUxtCUbyLm4W1pFluU2DAYckZmKD5cmbTlLO74dyiwvza2JSENI5k78FNyjoK97p1oVk+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448358; c=relaxed/simple;
	bh=ZeGQEvKxl/a7OqySIBQJZab1cA8jCZGtkUoJQzQICMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUni6ym0yOuTkiwOAM9e3Fgb5uyE/IRu/QH/o5zniixHW+3EmB74xiEi6C9X1YpmX28Yo+rZ0udDcC6v2KXCT2Sr/q2KlgxGx0Y9oup1VAO3EpLe6mlMsT3cRfK3GqrasY3MnlpZJrXNhLxEEYaS5g14W+hrgOkUyLdbehPHT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 27EDABBCAB;
	Wed, 25 Mar 2026 14:19:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id AC7222002C;
	Wed, 25 Mar 2026 14:19:07 +0000 (UTC)
Date: Wed, 25 Mar 2026 10:19:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
 <willy@infradead.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Oscar
 Salvador <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/5] mm: zone lock tracepoint instrumentation
Message-ID: <20260325101946.41c613ab@gandalf.local.home>
In-Reply-To: <acPRq1YPeGR8EqMB@shell.ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
	<aa7G1nD7Rd9F4eBH@casper.infradead.org>
	<aa7XdpIVtLFS3FIu@shell.ilvokhin.com>
	<aa7dgQDMEz34eadj@casper.infradead.org>
	<20260309151317.7bba06dd@gandalf.local.home>
	<aa8xawMxLeUjkyHx@casper.infradead.org>
	<20260309171700.063318b5@gandalf.local.home>
	<abhAoF5EpiPigsx7@shell.ilvokhin.com>
	<abv4riGLlubast8v@shell.ilvokhin.com>
	<20260324163918.1a3c5c960d85a4243c9ae314@linux-foundation.org>
	<acPRq1YPeGR8EqMB@shell.ilvokhin.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1runj8rhu9a1351cakufi84eft4cwmoc
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: AC7222002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/EMkt4khKrTUfV151jFVgSJ/6WQG5xPGI=
X-HE-Tag: 1774448347-522659
X-HE-Meta: U2FsdGVkX18CJYrOTc7hVR96FhN5yCibV3LQj4C7QJWHQd5CtYPpmFI5Ak5tJTbML02SPWJJs1n1pcrr5b+mM2O/2nhj0D1ILm08d78uSc4jhaXkh0u/jOFtbXpv5AQIp9xh12/yPSQdsTUpCjwCSvCF+PTrOg/MhY1uejk0xP3xxfiHPmkMH5dcttFZpoXUYEyQZsCd8fbix5P+GQwn6p1kpygA+K0H+WufhLP9mP/6JmyLh/zYaVXSBQZUWecJCX4l3TSg6BaEGAztVQB5Fv2ERbA3GLl88MUAKldXSJLQ272axuD9DrgZjtjipA7SdjKT4ErE0byYNs1x7SKz2ePVbrZg8IWANBEzEzAvpoBoJ2BRSn1lGDkwBPiLB2h/

On Wed, 25 Mar 2026 12:14:35 +0000
Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> > Please send that v2 sometime and hopefully Steven can help push it along?  
> 
> I'll send the next version of the generic locking series soon. Any help
> in pushing it along would be appreciated.

I'll see what I can do when I see v2!

-- Steve
