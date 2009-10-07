From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Massive ext4 filesystem corruption after a failed
 s2disk/ram cycle
Date: Tue, 6 Oct 2009 22:29:30 -0300
Message-ID: <20091007012930.GA7022@khazad-dum.debian.net>
References: <1254863215.11577.23.camel@maxim-laptop>
	<200910062358.32417.rjw@sisk.pl>
	<20091006225329.GA27646@khazad-dum.debian.net>
	<200910070102.47293.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200910070102.47293.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 07 Oct 2009, Rafael J. Wysocki wrote:
> On Wednesday 07 October 2009, Henrique de Moraes Holschuh wrote:
> > On Tue, 06 Oct 2009, Rafael J. Wysocki wrote:
> > > > You do sync file-systems before entering the hibernation, don't you?
> > > 
> > > Yes, a sync is there, but it is not effective on some filesystems.
> > 
> > Which ones?
> 
> XFS for one example.

Interesting.  So XFS is not only a Bad Idea for /, but also for anything
that might enter S3/S4.  Not nice.  I sure hope it doesn't do a
half-assed job of flushing and checkpointing itself during machine
shutdown/restart like it apparently does when told to "sync" before
S3/S4...

Would you be so kind to disclose to us, the uninitated, which other
filesystems are unsafe when faced with a sleep/suspend request?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
