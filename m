From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Strange delays during suspend
Date: Thu, 21 Feb 2008 17:16:23 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802211716080.2114-100000@iolanthe.rowland.org>
References: <47BDF432.6060801@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47BDF432.6060801@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 22 Feb 2008, Nigel Cunningham wrote:

> Hi Alan.
> 
> Alan Stern wrote:
> > Below is a dmesg log from a suspend test with pm_test set to 
> > "devices".  I have notated a few unaccountable delays.  Can anybody 
> > explain them?
> 
> Is this with no_hz enabled? If so, would you see if you get the same 
> results with it disabled?

NO_HZ was disabled.

Alan Stern
