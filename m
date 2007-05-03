From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 3 May 2007 11:52:38 +0200
Message-ID: <200705031152.38933.rjw__28154.6767837883$1178185723$gmane$org@sisk.pl>
References: <200705022213.35831.rjw@sisk.pl> <200705031146.03358.rjw@sisk.pl>
	<1178185551.13233.85.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178185551.13233.85.camel@johannes.berg>
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
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 May 2007 11:45, Johannes Berg wrote:
> On Thu, 2007-05-03 at 11:46 +0200, Rafael J. Wysocki wrote:
> 
> > Well, BUG_ON() is extremely user-unfriendly, and it'd trigger even if the user
> > actually didn't intend to suspend at all.
> 
> Well, hibernation_set_ops is invoked whenever the user loads his ACPI
> module with S4 possible, and typically having a BUG_ON here will make
> the developers who wrote the code that calls hibernation_set_ops see it
> right away while they might miss the message.
> 
> I don't care much though, it just seems wasteful to have this string in
> there when it'll never be seen by anyone but the developers who create
> new hibernation_ops.

You're making the dangerous assumption that all patches get tested before
hitting users. ;-)

Greetings,
Rafael
