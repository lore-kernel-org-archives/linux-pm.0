From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 13:54:36 +0200
Message-ID: <200707051354.37671.rjw__40447.1692433164$1183636087$gmane$org@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707041630.30048.rjw@sisk.pl>
	<18060.14341.341604.666867@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18060.14341.341604.666867@cargo.ozlabs.ibm.com>
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

On Thursday, 5 July 2007 02:15, Paul Mackerras wrote:
> Rafael J. Wysocki writes:
> 
> > This is incompatible with the code in kernel/power/main.c, since we only
> > disable the nonboot CPUs after devices have been suspended.  Do you think that
> > your framework can be modified to work without disabling the nonboot CPUs
> > by the user space?
> 
> Sure.  It was a "if it can be done in userspace, do it in userspace"
> kind of decision, but I'm not wedded to it.
> 
> I actually do want to converge to using the generic suspend-to-ram
> code on powerbooks.  I just want to avoid causing regressions for
> powerbook users, including myself. :)

Okay, but my question is this: Would that be possible, within your framework,
to disable the nonboot CPUs _after_ suspending devices?

Can you please point me to your high-level suspend code?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
