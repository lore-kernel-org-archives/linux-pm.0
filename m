From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][RFC][PATCH] PM / Runtime: Add sysfs switch
	for disabling device run-time PM
Date: Wed, 20 Jan 2010 23:17:46 +0100
Message-ID: <201001202317.46293.rjw__1768.77722046829$1264026011$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1001201637001.1360-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1001201637001.1360-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 20 January 2010, Alan Stern wrote:
> On Wed, 20 Jan 2010, Rafael J. Wysocki wrote:
> 
> > > Does anybody have a suggestion for a better attribute name?
> > 
> > Apparently not, but I can try. ;-)
> > 
> > * status
> > 
> > * power (power/power looks weird, but the values would make sense)
> > 
> > * control
> > 
> > No more ideas for now.
> 
> I vote for "control".

OK, if no one objects, I'll use that in the next "release" of the patch.

Rafael
