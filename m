From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] plist: add plist_last
Date: Fri, 2 Jul 2010 00:21:26 +0200
Message-ID: <201007020021.26420.rjw@sisk.pl>
References: <1277746434.10879.191.camel@mulgrave.site>
	<1277746885.10879.197.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1277746885.10879.197.camel@mulgrave.site>
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
Cc: Daniel Walker <dwalker@mvista.com>, Thomas Gleixner <tglx@linutronix.de>, James Bottomley <James.Bottomley@suse.de>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Monday, June 28, 2010, James Bottomley wrote:
> plist is currently used by the scheduler, which only needs to know the
> highest item in the list.  This adds plist_last which allows you to
> find the lowest.  This is necessary for using plists to implement a
> fast search of dynamic ranges in pm_qos which can have both highest
> and lowest criteria.
> 
> Signed-off-by: James Bottomley <James.Bottomley@suse.de>

Applied to suspend-2.6/linux-next.

Rafael
