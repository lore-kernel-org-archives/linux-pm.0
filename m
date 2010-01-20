From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Update][RFC][PATCH] PM / Runtime: Add sysfs switch
 for disabling device run-time PM
Date: Wed, 20 Jan 2010 16:37:35 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001201637001.1360-100000__17930.0638767474$1264023511$gmane$org@iolanthe.rowland.org>
References: <201001202209.29207.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001202209.29207.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 20 Jan 2010, Rafael J. Wysocki wrote:

> > Does anybody have a suggestion for a better attribute name?
> 
> Apparently not, but I can try. ;-)
> 
> * status
> 
> * power (power/power looks weird, but the values would make sense)
> 
> * control
> 
> No more ideas for now.

I vote for "control".

Alan Stern
