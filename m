From: Oliver Neukum <oliver@neukum.org>
Subject: Re: wacom + runtime PM = AA deadlock
Date: Tue, 14 Sep 2010 08:07:39 +0200
Message-ID: <201009140807.39977.oliver__14562.9527316943$1284444569$gmane$org@neukum.org>
References: <4C8E180D.4020309@suse.cz> <201009132120.23372.oliver@neukum.org>
	<20100914005209.GB27540@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100914005209.GB27540@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-input@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, pingc@wacom.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 14. September 2010, 02:52:10 schrieb Dmitry Torokhov:
> On Mon, Sep 13, 2010 at 09:20:23PM +0200, Oliver Neukum wrote:
> > Am Montag, 13. September 2010, 19:10:47 schrieb Dmitry Torokhov:
> > 
> > > I think this introduces significant change in behavior though - before
> > > we did not do usb_autopm_put_interface() on successful open, basically
> > > disabling autopm facilities, right?
> > 
> > Right. Which makes no sense at all. You'd better remove anything related
> > to runtime PM and not set supports_autosuspend for that.
> > 
> 
> That not what I meant, I do not want to remove autopm, it's just it was
> effectively disabled and if we fix it we might start getting some
> regression reports ;)

True. So currently we have

- a deadlock
- disabled runtime power management

We need to fix the deadlock. We can fix it retaining a disabled
runtime power management. Or we can fix it fixing the runtime
power management at the same time. However this opens
the door to regressions. So for now I really suggest removing
it from the driver and reintroduce it properly for the next merge
window.

	Regards
		Oliver
