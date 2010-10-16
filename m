From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ath9k: Convert to new PCI PM framework
Date: Sat, 16 Oct 2010 21:52:24 +0200
Message-ID: <201010162152.24344.rjw__21887.3538579375$1287274077$gmane$org@sisk.pl>
References: <201010160036.17653.rjw@sisk.pl>
	<AANLkTimXXERRCYEjzQbcii6XW8wbjNfN-eWigU7Wi_Lv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimXXERRCYEjzQbcii6XW8wbjNfN-eWigU7Wi_Lv@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Stewart <pstew@google.com>
Cc: linux-wireless@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ath9k-devel@venema.h4ckr.net, "Luis R. Rodriguez" <lrodriguez@atheros.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, October 16, 2010, Paul Stewart wrote:
> On Fri, Oct 15, 2010 at 3:36 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > The ath9k driver uses the legacy PCI power management (suspend
> > and resume) callbacks that apparently cause intermittent problems
> > to happen (the adapter sometimes doesn't resume correctly on my
> > Acer Ferrari One).  Make it use the new PCI PM and let the PCI core
> > code handle the PCI-specific details of power transitions.
> I'm curious.  What sort of behavior did you get when the device fails
> to resume correctly?  Every now and then I've been getting bad
> accesses to 0x7000 every now and then -- after that any reads to PCI
> registers return all f's.

Yes, this sort of matches my experience.  Even the config space isn't
really accessible after a failure to resume.

Thanks,
Rafael
