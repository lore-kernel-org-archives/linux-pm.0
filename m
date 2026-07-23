Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8053630AF;
	Thu, 23 Jul 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814435; cv=none; b=j8fwBink/SMblObeBVmGyImrhBzs9nHZNzng3EB2E8bOXV+f3qISI5Nkqo1Ix6B+v2+1n5vH539wc5Es/wnd3I/nR3hRfXQpTE6cj4AFSJiDVz5e7x35hyBf/D3cpuVsz5D47/2mWXKTirFACsE0rhF8inPh1C7o3XcA3CHte5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814435; c=relaxed/simple;
	bh=TTOiuNpKd3ZCkUsJNnXQtcBfFIarUNgpz9bYK41z5To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joh7u196R+FLRvMD3K1Q9hPCGzyINAyfDmU6S/WWcL2t8h4A6G8t1XHGKm5iuPDRTgg4jklSojskmsZp4Gl6uvEJjp/RPnt6bHvZEIVMR1gBHoO1FIPumi1WsAKNs/p6G5+D37+8A6QjFSEuTx8R2wpZiaYyA/4BS2Pmrorym8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJfmqszm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJfmqszm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784814433; x=1816350433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TTOiuNpKd3ZCkUsJNnXQtcBfFIarUNgpz9bYK41z5To=;
  b=QJfmqszmoazUO4TQ/refWGwArlf6IJPRlRFK0xkl/SMmu/MyHpA1fZLZ
   J6KPIMvKuZJnjTMRZLVYWn3jOKQ5pK+TMOYIwxcIdc6S9dx5KzUcF3jnB
   wqi5GC2CTUQ3beFpsJRBvV4bWjww1EEzeJrKT1DJSfc3S8xjd8kGqPvpp
   IRn7RJdwsNvCh/8IFDIHm0ALH9bw8Bm5K/BxscfpLH4n2C4PnUL5qtSEn
   XNjaixnWuz22MwRdkgxhYbbn8u11KGwm7URWqPJgsnPiDPk+a6ae+ycYP
   Z9X3jmZPOIlyVMItHNX/wwNl0sic+1pqbp1V9DvU1AbBYPRG2gvXH+KpY
   A==;
X-CSE-ConnectionGUID: hiYwjM9US0GVdBYAznH/3A==
X-CSE-MsgGUID: +qWTSrdSR2Oep9xtgrq7uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="88008518"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="88008518"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 06:47:07 -0700
X-CSE-ConnectionGUID: 5I8g06L0RzW2DP7JqA5g0A==
X-CSE-MsgGUID: b1+2gPZ+TkuUBaWrc2aoow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="261962172"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 06:47:07 -0700
Date: Thu, 23 Jul 2026 06:47:00 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: acpica-devel@lists.linux.dev, bpf@vger.kernel.org,
	coresight@lists.linaro.org, kvm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, mptcp@lists.linux.dev,
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	virtualization@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Christian =?iso-8859-1?Q?Borntr=E4ger?= <borntraeger@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Chun-Tse Shao <ctshao@google.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	David Matlack <dmatlack@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Geliang Tang <geliang@kernel.org>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Joe Damato <joe@dama.to>,
	John Garry <john.g.garry@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Kent Gibson <warthog618@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Len Brown <lenb@kernel.org>, Leo Yan <leo.yan@linux.dev>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@arm.com>,
	Mina Almasry <almasrymina@google.com>,
	Mykyta Yatsenko <yatsenko@meta.com>, Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Monnet <qmo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Song Liu <song@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Tomas Glozar <tglozar@redhat.com>,
	Vipin Sharma <vipinsh@google.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Will Deacon <will@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willy Tarreau <w@1wt.eu>, Yonghong Song <yonghong.song@linux.dev>,
	Zhang Chujun <zhangchujun@cmss.chinamobile.com>,
	Zhang Rui <rui.zhang@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tools: Use fputc() calls in some functions
Message-ID: <amIbVOIsOeZgcBZF@tassilo>
References: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>

On Thu, Jul 23, 2026 at 12:25:25PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 23 Jul 2026 11:13:30 +0200
> Subject: [PATCH] tools: Use fputc() calls in some functions
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Single characters should occasionally be transferred into the output.
> Thus use the corresponding function “fputc” (or even “putchar”).
> 
> The source code was transformed by using the Coccinelle software.

gcc already does this transformation automatically.
