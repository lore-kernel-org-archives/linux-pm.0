From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] PM / Runtime: Add sysfs switch for
 disabling device run-time PM (rev. 2)
Date: Sat, 23 Jan 2010 10:20:14 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001231018510.32358-100000__46102.0833733075$1264260295$gmane$org@netrider.rowland.org>
References: <201001231314.54926.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001231314.54926.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 23 Jan 2010, Rafael J. Wysocki wrote:

> Hmm, OK.
> 
> Of course, if the driver decides to leave disable_depth > 0, the user still
> won't be able to do anything about that, but if I understand correctly, you
> want drivers to have the option to use pm_runtime_forbid() initially, right
> after pm_runtime_enable(), so that the user space can turn the runtime PM
> on if desired via sysfs.
> 
> That makes sense.  I have a usage case for that myself. :-)
> 
> Updated patch is appended.

It looks good.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
