From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Tue, 30 Dec 2008 10:45:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812301043290.2292-100000__30846.3102359839$1230652119$gmane$org@iolanthe.rowland.org>
References: <495A1DC8.1050609@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <495A1DC8.1050609@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 30 Dec 2008, Alan Jenkins wrote:

> Ok, I think I got it.
> 
> The hang is in ieee80211_unregister_hw(), on this line:
> 
> destroy_workqueue(local->hw.workqueue);
> 
> 
> local->hw.workqueue is created using create_freezeable_workqueue().  So
> presumably destroy_workqueue() deadlocks because the workqueue has
> already been frozen.
> 
> Is it possible to fix this without suspend support in mac80211?  If not,
> I vote we change rtl8187 (and zd_usb) to prevent suspend.  I.e. set USB
> suspend callbacks which return an error.

It certainly should be possible to fix this.  For instance, why 
unregister anything during suspend?  If ieee80211_unregister_hw() 
weren't called then this problem would go away, right?

Alan Stern
