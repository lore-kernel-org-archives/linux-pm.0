From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/3] PM: Hibernation and suspend
	notifiers
Date: Thu, 31 May 2007 22:02:53 +0200
Message-ID: <200705312202.53945.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705281155270.22682-100000@netrider.rowland.org>
	<200705310744.44488.rjw@sisk.pl>
	<20070531142357.GK27309@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070531142357.GK27309@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday, 31 May 2007 16:23, Pavel Machek wrote:
> Hi!
> 
> > > > I'll post revised patches in a new thread.
> > > 
> > > I haven't been giving this much attention, so forgive me if I'm about to
> > > ask a silly question... which notifiers would you see the avenrun
> > > saving/restoring using?
> > 
> > I'm not sure what you mean.  Could you please clarify?
> 
> Remember that patch about saving/restoring "load average"? I guess
> Nigel asks where to hook it.

Ah, okay, thanks.

Hmm, that would be PM_PRE_HIBERNATION, I think.

Rafael
