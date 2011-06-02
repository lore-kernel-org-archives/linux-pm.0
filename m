From: Pavel Machek <pavel@ucw.cz>
Subject: Re: pm loss development
Date: Fri, 3 Jun 2011 00:21:11 +0200
Message-ID: <20110602222111.GA15414__44219.3158240572$1308034139$gmane$org@ucw.cz>
References: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
	<201105180107.58078.rjw@sisk.pl> <20110518031203.GA3640@gvim.org>
	<201105182143.13237.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201105182143.13237.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, davinci-linux-open-source@linux.davincidsp.com, Raffaele Recalcati <lamiaposta71@gmail.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > What do you mean by safe state?
> > >
> > I need to get more details on this but I assume its a state where the
> > meta data of the file system is committed to the emmc before lights go
> > off such that when power is reapplied that the damage isn't too big. 
> 
> I don't think you can guarantee that the metadata won't be damaged
> without notifying the filesystem of the event (and making it react
> appropriately).

Journalling filesystem should survive power loss at random time, as
long as block device behaves like a disk (i.e. writes whole sectors).

And that can be guaranteed at driver level...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
