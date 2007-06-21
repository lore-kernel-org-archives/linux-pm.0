From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep
	state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 21:52:25 +0200
Message-ID: <200706212152.26558.rjw__19759.435443166$1182455200$gmane$org@sisk.pl>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com>
	<20070621130312.GB18392@elf.ucw.cz>
	<200706210837.29857.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706210837.29857.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 21 June 2007 17:37, David Brownell wrote:
> 
> > > IMO it can be done in two different ways:
> > > 1) via a .suspend() argument
> > > 2) via a global variable that the drivers can read.
> 
> For sufficiently small values of "two" that is.  
> 
> Other solutions that have been described on the PM list include
> 
>   3) Providing accessors to the information actually needed
>      in drivers ... e.g. say whether this clock or power domain
>      will be available in that target state.

Well, you need to store that information somewhere.  The way in which
it will be provided to drivers is a secondary thing.

To me, the most important question is whether we want to pass that information
as a .suspend() argument or in any different way, which involves the use of a
global variable (or a set of variables) and that's 2).

>   4) Act more like "current" ... there's a function returning
>      whatever "state" struct is settled on.  (But ideally
>      without the pseudo-global.)

How would you be going to arrange that in practice?

> I'm amused that nobody really reacted to the technical comments in
> my previous posts on this thread.  That's unfortunate, since from
> where I sit it feels to me like everyone else is a johnny-come-lately
> on this issue, and is now grasping at the quickest and dirtiest ways
> to work around the issue instead of coming to grasp with the various
> underlying issues.
> 
> IMO #3 is strongly preferable.

Of course we can do that.  At least I don't have any objections.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
