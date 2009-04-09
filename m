From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: pm-hibernate : possible circular locking dependency
	detected
Date: Thu, 9 Apr 2009 22:45:22 +0800
Message-ID: <d82e647a0904090745j15e0e4nbb517c62c8af9ab5@mail.gmail.com>
References: <d82e647a0904050253n31bd2654s9b216465eec4d038@mail.gmail.com>
	<200904081247.08712.rusty@rustcorp.com.au>
	<1239194906.13185.93.camel@twins>
	<200904090915.18644.rusty@rustcorp.com.au>
	<20090409041746.GF20692@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090409041746.GF20692@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Rusty Russell <rusty@rustcorp.com.au>, Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2009/4/9 Ingo Molnar <mingo@elte.hu>:
>
> That's now upstream as per:
>
> =A06b44003: work_on_cpu(): rewrite it to create a kernel thread on demand
>
> So re-checking whether the warning still triggers with latest -git
> would be nice.

I don't find this warning  any longer  during pm-hibernate 2.6.30-rc1, which
have __not__ include 6b44003.

>
> =A0 =A0 =A0 =A0Ingo
>



-- =

Lei Ming
