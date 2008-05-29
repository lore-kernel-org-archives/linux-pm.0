From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.26-rc4-git] PM: boot time suspend selftest
Date: Thu, 29 May 2008 14:26:18 -0700
Message-ID: <200805291426.18404.david-b__8451.13898762993$1212096574$gmane$org@pacbell.net>
References: <200805291333.42057.david-b@pacbell.net>
	<200805292301.42244.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805292301.42244.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 29 May 2008, Rafael J. Wysocki wrote:
> Two questions:
> 
> 1) How is it related to the analogous patch in the Ingo's tree?

AFAIK -- just that it's an updated version.  Comments, some
code flow, but mostly having the "test_suspend=mode" parameter
default to "safe -- no testing" and allows the choice of modes.


> 2) Does it apply to the current linux-next?

No idea.
