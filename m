From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Mon, 30 Apr 2007 16:21:11 +0200
Message-ID: <200704301621.11826.rjw@sisk.pl>
References: <f129n6$mro$1@sea.gmane.org> <200704291832.15959.rjw@sisk.pl>
	<200704301434.10008.marcus@better.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704301434.10008.marcus@better.se>
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
To: Marcus Better <marcus@better.se>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Monday, 30 April 2007 14:34, Marcus Better wrote:
> Rafael J. Wysocki wrote:
> > Can you please apply the appended patch and see if that helps?
> 
> A second attempt also succeeded, so I think it's an improvement at least.

OK, so please run with it applied for a while to make sure it helps.

Ugh, we seem to have a problem with the code ordering in which
platform_finish() goes before device_resume(), at least in the hibernation
(aka s2disk) case.

This is the second report confirming that the change of this ordering has fixed
the a suspend problem, but the change of this ordering is intrusive, so I was
afraid to do it before 2.6.21.  Can we try to change it now?

Rafael
