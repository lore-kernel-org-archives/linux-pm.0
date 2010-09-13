From: Oliver Neukum <oliver@neukum.org>
Subject: Re: wacom + runtime PM = AA deadlock
Date: Mon, 13 Sep 2010 21:20:23 +0200
Message-ID: <201009132120.23372.oliver__36279.6422596604$1284405648$gmane$org@neukum.org>
References: <4C8E180D.4020309@suse.cz> <201009131656.18199.oneukum@suse.de>
	<20100913171046.GA23116@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100913171046.GA23116@core.coreip.homeip.net>
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
Cc: pingc@wacom.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Slaby <jslaby@suse.cz>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Montag, 13. September 2010, 19:10:47 schrieb Dmitry Torokhov:

> I think this introduces significant change in behavior though - before
> we did not do usb_autopm_put_interface() on successful open, basically
> disabling autopm facilities, right?

Right. Which makes no sense at all. You'd better remove anything related
to runtime PM and not set supports_autosuspend for that.

	Regards
		Oliver
