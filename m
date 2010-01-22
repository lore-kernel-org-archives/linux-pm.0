From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: syncing the disks when entering sleep
Date: Fri, 22 Jan 2010 22:38:13 +0100
Message-ID: <201001222238.13926.rjw@sisk.pl>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<4B5A1942.2050003@crca.org.au>
	<76FA3B279DD9DA48896E2B404944957204E0B68C@USA7061MS02.na.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <76FA3B279DD9DA48896E2B404944957204E0B68C@USA7061MS02.na.xerox.net>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 22 January 2010, Leisner, Martin wrote:
> To clarify what I proposed:
> 
> if(user sets knobs) 
>     if(disk is spun up)
>          sync
> 
> currently the algorithm is
> 
>     sync

Yes, but Nigel said it should be

if(user knob is unset)
          sync

which I agree with.

[BTW, please don't top-post in future.]

Rafael
