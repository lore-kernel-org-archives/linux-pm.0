From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [RFC Add in_use attribute] Let the driver know if
 it's	in use
Date: Mon, 20 Apr 2009 11:09:52 +0200
Message-ID: <49EC3BE0.1000902@gandalf.sssup.it>
References: <20090416131323.GA16752@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090416131323.GA16752@gandalf.sssup.it>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

Hi,

Michael Trimarchi wrote:
> Drivers on embedded systems would be smart enough
> to know that some of the devices should remain powered up, because
> they could still be useful even when the CPU wasn't running.
> The patch add the in_use attribute, that it can be used by the
> the drivers to avoid power down during suspend.
>
> Signed-off-by: Michael Trimarchi <trimarchi@gandalf.sssup.it>
> Cc: "Alan Stern" <stern@rowland.harvard.edu>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: "Pavel Mackek" <pavel@ucw.cz>
> Cc: "Len Brown" <lenb@kernel.org>
>
>   
I made a mistake to send the email, because I missed all the involved
people. This patch change the previus one "[linux-pm] [RFC Disable 
suspend on a
specific device] This is a little change in linux power scheme".

Regards
Michael
