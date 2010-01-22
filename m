From: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: Re: syncing the disks when entering sleep
Date: Fri, 22 Jan 2010 13:33:17 -0800
Message-ID: <76FA3B279DD9DA48896E2B404944957204E0B68C@USA7061MS02.na.xerox.net>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201001222149.46839.rjw@sisk.pl> <4B5A1942.2050003@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <4B5A1942.2050003@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

To clarify what I proposed:

if(user sets knobs) 
    if(disk is spun up)
         sync

currently the algorithm is

    sync

marty

>   -----Original Message-----
>   From: Nigel Cunningham [mailto:ncunningham@crca.org.au]
>   Sent: Friday, January 22, 2010 4:32 PM
>   To: Rafael J. Wysocki
>   Cc: Leisner, Martin; linux-pm@lists.linux-foundation.org
>   Subject: Re: [linux-pm] syncing the disks when entering sleep
>   
>   Hi.
>   
>   Rafael J. Wysocki wrote:
>   > On Friday 22 January 2010, Leisner, Martin wrote:
>   >> I noticed when we enter sleep states, it seems there's always a
>   >> sys_sync given.
>   >>
>   >> When having an embedded system doing WOL (already in laptop mode to
>   >> cache
>   >> all the writes), it reasonable to wake up dozens of times of day and
>   >> quickly go back to sleep.  If the disk is not spun up,
>   >> and there's some work to be done, won't the sys_sync spin up the disk
>   >> before going to sleep?
>   >>
>   >> It would be good to have a knob (in /sys) you can tweak from usespace
>   to
>   >>
>   >> configure the behavior of whether you want to do a sync when entering
>   >> sleep.
>   >>
>   >> The ideal behavior would be:
>   >>
>   >>     if(disk is spun up)
>   >>         then let the sync happen
>   >
>   > I'm not against that.  Patch welcome. :-)
>   
>   Oooh. I am. That's providing potential for unpredictable behaviour. Much
>   better IMO would be providing a tuning know that explicitly and
>   unconditionally disables syncing.
>   
>   Regards,
>   
>   Nigel
