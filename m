From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/3] PM: Hibernation and suspend
	notifiers
Date: Thu, 31 May 2007 07:42:20 +0200
Message-ID: <200705310742.21852.rjw__6693.63075071505$1180589865$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0705281155270.22682-100000@netrider.rowland.org>
	<200705302311.40123.rjw@sisk.pl>
	<20070530222956.GD27309@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070530222956.GD27309@elf.ucw.cz>
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

On Thursday, 31 May 2007 00:29, Pavel Machek wrote:
> Hi!
> 
> > > I think the rule should be: If you need to do something _before_ tasks are
> > > frozen, do it in PM_PRE_FREEZE, but if you can do that after the tasks have
> > > been frozen, do it on PM_HIBERNATION_PREPARE (or PM_SUSPEND_PREPARE in the
> > > suspend case).
> > 
> > OTOH, having considered it for a while, I think that for now I can add just
> > PM_PRE_FREEZE and PM_POST_THAW, as I don't have any user for the other ones.
> > The other events may be added in the future if need be (along with some users).
> > 
> > I'll post revised patches in a new thread.
> 
> Yes please.
> 
> (Hmm, but you may create 4 of them PM_PRE_HIBERNATION, PM_PRE_SUSPEND,
> PM_POST_HIBERNATION, PM_POST_SUSPEND -- I'd call all of them before
> freeze and after thaw, but if we drop freezer for suspend, we won't
> have to rename anything.)

Yes, that's a good idea. :-)

Greetings,
Rafael
