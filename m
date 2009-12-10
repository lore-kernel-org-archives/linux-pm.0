From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 14730] sky2 won't work after suspend/resume
	cycle
Date: Thu, 10 Dec 2009 20:13:49 +0100
Message-ID: <200912102013.49467.rjw__13990.5993165032$1260472473$gmane$org@sisk.pl>
References: <bug-14730-10028@http.bugzilla.kernel.org/>
	<200912101036.nBAAacka024465@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912101036.nBAAacka024465@demeter.kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: Linux PCI <linux-pci@vger.kernel.org>, akpm@linux-foundation.org, shemminger@linux-foundation.org, pm list <linux-pm@lists.linux-foundation.org>, mat@esi.com.pl
List-Id: linux-pm@vger.kernel.org

On Thursday 10 December 2009, bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=14730
> 
> --- Comment #11 from Ilya Hegai <vyacheslavovich@gmail.com>  2009-12-10 10:36:36 ---
> (In reply to comment #9)
> > On Monday 07 December 2009, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=14730
...
> > It may be worth trying to revert 
> > 
> > commit 4b77b0a2ba27d64f58f16d8d4d48d8319dda36ff
> > Author: Rafael J. Wysocki <rjw@sisk.pl>
> > Date:   Wed Sep 9 23:49:59 2009 +0200
> > 
> >     PCI: Clear saved_state after the state has been restored
> > 
> > and retesting.
> 
> I'm not familiar with git, but I haven't found traces of that commit in
> 2.6.31.7 that I'm using (gentoo-sources) (and the problem exists there)
> but after I applied it (got it from git) - sky2 errors after hibernation/resume
> dissapeared
> And as I can see this patch has applied against 2.6.32, so I guess TS person is
> considered to upgrade to the latest kernel

Hmm.  The original report is against 2.6.32-rc8.

So you're saying that the commit above, when applied against 2.6.31.7,
actually fixes a sky2 resume problem for you?

Maciej, can you please check if 2.6.31.7 with the above commit applied works
for you?
