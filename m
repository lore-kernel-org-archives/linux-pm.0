From: Jay Cliburn <jacliburn@bellsouth.net>
Subject: Re: Suspend, followed by immediate resume
Date: Sat, 3 May 2008 07:58:21 -0500
Message-ID: <20080503075821.673b1b14@osprey.hogchain.net>
References: <20080501214437.0ae618c5@osprey.hogchain.net>
	<20080502210529.56b11328@osprey.hogchain.net>
	<200805031432.12250.rjw@sisk.pl> <200805031450.19960.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805031450.19960.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 3 May 2008 14:50:19 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> BTW, have you tested it with init=/bin/bash already?

No.  Is mounting /proc and /sys manually as simple as this?

mount -t proc rw proc /proc
mount -t sysfs rw sysfs /sys

What sort of suspend/resume behavior am I looking for when I use
init=/bin/bash?
