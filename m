From: Paul Mackerras <paulus@samba.org>
Subject: Re: shrinking memory for suspend?
Date: Thu, 3 May 2007 22:51:36 +1000
Message-ID: <17977.56024.199983.463385@cargo.ozlabs.ibm.com>
References: <1177943076.5102.83.camel@johannes.berg>
	<200705031217.30979.rjw@sisk.pl>
	<17977.47777.929627.2150@cargo.ozlabs.ibm.com>
	<200705031245.05454.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705031245.05454.rjw@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki writes:

> > Which is why the powermac/powerbook sleep code insists on there only
> > being one cpu active.  I have an SMP powermac which can sleep; I use a
> > little script to take the second cpu down before sleeping and bring it
> > back up after waking up.
> 
> That's quite intrusive.  Ideally, user space processes should not notice that
> there have been a suspend at one point.

Certainly, *most* userspace processes should not notice, and they
don't.  But the process initiating the suspend most certainly knows
about the suspend happening.  And that's the one that arranges for
taking the second cpu down and bringing it up.  So your objection
seems silly to me, unless you meant something other than what your
words seem to say.

Paul.
