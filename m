From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 10:15:01 +1000
Message-ID: <18060.14341.341604.666867__20483.8654878133$1183595067$gmane$org@cargo.ozlabs.ibm.com>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707041310.11336.rjw@sisk.pl>
	<18059.33636.66185.902453@cargo.ozlabs.ibm.com>
	<200707041630.30048.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707041630.30048.rjw@sisk.pl>
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

> This is incompatible with the code in kernel/power/main.c, since we only
> disable the nonboot CPUs after devices have been suspended.  Do you think that
> your framework can be modified to work without disabling the nonboot CPUs
> by the user space?

Sure.  It was a "if it can be done in userspace, do it in userspace"
kind of decision, but I'm not wedded to it.

I actually do want to converge to using the generic suspend-to-ram
code on powerbooks.  I just want to avoid causing regressions for
powerbook users, including myself. :)

Paul.
