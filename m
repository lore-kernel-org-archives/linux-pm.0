From: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 18:40:44 +0100
Message-ID: <20070717174044.GA11212__23937.860193155$1184694397$gmane$org@gallifrey>
References: <200707151433.34625.rjw@sisk.pl> <20070715125855.GA1737@gallifrey>
	<200707160038.12943.rjw@sisk.pl>
	<Pine.LNX.4.64.0707151526080.25614@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707151526080.25614@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

* david@lang.hm (david@lang.hm) wrote:
> On Mon, 16 Jul 2007, Rafael J. Wysocki wrote:

> >Encryption is possible with both the userland hibernation (aka uswsusp) and
> >TuxOnIce (formerly known as suspend2).  Still, I don't consider it as a 
> >"must
> >have" feature for a framework to be generally useful (many users don't use 
> >it
> >anyway).
> 
> he's talking about the main system useing an encrypted device/partition, 
> not the hibernate image being stored encrypted.
> 
> This would require the main system 'forget' the keys when it does the 
> hinbernate and prompt for it again during the wake-up phase.

Indeed - although as I say I really don't know what you would do with
apps using the mounts at that point.   Still it seems like a 
sensible requrest from the security side.

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
