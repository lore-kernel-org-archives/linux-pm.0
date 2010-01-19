From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][RFC][PATCH] PM / Runtime: Add sysfs switch
	for disabling device run-time PM
Date: Wed, 20 Jan 2010 00:27:12 +0100
Message-ID: <201001200027.12466.rjw__3394.68085808239$1263943767$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1001191035150.1437-100000@iolanthe.rowland.org>
	<201001192132.26765.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001192132.26765.rjw@sisk.pl>
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

On Tuesday 19 January 2010, Rafael J. Wysocki wrote:
> On Tuesday 19 January 2010, Alan Stern wrote:
> > On Mon, 18 Jan 2010, Rafael J. Wysocki wrote:
... 
> > Don't forget to add an entry to Documentation/ABI/testing/.
> 
> OK

Actually, not in this patch.

There doesn't seem to be room for the /sys/devices/.../power/* attributes at
all right now and I don't think this particular patch is the right one for
adding them all.

Rafael
