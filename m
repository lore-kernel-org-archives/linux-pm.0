From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sat, 5 May 2007 00:25:47 +0200
Message-ID: <200705050025.48825.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705041020530.3417-100000@iolanthe.rowland.org>
	<200705042353.52409.rjw@sisk.pl>
	<1178315591.7408.45.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178315591.7408.45.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 4 May 2007 23:53, Johannes Berg wrote:
> On Fri, 2007-05-04 at 23:53 +0200, Rafael J. Wysocki wrote:
> > > Plus, it may have some parts related to the communications with operating
> > > system (*)... I guess we need to save those, and parts related to hw
> > > state... where your suggestion makes sense.
> > 
> > If they are accessible to us, then we can, but what if they aren't (eg. the
> > state information is stored in the embedded controller, can only be read with
> > the help of some AML invocations and cannot be changed from the OS level)?
> 
> Well, in that case you also haven't overwritten/changed them during
> restore so there's no room for mismatches and confusion.

Not if we went for S5 to finish the hibernation and then we try to be smart and
rely on the BIOS-provided information/functionality *as though* we had passed
through S4.

Greetings,
Rafael
