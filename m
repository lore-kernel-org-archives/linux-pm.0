From: "J. Bakshi" <j.bakshi@unlimitedmail.org>
Subject: Re: where is /sys/class/power_supply/ADP1 ?
Date: Sun, 14 Aug 2011 09:30:40 +0530
Message-ID: <201108140400.p7E40gBC023531__4223.73843980512$1313302843$gmane$org@dcnode-02.unlimitedmail.net>
References: <201107301330.p6UDUrt8004286@dcnode-01.unlimitedmail.net>
	<201107302328.55921.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107302328.55921.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 30 Jul 2011 23:28:55 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Saturday, July 30, 2011, J. Bakshi wrote:
> > Hello kernel gurus,
> > 
> > This is my very first email to this list, so greetings to all of you.
> > 
> > I have compiled the latest 3.0 kernel. But I have not found the 
> > 
> > /sys/class/power_supply/ADP1 and sys/class/power_supply/BAT0 any more
> > 
> > are they still supported in 3.0 ?
> 
> What's there in your /sys/class/power_supply/ with 3.0?  I surely have
> those links on my test systems.
> 

Problem solved with the new version of laptop-mode-tools 1.58
This version is designed to work with kernel 3.0

THNX
