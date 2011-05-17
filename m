From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm loss development
Date: Wed, 18 May 2011 01:06:56 +0200
Message-ID: <201105180106.57147.rjw__2290.50318380377$1305673711$gmane$org@sisk.pl>
References: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
	<201105142053.34920.oliver@neukum.org>
	<BANLkTikEJoV1JHMDZODvv40-8-jmvYMbgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTikEJoV1JHMDZODvv40-8-jmvYMbgg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, davinci-linux-open-source@linux.davincidsp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, May 14, 2011, Raffaele Recalcati wrote:
> On Sat, May 14, 2011 at 8:53 PM, Oliver Neukum <oliver@neukum.org> wrote:
> > Am Donnerstag, 12. Mai 2011, 21:27:44 schrieb Rafael J. Wysocki:
> >> On Thursday, May 12, 2011, Raffaele Recalcati wrote:
> >> > What happen normally in runtime pm implementation is that every devices
> >> > are switched off and are enabled only when needed.
> >> > In our case instead we have a completely functional embedded system and,
> >> > when an asyncrhonous event appear, we have only some tens milliseconds
> >> > before the actual power failure takes place.
> >> > This patchset add a support in order to switch off not vital part of the system,
> >> > in order to allow the board to survive longer.
> >> > This allow the possibility to save important data.
> >>
> >> OK, so first, who decides what parts of the system are vital and what aren't?
> >
> > If you know that power is failing in a few miliseconds, only stuff that can lead to data
> > corruption is vital. In that timeframe you can't even flush buffers.
> 
> Remember that if you switch off some peripherals this timeframe
> becomes longer, so maybe you have enough time to sync some storage
> devices.

However, switching off peripherals _also_ takes time.  So, it may be more
useful to take care of the stuff leading to data corruption along with the
switching off peripherals.

Thanks,
Rafael
