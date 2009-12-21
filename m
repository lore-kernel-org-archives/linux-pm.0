From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Asynchronous suspend/resume - test results
Date: Mon, 21 Dec 2009 15:54:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912211551580.2643-100000__46319.5224911489$1261429030$gmane$org@iolanthe.rowland.org>
References: <200912212136.12665.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912212136.12665.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Dec 2009, Rafael J. Wysocki wrote:

> Do you think it's a good idea to mark all SCSI devices as async?  Well, for
> testing it probably is, but I doubt in general.

That would be a good question to post on Linux-SCSI.

In most respects it's probably okay.  But some people with large disk
farms might not like it if their drives should suddenly start to spin
up (with a correspondingly large power draw) all at the same time.

Alan Stern
