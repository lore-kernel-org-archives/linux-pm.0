From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] power management: no valid states	w/o	pm_ops
 + docs
Date: Tue, 13 Feb 2007 09:57:02 -0800
Message-ID: <45D1FBEE.2010505@oracle.com>
References: <1171383980.10344.39.camel@johannes.berg>	
	<20070213092357.7ea02880.randy.dunlap@oracle.com>	
	<1171388184.10344.55.camel@johannes.berg>
	<45D1F835.9030103@oracle.com>
	<1171389259.10344.62.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1171389259.10344.62.camel@johannes.berg>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Johannes Berg wrote:
> On Tue, 2007-02-13 at 09:41 -0800, Randy Dunlap wrote:
> =

>>>>  * struct pm_ops - callbacks for managing platform-dependent suspend s=
tates
>>> But then the description "callbacks for ..." disappears completely in
>>> the HTML output! Should I duplicate it or something?
>> No, it's right there by the struct name (top line).
>> As you have it, it shows up at the bottom, after the struct members,
>> doesn't it (i.e., out of order)?
> =

> I now have:
> =

> /**
>  * struct pm_ops - Callbacks for managing platform dependent suspend stat=
es.
>  *
>  *... (rest kept identical)
>  */
> =

> and it's not there for me (output of
>   ./scripts/kernel-doc -html include/linux/pm.h
> attached). I also get an empty "Description" section.
> =

> But yes, if I put it into the third line then it shows up in the
> "Description" section which is all the way down.
> =

> I think I'll put this down to a bug in the html output (that maybe you
> get to fix? :) ), I just tested text and man output now and they both
> look fine as you describe.

Uh, please try one more thing.  Delete the '*' line between
 * struct pm_ops - Callbacks ...

and the struct members list and retest that.

-- =

~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
