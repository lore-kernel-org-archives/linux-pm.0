From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Sat, 13 Jun 2009 14:08:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906131404160.25619-100000__9968.97573718361$1244916561$gmane$org@netrider.rowland.org>
References: <200906130106.58464.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906130106.58464.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 13 Jun 2009, Rafael J. Wysocki wrote:

> So, the conclusion seems to be that we should break the recurrence
> at the point we find an already active device or a device with no parent and
> let the driver(s) handle the more complicated cases.  Is this correct?

That's right.

> BTW, is __device_release_driver() the right place for blocking the run-time PM
> temporarily during remove?

It is.  And for submitting a delayed autosuspend request afterward; we
may as well try to suspend devices that don't have drivers.

Alan Stern
