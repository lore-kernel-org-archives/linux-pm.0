From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 5/5] Hibernation: Introduce exportable
	suspend ioctls header
Date: Mon, 3 Sep 2007 23:15:37 +0200
Message-ID: <200709032315.38299.rjw@sisk.pl>
References: <200709022315.59652.rjw@sisk.pl> <200709022328.20720.rjw@sisk.pl>
	<1188812627.14564.34.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1188812627.14564.34.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 3 September 2007 11:43, Johannes Berg wrote:
> On Sun, 2007-09-02 at 23:28 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Move the definitions of hibernation ioctls to a separate header file in
> > include/linux, which can be exported to the user space.
> 
> Missing the actual export to userspace:
> 
> --- include/linux/Kbuild
> +++ include/linux/Kbuild
> +header-y += suspend_ioctls.h

Good point, thanks.

Greetings,
Rafael
