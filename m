From: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: Re: syncing the disks when entering sleep
Date: Wed, 10 Feb 2010 13:17:20 -0800
Message-ID: <76FA3B279DD9DA48896E2B4049449572051378FE@USA7061MS02.na.xerox.net>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201002101134.23851.rjw@sisk.pl>
	<20100210133118.GA31861@atrey.karlin.mff.cuni.cz>
	<201002102019.26518.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <201002102019.26518.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org



>   -----Original Message-----
>   From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
>   Sent: Wednesday, February 10, 2010 2:19 PM
>   To: Pavel Machek
>   Cc: linux-pm@lists.linux-foundation.org; Nigel Cunningham; Leisner,
>   Martin
>   Subject: Re: [linux-pm] syncing the disks when entering sleep
>   
......
>   > > So really, I don't see anything wrong with a knob that will turn the
>   kernel
>   > > sync off entirely, because that basically means "my user space is
>   > > not broken".
>   >
>   > Because, very easily, parts of my users space may be broken.
>   
>   How exactly would they be broken?
>   
>   Why do you want to protect the users from themselves for what it's
>   worth?
>   
>   Why don't we just assume that the user who sets the knob knows what he's
>   doing?
>   
>   Rafael

Exactly what I proposed -- if people who are root start playing with kernel settings, they'll get defined, documented behavior.   If they don't like it,
let them not play.   I see no reason to idiot proof root.

The problem is if the disk is not spinning, the system is in laptop mode, and sleep is entered, it makes no sense to spin up the disk to sync it in
embedded systems (i.e. the vendor controls all the software).

If root does
   dd if=/dev/zero of=/dev/sda
and they trash their disk, so be it.

marty
