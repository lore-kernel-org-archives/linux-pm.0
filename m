From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] [PM] Fixes missing PM entries in sysfs
 without CONFIG_PM_SLEEP
Date: Mon, 4 Aug 2008 11:14:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808041112580.2815-100000__7970.81714631549$1217863177$gmane$org@iolanthe.rowland.org>
References: <200808041703.28229.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808041703.28229.rjw@sisk.pl>
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
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, David Engraf <david.engraf@netcom.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 4 Aug 2008, Rafael J. Wysocki wrote:

> > Rafael, any objections?
> 
> Hm, well, one thing below.

> device_pm_add() can now be void and the error variable in there is not
> necessary any more.

Do you think we will want to make device_pm_add() return an error at 
some point in the future?  For example, earlier you had it fail if the 
parent device was asleep, instead of just printing a warning.

Alan Stern
