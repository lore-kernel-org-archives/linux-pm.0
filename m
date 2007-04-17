From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH][RFC] Kill off legacy power management stuff.
Date: Tue, 17 Apr 2007 15:28:00 -0700
Message-ID: <200704171528.00861.david-b@pacbell.net>
References: <Pine.LNX.4.64.0704122025380.3628@CPE00045a9c397f-CM001225dbafb6>
	<200704131022.45315.rjw@sisk.pl> <46254666.2020308@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46254666.2020308@tmr.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Bill Davidsen <davidsen@tmr.com>, "Robert P. J. Day" <rpjday@mindspring.com>, Pavel Machek <pavel@ucw.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 17 April 2007 3:12 pm, Bill Davidsen wrote:
>  =

> One reason was that there are (were?) a number of machines which only =

> powered down properly using apm. It was discussed as part of shutting =

> down after power failure when your UPS is running out of power.

At least the notification mechanism had only the one client (68328serial.c),
so that part should be easily removed even if APM emulation needs some of
the other bits ...
