From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 8/8] intel_idle: create a native cpuidle
 driver for select intel processors
Date: Thu, 27 May 2010 20:22:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005272009490.24823__48941.2233852365$1275006254$gmane$org@localhost.localdomain>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<e099975ca65a7f6ac7f8bc3fee84d3e03893aa31.1274926772.git.len.brown@intel.com>
	<198450ec1600d9a7f55270dd4d44d6b55bc5b184.1274926772.git.len.brown@intel.com>
	<87ljb5l9d5.fsf@deeprootsystems.com>
	<20100527072207.2e783b1e@infradead.org>
	<87ocg1jts7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <87ocg1jts7.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


> >> >  drivers/idle/intel_idle.c       |  446

> >> Any reason this arch-specific driver needs to be in drivers/idle
> >> instead of under a platform specific dir like arch/x86?

> To me that would be much less convenient as I expect to maintain my
> platform-specific CPUidle driver along with the rest of my
> platform-specific code.

I guess the reason is conveneince of the maintainer (me).

A good case could be made to put this driver under
drivers/cpuidle/, arch/x86/, drivers/platform/x86/,
as well as drivers/idle/ -- and maybe someplace else
that I didn't think of.

Maybe if I maintained all of arch/x86/, then I'd naturally
propose putting it someplace under arch/x86/.  But like i7300_idle,
it runs on only a sub-set of x86 boxes, so it seemed to
make sense to put it with i7300_idle.

BTW. There is an sfi_idle driver in the pipeline as well
with the same naming issue.  It is x86 specific, sfi-specific,
and cpuidle-specific -- so a case could be made to put it in
arch/x86/, drivers/sfi/, drivers/cpuidle/ -- but it will
just as likely land in drivers/idle/.

cheers,
Len Brown, Intel Open Source Technology Center
