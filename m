From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime PM: Calling Device runtime PM callbacks?
Date: Tue, 15 Dec 2009 15:51:26 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912151549090.2643-100000@iolanthe.rowland.org>
References: <200912152130.41272.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912152130.41272.rjw@sisk.pl>
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
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 15 Dec 2009, Rafael J. Wysocki wrote:

> In fact, I'm not very comfortable with the current possibility to call DPM
> callbacks of two or three kinds in a row for the same device, because that
> means very close connection between the bus type and device type or device
> class (or all three of them).  Nobody does that, as far as I can tell, and I
> guess nobody will.

How certain are you?  Do you want to add a WARN_ON to the PM core in 
case such a thing turns up?

> Now, if we agree that only one callback will be called for given device
> (either bus type, or device type, or device class), the code may be simpler
> and there won't be an issue with the ordering in _idle.

That would be perfectly fine with me.

Alan Stern
