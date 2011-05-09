From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] PM / Runtime: Support for generic I/O
	power domains (v3)
Date: Mon, 9 May 2011 21:22:09 +0200
Message-ID: <201105092122.09690.rjw__24842.047939501$1304968936$gmane$org@sisk.pl>
References: <201104290154.12966.rjw@sisk.pl> <201105082322.44268.rjw@sisk.pl>
	<BANLkTinPGQNUrFnyFVazqA72iyMbB-K_OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTinPGQNUrFnyFVazqA72iyMbB-K_OA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

On Monday, May 09, 2011, Todd Poynor wrote:
> On Sun, May 8, 2011 at 2:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> ...
> 
> > power management (i.e. ->stop_device() may disable a device's
> > clocks, while ->start_device() may enable them, ->power_on() is
> > supposed to remove power from the entire power domain
> > and ->power_off() is supposed to restore it).
> >
> 
> power_off removes power, power_on restores?

Yes, that's the intention.  Thanks for spotting that!

Rafael
