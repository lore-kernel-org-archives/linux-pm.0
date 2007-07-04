From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 21:24:20 +1000
Message-ID: <18059.33636.66185.902453@cargo.ozlabs.ibm.com>
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

> BTW, does your platform's suspend work on SMP systems?

Yes; currently we require userspace to offline all cpus other than the
boot cpu before initiating the suspend.

The main difficulty is actually that SMP powermacs that can suspend
tend to have video cards that get powered off in suspend.  We know how
to re-initialize one (the Radeon RV100 QW) but not others.  That's an
orthogonal issue to the issues we have been discussing, though.

Paul.
