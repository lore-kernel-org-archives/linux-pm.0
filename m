From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI suspend: Blacklist boxes that require
	us to set SCI_EN directly on resume
Date: Tue, 18 Nov 2008 23:59:57 +0100
Message-ID: <200811182359.58205.rjw@sisk.pl>
References: <200811172333.13466.rjw@sisk.pl> <49225697.90804@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49225697.90804@shaw.ca>
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
To: Robert Hancock <hancockr@shaw.ca>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Tino Keitel <tino.keitel@gmx.de>, Bob Copeland <me@bobcopeland.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 18 of November 2008, Robert Hancock wrote:
> Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: ACPI suspend: Blacklist boxes that require us to set SCI_EN directly on resume
> > 
> > Some Apple boxes evidently require us to set SCI_EN on resume
> > directly, because if we don't do that, they hung somewhere in the
> > resume code path.  Moreover, on these boxes it is not sufficient to
> > use acpi_enable() to turn ACPI on during resume.  All of this is
> > against the ACPI specification which states that (1) the BIOS is
> > supposed to return from the S3 sleep state with ACPI enabled
> > (SCI_EN set) and (2) the SCI_EN bit is owned by the hardware and we
> > are not supposed to change it.
> > 
> > For this reason, blacklist the affected systems so that the SCI_EN
> > bit is set during resume on them.
> > 
> > [NOTE: Unconditional setting SCI_EN for all system on resume doesn't
> >  work, because it makes some other systems crash (that's to be
> >  expected).  Also, it is not entirely clear right now if all of the
> >  Apple boxes require this workaround.]
> 
> This is rather gross. The usual question arises, why does Windows work 
> without such a hack? Maybe there is no better solution for now, but 
> somebody should really look into why the behavior is different in Linux..

I discussed this with Len and we agreed that the best thing we can do is to
blacklist those boxes.

In fact, the SCI_EN flag is already forcibly set in irqrouter_resume() due to
the very same Apple BIOS borkage and what this patch actually does is to
move that as early in the resume code path as possible.  Also it generally
is inappropriate to set SCI_EN for all systems unconditionally (I'm planning
to remove this from irqrouter_resume() in .29, because it's a noop after the
$subject patch).

Apparently, acpi_enable() in acpi_suspend_enter() doesn't work on the Apple
boxes and that's why the $subject patch is necessary.  It would be nice to know
_why_ it doesn't work on them, but I'm not sure if we can find that out.

Thanks,
Rafael
