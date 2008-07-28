From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Vulnerability in Software Suspend 2 (all versions)
Date: Mon, 28 Jul 2008 18:58:01 +1000
Message-ID: <1217235481.8430.124.camel@nigel-laptop>
References: <488D821D.5060603@iviztechnosolutions.com>
	<488D8449.2010006@iviztechnosolutions.com>
	<1217234901.8430.115.camel@nigel-laptop>
	<488D8853.7080907@iviztechnosolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <488D8853.7080907@iviztechnosolutions.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jonathan Brossard <jonathan@iviztechnosolutions.com>
Cc: ncunningham@users.sourceforge.net, chabaud@users.sourceforge.net, bernardb@users.sourceforge.net, seasons@users.sourceforge.net, techteam@ivizindia.com, "CERT(R) Coordination Center" <cert@cert.org>, mhfl@users.sourceforge.net, linux-pm <linux-pm@lists.linux-foundation.org>, Jonathan Brossard <jonathan@ivizindia.com>
List-Id: linux-pm@vger.kernel.org

Hi again.

On Mon, 2008-07-28 at 14:20 +0530, Jonathan Brossard wrote:
> Dear Nigel,
> 
> >This is not a bug in TuxOnIce (or for that matter other Linux
> >hibernation implementations, which would have the same issue).
> 
> Yes it is.
> 
> >TuxOnIce has no way to know what running applications have passwords
> >stored in memory or whether they are storing them in an encrypted format
> >or not. Bugs should be filed against applications that are storing
> >passwords in plain text.
> 
> We are talking about the password of tuxonice itself here...

TuxOnIce itself doesn't have any password support. Do you mean a
password for encrypted swap or such like?

> Please boot a computer using tuxonice, go for hibernation,
> reboot, and then type this (as root) :
> 
> xxd -l 32 -s 0x041e  /dev/mem
> 
> 
> >By the way, these contact email addresses are grossly out of date. For
> >TuxOnIce, the contact is nigel@tuxonice.net. For swsusp and uswsusp
> >(which would have the same problem), refer to linux-pm@lists.osdl.org.
> 
> I did my best to find one on the site's website and ended up
> taking those of sourceforge.

Hmm, you're right there. I'll address that shortly.

Regards,

Nigel
