From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Thu, 20 Sep 2007 22:46:08 -0600
Message-ID: <m1r6ksiq27.fsf__25261.6197373301$1190350242$gmane$org@ebiederm.dsl.xmission.com>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211225.25874.nigel@nigel.suspend2.net>
	<1190342757.21818.75.camel@caritas-dev.intel.com>
	<200709211259.00195.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709211259.00195.nigel@nigel.suspend2.net> (Nigel Cunningham's
	message of "Fri, 21 Sep 2007 12:58:59 +1000")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@suspend2.net
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Nigel Cunningham <nigel@nigel.suspend2.net> writes:
>
> Sounds doable, as long as you can cope with long command lines (which 
> shouldn't be a biggie). (If you've got a swapfile or parts of a swap 
> partition already in use, it can be quite fragmented).

Hmm.  This is an interesting problem.  Sharing a swap file or a swap
partition with the actual swap of user space pages does seem to be
a limitation of this approach.

Although the fact that it is simple to write to a separate file may
be a reasonable compensation.

> Andrew, you're seeing that it really doesn't mean the removal of all 
> hibernation code from the kernel being suspended, aren't you? (And if the 
> kexec'd kernel is the same binary, then there's more code again).

More binary size yes not more code to maintain.

As for the rest the current implementation is small enough and allows
for enough beyond hibernation I think it makes sense to eventually
merge assuming a good clean implementation can be achieved.

Eric
