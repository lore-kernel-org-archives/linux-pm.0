From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: Alternative Concept
Date: Sun, 18 Mar 2007 23:25:36 +0300
Message-ID: <45FDA040.4020502@gmail.com>
References: <44ECFF94.3030506@gmail.com>
	<200703151921.55310.david-b@pacbell.net> <45FA965E.80503@gmail.com>
	<200703161103.12333.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703161103.12333.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> On Friday 16 March 2007 6:06 am, Dmitry Krivoschekov wrote:
>
>> 	 I surprised you didn't comment
>> on original Matthew's post since it contains so many points to discuss.
>
> As a direction, it sounded better than many notions I've seen here.
>
> But there was a certain lack of ... detail ... making discussion
> impractical, except as speculation.
I believe  details  was intentionally omitted to receive some feedback
regarding
concept basics only, this may help to adjust (or change) implementation
details
from the beginning.

But ok, as you aren't arguing against those basics and intentions then
seems you
agree to them.

For me, there is a point that seems debatable already at the starting stage:

> The goal of this parameter framework is to expose the resources in  a  =

> way that allows other s/w (governors, policy mangers, etc) to control  =

> the resources while keeping the system operational.  One of the main  =

> requirements in our thinking is that we want this layer to represent  =

> the h/w and not include policy or decision making.  Meaning the =

> software using the parameter framework would be responsible for  =

> deciding the appropriate value for the parameters.   =



Sometimes it's quite reasonable to make decisions (or policy)
at the low level, without exposing events to higher layers,
e.g. turning a clock off when reference counter gets zero, this is
what OMAP's clock framework currently does.


Thanks,
Dmitry
