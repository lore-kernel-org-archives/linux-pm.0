Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D0733DEC2;
	Thu, 23 Jul 2026 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819831; cv=none; b=NdGdT8qBw2hxo/WhTNuidrVBjbNda0gMPtrALkwMNif2wvW4x+7NA9/SBL+iZceawSt9hVumx+LGg5vQtjqpRjtzxTOxvFzgnwQy7/qvFSJxbdD3+GRNqP47sSJ9dseeXL1bY/DbEp8xPpQMXH82OeZ+Q/v481FOPFXA6ikis94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819831; c=relaxed/simple;
	bh=WfY8nqKuTsiHSSWHKLtcZI05puT7uLfuQEDUgUGR9l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epFSFATB69uHK2yIHbAvKBRH8DCorhK+U4YJObd0UUZZejDCKQDI0Iwwrk8KA2su3dQ8BQkzdRNnMekR46Y0AUJGq3ax/E9lY3iq0ejCFr2suz4liReYIuKbfjv5Ho8HuUYRgnnhEabQ6jh/yDOChFu2V7Mz+3tRqY6A9k1muVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 66NFEMq5259803;
	Thu, 23 Jul 2026 10:14:22 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 66NFECrd259732;
	Thu, 23 Jul 2026 10:14:12 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 23 Jul 2026 10:14:12 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, acpica-devel@lists.linux.dev,
        bpf@vger.kernel.org, coresight@lists.linaro.org, kvm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mptcp@lists.linux.dev,
        netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        virtualization@lists.linux.dev,
        Adrian Hunter <adrian.hunter@intel.com>, Alex Mastro <amastro@fb.com>,
        Alex Williamson <alex@shazbot.org>,
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
        Jakub Kicinski <kuba@kernel.org>, James Clark <james.clark@linaro.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Jason Xing <kerneljasonxing@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Damato <joe@dama.to>, John Garry <john.g.garry@oracle.com>,
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
        Michael Ellerman <mpe@ellerman.id.au>, Mike Leach <mike.leach@arm.com>,
        Mina Almasry <almasrymina@google.com>,
        Mykyta Yatsenko <yatsenko@meta.com>, Nam Cao <namcao@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Quentin Monnet <qmo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Saket Dumbre <saket.dumbre@intel.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>, Song Liu <song@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Tomas Glozar <tglozar@redhat.com>, Vipin Sharma <vipinsh@google.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Will Deacon <will@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Yonghong Song <yonghong.song@linux.dev>,
        Zhang Chujun <zhangchujun@cmss.chinamobile.com>,
        Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tools: Use fputc() calls in some functions
Message-ID: <amIvxECTIM5paT94@gate>
References: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>
 <amIbVOIsOeZgcBZF@tassilo>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amIbVOIsOeZgcBZF@tassilo>

On Thu, Jul 23, 2026 at 06:47:00AM -0700, Andi Kleen wrote:
> On Thu, Jul 23, 2026 at 12:25:25PM +0200, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Thu, 23 Jul 2026 11:13:30 +0200
> > Subject: [PATCH] tools: Use fputc() calls in some functions
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=UTF-8
> > Content-Transfer-Encoding: 8bit
> > 
> > Single characters should occasionally be transferred into the output.
> > Thus use the corresponding function “fputc” (or even “putchar”).
> > 
> > The source code was transformed by using the Coccinelle software.
> 
> gcc already does this transformation automatically.

Yup.  And the printf() form is much more regular, expected, readable.
The primary consumers of source code are human beings, all programs
should be written with that in mind!


Segher
