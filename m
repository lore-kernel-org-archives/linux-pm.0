From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pm loss development
Date: Tue, 14 Jun 2011 15:36:30 +0100
Message-ID: <20110614153630.023eeeef__24366.6726667017$1308062230$gmane$org@lxorguk.ukuu.org.uk>
References: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
	<201105180107.58078.rjw@sisk.pl> <20110518031203.GA3640@gvim.org>
	<201105182143.13237.rjw@sisk.pl> <20110602222111.GA15414@ucw.cz>
	<20110614140642.GA14509@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110614140642.GA14509@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Raffaele Recalcati <lamiaposta71@gmail.com>
List-Id: linux-pm@vger.kernel.org

> I know nothing about journalling file systems or how well they limit the
> critical sections of time where the file system is exposed to corruption
> from sudden power failure.  Its an interesting question though.

A properly written journalling file system has no critical sections. The
only things it relies upon are

- store ordering in the drive working properly
- a single disk block write being atomic

the former is well specified even for ATA devices, the latter is a pretty
safe property of rotating media, although in theory you have a finite
chance of getting a bad sector.

For flash it's a lot lot more complicated but for a flash device claiming
to be ATA compliant you ought to get ATA behaviour.

All that said there is still (as ever) a tiny chance your system may
malfunction. It's all down to probabilities and if your laptop explodes
you need a backup (trust me, I've tested this case).

Alan
