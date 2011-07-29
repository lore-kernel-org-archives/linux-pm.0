From: Oliver Neukum <oliver@neukum.org>
Subject: Re: better oopsing when frozen
Date: Fri, 29 Jul 2011 22:27:36 +0200
Message-ID: <201107292227.36424.oliver__27188.6387643919$1311971233$gmane$org@neukum.org>
References: <201107251043.19932.oneukum@suse.de> <20110729195430.GB1720@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110729195430.GB1720@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, 29. Juli 2011, 21:54:30 schrieb Pavel Machek:
> On Mon 2011-07-25 10:43:19, Oliver Neukum wrote:
> > Hi Rafael,
> > 
> > I had a problem with the kernel stopping the machine forever because I got an
> > oops while tasks were frozen. It seems to me that we should thaw when this
> > happens. How about this approach?
> 
> Danger, Will Robinson. You must not write to the filesystems after
> hibernation started. By thawing, you may do just that.
> 
> It should be safe to thaw as long as final suspend signature is not
> on disk and will not be written there.

Yes. But this applies only if I use kernel-space hibernation, doesn't it?
So I need a second flag for the signature being written. Any other problem?

	Regards
		Oliver
