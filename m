From: mark gross <markgross@thegnar.org>
Subject: Re: pm loss development
Date: Tue, 14 Jun 2011 07:06:42 -0700
Message-ID: <20110614140642.GA14509__20437.3986147859$1308060551$gmane$org@gvim.org>
References: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
	<201105180107.58078.rjw@sisk.pl> <20110518031203.GA3640@gvim.org>
	<201105182143.13237.rjw@sisk.pl> <20110602222111.GA15414@ucw.cz>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110602222111.GA15414@ucw.cz>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, markgross@thegnar.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Raffaele Recalcati <lamiaposta71@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 03, 2011 at 12:21:11AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > What do you mean by safe state?
> > > >
> > > I need to get more details on this but I assume its a state where the
> > > meta data of the file system is committed to the emmc before lights go
> > > off such that when power is reapplied that the damage isn't too big. 
> > 
> > I don't think you can guarantee that the metadata won't be damaged
> > without notifying the filesystem of the event (and making it react
> > appropriately).
> 
> Journalling filesystem should survive power loss at random time, as
> long as block device behaves like a disk (i.e. writes whole sectors).
> 
> And that can be guaranteed at driver level...
> 

What if the battery falls out of the device at a bad time?  The HW will
have micro to mili seconds of time to close out whatever transaction is
in flight.

I know nothing about journalling file systems or how well they limit the
critical sections of time where the file system is exposed to corruption
from sudden power failure.  Its an interesting question though.

--mark
