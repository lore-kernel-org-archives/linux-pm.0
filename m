Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06B48094A;
	Thu, 23 Jul 2026 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817251; cv=none; b=Ee7xe17cnZLanVLAs+LpN3PODZmPsGaqvqRHe0QmNgA/H9WCRhQk75pPQI78kH60yBUdrj8uJYSb4kFFObQ315LJ3O+85/sujhReieo2ymoGOXNFvH163jA+hx0/eaAO6q52IAHyIP03ARzpiLgfEMf0bB38DRvX3VVh/rqgMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817251; c=relaxed/simple;
	bh=rnzS3t2OB9mXDKCdXxoAM7rMpi7xvwiWGRBta5UVvXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4286ReeLlbLgg6NSwPv/tAeBeUuPeRKPpD+63RxzXwhCBFKE3xeZsZk76exZjg9qxv/urKP5tSUor9FKWjpF9R47y7ooP9xMwd8Rn/V/VQKKbzUV9ljEC4ALALsnXn0mP0OfuoCn/tQtOa7MrzmemnmCVN9EyQswzHWJOhaYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 99A3DC04D7;
	Thu, 23 Jul 2026 14:34:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 056E717;
	Thu, 23 Jul 2026 14:33:13 +0000 (UTC)
Date: Thu, 23 Jul 2026 10:33:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, acpica-devel@lists.linux.dev,
 bpf@vger.kernel.org, coresight@lists.linaro.org, kvm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 virtualization@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
 Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Morton
 <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, Ankur
 Arora <ankur.a.arora@oracle.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Bobby Eshleman
 <bobbyeshleman@meta.com>, Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?=
 <borntraeger@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>,
 Chun-Tse Shao <ctshao@google.com>, Claudio Imbrenda
 <imbrenda@linux.ibm.com>, Costa Shulyupin <costa.shul@redhat.com>, Crystal
 Wood <crwood@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, David Hildenbrand <david@kernel.org>,
 David Matlack <dmatlack@google.com>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Eduard
 Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Eric
 Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Geliang Tang <geliang@kernel.org>, Ian Rogers <irogers@google.com>, Ingo
 Molnar <mingo@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, James Clark <james.clark@linaro.org>,
 Janosch Frank <frankja@linux.ibm.com>, Jason Xing
 <kerneljasonxing@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Joe Damato
 <joe@dama.to>, John Garry <john.g.garry@oracle.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
 Kent Gibson <warthog618@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Len Brown <lenb@kernel.org>, Leo Yan
 <leo.yan@linux.dev>, Lukasz Luba <lukasz.luba@arm.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Martin KaFai
 Lau <martin.lau@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Mike Leach <mike.leach@arm.com>,
 Mina Almasry <almasrymina@google.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 Nam Cao <namcao@linutronix.de>, Namhyung Kim <namhyung@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Quentin Monnet <qmo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Raghavendra Rao Ananta <rananta@google.com>, Saket Dumbre
 <saket.dumbre@intel.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, Song Liu <song@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Stefano Garzarella <sgarzare@redhat.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>, Tomas Glozar
 <tglozar@redhat.com>, Vipin Sharma <vipinsh@google.com>, Wander Lairson
 Costa <wander@redhat.com>, Will Deacon <will@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Willy Tarreau <w@1wt.eu>, Yonghong Song
 <yonghong.song@linux.dev>, Zhang Chujun <zhangchujun@cmss.chinamobile.com>,
 Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tools: Use fputc() calls in some functions
Message-ID: <20260723103336.6593118b@gandalf.local.home>
In-Reply-To: <amIbVOIsOeZgcBZF@tassilo>
References: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>
	<amIbVOIsOeZgcBZF@tassilo>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ncsjbmpq4hct7p4sj4iefr1r53tacukj
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 056E717
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+f7u83oRUulG9XwKl2P+q3kHYGrSLtLJ0=
X-HE-Tag: 1784817193-538669
X-HE-Meta: U2FsdGVkX19mSJrQ4yCgpa5T21s3DOyupJQtrDkbhb4BdFNkpGoXwq/ibfVmVhXFNmqX8uwKJldaBwfXYwLpcFxk6WAoDZEXT/gOP4/87ir9dCPM++yAwBRZudspVL4fEcLJ8BQR+IIioDSpRN3BUfGiJrTRVS7/uta9AmYBpm0bV/zvbFblUCnE1I0vyxTsAPHkh0LX+JrCxO4Fb8yldd7jKVRG3hDwMmD/y539S+5vq64BAxIp9RMpMFz5panzgBl/T6DnlC5NF2X6cBflLJ9t5of1YaVukjrextWC1Mkdf4ypcuVGdK7IR4N2F6BEhF3E+awXwxrLnbww9pI6GrXPJih6633rwSWNy/mC4FmaOinac79jHA==

On Thu, 23 Jul 2026 06:47:00 -0700
Andi Kleen <ak@linux.intel.com> wrote:

> > The source code was transformed by using the Coccinelle software.  
> 
> gcc already does this transformation automatically.

Yep, I showed this in my talk[1] that looked at what printf("Hello World!")
does. Doing an objdump of:

#include <stdio.h>

int main(void) {
	printf("Hello World!\n");
	return 0;
}

has:

0000000000001139 <main>:
    1139:       55                      push   %rbp
    113a:       48 89 e5                mov    %rsp,%rbp
    113d:       48 8d 05 c0 0e 00 00    lea    0xec0(%rip),%rax        # 2004 <_IO_stdin_used+0x4>
    1144:       48 89 c7                mov    %rax,%rdi
    1147:       e8 e4 fe ff ff          call   1030 <puts@plt>  <<<--- puts and not printf
    114c:       b8 00 00 00 00          mov    $0x0,%eax
    1151:       5d                      pop    %rbp
    1152:       c3                      ret

-- Steve

[1] https://www.youtube.com/watch?v=JRyrhsx-L5Y
