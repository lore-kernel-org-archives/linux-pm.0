From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Hibernation and suspend patchset
Date: Tue, 1 May 2007 10:04:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705011003230.3276-100000@iolanthe.rowland.org>
References: <200705011558.11170.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705011558.11170.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Tue, 1 May 2007, Rafael J. Wysocki wrote:

> I'm going to track and include in the patchset all patches that affect:
> - any files under kernel/power
> - any files under Documentation/power
> - include/linux/freezer.h
> - include/linux/pm.h
> - include/linux/suspend.h
> - kernel/freezer.c
> and some architecture-dependent files related to hibernation/suspend (patches
> that don't affect these files may be included too, if they are related to
> hibernation/suspend) and that have been posted for a review either to this list
> or to the LKML and have not received negative comments.
> 
> If you know of a patch that in your opinion should be included but currently is
> not, please let me know.

Shouldn't you also include all files under drivers/base/power?

Alan Stern
