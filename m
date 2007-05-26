From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: fw-ohci breaks suspend-to-RAM
Date: Sat, 26 May 2007 23:42:31 +0200
Message-ID: <200705262342.32060.rjw__44180.5610819303$1180215455$gmane$org@sisk.pl>
References: <200705181207.45868.marcus@better.se>
	<200705262210.43365.rjw@sisk.pl>
	<4658A59E.2080106@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4658A59E.2080106@s5r6.in-berlin.de>
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
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Marcus Better <marcus@better.se>
List-Id: linux-pm@vger.kernel.org

On Saturday, 26 May 2007 23:24, Stefan Richter wrote:
> Rafael J. Wysocki wrote:
> > On Saturday, 26 May 2007 14:14, Stefan Richter wrote:
> >> I might try to install suspend2 for hibernate-to-swapfile
> 
> > Actually you can try swsusp too (the built-in stuff).
> 
> I don't have a swap partition.

Please see Documentation/power/swsusp-and-swap-files.txt

In the suspend package containing s2ram there is the program swap-offset
that you can use to obtain the resume_offset value for your swap file
(NOTE: this doesn't work with swap files on LVM).

Greetings,
Rafael
