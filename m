From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2.6.26-rc4-git] PM: boot time suspend selftest
Date: Fri, 30 May 2008 12:04:51 -0700
Message-ID: <20080530120451.5cb9d664.akpm@linux-foundation.org>
References: <200805291333.42057.david-b@pacbell.net>
	<20080529162257.03426e48.akpm@linux-foundation.org>
	<20080530105948.GA12236@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080530105948.GA12236@elte.hu>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

On Fri, 30 May 2008 12:59:48 +0200 Ingo Molnar <mingo@elte.hu> wrote:

> * Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > > +	WARN_ON_ONCE(msec > (TEST_SUSPEND_SECONDS * 1000));
> > 
> > We should have a comment here explaining what we're warning about.  
> > Why would it take more that five seconds?
> 
> i asked for that because we had regressions in the past in the form of 
> "it takes one minute to resume".

It is not possible for a reader to learn this from either the kernel
source nor from the changelogs.

Hence...
