From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] [PM] Fixes missing PM entries in sysfs
	without CONFIG_PM_SLEEP
Date: Mon, 4 Aug 2008 17:24:22 +0200
Message-ID: <200808041724.24016.rjw__10872.4897531376$1217863674$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0808041112580.2815-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0808041112580.2815-100000@iolanthe.rowland.org>
Content-Disposition: inline
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
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, David Engraf <david.engraf@netcom.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 4 of August 2008, Alan Stern wrote:
> On Mon, 4 Aug 2008, Rafael J. Wysocki wrote:
> 
> > > Rafael, any objections?
> > 
> > Hm, well, one thing below.
> 
> > device_pm_add() can now be void and the error variable in there is not
> > necessary any more.
> 
> Do you think we will want to make device_pm_add() return an error at 
> some point in the future?

Well, maybe, but not any time soon. :-)

> For example, earlier you had it fail if the parent device was asleep, instead
> of just printing a warning. 

Yes, I remeber it, but there still are some drivers that would break if we
did that.

Anyway, I think it won't be hard to change device_pm_add() to return error
codes again if we decide to in future.

Thanks,
Rafael
