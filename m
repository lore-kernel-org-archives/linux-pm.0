From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Massive ext4 filesystem corruption after a
	failed	s2disk/ram cycle
Date: Wed, 7 Oct 2009 12:16:04 -0400
Message-ID: <20091007161604.GA28849__2183.6178763353$1254932338$gmane$org@infradead.org>
References: <1254863215.11577.23.camel@maxim-laptop>
	<200910062358.32417.rjw@sisk.pl>
	<20091006225329.GA27646@khazad-dum.debian.net>
	<200910070102.47293.rjw@sisk.pl>
	<20091007012930.GA7022@khazad-dum.debian.net>
	<87vdisq7bh.fsf@rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87vdisq7bh.fsf@rimspace.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-pm@lists.linux-foundation.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 07, 2009 at 01:14:10PM +1100, Daniel Pittman wrote:
> For what it is worth, I would also be quite interested to know /why/ XFS is
> bad in this regard.  Is it just the previously stated "XFS writes to disk
> despite freezing kernel threads" issue, or something deeper?

sync pushes out all data to disk, but in a journaling filesystem that
might just but the log not the "normal" place on disk.  For a boot
loader to deal with it properly it actually needs to do an replay of
the log.  Grub does so for reiserfs but not for XFS for some reason.
I don't know why problems don't trigger more often with ext3, though.
