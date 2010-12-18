From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 18 Dec 2010 23:57:25 +0100
Message-ID: <201012182357.25687.rjw__36042.4137594693$1292713134$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1012181629350.7965-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1012181629350.7965-100000@netrider.rowland.org>
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
Cc: linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, December 18, 2010, Alan Stern wrote:
> On Sat, 18 Dec 2010, Ohad Ben-Cohen wrote:
> 
> > > Sounds to me like the difference isn't really in the driver, but the
> > > core PM subsystem. Why does it care when powering off a device whether
> > > it's during suspend, or during runtime?
> > 
> > Agree.
> > 
> > If we can add a dev_pm_info bit, that would allow using runtime PM API
> > during suspend/resume transitions, the driver will not have to care.
> > 
> > Rafael what do you think ? Is that totally unacceptable ?
> 
> Have you forgotten about the "echo on >.../power/control" scenario?

Well, that change would basically require the runtime PM framework to ignore
the usage count for this particular device, which would defeat the framework's
purpose to some extent, but it would cover the "echo on > ..." case.

However, I'm not going to agree to make that change.

Thanks,
Rafael
