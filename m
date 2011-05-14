From: Oliver Neukum <oliver@neukum.org>
Subject: Re: pm loss development
Date: Sat, 14 May 2011 20:53:34 +0200
Message-ID: <201105142053.34920.oliver__41746.771548833$1305399165$gmane$org@neukum.org>
References: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
	<201105122127.44484.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105122127.44484.rjw@sisk.pl>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-kernel@vger.kernel.org, Raffaele Recalcati <lamiaposta71@gmail.com>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 12. Mai 2011, 21:27:44 schrieb Rafael J. Wysocki:
> On Thursday, May 12, 2011, Raffaele Recalcati wrote:
> > What happen normally in runtime pm implementation is that every devices
> > are switched off and are enabled only when needed.
> > In our case instead we have a completely functional embedded system and,
> > when an asyncrhonous event appear, we have only some tens milliseconds
> > before the actual power failure takes place.
> > This patchset add a support in order to switch off not vital part of the system,
> > in order to allow the board to survive longer.
> > This allow the possibility to save important data.
> 
> OK, so first, who decides what parts of the system are vital and what aren't?

If you know that power is failing in a few miliseconds, only stuff that can lead to data
corruption is vital. In that timeframe you can't even flush buffers.

	Regards
		Oliver
