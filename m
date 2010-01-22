From: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: Re: syncing the disks when entering sleep
Date: Fri, 22 Jan 2010 13:40:46 -0800
Message-ID: <76FA3B279DD9DA48896E2B404944957204E0B6AE@USA7061MS02.na.xerox.net>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<4B5A1942.2050003@crca.org.au>
	<76FA3B279DD9DA48896E2B404944957204E0B68C@USA7061MS02.na.xerox.net>
	<201001222238.13926.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <201001222238.13926.rjw@sisk.pl>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org



>   -----Original Message-----
>   From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
>   Sent: Friday, January 22, 2010 4:38 PM
>   To: Leisner, Martin
>   Cc: Nigel Cunningham; linux-pm@lists.linux-foundation.org
>   Subject: Re: [linux-pm] syncing the disks when entering sleep
>   
>   On Friday 22 January 2010, Leisner, Martin wrote:
>   > To clarify what I proposed:
>   >
>   > if(user sets knobs)
>   >     if(disk is spun up)
>   >          sync
>   >
>   > currently the algorithm is
>   >
>   >     sync
>   
>   Yes, but Nigel said it should be
>   
>   if(user knob is unset)
>             sync
>   
>   which I agree with.
>   
>   [BTW, please don't top-post in future.]
>   
>   Rafael

if(knob is set) {
    if(disk is spun up)
       sync
} else sync

The spinup of the disk can have a very noticeable amount of time...if the user doesn't care about syncing, then the top is preferred...


marty
