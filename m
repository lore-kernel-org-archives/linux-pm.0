From: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: syncing the disks when entering sleep
Date: Fri, 22 Jan 2010 07:59:53 -0800
Message-ID: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

I noticed when we enter sleep states, it seems there's always a
sys_sync given.

When having an embedded system doing WOL (already in laptop mode to
cache
all the writes), it reasonable to wake up dozens of times of day and
quickly go back to sleep.  If the disk is not spun up,
and there's some work to be done, won't the sys_sync spin up the disk
before going to sleep?

It would be good to have a knob (in /sys) you can tweak from usespace to

configure the behavior of whether you want to do a sync when entering
sleep.

The ideal behavior would be:

    if(disk is spun up)
        then let the sync happen

marty
