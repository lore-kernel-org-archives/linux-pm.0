From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] libata: skip EH autopsy and recovery during
	suspend
Date: Thu, 2 Sep 2010 23:09:56 +0200
Message-ID: <201009022309.56824.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009021646510.1311-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009021646510.1311-100000@iolanthe.rowland.org>
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
Cc: Tejun Heo <htejun@gmail.com>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 02, 2010, Alan Stern wrote:
> On Thu, 2 Sep 2010, Tejun Heo wrote:
> 
> > Hello,
> > 
> > On 09/02/2010 10:28 PM, Rafael J. Wysocki wrote:
> > > That would be very nice.  In particular, I'd like to get rid of the
> > > pm_message_t thing if possible.  And I'd like to avoid putting the
> > > controller into D3 before creating hibernation image. :-)
> 
> Ultimately I don't think it will be possible to get rid of pm_message_t
> throughout the entire kernel.  Not just because it's a legacy thing
> spread all over the place, but because it sometimes is genuinely
> useful.  In situations where there are only minimal differences between
> the various suspend/resume paths, it makes a lot of sense to call a
> single function and tell it which type of operation to perform.

Well, that's why I said "if possible" above. :-)

Thanks,
Rafael
