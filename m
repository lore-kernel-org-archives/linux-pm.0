From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 16:30:29 +0200
Message-ID: <200707041630.30048.rjw__1565.53272759101$1183559081$gmane$org@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707041310.11336.rjw@sisk.pl>
	<18059.33636.66185.902453@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18059.33636.66185.902453@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 4 July 2007 13:24, Paul Mackerras wrote:
> Rafael J. Wysocki writes:
> 
> > BTW, does your platform's suspend work on SMP systems?
> 
> Yes; currently we require userspace to offline all cpus other than the
> boot cpu before initiating the suspend.

This is incompatible with the code in kernel/power/main.c, since we only
disable the nonboot CPUs after devices have been suspended.  Do you think that
your framework can be modified to work without disabling the nonboot CPUs
by the user space?

> The main difficulty is actually that SMP powermacs that can suspend
> tend to have video cards that get powered off in suspend.  We know how
> to re-initialize one (the Radeon RV100 QW) but not others.  That's an
> orthogonal issue to the issues we have been discussing, though.

Sure.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
