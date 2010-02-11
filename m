From: Pavel Machek <pavel@ucw.cz>
Subject: Re: syncing the disks when entering sleep
Date: Thu, 11 Feb 2010 15:49:58 +0100
Message-ID: <20100211144958.GA1434@ucw.cz>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201002101134.23851.rjw@sisk.pl>
	<20100210133118.GA31861@atrey.karlin.mff.cuni.cz>
	<201002102019.26518.rjw@sisk.pl>
	<76FA3B279DD9DA48896E2B4049449572051378FE@USA7061MS02.na.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <76FA3B279DD9DA48896E2B4049449572051378FE@USA7061MS02.na.xerox.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

Hi!

> ......
> >   > > So really, I don't see anything wrong with a knob that will turn the
> >   kernel
> >   > > sync off entirely, because that basically means "my user space is
> >   > > not broken".
> >   >
> >   > Because, very easily, parts of my users space may be broken.
> >   
> >   How exactly would they be broken?
> >   
> >   Why do you want to protect the users from themselves for what it's
> >   worth?
> >   
> >   Why don't we just assume that the user who sets the knob knows what he's
> >   doing?
> 
> Exactly what I proposed -- if people who are root start playing with kernel settings, they'll get defined, documented behavior.   If they don't like it,
> let them not play.   I see no reason to idiot proof root.
>

And I see no reason to have bad interface when we can have good one.

You don't have to be idiot to do "echo disabled > sync; echo mem >
state" and then forget to undo the sync setting when it resumes
20hours later.
 
> The problem is if the disk is not spinning, the system is in laptop mode, and sleep is entered, it makes no sense to spin up the disk to sync it in
> embedded systems (i.e. the vendor controls all the software).
> 

I agree that functionality would be nice. I don't agree with proposed interface.



-- 

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
