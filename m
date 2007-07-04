From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 21:25:19 +1000
Message-ID: <18059.33695.858520.478179__16287.2056513608$1183548378$gmane$org@cargo.ozlabs.ibm.com>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707041233.18199.rjw@sisk.pl>
	<18059.31464.183382.358931@cargo.ozlabs.ibm.com>
	<200707041310.11336.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707041310.11336.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki writes:

> > > So, I gather, you're volunteering to handle suspend-related bug reports
> > > from the point in which we drop the freezer from the suspend code path?
> > 
> > Ben and I are happy to handle all the ones for the platform we
> > maintain, which currently does suspend without freezing processes. :)
> 
> I mean all platforms.  After all, the $subject change won't affect yours.

Well, I can't commit to handling all bug reports, but I am happy to
help out where I can...

Paul.
