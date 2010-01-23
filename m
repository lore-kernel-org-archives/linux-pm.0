From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM / Runtime: Add sysfs switch for
	disabling device run-time PM (rev. 2)
Date: Sat, 23 Jan 2010 21:08:07 +0100
Message-ID: <201001232108.07693.rjw__790.208477019583$1264277326$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1001231018510.32358-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1001231018510.32358-100000@netrider.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

On Saturday 23 January 2010, Alan Stern wrote:
> On Sat, 23 Jan 2010, Rafael J. Wysocki wrote:
> 
> > Hmm, OK.
> > 
> > Of course, if the driver decides to leave disable_depth > 0, the user still
> > won't be able to do anything about that, but if I understand correctly, you
> > want drivers to have the option to use pm_runtime_forbid() initially, right
> > after pm_runtime_enable(), so that the user space can turn the runtime PM
> > on if desired via sysfs.
> > 
> > That makes sense.  I have a usage case for that myself. :-)
> > 
> > Updated patch is appended.
> 
> It looks good.
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks!

Rafael
