From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Asynchronous suspend/resume - test results
Date: Sun, 20 Dec 2009 23:35:55 -0800
Message-ID: <20091221073555.GB3234__29678.3156613403$1261381031$gmane$org@core.coreip.homeip.net>
References: <200912210140.19713.rjw@sisk.pl> <4B2F22EF.6040500@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B2F22EF.6040500@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Nigel,

On Mon, Dec 21, 2009 at 06:25:35PM +1100, Nigel Cunningham wrote:
> Hi.
> 
> Rafael J. Wysocki wrote:
> > I'm not sure what the next step should be at this point.  To me, the picture is
> > quite clear now, but perhaps we ought to run more tests on some other machines
> > or something.  Please let me know what you think.
> 
> Looks great. If you do decide you want other machines tested, I'll
> happily try the machines around here:
> 
> - Dell M1530
> - Omnibook XE3-GF.
> - Via LN10000 based Mythtv Box
> - Desktop machine - Some Intel-based mobo I've forgotten the name of.
> 

Would you mind also testing patch that I just posted that changes full
PS/2 keyboard and mouse resets to more lightweight versions?

Thanks!

-- 
Dmitry
