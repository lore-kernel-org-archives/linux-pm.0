From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Strange delays during suspend
Date: Fri, 22 Feb 2008 08:59:14 +1100
Message-ID: <47BDF432.6060801@nigel.suspend2.net>
References: <Pine.LNX.4.44L0.0802211640230.2114-100000@iolanthe.rowland.org>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0802211640230.2114-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Alan.

Alan Stern wrote:
> Below is a dmesg log from a suspend test with pm_test set to 
> "devices".  I have notated a few unaccountable delays.  Can anybody 
> explain them?

Is this with no_hz enabled? If so, would you see if you get the same 
results with it disabled?

Regards,

Nigel
