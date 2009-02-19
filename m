From: Brian Swetland <swetland@google.com>
Subject: Re: [RFD] Automatic suspend
Date: Thu, 19 Feb 2009 13:56:31 -0800
Message-ID: <20090219215631.GA23925__42131.5604042777$1235080843$gmane$org@bulgaria.corp.google.com>
References: <Pine.LNX.4.44L0.0902190956570.3012-100000@iolanthe.rowland.org>
	<200902192215.18365.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902192215.18365.rjw@sisk.pl>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

["Rafael J. Wysocki" <rjw@sisk.pl>]
> 
> > It might have to be platform-specific.  The Android people seem to have a
> > pretty good idea of what criteria will work for them.
> 
> I'd really like to know in what situations Androind is supposed to suspend
> automatically.

Currently, whenever the display is off (after the user-selectable
timeout), we aggressively enter suspend -- wakelocks are used to prevent
suspend when a driver or userspace entity needs the CPU to actually be
awake.

Brian
