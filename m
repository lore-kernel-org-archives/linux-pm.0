From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: wacom + runtime PM = AA deadlock
Date: Mon, 13 Sep 2010 17:52:10 -0700
Message-ID: <20100914005209.GB27540__7666.04050663791$1284425614$gmane$org@core.coreip.homeip.net>
References: <4C8E180D.4020309@suse.cz> <201009131656.18199.oneukum@suse.de>
	<20100913171046.GA23116@core.coreip.homeip.net>
	<201009132120.23372.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201009132120.23372.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, linux-input@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, pingc@wacom.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 13, 2010 at 09:20:23PM +0200, Oliver Neukum wrote:
> Am Montag, 13. September 2010, 19:10:47 schrieb Dmitry Torokhov:
> 
> > I think this introduces significant change in behavior though - before
> > we did not do usb_autopm_put_interface() on successful open, basically
> > disabling autopm facilities, right?
> 
> Right. Which makes no sense at all. You'd better remove anything related
> to runtime PM and not set supports_autosuspend for that.
> 

That not what I meant, I do not want to remove autopm, it's just it was
effectively disabled and if we fix it we might start getting some
regression reports ;)

-- 
Dmitry
